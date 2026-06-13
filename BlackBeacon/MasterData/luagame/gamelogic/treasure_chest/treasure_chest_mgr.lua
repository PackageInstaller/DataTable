local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local TreasureChestCfg = require("uimodule.treasure_chest.treasure_chest_configs")
local CURSE_RING_CONTRIBUTION_POINT = 28
local Item_Helper = require("utils.item_helper")
local LocalStorage = require("utils.localstorage")
local TOGGLE_TYPE = TreasureChestCfg.TOGGLE_TYPE
local CARD_IMG_NAME = Config.CARD_IMG_NAME
local FILE_PATH = "UIEvent03/Settle/"
local TREASURE_CHEST_TYPE = TreasureChestCfg.TREASURE_CHEST_TYPE
local commonDef = require("cs_share.common_define")
local _tinsert = table.insert
local _tsort = table.sort
local _tremove = table.remove

local function treasure_chest_sort(a, b)
  local a_is_show = a.is_show
  local b_is_show = b.is_show
  local a_quality = a.item_cfg.Quality
  local b_quality = b.item_cfg.Quality
  local a_priority = a.item_cfg.Priority
  local b_priority = b.item_cfg.Priority
  local a_id = a.item_cfg.Id
  local b_id = b.item_cfg.Id
  local a_uuid = a.info.uuid
  local b_uuid = b.info.uuid
  if a_is_show == b_is_show then
    if a_quality == b_quality then
      if a_priority == b_priority then
        if a_id == b_id then
          return a_uuid < b_uuid
        else
          return a_id < b_id
        end
      else
        return a_priority > b_priority
      end
    else
      return a_quality > b_quality
    end
  else
    return a_is_show > b_is_show
  end
end

function M:init_sys()
  Base.init_sys(self)
  self.v_treasure_chest_list = {}
  self:sys_mq_bind(Const.MSG_ON_ITEM_UPDATE, self.reset_treasure_chest_list, self)
  self.treasure_chest_type = {}
  self.card_drag_state_list = {}
  self.choose_award_list = {}
  self.flip_card_award = {}
  self.history_choose_award = {}
  self.card_total_count = 0
  local item_filter_cfg = ShareRes.create("item.treasure_chest_filter")
  for index, data in ipairs(item_filter_cfg) do
    self.treasure_chest_type[index + 1] = index
  end
  self.v_contains_box_chapter_page_list = {
    Config.Chapter_Page.MAINLINE,
    Config.Chapter_Page.OUTER
  }
end

function M:exit_tower()
  self.card_drag_state_list = {}
  self.choose_award_list = {}
  self.flip_card_award = {}
  self.history_choose_award = {}
  self.card_total_count = 0
end

local function _sort_func(a, b)
  local x = 0
  local y = 0
  if a.Priority then
    x = x + a.Priority * 10000000
  end
  if b.Priority then
    y = y + b.Priority * 10000000
  end
  x = x + a.qulity * 100000000 - a.item_cfg.Id
  y = y + b.qulity * 100000000 - b.item_cfg.Id
  if a.count and 0 == a.count then
    x = 0
  end
  if b.count and 0 == b.count then
    y = 0
  end
  if x ~= y then
    return x > y
  end
  return false
end

function M:reset_treasure_chest_list()
  self:set_treasure_chest_list()
end

function M:set_treasure_chest_list()
  local treasure_chest_list = self.v_treasure_chest_list or {}
  self.v_treasure_chest_dict = {}
  local treasure_chest_dict = self.v_treasure_chest_dict
  UtilTable.clear_list(treasure_chest_list)
  local item_cfg
  local treasure_chest_cfg_list = ShareRes.create("item.treasure_chest")
  local bag_treasure_chest_list = BagMgr:get_bag(TreasureChestCfg.TREASURE_CHEST_TYPE) or {}
  for _, data in pairs(bag_treasure_chest_list) do
    item_cfg = ShareRes.create("item.item", data.id)
    local temp = {
      item_cfg = item_cfg,
      treasure_chest_cfg = treasure_chest_cfg_list[item_cfg.Arg[1]],
      info = data,
      is_show = 1,
      qulity = item_cfg.Quality,
      priority = item_cfg.Priority,
      img_name = FILE_PATH .. CARD_IMG_NAME[data.id]
    }
    local table = treasure_chest_dict[data.id]
    if not table then
      treasure_chest_dict[data.id] = {}
      table = treasure_chest_dict[data.id]
    end
    _tinsert(table, temp)
    _tinsert(treasure_chest_list, temp)
  end
  _tsort(treasure_chest_list, treasure_chest_sort)
  self.v_treasure_chest_dict = treasure_chest_dict
  self.v_treasure_chest_list = treasure_chest_list
