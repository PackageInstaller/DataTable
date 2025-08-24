local Base = require("ui.uiobject")
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
local M = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_btn_del = {
    "BtnDel",
    BIND_TYPE.BUTTON
  },
  v_hero_icon = {
    "HeroIcon",
    BIND_TYPE.IMAGE
  },
  v_icon = {
    "Icon",
    BIND_TYPE.IMAGE
  },
  v_item_num = {
    "ItemNum",
    BIND_TYPE.TEXT
  },
  v_lock = {
    "Lock",
    BIND_TYPE.IMAGE
  },
  v_lv = {
    "Lv",
    BIND_TYPE.TEXT
  },
  v_quality_bg = {
    "QualityBg",
    BIND_TYPE.IMAGE
  },
  v_select = {
    "Select",
    BIND_TYPE.IMAGE
  },
  v_wear = {
    "Wear",
    BIND_TYPE.IMAGE
  }
}

function M:ui_finish_load()
  self:init_model(MODEL)
  self.v_btn = Util.get_button(nil, self.v_object)
end

function M:ui_on_hide()
  self.v_data = nil
end

function M:set_linked_parent(parent)
  self.v_linked_parent = parent
end

function M:on_data_update(msg)
  if self.v_data and msg.mm_x == self.v_data.relic_uuid then
    self:update_view()
  end
end

function M:set_data(go, data_list, index)
  self:bind_auto_mq(Const.MSG_ON_RELIC_UPDATE, self.on_data_update, self)
  self:bind_auto_mq(Const.MSG_ON_RELIC_LOCK_UPDATE, self.on_data_update, self)
  self.v_data = data_list[index]
  self.v_index = index
  self.v_is_exp_item = self.v_data.is_exp_item
  self:update_view()
  self:set_button_listener(self.v_btn, function()
    if self.v_is_exp_item then
      local exp_item_id = self.v_data.exp_item_id
      local selected_num = self.v_linked_parent:get_exp_item_selected_num(exp_item_id)
      local own_num = BagMgr:get_item_num(exp_item_id)
      if selected_num < own_num then
        self.v_linked_parent:on_click_exp_item(exp_item_id)
      end
    else
      self.v_linked_parent:on_click_relic(self.v_data.relic_uuid)
    end
  end)
  self:set_button_listener(self.v_btn_del, function()
    if self.v_is_exp_item then
      local exp_item_id = self.v_data.exp_item_id
      self.v_linked_parent:on_click_exp_item(exp_item_id, true)
    end
  end)
end

function M:update_view()
  if self.v_is_exp_item then
    self:set_exp_item_view()
  else
    self:set_relic_view()
  end
  self:update_selected()
end

function M:set_exp_item_view()
  local exp_item_id = self.v_data.exp_item_id
  local icon_path, quality_path = UtilUI.get_item_images(exp_item_id)
  ResMgr:load_set_icon(self.v_icon, icon_path)
  ResMgr:load_set_icon(self.v_quality_bg, quality_path)
  self.v_uiobjects.Wear:SetActive(false)
  self.v_uiobjects.Lock:SetActive(false)
  self.v_uiobjects.Lv:SetActive(false)
  self.v_uiobjects.ItemNum:SetActive(true)
end

function M:set_relic_view()
  local relic_data = RelicMgr:get_relic_data_by_uuid(self.v_data.relic_uuid)
  local cfg = ShareRes.get_relic_cfg(relic_data.id)
  local icon_path, quality_path = UtilUI.get_item_images(relic_data.id)
  ResMgr:load_set_icon(self.v_quality_bg, quality_path)
  ResMgr:load_set_icon(self.v_icon, icon_path)
  local owner = relic_data.buddy_id or 0
  self.v_uiobjects.Wear:SetActive(0 ~= owner)
  if 0 ~= owner then
    local path = CharacterMgr:get_buddy_icon_path(owner)
    ResMgr:load_set_icon(self.v_hero_icon, path)
  end
  self.v_uiobjects.BtnDel:SetActive(false)
  self.v_uiobjects.Lock:SetActive(1 == relic_data.lock)
  self.v_uiobjects.ItemNum:SetActive(false)
  self.v_uiobjects.Lv:SetActive(true)
  self.v_lv.text = Util.format_str("LV.{1}", relic_data.lv)
end

function M:update_selected()
  local is_selected
  if self.v_is_exp_item then
    local exp_item_id = self.v_data.exp_item_id
    local selected_num = self.v_linked_parent:get_exp_item_selected_num(exp_item_id)
    local own_num = BagMgr:get_item_num(exp_item_id)
    self.v_uiobjects.BtnDel:SetActive(selected_num > 0)
    self.v_item_num.text = selected_num > 0 and Util.format_str("{1}/{2}", selected_num, own_num) or own_num
    is_selected = self.v_linked_parent:get_is_exp_item_selected(self.v_data.exp_item_id)
  else
    is_selected = self.v_linked_parent:get_is_relic_selected(self.v_data.relic_uuid)
  end
  self.v_uiobjects.Select:SetActiveEx(is_selected)
end

function M:is_visible_item()
  return self.v_visible
end

return M
