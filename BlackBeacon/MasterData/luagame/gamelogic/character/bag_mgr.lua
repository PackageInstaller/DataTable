local Base = require("gamelogic.base_system")
local _tinsert = table.insert
local CommonDefine = require("cs_share.common_define")
local Item_Helper = require("utils.item_helper")
local Timer = Global.timer
local EQUIP_BAG_TYPE = 6
local BATTLE_RES = 7
local BATTLE_ITEM = 8
local TREASURE_CHEST_TYPE = 15
local GEM_STONE_TYPE = 25
local PUZZLE_TYPE = 26
local TIPS_DAY = ShareRes.get_comm_value("ItemRemainTimeTipsDay") or 1
local active_system_item_cfg = ShareRes.create("item.item_subtype", "active_system_item")
local ONE_DAY_SECS = TIPS_DAY * 24 * 60 * 60
local delay_award_time = 0
local delay_award_list
local auto_use_item_list = {}
local is_need_show_item_remain_time_tips = true
local M = Util.create_child_mt(Base)
local RES_ENUM = {}
M.RES_ENUM = RES_ENUM

local function _sub_insert(id_lists, id, item)
  id_lists[id] = id_lists[id] or {}
  _tinsert(id_lists[id], item)
end

local function _sub_replace(id_lists, id, item)
  if id_lists[id] then
    local list = id_lists[id]
    local is_new = true
    for i = 1, #list do
      if list[i].uuid == item.uuid then
        list[i] = item
        is_new = false
      end
    end
    if is_new then
      _tinsert(list, item)
    end
  else
    id_lists[id] = {}
    _tinsert(id_lists[id], item)
  end
end

function M:init_res_enum()
  local all_cfg = ShareRes.create("item.item")
  for key, cfg in pairs(all_cfg) do
    if not Util.is_empty(cfg.CodeKey) then
      RES_ENUM[cfg.CodeKey] = cfg.Id
    end
  end
end

function M:init_sys()
  Base.init_sys(self)
  is_need_show_item_remain_time_tips = true
  self.v_items = {}
  self.v_item_maps = {}
  self.v_id2_grids = {}
  self:init_res_enum()
end

function M:on_reconnect()
  self.v_items = {}
  self.v_item_maps = {}
  self.v_id2_grids = {}
end

function M:on_get_item_list(data)
  self.v_items[data.bag_type] = data.item_list
  for _, item in pairs(data.item_list) do
    self.v_item_maps[item.uuid] = item
    _sub_replace(self.v_id2_grids, item.id, item)
  end
  if data.bag_type == TREASURE_CHEST_TYPE then
    TreasureChestMgr:refresh_treasure_chest_red()
  end
  self:is_show_bag_red()
end

function M:on_items_update(data)
  local items = self.v_items[data.bag_type]
  for _, item in pairs(data.item) do
    local origin_item_count = self.v_item_maps[item.uuid] and self.v_item_maps[item.uuid].count or 0
    self.v_item_maps[item.uuid] = item
    _sub_replace(self.v_id2_grids, item.id, item)
    if items then
      local is_new = true
      for k, item_info in pairs(items) do
        if item_info.uuid == item.uuid then
          items[k] = item
          is_new = false
          break
        end
      end
      if is_new then
        table.insert(items, item)
      end
    end
    local item_cfg = UtilUI.get_item_cfg(item.id)
    if item_cfg.Subtype == active_system_item_cfg.SubtypeId then
      if (item.id == 4002 or item.id == 4003) and PassPortMgr:is_senior() then
        return
      end
      local consume_list = {
        bag_type = data.bag_type,
        item_list = {
          {
            uuid = item.uuid,
            count = item.count - origin_item_count
          }
        }
      }
      self:request_use_item(consume_list, function(ok)
        if ok then
          Util.show_message_tip(2070)
        end
      end)
    end
  end
  self:send_item_update_msg(data.bag_type)
end

function M:on_item_delete(data)
  self:delete_item(data)
  self:send_item_update_msg(data.bag_type)
end