end

local function _update_tb(uuid, count, tb)
  for index, data in pairs(tb) do
    if data.info.uuid == uuid then
      data.info.count = data.info.count - count
      if data.info.count <= 0 then
        tb[index] = nil
      end
      break
    end
  end
end

function M:update_treasure_chest_list(delete_data, count)
  count = count or 1
  _update_tb(delete_data.info.uuid, count, self.v_treasure_chest_list)
  local tb = self.v_treasure_chest_dict[delete_data.info.id]
  _update_tb(delete_data.info.uuid, count, tb)
end

function M:filter_treasure_chest_list(toggle_index)
  local show_list = self.v_show_list or {}
  UtilTable.clear_list(show_list)
  local item_relation_filter_cfg = ShareRes.create("item.treasure_chest_relation_filter")
  for _, data in pairs(self.v_treasure_chest_list) do
    data.is_show = (toggle_index == TOGGLE_TYPE.ALL or self.treasure_chest_type[toggle_index] == item_relation_filter_cfg[data.item_cfg.Id].RelationID) and 1 or 0
    if 0 ~= data.is_show then
      _tinsert(show_list, data)
    end
  end
  self.v_show_list = show_list
  return self.v_show_list
end

function M:get_treasure_chest(itemId)
  if not self.v_treasure_chest_dict or next(self.v_treasure_chest_dict) == nil then
    self:set_treasure_chest_list()
  end
  if self.v_treasure_chest_dict[itemId] then
    return self.v_treasure_chest_dict[itemId]
  end
end

function M:get_treasure_chest_dict()
  if not self.v_treasure_chest_dict or next(self.v_treasure_chest_dict) == nil then
    self:set_treasure_chest_list()
  end
  return self.v_treasure_chest_dict
end

function M:get_treasure_chest_list_ex(rule_out_list)
  local treasure_chest_dict = UtilTable.copy_table(self:get_treasure_chest_dict())
  if rule_out_list and next(rule_out_list) ~= nil then
    for key, data in pairs(rule_out_list) do
      local real_data = treasure_chest_dict[data.id][1]
      local count = real_data.info.count - data.count
      if count <= 0 then
        treasure_chest_dict[data.id] = nil
      end
    end
  end
  local tb = {}
  for key, list in pairs(treasure_chest_dict) do
    table.insert(tb, list)
  end
  return tb
end

function M:get_treasure_chest_count()
  local count = 0
  if self.v_treasure_chest_list == nil or nil == next(self.v_treasure_chest_list) then
    self:set_treasure_chest_list()
  end
  for key, value in pairs(self.v_treasure_chest_list) do
    count = value.info.count + count
  end
  return count
end

function M:get_discard_card_data(discard_data)
  local list = self.v_treasure_chest_dict[discard_data.id]
  local discard_list = {}
  local index = 1
  local need_count = discard_data.count
  local total_count = 0
  while need_count > total_count do
    local info = list[index].info
    if need_count >= info.count + total_count then
      table.insert(discard_list, {
        uuid = info.uuid,
        count = info.count
      })
      total_count = total_count + info.count
    else
      table.insert(discard_list, {
        uuid = info.uuid,
        count = need_count - total_count
      })
      total_count = total_count + info.count
    end
  end
  return discard_list
end

function M:reset_show_state()
  for _, data in pairs(self.v_treasure_chest_list) do
    data.is_show = 1
  end
end

function M:refresh_treasure_chest_red()
  local treasure_chest_list = BagMgr:get_bag(TreasureChestCfg.TREASURE_CHEST_TYPE) or {}
  if next(treasure_chest_list) == nil then
    RedPointMgr:enable_redpoint(RedEnum.TREASURE_CHEST, false)
  else
    local consume_list = {}
    local item_cfg, treasure_chest_cfg
    local treasure_chest_cfg_list = ShareRes.create("item.treasure_chest")
    for _, data in pairs(treasure_chest_list) do
      item_cfg = ShareRes.create("item.item", data.id)
      treasure_chest_cfg = treasure_chest_cfg_list[item_cfg.Arg[1]]
      if nil == consume_list[treasure_chest_cfg.itemID] then
        consume_list[treasure_chest_cfg.itemID] = treasure_chest_cfg.itemCount
      elseif consume_list[treasure_chest_cfg.itemID] > treasure_chest_cfg.itemCount then
        consume_list[treasure_chest_cfg.itemID] = treasure_chest_cfg.itemCount
      end
    end
    for id, count in pairs(consume_list) do
      if count <= BagMgr:get_item_num(id) then
        RedPointMgr:enable_redpoint(RedEnum.TREASURE_CHEST, true)
        return
      end
    end
    RedPointMgr:enable_redpoint(RedEnum.TREASURE_CHEST, false)
  end
