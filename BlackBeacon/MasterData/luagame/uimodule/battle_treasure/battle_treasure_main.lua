local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SaticSv = require("ui.widget.static_scroll_view")
local SvItem = require("uimodule.battle_treasure.battle_treasure_item")
local Item_Helper = require("utils.item_helper")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local TreasureHelper = require("uimodule.battle_treasure.treasure_helper")
local LIST_ITEM_KEY = "TREASURE_CHOOSE_ITEM"

function ui:ui_finish_load()
  self:set_button("Submit", function()
    if self.select_item_data ~= nil then
      if self.v_equip_select_cb then
        self.v_equip_select_cb(true)
        return
      end
      BattleTreasureMgr:choose_battle_treasure(self.select_item_data.idx)
      self:ui_hide()
    else
      Util.show_message_tip(2137)
    end
  end)
  self:set_button("CloseBtn", function()
    self.v_uiobjects.CloseBtn:SetActive(false)
    self:refresh_view()
  end)
  self:set_button("RoleSkillInfo", function()
    local hero_list = BattleTreasureMgr:get_treasure_skill_list()
    UIMgr:get_ui("uiheropassive"):ui_show(hero_list)
  end)
  self:set_button("Refresh", function()
    BattleTreasureMgr:refresh_battle_treasure()
  end)
  self.v_choose_panel_list = SaticSv:new(self, self.v_uiobjects.ChooseContent, SvItem, LIST_ITEM_KEY)
  local show_list = TreasureHelper.control_obj_show(self.v_ui_name)
  self:init_show_list(show_list)
end

function ui:init_show_list(show_list)
  for ui_name, is_show in pairs(show_list) do
    self.v_uiobjects[ui_name]:SetActive(is_show)
  end
end

function ui:ui_on_show()
  self.select_item_data = nil
  self:refresh_view()
  self:register_event()
end

function ui:ui_on_hide()
  self.select_item_data = nil
  self.v_treasure_list = nil
  self.v_choose_panel_list:clear()
end

function ui:ui_on_destroy()
  self.v_choose_panel_list = nil
end

function ui:refresh_view()
  self.select_item_data = nil
  self.v_treasure_list = BattleTreasureMgr:get_treasure_list()
  local skill_list = BattleTreasureMgr:get_treasure_skill_list()
  if not next(skill_list) then
    self.v_uiobjects.RoleSkillInfo:SetActive(false)
  else
    self.v_uiobjects.RoleSkillInfo:SetActive(true)
  end
  local max_num = BattleTreasureMgr:get_max_refresh_count()
  local now_num = self.v_treasure_list.refresh_cnt or 0
  self.v_uicompents.Num_txt.text = string.format("(%d/%d)", now_num, max_num)
  local grid_list = self.v_treasure_list.grid_list
  self.v_choose_panel_list:update_list(grid_list)
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_BATTLE_TREASURE_UPDATE, self.refresh_view, self)
  self:bind_auto_mq(Const.MSG_ON_SELECTED_TREASURE_ITEM, self.select_treasure_item, self)
  self:bind_auto_mq(Const.MSG_OB_OPEN_TREASURE_SUIT, self.open_close_btn, self)
end

function ui:open_close_btn(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  local data = msg.mm_obj.data
  local ucom = self.v_uicompents
  ucom.two_suit_txt.text = data.two_piece
  ucom.four_suit_txt.text = data.four_piece
  self.v_uiobjects.CloseBtn:SetActive(true)
end

function ui:select_treasure_item(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  self.select_item_data = msg.mm_obj
  local idx = msg.mm_obj.idx
  local selected_item = self.v_choose_panel_list:get_item_by_idx(idx)
  self.v_choose_panel_list:on_select_change(selected_item)
  if not Item_Helper.get_is_equip_collect(msg.mm_obj.item_id) then
    return
  end
  
  function self.v_equip_select_cb(is_need)
    BattleTreasureMgr:choose_battle_equip_treasure(self.select_item_data.idx, is_need)
    self:ui_hide()
  end
  
  local has_equip = FightBagMgr:has_same_type_equip(msg.mm_obj.item_id)
  if not has_equip then
    return
  end
  local param = {
    tips_source = BagCfg.TIPS_SOURCE.OTHER,
    get_cb = self.v_equip_select_cb
  }
  Item_Helper.show_battle_tips(msg.mm_obj.item_id, msg.mm_obj.ran_ans_uuid, param)
end

function ui:cache_ui()
  return true
end

return ui
