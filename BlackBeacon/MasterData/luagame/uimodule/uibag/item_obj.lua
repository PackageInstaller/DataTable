local Base = require("ui.uiobject")
local ToggleTab = require("ui.widget.widget_toggle_tab")
local BagCfg = require("uimodule.uibag.uibag_configs")
local ItemSell = require("uimodule.uibag.bottom_item_sell")
local _clamp = require("base.mathx").Clamp
local _tinsert = table.insert
local ui = Util.create_child_mt(Base)
local Cfg = require("uimodule.uibag.uibag_configs")
local ITEM_IDX = Cfg.ITEM_IDX
local IMPORTANT_QUALITY = Cfg.IMPORTANT_QUALITY
local TRIGGER_DYNAMIC_EFFECT_TYPE = BagCfg.TRIGGER_DYNAMIC_EFFECT_TYPE
local BIND_TYPE = Config.BIND_TYPE
local DrawDown_texts = {
  "全  部",
  "消  耗",
  "培  养",
  "其  他"
}
local MODEL = {
  v_item_filter_obj = {
    "Right_item",
    BIND_TYPE.OBJECT
  },
  v_item_sell_obj = {
    "Bottom_item_sell",
    BIND_TYPE.OBJECT
  },
  v_down_content = {
    "ItemDownContent",
    BIND_TYPE.OBJECT
  },
  v_cancel_btn = {
    "BtnCancel",
    BIND_TYPE.BUTTON
  },
  v_sale_btn = {
    "BtnSale",
    BIND_TYPE.BUTTON
  },
  v_draw_down_btn = {
    "BtnItemDrawDown",
    BIND_TYPE.BUTTON
  },
  v_close_down_content_btn = {
    "BtnCloseDrawDown",
    BIND_TYPE.BUTTON
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:init_item_filt()
  local panel_item_sell = ItemSell:ui_wrap_ex(self, self.v_item_sell_obj)
  self:add_panel("item_sell", panel_item_sell, false)
  self:set_button_listener(self.v_cancel_btn, function()
    self:onclick_cancel_btn()
  end)
  self:set_button_listener(self.v_sale_btn, function()
    self:onclick_sale_btn()
  end)
end

function ui:ui_on_show()
  self.v_sale_btn.interactable = true
  self:bind_auto_mq(Const.MSG_ON_ITEM_UPDATE, self.recover_btn_interactable, self)
  Util.get_child_gameobj("Select", self.v_draw_down_btn.gameObject):SetActive(false)
  self.v_down_content:SetActive(false)
  self:set_button_active(false)
end

function ui:ui_on_hide()
  if self.v_remove_dynamic_effect_timer then
    Timer:remove_timer(self.v_remove_dynamic_effect_timer)
  end
  self.v_remove_dynamic_effect_timer = nil
end

function ui:init_item_filt()
  local pages = {}
  _tinsert(pages, Util.get_toggle("ItemTogAll_", self.v_down_content))
  _tinsert(pages, Util.get_toggle("ItemTogCost_", self.v_down_content))
  _tinsert(pages, Util.get_toggle("ItemTogDevelop_", self.v_down_content))
  _tinsert(pages, Util.get_toggle("ItemTogOther_", self.v_down_content))
  self:set_button_listener(self.v_draw_down_btn, function()
    Util.get_child_gameobj("Select", self.v_draw_down_btn.gameObject):SetActive(not self.v_down_content.activeInHierarchy)
    self.v_down_content:SetActive(not self.v_down_content.activeInHierarchy)
    self.v_close_down_content_btn.gameObject:SetActive(not self.v_close_down_content_btn.gameObject.activeInHierarchy)
  end)
  self:set_button_listener(self.v_close_down_content_btn, function()
    self.v_close_down_content_btn:SetActive(false)
    Util.get_child_gameobj("Select", self.v_draw_down_btn.gameObject):SetActive(false)
    self.v_down_content:SetActive(false)
  end)
  self.v_item_filt_toggle_tab = ToggleTab:new(self)
  self.v_item_filt_toggle_tab:init_by_toggles(pages, function(cur_select, pre_select, cur_toggle, pre_toggle)
    Util.get_text("Text", self.v_draw_down_btn.gameObject).text = Util.format_str(DrawDown_texts[cur_select])
    Util.get_child_gameobj("Select", self.v_draw_down_btn.gameObject):SetActive(false)
    self.v_down_content:SetActive(false)
    self.v_close_down_content_btn.gameObject:SetActive(false)
    self.v_parent_ui:select_item_type_tag_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  end, 0)
end

function ui:onclick_cancel_btn()
  local bag_list = self.v_parent_ui.bag_list
  local need_dec_uuid = bag_list:get_selected_list(ITEM_IDX)
  if 0 ~= #need_dec_uuid then
    UIMgr:get_ui("uinotice_tips"):ui_show(function()
      self:_play_dynamic_effect()
      self:set_button_active(false)
    end, nil, Util.format_str("将取消选择，是否继续"))
  else
    self:_play_dynamic_effect()
    self:set_button_active(false)
  end
end

function ui:do_sale()
  local panel = self:get_panel("item_sell")
  BagMgr:sell_item(panel.v_cur_item_uuid, panel.v_cur_item_id, panel.v_choose_num)
end

function ui:onclick_sale_btn()
  local bag_list = self.v_parent_ui.bag_list
  local _, id_list = bag_list:get_selected_list(ITEM_IDX)
  if 0 == #id_list or 0 == self:get_panel("item_sell").v_choose_num then
    Util.show_message_tip(2226)
    return
  end
  self.v_sale_btn.interactable = false
  local temp_quality, need_tips
  for i = 1, #id_list do
    temp_quality = ShareRes.get_item_quality(id_list[i])
    if IMPORTANT_QUALITY[temp_quality] then
      need_tips = true
      break
    end
  end
  if need_tips then
    UIMgr:get_ui("uinotice_tips"):ui_show(function()
      self:do_sale()
    end, nil, Util.format_str("物品中包含高品质道具，是否确定出售"))
  else
    self:do_sale()
  end
end

function ui:_play_dynamic_effect()
  local out_pd = self.v_parent_ui.v_uicompents.WeaponOutPd_pd
  local duration = out_pd.duration
  self.v_parent_ui:play_dynamic_effect(TRIGGER_DYNAMIC_EFFECT_TYPE.LEFT_VIEW_HIDE, duration)
  self.v_parent_ui:set_cannot_touch_obj_state(duration)
  out_pd:Stop()
  out_pd:Play()
  self.v_remove_dynamic_effect_timer = Timer:add_timer("remove_dynamic_effect_timer", duration, function()
    self:get_panel("item_sell"):set_enable(false)
  end)
end

function ui:recover_btn_interactable()
  self.v_sale_btn.interactable = true
end

function ui:set_button_active(param)
  self.v_cancel_btn.gameObject:SetActive(param)
  self.v_sale_btn.gameObject:SetActive(param)
end

function ui:set_delete_btn_active(param)
  self.v_parent_ui:set_delete_btn_active(param)
end

function ui:set_return_btn_active(param)
  self.v_parent_ui:set_return_btn_active(param)
end

function ui:set_button_grey(param)
  Util.apply_grey(nil, self.v_sale_btn, param)
end

function ui:get_item_scroll_view_rect()
  return self.v_parent_ui.v_uicompents.ItemScrollView_rect
end

function ui:play_decompose_show_pd()
  self.v_parent_ui.v_uicompents.WeaponInPd_pd:Stop()
  self.v_parent_ui.v_uicompents.WeaponInPd_pd:Play()
end

return ui