end

function M:flip_card(data)
  if data and data[1] then
    local function callback(ok)
      if ok then
        UIMgr:get_ui("flip_card"):ui_show(data[1], BagMgr.flip_card_award_list)
      end
    end
    
    local consume_list = {
      bag_type = TreasureChestCfg.TREASURE_CHEST_TYPE,
      item_list = {
        {
          uuid = data[1].info.uuid,
          count = 1
        }
      }
    }
    BagMgr:request_use_item(consume_list, callback)
  end
end

function M:discard_card(data, callback)
  local discard_list = {
    bag_type = TreasureChestCfg.TREASURE_CHEST_TYPE,
    item_list = {}
  }
  if data and data[1] then
    local tb = {
      uuid = data[1].info.uuid,
      count = 1
    }
    table.insert(discard_list.item_list, tb)
    BagMgr:discard_item(discard_list, callback)
  else
    UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("数据错误"))
  end
end

function M:discard_card_by_list(data_list, callback)
  local discard_list = {
    bag_type = TreasureChestCfg.TREASURE_CHEST_TYPE,
    item_list = data_list
  }
  BagMgr:discard_item(discard_list, callback)
end

function M:check_card_pack_is_fully()
  return self:get_treasure_chest_count() >= tonumber(ShareRes.create("item.award_type", TreasureChestCfg.TREASURE_CHEST_TYPE).MaxGrid)
end

function M:recore_award_tf(award_tf)
  self.v_recore_award_tf = award_tf
end

function M:get_award_tf()
  return self.v_recore_award_tf
end

function M:set_crad_drag_state(item_id, is_drag)
  self.card_drag_state_list[item_id] = is_drag
end

function M:get_crad_drag_state(item_id)
  return self.card_drag_state_list[item_id]
end

function M:reset_crad_drag_state()
  self.card_drag_state_list = {}
end

function M:reset_crad_drag_state()
  self.card_drag_state_list = {}
end

function M:build_choose_award_list(old_choose_award_list, tower_progress)
  local treasure_chest_cfg_list = ShareRes.create("item.treasure_chest")
  local award_list = old_choose_award_list or {}
  if award_list[CURSE_RING_CONTRIBUTION_POINT] then
    award_list[CURSE_RING_CONTRIBUTION_POINT] = nil
  end
  TreasureChestMgr:record_flip_card_award_dict(tower_progress.history_reward or {})
  self.card_total_count = 0
  for key, award_data in pairs(award_list) do
    local item_cfg = Item_Helper.get_item_cfg(award_data.id)
    award_data.qulity = item_cfg.Quality
    award_data.priority = item_cfg.Priority
    award_data.img_name = FILE_PATH .. CARD_IMG_NAME[award_data.id]
    award_data.item_cfg = item_cfg
    award_data.treasure_chest_cfg = treasure_chest_cfg_list[item_cfg.Arg[1]]
    self.card_total_count = self.card_total_count + award_data.count
    table.insert(self.choose_award_list, award_data)
  end
  table.sort(self.choose_award_list, _sort_func)
  self.history_choose_award = tower_progress.history_choose_item or {}
  for key, choose_reward in pairs(self.history_choose_award) do
    local actions = choose_reward.history_action
    for index, action in ipairs(actions) do
      if action.status == commonDef.CHOOSE_ITEM_STATUS.IN_BAG then
        self:record_flip_card_award({
          id = choose_reward.id,
          count = action.count
        })
      end
    end
  end
end

function M:add_card_total_count(add)
  self.card_total_count = self.card_total_count + add
end

function M:get_card_total_count()
  return self.card_total_count
end

function M:record_history_choose_award(award_list)
  self.history_choose_award = award_list
end

function M:get_history_choose_award()
  return self.history_choose_award
end