function M:delete_item(data)
  local items = self.v_items[data.bag_type]
  if not items then
    return
  end
  local auto_use_item
  for k, item_info in pairs(items) do
    if item_info.uuid == data.uuid then
      table.remove(items, k)
      if data.reason == "item_expire_auto_use" then
        auto_use_item = item_info
      end
      break
    end
  end
  local item_id
  for k, item in pairs(self.v_item_maps) do
    if item.uuid == data.uuid then
      item_id = item.id
      self.v_item_maps[k] = nil
      if not auto_use_item then
        auto_use_item = item
      end
      break
    end
  end
  if self.v_id2_grids[item_id] then
    UtilTable.list_delete_by_func(self.v_id2_grids[item_id], function(item)
      return item.uuid == data.uuid
    end)
  end
  if auto_use_item then
    local item_cfg = ShareRes.create("item.item", auto_use_item.id)
    if item_cfg then
      local count = auto_use_item_list[auto_use_item.id]
      if count then
        auto_use_item_list[auto_use_item.id] = count + auto_use_item.count
      else
        auto_use_item_list[auto_use_item.id] = auto_use_item.count
      end
    end
    auto_use_item = nil
  end
end

function M:send_item_update_msg(bag_type)
  self:is_show_bag_red()
  local msg = MsgGame:mq_publish2(Const.MSG_ON_ITEM_UPDATE)
  msg.mm_x = bag_type
end

function M:on_item_list_delete(data)
  local remove_data = {}
  for _, uuid in pairs(data.uuid_list) do
    remove_data.bag_type = data.bag_type
    remove_data.uuid = uuid
    self:delete_item(remove_data)
  end
  self:send_item_update_msg(data.bag_type)
end

function M:get_grid(grid_uuid)
  return self.v_item_maps[grid_uuid]
end

function M:get_item(item_id)
  local list = self.v_id2_grids[item_id]
  if self.v_id2_grids[item_id] then
    return list[1]
  end
end

function M:get_item_num(item_id)
  local list = self.v_id2_grids[item_id]
  local num = 0
  local bag_type = Util.get_item_type_cfg(item_id).BagType
  if bag_type == EQUIP_BAG_TYPE then
    return CharacterMgr:get_equip_num(item_id)
  elseif bag_type == BATTLE_RES then
    return FightBagMgr:get_fight_item_num_by_id(item_id)
  elseif bag_type == BATTLE_ITEM then
    return FightBagMgr:get_item_num_by_id(item_id)
  elseif bag_type == GEM_STONE_TYPE then
    return GemStoneMgr:get_gem_num_by_id(item_id)
  elseif bag_type == PUZZLE_TYPE then
    return PuzzleMgr:get_own_puzzle_num_by_id(item_id)
  end
  if item_id <= Config.RES_DIVISION_VAL then
    num = CharacterMgr:get_res_val(item_id)
  elseif self.v_id2_grids[item_id] then
    for i = 1, #list do
      num = num + list[i].count
    end
  end
  return num
end

function M:get_cost_enough(item_id, count)
  count = count or 0
  return count <= self:get_item_num(item_id)
end

function M:get_bag(bag_type)
  return self.v_items[bag_type]
end

function M:get_item_count_by_bag_type(bag_type)
  return self.v_items[bag_type] and #self.v_items[bag_type] or 0
end

function M:get_item_list_by_type(item_type, item_sub_type, bag_type)
  local item_cfg = ShareRes.create("item.item")
  local item_list = {}
  for _, item_info in pairs(self.v_items[bag_type]) do
    local item_data = item_cfg[item_info.id]
    if item_data.Subtype == item_sub_type and item_type == item_data.Type then
      _tinsert(item_list, item_info)
    end
  end
  return item_list
end

function M:get_chapter_item(chapter_id)
  local dp_chapter_type_name = "dp_item"
  local item_cfg = ShareRes.create("item.item")
  local type_cfg = ShareRes.create("item.item_subtype", dp_chapter_type_name)
  local item_type = type_cfg.TypeId
  local item_sub_type = type_cfg.SubtypeId
  for _, item_info in pairs(self.v_items[item_type]) do
    local item_data = item_cfg[item_info.id]
    if item_data.Subtype == item_sub_type and item_data.Arg[1] == chapter_id then
      return item_info
    end
  end
end

