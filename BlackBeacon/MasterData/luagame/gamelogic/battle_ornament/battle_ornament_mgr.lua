local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local curse_com_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local default_source = -1
M.ORN_QUALITY_COLOR = {
  [0] = {
    r = 1,
    g = 1,
    b = 1,
    a = 1
  },
  [1] = {
    r = 0.7568628,
    g = 0.7882353,
    b = 0.8392157,
    a = 1
  },
  [2] = {
    r = 0.7568628,
    g = 0.7882353,
    b = 0.8392157,
    a = 1
  },
  [3] = {
    r = 0.572549,
    g = 0.7333333,
    b = 0.9529412,
    a = 1
  },
  [4] = {
    r = 0.8862745,
    g = 0.6588235,
    b = 1,
    a = 1
  },
  [5] = {
    r = 1,
    g = 0.854902,
    b = 0.6156863,
    a = 1
  }
}
M.ORN_BG_NAME = {
  [1] = "UICommon/Event_spk_04",
  [2] = "UICommon/Event_spk_04",
  [3] = "UICommon/Event_spk_03",
  [4] = "UICommon/Event_spk_02",
  [5] = "UICommon/Event_spk_01"
}
M.ORNAMENT_TYPE = 16

function M:exit_tower()
  self.ornaments_pos_dict = {}
  self.v_record_magic_level_map = nil
end

function M:init_sys()
  Base.init_sys(self)
  self:sys_mq_bind(Const.MSG_ON_BUFF_ROUND_COUNT_ZERO, self.on_buff_round_count_zero, self)
  self.ornaments_pos_dict = {}
  self.v_record_magic_level_map = nil
end

function M:update_ornaments_list(data)
  self.ornaments_pos_dict = data.ornaments_list
  MsgGame:mq_publish2(Const.MSG_ON_ORNAMENT_CHANGE)
end

function M:update_ornaments_pos(data)
  local new_ornament_data = data.ornaments_data
  local update_queue_data
  local pos = new_ornament_data.id
  if self.ornaments_pos_dict[pos] and self.ornaments_pos_dict[pos].item_id ~= new_ornament_data.item_id then
    if new_ornament_data.item_id and new_ornament_data.item_id > 0 then
      update_queue_data = UtilTable.copy_table(data)
      update_queue_data.award_type = curse_com_def.CURSE_GET_AWARD_TIP_TYPE.GET_ORNAMENT
    else
      local old_ornament_data = self.ornaments_pos_dict[new_ornament_data.id]
      if old_ornament_data and Util.is_more_than_zero(old_ornament_data.item_id) then
        local source = old_ornament_data.source or default_source
        update_queue_data = {
          data_list = {old_ornament_data},
          award_type = curse_com_def.CURSE_GET_AWARD_TIP_TYPE.REMOVE_ORNAMENT_LIST,
          source = source
        }
      end
    end
  end
  if update_queue_data then
    ChallengeRingPlusMgr:check_need_push_update_queue(update_queue_data)
  end
  self:update_new_ornament_data(new_ornament_data)
  MsgGame:mq_publish2(Const.MSG_ON_ORNAMENT_CHANGE)
end

function M:on_batch_update_ornament_pos_data(data)
  local ornaments_list = data.ornaments_list
  local source, new_data_map
  for _, new_ornament_data in pairs(ornaments_list) do
    local insert_data_map, show_ornament_data
    if Util.is_more_than_zero(new_ornament_data.item_id) then
      show_ornament_data = UtilTable.copy_table(new_ornament_data)
      new_data_map = new_data_map or {}
      insert_data_map = new_data_map
    end
    if show_ornament_data then
      source = show_ornament_data.source or default_source
      insert_data_map[source] = insert_data_map[source] or {}
      table.insert(insert_data_map[source], show_ornament_data)
    end
    self:update_new_ornament_data(new_ornament_data)
  end
  if new_data_map then
    for _, list in pairs(new_data_map) do
      local insert_data = {
        data_list = list,
        award_type = curse_com_def.CURSE_GET_AWARD_TIP_TYPE.GET_ORNAMENT_LIST,
        source = list[1].source or default_source
      }
      ChallengeRingPlusMgr:check_need_push_update_queue(insert_data)
    end
  end
  MsgGame:mq_publish2(Const.MSG_ON_ORNAMENT_CHANGE)
end