function M:record_choose_award_list(award_list)
  self.choose_award_list = award_list
end

function M:get_choose_award_list()
  return self.choose_award_list
end

function M:sort_award_list()
  table.sort(self.choose_award_list, _sort_func)
end

function M:check_can_oper_card(item_id)
  for key, award_data in pairs(self.choose_award_list) do
    if award_data.id == item_id then
      return award_data.count - 1 >= 0
    end
  end
  return false
end

function M:on_oper_card(item_id)
  for key, award_data in pairs(self.choose_award_list) do
    if award_data.id == item_id then
      if award_data.count - 1 >= 0 then
        award_data.count = award_data.count - 1
        return true
      else
        return false
      end
    end
  end
  return false
end

function M:reset_choose_award_list()
  self.choose_award_list = {}
end

function M:record_flip_card_award_dict(award_dict)
  self.flip_card_award = award_dict
end

function M:record_flip_card_award(data)
  if self.flip_card_award[data.id] then
    self.flip_card_award[data.id].count = self.flip_card_award[data.id].count + data.count
  else
    self.flip_card_award[data.id] = data
  end
end

function M:get_flip_card_award_dict()
  return self.flip_card_award
end

local RED_BOX_LIST_KEY = "RED_BOX_LIST_KEY"
local scene_treasure_chest_list = {}
local group_max_list = {}
local group_box_cfg_list = {}
local red_box_list = {}
local last_building_box_id = 0

function M:on_scene_treasure_chest_init(data)
  if not data then
    return
  end
  local list = data.box_list
  if not list then
    return
  end
  scene_treasure_chest_list = {}
  group_max_list = {}
  group_box_cfg_list = {}
  for idx, box_id in pairs(list) do
    scene_treasure_chest_list[box_id] = 1
  end
  local treasure_chest_cfg = ShareRes.create("episode_box.episode_box")
  for _, cfg in pairs(treasure_chest_cfg) do
    if not group_box_cfg_list[cfg.BoxGroup] then
      group_box_cfg_list[cfg.BoxGroup] = {}
    end
    table.insert(group_box_cfg_list[cfg.BoxGroup], cfg)
    if group_max_list[cfg.BoxGroup] then
      group_max_list[cfg.BoxGroup] = group_max_list[cfg.BoxGroup] + 1
    else
      group_max_list[cfg.BoxGroup] = 1
    end
  end
  red_box_list = LocalStorage:load_table(RED_BOX_LIST_KEY, true)
  if not red_box_list then
    red_box_list = {}
  end
end

function M:on_scene_treasure_chest_refresh(data)
  if not data then
    return
  end
  self:on_trigger_scene_treasure_chest(data.box_id)
  if data.is_building then
    last_building_box_id = data.box_id
  end
  red_box_list[data.box_id] = 1
  LocalStorage:save_table(RED_BOX_LIST_KEY, red_box_list, true)
end

function M:get_last_building_box_id()
  return last_building_box_id
end

function M:reset_last_building_box_id()
  last_building_box_id = nil
end

function M:get_is_need_show_chapter_box_red_key()
  return "is_need_show_chapter_box_red"
end

function M:get_is_need_show_chapter_box_red()
  local is_need_show = 0 == LocalStorage:load_int(self:get_is_need_show_chapter_box_red_key(), 0, true)
  local is_condition_finish = Condition:check_condition(28123)
  if is_need_show and is_condition_finish then
    return true
  end
  return false
end

function M:on_chapter_box_progress_click()
  LocalStorage:save_int(self:get_is_need_show_chapter_box_red_key(), 1, true)
end

function M:get_is_need_show_red(chapter_id)
  if not next(red_box_list) then
    return false
  end
  local node_cfg_list = M:get_box_node_cfg_list(chapter_id)
  for _, node_cfg in pairs(node_cfg_list) do
    local box_cfg_list = TreasureChestMgr:get_box_cfg_list(node_cfg.BoxGroupId)
    if box_cfg_list then
      for _, box_cfg in pairs(box_cfg_list) do
        if red_box_list[box_cfg.Id] then
          return true
        end
      end
    else
      Log.Error("节点配了宝箱组id, 但是关卡宝箱表找不到对应id", node_cfg.BoxGroupId)
    end
  end
  return false
end