local SPETIAL_REWARD_PROCESS = {
  [CommonDefine.SYSTEM_TYPE.SIGN_IN] = function(award_list)
    local commcfg = ShareRes.create("commcfg.system_commcfg")
    Timer:add_timer("sign_in_award_show", commcfg.SignInGetItemDelayTime.value, function()
      UIMgr:get_ui("award_show_panel"):ui_show(award_list)
    end)
  end,
  [CommonDefine.SYSTEM_TYPE.RECHARGE] = function(award_list)
    for index = #award_list, 1, -1 do
      local id = award_list[index].id
      local type_config = Util.get_item_type_cfg(id)
      if type_config.AwardType == Config.AWARD_TYPE.FASHION then
        local skin_cfg = ShareRes.create("buddy.buddy_fashion", id)
        if skin_cfg and (skin_cfg.Icon[8] or skin_cfg.Icon[7]) then
          UIMgr:add_ui_queue(Config.UI_QUEUE_GROUP.Recharge_Reward, "ui_fashion_show", id)
          table.remove(award_list, index)
        end
      end
    end
    if #award_list > 0 then
      UIMgr:add_ui_queue(Config.UI_QUEUE_GROUP.Recharge_Reward, "award_show_panel", award_list)
    end
  end,
  [CommonDefine.SYSTEM_TYPE.PLAYER_UPGRADE] = function(award_list)
    UIMgr:add_ui_queue(Config.UI_QUEUE_GROUP.Lv_Up_Reward, "award_show_panel", award_list)
  end,
  [CommonDefine.SYSTEM_TYPE.DRAW] = function(award_list)
    if not M.check_new_char(award_list, true) then
      UIMgr:add_ui_queue(Config.UI_QUEUE_GROUP.Common_Reward, "award_show_panel", award_list)
    end
  end,
  [CommonDefine.SYSTEM_TYPE.RELIC] = function(award_list)
    Timer:add_timer("relic_overflow_award_show", 0.6, function()
      UIMgr:get_ui("award_show_panel"):ui_show(award_list)
    end)
  end,
  [CommonDefine.SYSTEM_TYPE.CHAIN_CENTRE] = function(award_list)
    Timer:add_timer("relic_overflow_award_show", 0.6, function()
      UIMgr:get_ui("award_show_panel"):ui_show(award_list)
    end)
  end,
  [CommonDefine.SYSTEM_TYPE.RELEASE_DESTINY_LEVEL] = function(award_list)
    UIMgr:get_ui("award_show_panel"):ui_show(award_list)
  end,
  [CommonDefine.SYSTEM_TYPE.RECLAIM_ITEM] = function(award_list)
    M:add_award_list_to_delay_list(award_list)
  end,
  [CommonDefine.SYSTEM_TYPE.BUDDY_EXCHANGE_ITEM] = function(award_list)
    local target_view = UIMgr:try_get_visible_ui("uidrawcard_choose_award")
    if target_view then
      BagMgr:show_award_exchange(award_list)
    end
  end,
  [CommonDefine.SYSTEM_TYPE.BUILDING_EXCLUSIVE_TASK] = function(award_list)
    BuildingMgr:record_adventrue_task_award(award_list)
  end,
  [CommonDefine.SYSTEM_TYPE.ACTIVITY_GOLD_EQUIP] = function(award_list)
    M.weapon_activity_get_award(award_list)
  end,
  [CommonDefine.SYSTEM_TYPE.BATTLE_PASSPORT_AWARD] = function(award_list)
    UIMgr:add_ui_queue(Config.UI_QUEUE_GROUP.Common_Reward, "ui_monthtask_award_show_panel", award_list)
  end,
  [CommonDefine.SYSTEM_TYPE.ADVENTURE_TASK_BOX] = function(award_list)
    UIMgr:get_ui("ui_treasure_chest_award"):ui_show(award_list)
  end,
  [CommonDefine.SYSTEM_TYPE.SHOOTING_GAME] = function(award_list)
    Timer:add_timer("shooting_game_award_show", 1.8, function()
      UIMgr:get_ui("award_show_panel"):ui_show(award_list)
    end)
  end
}

function M:update(elapsed)
  if not delay_award_list then
    return
  end
  if TowerMgr and TowerMgr:get_tower() then
    return
  end
  if UIMgr:get_cur_show_ui_name() ~= "uimain" then
    return
  end
  delay_award_time = delay_award_time + elapsed
  if delay_award_time >= 10 then
    self:show_auto_use_tips(delay_award_list)
    delay_award_list = nil
    delay_award_time = 0
  end
end

function M:show_auto_use_tips(award_list)
  local tips = ""
  for item_id, count in pairs(auto_use_item_list) do
    local item_cfg = ShareRes.create("item.item", item_id)
    if item_cfg then
      if "" ~= tips then
        tips = tips .. "、"
      end
      tips = tips .. Util.format_str("[{1}]x{2}", item_cfg.Name, count)
    end
  end
  if "" ~= tips then
    tips = Util.format_str("<color=red>{1}</color>已过期，已自动使用！", tips)
    UIMgr:get_ui("uinotice_tips"):ui_show(function()
      UIMgr:get_ui("award_show_panel"):ui_show(award_list)
    end, nil, tips, nil, nil, nil, true)
    auto_use_item_list = {}
  else
    UIMgr:get_ui("award_show_panel"):ui_show(award_list)
  end
