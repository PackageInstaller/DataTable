local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SaticSv = require("ui.widget.static_scroll_view")
local SvItem = require("uimodule.drop_show.drop_show_item")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local horizon_group = UnityEngine.UI.HorizontalLayoutGroup
local half = Global.screen_width / 2
local active_icon_path = "UICommon2/Btn/Common_btn_third_sort_unsec"
local unactive_icon_path = "UICommon2/Icon/Common_sicon_hook"
local anim_speed = 0.8
local LIST_ITEM_KEY = "DROP_SHOW_ITEM"

function ui:ui_finish_load()
  self:set_button("SureBtn", function()
    self:ui_hide()
  end)
  self:set_button("Is_Tip", function()
    self:set_drop_show_state()
    self:refresh_show_state()
  end)
  self:set_button("Tip", function()
    self:set_drop_show_state()
    self:refresh_show_state()
  end)
  self:set_button("CloseBtn", function()
    self.v_uiobjects.CloseBtn:SetActive(false)
    self:refresh_suit_show(false)
  end)
  self.v_choose_panel_list = SaticSv:new(self, self.v_uiobjects.ChooseContent, SvItem, LIST_ITEM_KEY)
end

function ui:ui_on_show(cb)
  self.v_callback = cb
  self:register_event()
  self.v_show_drop_list = DropShowMgr:get_show_drop_list()
  self:refresh_view()
  MsgGame:mq_publish2(Const.MSG_ON_OPEN_DROP_UI)
end

function ui:ui_on_hide()
  self.v_show_drop_list = nil
  self.v_choose_panel_list:clear()
  if self.v_callback then
    self.v_callback()
  end
  self.v_callback = nil
  MsgGame:mq_publish2(Const.MSG_ON_CLOSE_DROP_UI)
end

function ui:ui_on_destroy()
  self.v_choose_panel_list = nil
end

function ui:set_drop_show_state()
  DropShowMgr:set_show_state()
end

function ui:refresh_view()
  local grid_list = self.v_show_drop_list
  local length = #grid_list
  local content_obj = self.v_uiobjects.ChooseContent
  local content_panel_obj = self.v_uiobjects.ChoosePanel
  local panel_rect = Util.get_rect_transform(nil, content_panel_obj)
  local horizontal_com = content_obj:GetComponent(typeof(horizon_group))
  local spacing_x = horizontal_com.spacing
  local item_width = 300
  local width
  if length < 4 then
    width = (length - 1) * spacing_x + length * item_width
  else
    width = 3 * spacing_x + 4 * item_width
  end
  panel_rect:SetSizeDeltaWidthA(width)
  self:refresh_show_state()
  self:refresh_show_currency()
  self:refresh_suit_show(false)
  self.v_choose_panel_list:update_list(grid_list)
end

function ui:refresh_show_state()
  local icon = self.v_uicompents.Tip_img
  local is_can_show = DropShowMgr:get_show_state()
  local path
  if is_can_show then
    path = active_icon_path
  else
    path = unactive_icon_path
  end
  ResMgr:load_set_icon(icon, path)
end

function ui:refresh_show_currency()
  local currency_num = DropShowMgr:get_show_drop_currency()
  local txt_com = self.v_uicompents.AddMoneyNum_txt
  txt_com.text = "+" .. currency_num
end

function ui:refresh_suit_show(is_show)
  self.v_uiobjects.suit_info:SetActive(is_show)
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_OB_OPEN_TREASURE_SUIT, self.open_close_btn, self)
end

function ui:open_close_btn(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  local xoffset = 200
  local x = msg.mm_obj.x
  local data = msg.mm_obj.data
  local uobj = self.v_uiobjects
  local ucom = self.v_uicompents
  uobj.suit_info:SetActive(true)
  local suit_rect = ucom.suit_info_rect
  local y = suit_rect.anchoredPosition.y
  suit_rect:SetAnchoredPositionA(x + xoffset, y)
  ucom.two_suit_txt.text = data.two_piece
  ucom.four_suit_txt.text = data.four_piece
  self.v_uiobjects.CloseBtn:SetActive(true)
end

return ui