function M:reset_box_red(chapter_id)
  if not next(red_box_list) then
    return
  end
  local node_cfg_list = M:get_box_node_cfg_list(chapter_id)
  for _, node_cfg in pairs(node_cfg_list) do
    local box_cfg_list = TreasureChestMgr:get_box_cfg_list(node_cfg.BoxGroupId)
    if box_cfg_list then
      for _, box_cfg in pairs(box_cfg_list) do
        if red_box_list[box_cfg.Id] then
          red_box_list[box_cfg.Id] = nil
        end
      end
    end
  end
  LocalStorage:save_table(RED_BOX_LIST_KEY, red_box_list, true)
end

function M:get_is_building(box_id)
  return red_box_list[box_id]
end

function M:reset_build_box_list(chapter_id)
  local node_cfg_list = M:get_box_node_cfg_list(chapter_id)
  local is_need_save
  for _, node_cfg in pairs(node_cfg_list) do
    local box_cfg_list = TreasureChestMgr:get_box_cfg_list(node_cfg.BoxGroupId)
    for _, box_cfg in pairs(box_cfg_list) do
      if red_box_list[box_cfg.Id] then
        red_box_list[box_cfg.Id] = nil
        is_need_save = true
      end
    end
  end
  if is_need_save then
    LocalStorage:save_table(RED_BOX_LIST_KEY, red_box_list, true)
  end
end

function M:on_trigger_scene_treasure_chest(box_id)
  if not box_id then
    return
  end
  scene_treasure_chest_list[box_id] = 1
end

function M:get_treasure_chest_is_finished(box_id)
  return 1 == scene_treasure_chest_list[box_id]
end

function M:get_scene_treasure_chest_count(group)
  local finish_count = 0
  local max_count = 0
  local box_cfg_list = group_box_cfg_list[group]
  if not box_cfg_list then
    return 0, 0
  end
  for _, box_cfg in pairs(box_cfg_list) do
    max_count = max_count + 1
    if scene_treasure_chest_list[box_cfg.Id] then
      finish_count = finish_count + 1
    end
  end
  return finish_count, max_count
end

function M:get_box_node_cfg_list(chapter_id)
  local node_cfg_list = ShareRes.get_chapter_all_node_id_by_chapter_id(chapter_id)
  if not node_cfg_list then
    return nil
  end
  local box_node_list = {}
  for _, node_cfg in pairs(node_cfg_list) do
    local box_group_id = node_cfg.BoxGroupId
    if box_group_id and box_group_id > 0 then
      table.insert(box_node_list, node_cfg)
    end
  end
  return box_node_list
end

function M:get_box_cfg_list(group_id)
  if group_id then
    return group_box_cfg_list[group_id]
  end
  return group_box_cfg_list
end

function M:get_chapter_treasure_chest_count(chapter_id)
  local node_cfg_list = ShareRes.get_chapter_all_node_id_by_chapter_id(chapter_id)
  if not node_cfg_list then
    return 0, 0
  end
  local box_group_list = {}
  for i, node_cfg in pairs(node_cfg_list) do
    local box_group_id = node_cfg.BoxGroupId
    if box_group_id and box_group_id > 0 and not box_group_list[box_group_list] then
      box_group_list[box_group_id] = 1
    end
  end
  local total_finish_count = 0
  local total_count = 0
  for box_group_id, v in pairs(box_group_list) do
    local finish_count, max_count = M:get_scene_treasure_chest_count(box_group_id)
    total_finish_count = total_finish_count + finish_count
    total_count = total_count + max_count
  end
  return total_finish_count, total_count
end

function M:get_all_chapter_treasure_chest_can_open()
  local chapter_cfg_list = {}
  for _, chapter_cfg in pairs(ShareRes.get_chapter_cfg()) do
    if chapter_cfg.ChapterPage == Config.Chapter_Mode.NORMAL and chapter_cfg.ChapterMode == Config.Chapter_Mode.NORMAL and not chapter_cfg_list[chapter_cfg.SerialNum] then
      chapter_cfg_list[chapter_cfg.SerialNum] = chapter_cfg
    end
  end
  for _, chapter_cfg in pairs(chapter_cfg_list) do
    if not ChapterMgr:get_chapter_data_by_chapter_id(chapter_cfg.Id) then
      return false
    end
    if M:get_chapter_treasure_chest_can_open(chapter_cfg.Id) then
      return true
    end
  end
  return false
end