end

function M:add_award_list_to_delay_list(award_list)
  if not delay_award_list then
    delay_award_list = {}
  end
  for i, need_show_award in pairs(award_list) do
    local is_have = false
    for idx, award in pairs(delay_award_list) do
      if award.id == need_show_award.id then
        award.count = award.count + need_show_award.count
        is_have = true
        break
      end
    end
    if not is_have then
      table.insert(delay_award_list, need_show_award)
    end
  end
  delay_award_time = 0
end

function M:show_reward_list(award_data)
  self.award_list = award_data.award_list
  if 1 == #self.award_list and (self.award_list[1].id == Config.DAILY_TASK_POINT or self.award_list[1].id == Config.WEEKLY_TASK_POINT) then
    return
  end
  local spetial_process = SPETIAL_REWARD_PROCESS[award_data.source_system_id]
  if spetial_process then
    spetial_process(self.award_list)
  else
    local tower = TowerMgr:get_tower()
    if tower and TowerMgr:get_fight_type() == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER or award_data.source_system_id == Config.CommonDefine.SYSTEM_TYPE.CHAPTER or award_data.source_system_id == Config.CommonDefine.SYSTEM_TYPE.VERSION_EPISODE then
      TowerMgr:record_long_chapter_award(self.award_list)
    elseif not M.check_new_char(self.award_list) then
      UIMgr:add_ui_queue(Config.UI_QUEUE_GROUP.Common_Reward, "award_show_panel", self.award_list)
    end
  end
end

function M.check_new_char(award_list, include_old)
  if not award_list or next(award_list) == nil then
    return
  end
  local new_char_list = {}
  for _, v in ipairs(award_list) do
    local type_config = Util.get_item_type_cfg(v.id)
    if type_config.AwardType == Config.AWARD_TYPE.CHARA then
      local is_new = M.check_new(v.id)
      if is_new or include_old then
        local length = #new_char_list + 1
        new_char_list[length] = {
          item_id = v.id,
          is_new = is_new,
          get_index = length,
          has_extra = false
        }
      end
    end
  end
  if not new_char_list or next(new_char_list) == nil then
    return
  end
  local uimain = UIMgr:try_get_ui("uimain")
  if uimain and uimain:prepare_fo_draw_movie_panel() then
    local function hide_cb()
      local _uimain = UIMgr:try_get_ui("uimain")
      
      if _uimain then
        _uimain:reset_after_draw_movie_panel()
      end
    end
    
    UIMgr:get_ui("uidrawcard_movie_panel"):ui_show(new_char_list, false, award_list, nil, hide_cb)
    return true
  end
end

function M.weapon_activity_get_award(award_list)
  if UtilTable.is_empty(award_list) then
    return
  end
  local new_char_list = {}
  for _, v in ipairs(award_list) do
    local is_new = M.check_new(v.id)
    local length = #new_char_list + 1
    new_char_list[length] = {
      item_id = v.id,
      is_new = is_new,
      get_index = length,
      has_extra = false
    }
  end
  local uimain = UIMgr:try_get_ui("uimain")
  if uimain and uimain:prepare_fo_draw_movie_panel() then
    local function hide_cb()
      local _uimain = UIMgr:try_get_ui("uimain")
      
      if _uimain then
        _uimain:reset_after_draw_movie_panel()
      end
    end
    
    UIMgr:get_ui("uidrawcard_movie_panel"):ui_show(new_char_list, false, award_list, nil, hide_cb)
    return true
  end
end

function M.check_new(item_id)
  local buddy_config = ShareRes.get_buddy_cfg(item_id) or {}
  local buddy_id = buddy_config.Id or 0
  return CharacterMgr:is_buddy_new(buddy_id)
end

function M:show_award_exchange(award_data)
  UIMgr:get_ui("side_pop_item_tips"):ui_show(award_data.award_list or award_data)
end

function M:get_min_remain_time_item()
  local item_list = self:get_bag(2) or {}
  local cur_min_remain, cur_min_item_id
  for _, item_info in pairs(item_list) do
    if item_info.end_time and item_info.end_time > 0 then
      local remain_time = item_info.end_time - Date.server_time()
      if remain_time > 0 then
        if not cur_min_remain then
          cur_min_remain = remain_time
          cur_min_item_id = item_info.id
        elseif remain_time < cur_min_remain then
          cur_min_remain = remain_time
          cur_min_item_id = item_info.id
        end
      end
    end
  end
  if cur_min_remain then
    return cur_min_remain, cur_min_item_id
  end
