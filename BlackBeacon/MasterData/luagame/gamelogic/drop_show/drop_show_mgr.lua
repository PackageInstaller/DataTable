local Base = require("gamelogic.base_system")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local M = Util.create_child_mt(Base)
local _insert = table.insert
local _tsort = table.sort
local _remove = table.remove
local DEBUG = false
local DROP_TYPE = Config.DROP_TYPE

local function item_cmp(a, b)
  local a_type_cfg = a.award_cfg
  local b_type_cfg = b.award_cfg
  local a_award_type = a_type_cfg.AwardType
  local b_award_type = b_type_cfg.AwardType
  if a_award_type == b_award_type then
    local a_item_cfg = a.item_cfg
    local b_item_cfg = b.item_cfg
    local a_quality = a_item_cfg.Quality
    local b_quality = b_item_cfg.Quality
    if a_quality == b_quality then
      return a.id < b.id
    else
      return a_quality > b_quality
    end
  else
    return a_award_type < b_award_type
  end
end

local NOT_SHOW_BATTLE_ITEM_TYPE = {
  [5] = {
    is_all = false,
    [6] = true
  },
  [6] = {
    is_all = false,
    [7] = true
  }
}
local Treasure_Item = {
  [6] = {
    [7] = true
  }
}

function M:init_sys()
  Base.init_sys(self)
  self.v_drop_list = {}
  self.v_show_drop_list = {}
  self.v_drop_currency_num = 0
  self.v_is_show_drop_ui = true
  self.v_drop_show_ui = {}
  self.v_open_ui_show_state = false
  self.v_is_showing_ui = false
  self.v_try_open_ui = false
  self.v_drop_seq = {}
  self.v_head = 0
  self.v_tail = 0
  self.v_use_drop_info = false
  self:sys_mq_bind(Const.MSG_ON_CLOSE_DROP_UI, self.response_close_drop_ui, self)
  self:sys_mq_bind(Const.MSG_ON_HERO_BORN_ANIM_END, self.response_hero_born, self)
  self:sys_mq_bind(Const.MSG_ON_FIGHT_BAG_UPDATE, self.response_fight_bag_update, self)
  self:sys_mq_bind(Const.MSG_ON_FIGHT_END, self.response_fight_end_update, self)
  self:sys_mq_bind(Const.MSG_ON_OPEN_DROP_UI, self.response_open_drop_ui, self)
  self:sys_mq_bind(Const.MSG_BEGIN_SWITCH_ROOM, self.on_switch_room, self)
end

function M:on_switch_room()
  self.v_drop_list = {}
end

function M:on_battle_drop_show_list(data)
  self.v_drop_list = data.drop_list
  if self:is_have_drop_item() then
    self:set_have_drop_item()
  else
    self:set_no_drop_item()
  end
end

function M:update()
  if self.v_is_showing_ui_list then
    if self.v_is_showing_ui then
      return
    end
    if not TowerMgr then
      return
    end
    local tower = TowerMgr:get_tower()
    if not tower then
      return
    end
    local room = tower:get_room()
    if not room or not room:is_fight_end() then
      return
    end
    if not Global.hero then
      return
    end
    if self:is_in_top_ver_act() then
      return
    end
    if BattleSkillBookMgr:is_need_open_select_ui() then
    elseif BattleTreasureBoxMgr:is_need_open_treasure_box_ui() then
      self:use_treasure_box()
      self:change2showing_ui()
    elseif FightBagMgr:get_need_display_map() then
      self:change2showing_ui()
    elseif Rune2Mgr:is_setting_rune() then
      self:change2showing_ui()
    else
      self:close_drop_show_state()
    end
  end
end

function M:get_skill_book_num()
  local book_num = 0
  local skill_book_id = ShareRes.get_single_key_define("BattleSkillBookId")
  local bag = FightBagMgr:get_bag(BagCfg.BagType.ITEM)
  for _, data in pairs(bag) do
    if data.Id == skill_book_id then
      book_num = data.count
      break
    end
  end
  return book_num
end

function M:is_have_treasure_box()
  local is_have = false
  local bag = FightBagMgr:get_bag(BagCfg.BagType.ITEM)
  for _, data in pairs(bag) do
    local item_cfg = data.Cfg
    local father_type = item_cfg.Type
    local sub_type = item_cfg.Subtype
    local is_type_have = Treasure_Item[father_type]
    if is_type_have and is_type_have[sub_type] then
      is_have = true
      break
    end
  end
  return is_have
end

function M:use_skill_book()
  BattleSkillBookMgr:use_skill_book()
end

function M:use_treasure_box()
  BattleTreasureBoxMgr:use_treasure_box()
end

