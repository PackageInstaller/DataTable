local Base = require("ui.uiobject")
local _clamp = require("base.mathx").Clamp
local M = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_icon = {
    "ItemIcon",
    BIND_TYPE.IMAGE
  },
  v_quality = {
    "ItemQuality",
    BIND_TYPE.IMAGE
  },
  v_amount_bg = {
    "AmountBg",
    BIND_TYPE.OBJECT
  },
  v_amount = {
    "Amount",
    BIND_TYPE.TEXT
  },
  v_inventory_obj = {
    "Inventory",
    BIND_TYPE.OBJECT
  }
}

function M:ui_finish_load()
  self:init_model(MODEL)
  self.v_scale = 1
  self.v_btn = self:get_button(nil, self.v_object)
  Global.listener_mgr:add_listener(self.v_object, self.v_btn.onClick, function()
    self:_onclick_item()
  end)
end

function M:ui_on_show(data)
  self:set_data(data)
end

function M:set_data(data)
  if not data then
    return
  end
  self.v_param = data
  if self.v_item_id == data.item_id then
    return
  end
  self.v_item_id = data.item_id
  self.v_click_cb = data.click_cb
  self.v_quality.raycastTarget = self.v_click_cb ~= nil
  assert(self.v_item_id)
  self.v_item_cfg = ShareRes.get_item_cfg(self.v_item_id)
  local get_award_type_cfg = ShareRes.get_award_type_cfg(self.v_item_id)
  local cfg_name = get_award_type_cfg.TabName
  local path_head = get_award_type_cfg.IconPath
  local bag_type = get_award_type_cfg.AwardType
  local func_name = "_set_" .. cfg_name
  if self[func_name] then
    self[func_name](self, path_head)
  else
    local item_icon_path, item_quality_path = ShareRes.get_item_icon_path(self.v_item_id, true)
    ResMgr:load_set_icon(self.v_icon, item_icon_path)
    ResMgr:load_set_icon(self.v_quality, item_quality_path)
  end
  self.v_inventory_obj:SetActiveEx(bag_type == Config.BAG_TYPE.INVENTORY)
  self.v_amount_bg:SetActive(false)
  local param = data.param
  if param and param.show_num and 0 ~= param.show_num then
    self.v_amount_bg:SetActive(true)
    self.v_amount.text = "x" .. param.show_num
  end
end

function M:_set_player_avatar(icon_path_prefix)
  local icon_path = string.format(icon_path_prefix, self.v_item_cfg.Icon)
  local item_quality_path = ShareRes.get_item_quality_path(self.v_item_id)
  ResMgr:load_set_icon(self.v_icon, icon_path)
  ResMgr:load_set_icon(self.v_quality, item_quality_path)
end

function M:_set_buddy()
  local item_icon_path = UtilUI.get_hero_images(self.v_item_id)
  local item_quality_path = ShareRes.get_item_quality_path(self.v_item_id)
  ResMgr:load_set_icon(self.v_icon, item_icon_path)
  ResMgr:load_set_icon(self.v_quality, item_quality_path)
end

function M:set_scale(scale)
  self.v_icon.transform:SetLocalScaleA(scale, scale, scale)
  self.v_inventory_obj.transform:SetLocalScaleA(scale, scale, scale)
end

function M:_onclick_item()
  if self.v_click_cb then
    self.v_click_cb()
  end
end

function M:get_item_name()
  return self.v_item_cfg.Name
end

return M