end

function M:is_show_bag_red(return_time)
  local item_list = self:get_bag(2) or {}
  local item_cfg, remain_time
  local is_overdue_list = {}
  local all_not_tip = true
  for k, item in pairs(item_list) do
    item_cfg = ShareRes.create("item.item", item.id)
    if item_cfg.end_time and item_cfg.end_time > 0 then
      remain_time = item.end_time - Date.server_time()
      if return_time then
        table.insert(is_overdue_list, remain_time)
      else
        return true
      end
    end
    if Util.need_check_server_redpoint(item_cfg.Type, item_cfg.Subtype) and 0 == item.not_tip then
      RedPointMgr:enable_redpoint(RedEnum.BAG_ITEM, true)
      all_not_tip = false
      if not return_time then
        return true
      end
    end
  end
  if all_not_tip then
    RedPointMgr:enable_redpoint(RedEnum.BAG_ITEM, false)
  end
  if #is_overdue_list > 0 then
    table.sort(is_overdue_list, function(w1, w2)
      if w1 ~= w2 then
        return w1 < w2
      end
    end)
    return is_overdue_list[1]
  else
    return nil
  end
end

function M:decompose_item(item, callback)
  Network:call("c2gs_decompose_item", {
    item.uuid,
    item.id,
    item.count
  }, function(ok, resp)
    callback()
  end)
end

function M:request_use_item(consumeList, callback)
  Network:call("c2gs_use_items", {consume_list = consumeList}, function(ok, resp)
    callback(ok, resp.errcode)
  end)
end

function M:decompose_equip(uuid_list)
  local _, privilege_id = NewbieTowerMgr:check_have_resolve_privilege()
  Network:call("c2gs_decompose_equip", {uuid_list = uuid_list, newbie_privilege_id = privilege_id}, function(ok, resp)
  end)
end

function M:sell_item(uuid, id, num)
  Network:call("c2gs_decompose_item", {
    uuid = uuid,
    id = id,
    count = num
  }, function(ok, resp)
  end)
end

function M:discard_item(discardlist, callback)
  Network:call("c2gs_discard_items", {discard_list = discardlist}, function(ok, resp)
    if ok and callback then
      callback(ok, resp.errcode)
    end
  end)
end

function M:item_synthesis(send_data, callback)
  Network:call("c2gs_combine_items", send_data, function(ok, resp)
    if ok then
      if callback then
        callback()
      end
      MsgGame:mq_publish2(Const.MSG_ON_ITEM_SYNTHESIS)
    end
  end)
end

function M:request_item_recover_time(id, callback)
  Network:call("c2gs_item_recover_time", {id = id}, function(ok, resp)
    Log.Info("c2gs_item_recover_time resp = ", resp)
    callback(resp)
  end)
end

function M:close_item_not_tip(uuid)
  if self.v_item_maps[uuid] then
    self.v_item_maps[uuid].not_tip = 1
  end
  self:is_show_bag_red()
end

function M:request_infinite_gain_score_reward(callback)
  Network:call("c2gs_infinite_gain_score_reward", {}, function(ok, resp)
    if ok then
      ChapterEndlessMgr:update_endless_award_bit(resp.reward_bit)
      callback(resp)
    end
  end)
end

function M:get_auto_select_box(item_id)
  local list = {}
  local type_list = self:get_bag(2)
  local sub_type = CommonDefine.CONSUMABLE_ITEM_SUB_TYPE
  for idx, item_info in pairs(type_list) do
    local item_cfg = ShareRes.create("item.item", item_info.id)
    if item_cfg.Subtype ~= sub_type.TREASURE_CHEST_SELECT and item_cfg.Subtype ~= sub_type.AWARD_ITEM then
    else
      local award_group = ShareRes.create("award.award_group", item_cfg.Arg[1])
      local is_have = false
      for i, award_id in ipairs(award_group) do
        if award_id <= 0 then
        else
          local award_config = ShareRes.create("award.award", award_id)
          if award_config.ItemId == item_id then
            is_have = true
            break
          end
        end
      end
      if is_have then
        local item_data = {}
        item_data.item_cfg = item_cfg
        item_data.item_info = item_info
        table.insert(list, item_data)
      end
    end
  end
  return list