function M:on_batch_ornaments_restore_pos_data(data)
  local ornaments_restore_list = data.ornaments_restore_list
  local temp_source_map
  for _, restore_data in pairs(ornaments_restore_list) do
    if restore_data.source then
      temp_source_map = temp_source_map or {}
      temp_source_map[restore_data.source] = temp_source_map[restore_data.source] or {}
      table.insert(temp_source_map[restore_data.source], restore_data)
    end
  end
  if temp_source_map then
    for _, list in pairs(temp_source_map) do
      local insert_data = {
        data_list = list,
        award_type = curse_com_def.CURSE_GET_AWARD_TIP_TYPE.RESTORE_ORNAMENT_LIST,
        source = list[1].source
      }
      ChallengeRingPlusMgr:check_need_push_update_queue(insert_data)
    end
  end
  MsgGame:mq_publish2(Const.MSG_ON_ORNAMENT_CHANGE)
end

function M:on_buff_ornament_drop(data)
  data.data_type = curse_com_def.CURSE_CHOOSE_ITEM_TYPE.BUFF_ORNAMENT
  ChallengeRingPlusMgr:drop_award_data_enqueue(data)
  ChallengeRingPlusMgr:try_choose_drop_award()
end

function M:update_new_ornament_data(new_ornament_data)
  local pos = new_ornament_data.id
  if self.ornaments_pos_dict[pos] and self.ornaments_pos_dict[pos].item_id then
    local ornament_cfg = ShareRes.create("item.ornaments", self.ornaments_pos_dict[pos].item_id)
    local buff_cfg = ShareRes.create("battle.battle_buff", ornament_cfg.MainBuff)
    BuffMgr:on_discharge_onament(buff_cfg)
  end
  self.ornaments_pos_dict[pos] = new_ornament_data
end

function M:is_ornament_count_max()
  return self:get_ornament_count() >= Config.CommonDefine.CURSE_ORNAMENTS_SIZE
end

function M:is_ornament(item_id)
  item_id = tonumber(item_id)
  local award_type = ShareRes.create("item.award_type", self.ORNAMENT_TYPE)
  return item_id >= award_type.IdBegin and item_id <= award_type.IdEnd
end

function M:is_have_same_ornament(item_id)
  for key, ornament_data in pairs(self.ornaments_pos_dict) do
    if ornament_data.item_id and ornament_data.item_id == item_id then
      return true
    end
  end
  return false
end

function M:get_ornament_count()
  local count = 0
  for index, ornament_data in ipairs(self.ornaments_pos_dict) do
    if ornament_data.item_id then
      count = count + 1
    end
  end
  return count
end

function M:get_ornaments_dict()
  return self.ornaments_pos_dict
end

function M:get_ornaments_list()
  return self.ornaments_pos_dict
end

function M:get_ornament_data(pos)
  return self.ornaments_pos_dict[pos]
end

function M:get_ornament_bg_icon(quality)
  return self.ORN_BG_NAME[quality]
end

function M:get_ornament_color_param(quality)
  return self.ORN_QUALITY_COLOR[quality]
end

function M:get_ornament_color(quality)
  local param = self:get_ornament_color_param(quality)
  return UnityEngine.Color(param.r, param.g, param.b, param.a)
end

function M:set_select_pos(pos)
  if self.be_selling and nil == pos then
    return
  end
  self.cur_select_pos = pos
end

function M:is_ornament_breaked(item_id)
  for key, ornament_data in pairs(self.ornaments_pos_dict) do
    if ornament_data.item_id == item_id then
      return ornament_data.is_break
    end
  end
  return false
end

function M:get_select_pos()
  return self.cur_select_pos
end

function M:get_null_pos()
  for index, ornament_data in ipairs(self.ornaments_pos_dict) do
    if not ornament_data.item_id then
      return ornament_data.id
    end
  end
  return #self.ornaments_pos_dict + 1
end

function M:get_ornament_desc(ornament_id)
  local cfg = ShareRes.get_ornaments(ornament_id)
  local desc = Util.format_str(cfg.Desc)
  if cfg.CurrentDesc then
    local cur_desc_str = Util.format_str(cfg.CurrentDesc)
    local level = self.v_record_magic_level_map and self.v_record_magic_level_map[cfg.CurrentDescMagicID] or 0
    local effect_num = (cfg.CurrentDescParam[1] or 0) * level + (cfg.CurrentDescParam[2] or 0)
    desc = desc .. Util.format_str(cur_desc_str, effect_num)
  end
  return desc
end

function M:try_record_magic_level(magic_id, magic_level)
  local result = ShareRes.get_ornament_desc_magic(magic_id)
  if result then
    self.v_record_magic_level_map = self.v_record_magic_level_map or {}
    self.v_record_magic_level_map[magic_id] = magic_level
  end
end