function M:get_chapter_treasure_chest_can_open(chapter_id)
  local node_cfg_list = ShareRes.get_chapter_all_node_id_by_chapter_id(chapter_id)
  if not node_cfg_list then
    return false
  end
  for _, node_cfg in pairs(node_cfg_list) do
    local state = ChapterMgr:get_node_state(chapter_id, node_cfg.Id)
    local is_finished = state == Config.CommonDefine.CHAPTER_NODE_STATE.FINISHED
    if not is_finished then
      return false
    end
    local box_group_id = node_cfg.BoxGroupId
    if box_group_id and box_group_id > 0 then
      local box_cfg_list = group_box_cfg_list[box_group_id]
      for _, box_cfg in pairs(box_cfg_list) do
        if not scene_treasure_chest_list[box_cfg.Id] then
          return true
        end
      end
    end
  end
  return false
end

function M:get_all_chapter_treasure_chest_opened()
  local chapter_cfg_list = self:get_all_box_chapter_cfg_list()
  for _, chapter_cfg in pairs(chapter_cfg_list) do
    if not M:get_chapter_treasure_check_all_opened(chapter_cfg.Id) then
      return false
    end
  end
  return true
end

function M:get_all_box_chapter_cfg_list()
  local chapter_cfg_list = {}
  local temp_chapter_cfg_list = {}
  for _, chapter_cfg in pairs(ShareRes.get_chapter_cfg()) do
    if self:is_contains_box(chapter_cfg) and chapter_cfg.ChapterMode == Config.Chapter_Mode.NORMAL and not chapter_cfg_list[chapter_cfg.SerialNum] and not temp_chapter_cfg_list[chapter_cfg.SerialNum] then
      temp_chapter_cfg_list[chapter_cfg.SerialNum] = chapter_cfg
    end
  end
  for _, cfg in pairs(temp_chapter_cfg_list) do
    table.insert(chapter_cfg_list, cfg)
  end
  table.sort(chapter_cfg_list, function(a, b)
    return a.SerialNum < b.SerialNum
  end)
  return chapter_cfg_list
end

function M:is_contains_box(chapter_cfg)
  for _, page in ipairs(self.v_contains_box_chapter_page_list) do
    if chapter_cfg.ChapterPage == page then
      return true
    end
  end
  return false
end

function M:get_all_page_un_lock_chapter_id()
  local total_list = {}
  for _, page in ipairs(self.v_contains_box_chapter_page_list) do
    local all_chapter_index_list = ChapterMgr:get_all_unlock_chapter_cfg(page, true)
    for _, chapter_index in ipairs(all_chapter_index_list) do
      table.insert(total_list, chapter_index)
    end
  end
  return total_list
end

function M:get_chapter_treasure_check_all_opened(chapter_id)
  local node_cfg_list = ShareRes.get_chapter_all_node_id_by_chapter_id(chapter_id)
  if not node_cfg_list then
    return true
  end
  for _, node_cfg in pairs(node_cfg_list) do
    local box_group_id = node_cfg.BoxGroupId
    if box_group_id and box_group_id > 0 then
      local box_cfg_list = group_box_cfg_list[box_group_id]
      for _, box_cfg in pairs(box_cfg_list) do
        if not scene_treasure_chest_list[box_cfg.Id] then
          return false
        end
      end
    end
  end
  return true
end

function M:get_need_open_chapter_info()
  local chapter_cfg_list = self:get_all_box_chapter_cfg_list()
  local total_count = 0
  local opened_count = 0
  for _, chapter_cfg in pairs(chapter_cfg_list) do
    local node_cfg_list = ShareRes.get_chapter_all_node_id_by_chapter_id(chapter_cfg.Id)
    local chapter_data = ChapterMgr:get_chapter_data_by_chapter_id(chapter_cfg.Id)
    if not chapter_data then
    else
      for _, node_cfg in pairs(node_cfg_list) do
        local state = ChapterMgr:get_node_state(chapter_cfg.Id, node_cfg.Id)
        local is_finished = state == Config.CommonDefine.CHAPTER_NODE_STATE.FINISHED
        if is_finished then
          local box_group_id = node_cfg.BoxGroupId
          if box_group_id and box_group_id > 0 then
            local box_cfg_list = group_box_cfg_list[box_group_id]
            for _, box_cfg in pairs(box_cfg_list) do
              total_count = total_count + 1
              if scene_treasure_chest_list[box_cfg.Id] then
                opened_count = opened_count + 1
              end
            end
          end
        end
      end
    end
  end
  return nil, total_count, opened_count
end

return M