end

function M:check_item_end_time()
  if not is_need_show_item_remain_time_tips then
    return
  end
  local item_names
  for bag_type, bag_list in pairs(self.v_items) do
    for uuid, item in pairs(bag_list) do
      if item.end_time and item.end_time > 0 and item.end_time - Date.server_time() <= ONE_DAY_SECS then
        local item_cfg = ShareRes.create("item.item", item.id)
        if not item_cfg then
          Log.Error("item.id", item.id)
        end
        local item_name = "[" .. item_cfg.Name .. "]"
        if not item_names then
          item_names = ""
          item_names = item_names .. item_name
        else
          item_names = item_names .. "," .. item_name
        end
      end
    end
  end
  if not item_names then
    return
  end
  is_need_show_item_remain_time_tips = false
  local tips = "部分道具即将过期：<color=red>" .. item_names .. "</color>"
  UIMgr:add_ui_queue(Config.UI_QUEUE_GROUP.Task_Notice, "uinotice_tips", function()
  end, nil, tips, "确认", nil, nil, true)
end

function M:set_is_need_show_item_remain_time_tips(value)
  is_need_show_item_remain_time_tips = value
end

function M:on_auto_use_reclaim_item(data)
  if not data.item_list then
    return
  end
  local item_names
  for _, item in pairs(data.item_list) do
    local item_cfg = ShareRes.create("item.item", item.id)
    local item_name = "[" .. item_cfg.Name .. "]"
    if not item_names then
      item_names = ""
      item_names = item_names .. item_name
    else
      item_names = item_names .. "," .. item_name
    end
    if item.count > 1 then
      item_names = item_names .. "*" .. tostring(item.count)
    end
  end
  local tips = "<color=red>" .. item_names .. "</color>" .. "已过期,已使用"
  UIMgr:add_ui_queue(Config.UI_QUEUE_GROUP.Task_Notice, "uinotice_tips", nil, nil, tips)
end

function M:on_all_server_win_pop_finish()
  self:check_item_end_time()
end

function M:get_sort_award_list(award_list)
  if not award_list or next(award_list) == nil then
    return nil
  end
  local have_exp_item = false
  local is_need_sort = true
  for i, v in pairs(award_list) do
    local item_cfg = Item_Helper.get_item_cfg(v.id)
    if nil == item_cfg or nil == item_cfg.Quality then
      is_need_sort = false
      break
    end
    v.Quality = item_cfg.Quality
    v.Priority = item_cfg.Priority or 0
    if v.id == Config.EXP_ITEMID then
      have_exp_item = true
    end
  end
  if have_exp_item then
    PlayerMgr:try_show_exp_up_tips()
  end
  if true == is_need_sort then
    table.sort(award_list, function(a, b)
      if a.Quality ~= b.Quality then
        return a.Quality > b.Quality
      end
      if a.Priority ~= b.Priority then
        return a.Priority > b.Priority
      end
      return a.id > b.id
    end)
  end
  return award_list
end

function M:check_item_expiring(item_id)
  if not item_id then
    return false
  end
  local item_list = self.v_id2_grids[item_id]
  if not item_list or 0 == #item_list then
    return false
  end
  local server_time = Date.server_time()
  for _, item in ipairs(item_list) do
    if item and item.end_time and item.end_time > 0 then
      local remain_time = item.end_time - server_time
      if remain_time <= ONE_DAY_SECS and remain_time > 0 then
        return true
      end
    end
  end
  return false
end

function M:get_item_num_include_synthesis(item_id)
  return self:get_item_num(item_id) + self:cal_can_synthesis_count(item_id)
end

function M:cal_can_synthesis_count(item_id)
  local combine_id = self:get_item_combine_id(item_id)
  if not combine_id then
    return 0
  end
  local combine_cfg = ShareRes.get_item_combine_cfg(combine_id)
  local child_item_id = combine_cfg.Material[1]
  local need_count = combine_cfg.Num[1]
  local child_count = self:get_item_num_include_synthesis(child_item_id)
  return math.floor(child_count / need_count)
end

function M:get_item_combine_id(item_id)
  if not item_id then
    return
  end
  local combine_alias = ShareRes.get_item_combine_alias(item_id)
  if not combine_alias or not next(combine_alias) then
    return
  end
  local combine_id = combine_alias[next(combine_alias)]
  return BuildingMgr:get_replace_item_combine_id(combine_id) or combine_id
end

return M