function M:is_in_top_ver_act()
  local activity = ActivityMgr:get_top_version_act()
  if activity and activity:is_end() then
    return true
  end
  return false
end

function M:fun_npc_refresh_drop_list(data)
  self.v_drop_list = {}
  for _, item_data in pairs(data) do
    local temp = {
      id = item_data.item_id,
      count = item_data.count
    }
    _insert(self.v_drop_list, temp)
  end
end

function M:no_show_drop_ui()
  return self.v_no_show_drop_ui
end

function M:get_show_drop_list()
  return self.v_show_drop_list
end

function M:get_show_drop_currency()
  return self.v_drop_currency_num
end

function M:get_show_state()
  return self.v_is_show_drop_ui
end

function M:set_show_state()
  self.v_is_show_drop_ui = not self.v_is_show_drop_ui
end

function M:exit_tower()
  self.v_is_show_drop_ui = true
  self.v_is_showing_ui_list = false
  self.v_is_showing_ui = false
  self.v_use_drop_info = false
  self:clear_drop_seq()
end

function M:clear_drop_seq()
  self.v_drop_seq = {}
  self.v_head = 0
  self.v_tail = 0
end

function M:is_have_drop()
  return self.v_have_drop
end

function M:is_have_drop_item()
  if self.v_drop_list and next(self.v_drop_list) then
    return true
  end
  return false
end

function M:is_have_drop_item_show()
  return BattleSkillBookMgr:is_need_open_select_ui() or BattleTreasureBoxMgr:is_need_open_treasure_box_ui()
end

function M:set_have_drop_item()
  self.v_have_drop = true
end

function M:set_no_drop_item()
  self.v_have_drop = false
end

function M:clear_drop_state()
  self.v_have_drop = false
end

function M:response_close_drop_ui()
  self.v_is_showing_ui = false
end

function M:response_open_drop_ui()
  self:open_ui_success()
end

function M:open_drop_show_state(no_show_drop_ui, drop_type)
  local drop_info = {no_show_drop_ui = no_show_drop_ui, drop_type = drop_type}
  self.v_drop_seq[self.v_tail] = drop_info
  self.v_tail = self.v_tail + 1
  if not self.v_use_drop_info then
    self:_open_drop_show_state()
  end
end

function M:_open_drop_show_state()
  self.v_use_drop_info = true
  local no_show_drop_ui = self.v_drop_seq[self.v_head].no_show_drop_ui
  local drop_type = self.v_drop_seq[self.v_head].drop_type
  self.v_no_show_drop_ui = no_show_drop_ui
  self.v_drop_type = drop_type
  self.v_is_showing_ui_list = true
end

function M:close_drop_show_state()
  self.v_is_showing_ui_list = false
  self.v_is_showing_ui = false
  self.v_no_show_drop_ui = true
  if DEBUG then
    Log.Error("drop show end")
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ON_DROP_SHOW_ITEM_END)
  msg.mm_x = self.v_drop_type
  self.v_drop_seq[self.v_head] = nil
  self.v_no_show_drop_ui = nil
  self.v_drop_type = nil
  self.v_head = self.v_head + 1
  self.v_use_drop_info = false
  if self.v_head < self.v_tail then
    self:_open_drop_show_state()
  end
end

function M:change2showing_ui()
  self.v_is_showing_ui = true
  self.v_try_open_ui = true
  Timer:add_timer("check_is_open_success", 2, function()
    if self.v_try_open_ui then
      self.v_is_showing_ui = false
    end
  end)
end

function M:open_ui_success()
  self.v_try_open_ui = false
end

function M:is_showing_ui_list()
  return self.v_is_showing_ui_list
end

function M:response_hero_born()
  self:open_drop_show_state(true, DROP_TYPE.HERO_BORN)
end

function M:remove_drop_info()
  self.v_drop_type = nil
  self.v_drop_seq[self.v_head] = nil
  self.v_head = self.v_head + 1
  if self.v_drop_seq and next(self.v_drop_seq) then
    local no_show_drop_ui = self.v_drop_seq[self.v_head].no_show_drop_ui
    local drop_type = self.v_drop_seq[self.v_head].drop_type
    self:_open_drop_show_state(no_show_drop_ui, drop_type)
  end
end

function M:response_fight_bag_update(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  self:open_drop_show_state(true, DROP_TYPE.GM)
end

function M:response_fight_end_update()
  if self.v_have_drop then
    return
  end
  if UIMgr and UIMgr:try_get_visible_ui("challenge_ring_plus") then
    return
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ON_DROP_SHOW_ITEM_END)
  msg.mm_x = DROP_TYPE.FIGHT_END
end

function M:is_have_drop_seq()
  return #self.v_drop_seq > 0
end

return M
