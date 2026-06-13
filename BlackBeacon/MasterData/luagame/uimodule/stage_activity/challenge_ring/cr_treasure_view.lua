local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SaticSv = require("ui.widget.static_scroll_view")
local SvItem = require("uimodule.battle_treasure.cr_treasure_item")
local Item_Helper = require("utils.item_helper")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local TreasureHelper = require("uimodule.battle_treasure.treasure_helper")
local CommonDefine = require("cs_share.common_define")
local RUNE2_SOURCE = CommonDefine.RUNE2_SOURCE
local LIST_ITEM_KEY = "CR_TREASURE_BOX_CHOOSE_ITEM"

function ui:ui_finish_load()
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
  self.v_treasure_box_list = nil
  self.v_choose_panel_list:clear()
end

function ui:ui_on_destroy()
  self.v_choose_panel_list = nil
end

function ui:refresh_view()
  self.select_item_data = nil
  self.v_treasure_list = BattleTreasureMgr:get_treasure_list()
  local grid_list = self.v_treasure_list.grid_list
  self.v_choose_panel_list:update_list(grid_list)
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_SELECTED_TREASURE_ITEM, self.select_treasure_box_item, self)
  self:bind_auto_mq(Const.MSG_ON_CLOSE_RING_BAG_ITEM_TIPS, self._response_close_tips, self)
end

function ui:select_treasure_box_item(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  if Item_Helper.get_is_rune_item(msg.mm_obj.item_id) then
    local item_data = msg.mm_obj
    self.select_item_data = item_data
    local rune_item_data = {
      item_id = item_data.item_id,
      uuid = item_data.idx,
      ran_ans_uuid = item_data.ran_ans_uuid,
      count = item_data.item_count
    }
    UIMgr:get_ui("ui_rune_set"):ui_show(rune_item_data, RUNE2_SOURCE.TREASURE)
    return
  end
  if not Item_Helper.get_is_equip_collect(msg.mm_obj.item_id) then
    self.select_item_data = msg.mm_obj
    self:_on_select_treasure()
    return
  end
  
  local function callback(is_need)
    self.select_item_data = msg.mm_obj
    self:_on_select_equip_treasure(is_need)
  end
  
  local has_equip = FightBagMgr:has_same_type_equip(msg.mm_obj.item_id)
  if not has_equip then
    callback(true)
    return
  end
  local param = {
    tips_source = BagCfg.TIPS_SOURCE.OTHER,
    get_cb = callback
  }
  Item_Helper.show_battle_tips(msg.mm_obj.item_id, msg.mm_obj.ran_ans_uuid, param)
  self.v_open_tips = true
  self.v_callback = callback
end

function ui:_on_select_treasure()
  if self.select_item_data ~= nil then
    BattleTreasureMgr:choose_battle_treasure(self.select_item_data.idx)
    self:ui_hide()
    ChallengeRingMgr:on_ring_card_end()
  else
    Util.show_message_tip(2137)
  end
end

function ui:_on_select_equip_treasure(is_need)
  if self.select_item_data ~= nil then
    BattleTreasureMgr:choose_battle_equip_treasure(self.select_item_data.idx, is_need)
    self:ui_hide()
    ChallengeRingMgr:on_ring_card_end()
  else
    Util.show_message_tip(2137)
  end
end

function ui:_response_close_tips(msg)
end

return ui