function M:get_ornament_drop_effect_name(ornament_id)
  local cfg = ShareRes.get_ornaments(ornament_id)
  if not cfg then
    return
  end
  local effect_name
  if cfg.Quality <= 3 then
    effect_name = curse_com_def.DROP_ITEM_EFFECT_NAME.FX_TREASURE_ITEM2
  elseif 4 == cfg.Quality then
    effect_name = curse_com_def.DROP_ITEM_EFFECT_NAME.FX_TREASURE_ITEM3
  else
    effect_name = curse_com_def.DROP_ITEM_EFFECT_NAME.FX_TREASURE_ITEM4
  end
  return effect_name
end

function M:inlaid_ornament(item, source_type, cb)
  local pos = self.cur_select_pos
  local uuid = item.uuid
  local npc_id
  local npc_data = item.npc_data
  if npc_data then
    npc_id = npc_data.npc_id
  end
  pos = pos or self:get_null_pos()
  if not pos then
    UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("槽位已满，请选择需替换的奇珍"))
    return
  end
  
  local function callback(ok, resp)
    if ok then
      UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("穿戴成功"))
      if cb then
        cb()
      end
    else
      UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("穿戴失败"))
    end
  end
  
  Network:protect_call("c2gs_inlaid_ornaments", {
    pos = pos,
    uuid = uuid,
    source_type = source_type,
    npc_id = npc_id
  }, callback)
end

function M:sell_ornaments(item, source_type, cb)
  local uuid = item.uuid
  local npc_id
  local npc_data = item.npc_data
  if npc_data then
    npc_id = npc_data.npc_id
  end
  Network:protect_call("c2gs_sell_ornaments", {
    uuid = uuid,
    source_type = source_type,
    npc_id = npc_id
  }, function(ok, resp)
    if ok then
      UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("出售成功"))
      if cb then
        cb()
      end
    else
      UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("出售失败"))
    end
  end)
end

function M:buy_ornament_by_npc_shop(npc_id, good_index, hero_id, pos, cb)
  Network:protect_call("c2gs_buy_npc_shop", {
    id = npc_id,
    good_index = good_index,
    hero_id = hero_id,
    pos = pos
  }, function(ok, resp)
    if ok and cb then
      cb()
    end
  end)
end

function M:request_choose_ornament(recuperation_id, index, use_curse, cb)
  local arg = {index}
  ChallengeRingPlusMgr:request_use_recuperation_func(recuperation_id, arg, use_curse, cb)
end

function M:request_buff_choose_ornament(uuid, index, cb)
  Network:protect_call("c2gs_select_buff_ornament", {uuid = uuid, index = index}, function(ok, resp)
    if ok then
      if uuid then
        ChallengeRingPlusMgr:remove_award_data_on_queue(uuid)
      end
      if cb then
        cb(resp.choose_ornamets)
      end
    end
  end)
end

function M:select_drop_ornament(index, uuid, cb)
  Network:protect_call("c2gs_mosaic_ornamens_by_drop", {index = index}, function(ok, response)
    if ok then
      if uuid then
        ChallengeRingPlusMgr:remove_award_data_on_queue(uuid)
      end
      if cb then
        cb()
      end
    end
  end)
end

function M:request_choose_options_ornaments(index, uuid, cb)
  Network:protect_call("c2gs_curse_choose_options_ornaments", {index = index}, function(ok, resp)
    if ok then
      if uuid then
        ChallengeRingPlusMgr:remove_award_data_on_queue(uuid)
      end
      if resp.ornaments_drop_data then
        if not UtilTable.is_empty(resp.ornaments_drop_data.choose_ornamets) and not resp.ornaments_drop_data.is_finish then
          resp.data_type = curse_com_def.CURSE_CHOOSE_ITEM_TYPE.OPTION_ORNAMENT
        else
          MsgGame:mq_publish2(Const.MSG_ON_FATE_BOOK_CHECK_NEXT_START_STEP)
        end
      end
      if cb then
        cb(resp)
      end
    end
  end)
end

function M:on_buff_round_count_zero(msg)
  if msg and msg.mm_x then
    local buff = msg.mm_x
    local temp = Util.split_str(buff.source, "-", false)
    if temp[1] == Config.BUFF_SOURCE_TYPE.ornaments and temp[3] then
      local function next_refresh_callback()
        local data = {
          damage_orn_id = tonumber(temp[3])
        }
        UIMgr:get_ui("common_battle_tips"):ui_show(data)
      end
      
      local curse_get_award_tips = UIMgr:try_get_visible_ui("curse_get_award_tips")
      if curse_get_award_tips and curse_get_award_tips:is_show_ornament_award() then
        curse_get_award_tips:set_next_refresh_callback(next_refresh_callback, curse_com_def.CURSE_GET_AWARD_TIP_TYPE.GET_ORNAMENT)
      else
        next_refresh_callback()
      end
    end
  end
end

return M
