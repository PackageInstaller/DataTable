local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local SELECT_COLOR = {
  [true] = "f5ede2",
  [false] = "ae9577"
}

function ui:on_click_btn()
  if not self.v_is_unlock then
    Util.show_message_tip(2253)
    return
  end
  self.v_parent_ui:on_select_factory_item(self.v_factory_id)
end

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(data, building_level)
  self.v_factory_id = data.id
  self.v_factory_cfg = ShareRes.get_factory_cfg(self.v_factory_id)
  self.v_uicompents.RoomName_txt.text = self.v_factory_cfg.Name
  local is_unlock = BuildingMgr:check_condition(self.v_factory_cfg.Condition)
  self.v_is_unlock = is_unlock
  local in_product = Util.is_more_than_zero(data.material_id)
  self:refresh_material(data, building_level)
  self.v_uiobjects.Lock:SetActive(not is_unlock)
  self.v_uiobjects.RoomName:SetActive(is_unlock)
  self.v_uiobjects.ProgressBg:SetActive(is_unlock and in_product)
  self.v_uiobjects.ItemBg:SetActive(is_unlock and in_product)
  self.v_uiobjects.ItemIcon:SetActive(is_unlock and in_product)
  self.v_uiobjects.Add:SetActive(is_unlock and not in_product)
  self:set_button_listener(self:get_button(), function()
    self:on_click_btn()
  end)
  if not is_unlock then
    local desc = ShareRes.get_condition_desc(self.v_factory_cfg.Condition)
    self.v_uicompents.Condition_txt.text = desc
    self:set_button("BtnJump", function()
      UIMgr:get_ui("building_tower_view"):ui_show()
    end)
  end
end

function ui:refresh_material(data, building_level, remain_time)
  local item_id = data.material_id
  if not Util.is_more_than_zero(item_id) then
    self.v_uiobjects.Pause:SetActive(true)
    self.v_uiobjects.ItemBg:SetActive(false)
    self.v_uiobjects.RoomMax:SetActive(false)
    self.v_uiobjects.LessTime:SetActive(false)
    Util.set_color(self.v_uicompents.Bg1_img, SELECT_COLOR[false])
    return
  end
  local is_unlock = BuildingMgr:check_condition(self.v_factory_cfg.Condition)
  local path = ShareRes.get_item_icon_path(item_id)
  ResMgr:load_set_icon(self.v_uicompents.ItemIcon_img, path)
  if is_unlock then
    local cur_count
    local fill_time = BuildingMgr:get_fill_factory_slot_time(data.id)
    if fill_time > 0 then
      local cur_time = Date.server_time()
      local factory_time = cur_time - data.start_time
      local end_time = factory_time - factory_time % 60 + data.start_time
      cur_count = BuildingMgr:cal_for_a_while_factory_material_count(self.v_factory_id, end_time)
    else
      cur_count = BuildingMgr:cal_factory_material_count(self.v_factory_id)
    end
    local level_info = BuildingMgr:get_factory_material_level_info(self.v_factory_id)
    local max_count = level_info.Capacity
    if cur_count >= max_count then
      Util.set_color(self.v_uicompents.ProgressFill_img, "ae9577")
      self.v_uicompents.ProgressFill_img.fillAmount = 1
      self.v_uiobjects.RoomMax:SetActive(true)
      self.v_uiobjects.LessTime:SetActive(false)
    else
      Util.set_color(self.v_uicompents.ProgressFill_img, "efc66e")
      self.v_uicompents.ProgressFill_img.fillAmount = cur_count / max_count
      self.v_uiobjects.RoomMax:SetActive(false)
      self.v_uiobjects.LessTime:SetActive(true)
      fill_time = remain_time or BuildingMgr:get_fill_factory_slot_time(data.id)
      local hour = math.floor(fill_time / 3600)
      local min = math.floor(fill_time % 3600 / 60)
      local sec = math.floor(fill_time % 60)
      self.v_uicompents.LessTimeNum_txt.text = string.format("%.2d:%.2d:%.2d", hour, min, sec)
    end
  end
  self.v_uiobjects.Pause:SetActive(false)
end

function ui:update_timer()
  if not self:is_in_factory() then
    return false
  end
  local factory_data = BuildingMgr:get_factory_data(self.v_factory_id)
  local building_level = BuildingMgr:get_building_level(Config.CommonDefine.BUILDING_TYPE.FACTORY)
  local fill_time = BuildingMgr:get_fill_factory_slot_time(factory_data.id)
  self:refresh_material(factory_data, building_level, fill_time)
  return true
end

function ui:is_in_factory()
  if not self.v_factory_id then
    return false
  end
  local factory_data = BuildingMgr:get_factory_data(self.v_factory_id)
  if not factory_data then
    return false
  end
  if not Util.is_more_than_zero(factory_data.id) then
    return false
  end
  return true
end

function ui:on_select_item(select_id)
  local in_product = BuildingMgr:get_factory_is_in_product(self.v_factory_id)
  local is_select = self.v_is_unlock and self.v_factory_id == select_id
  self.v_uiobjects.UnSelectLine:SetActive(not is_select)
  self.v_uiobjects.Select:SetActive(is_select)
  self.v_uiobjects.ItemBg:SetActive(is_select and in_product)
  Util.set_color(self.v_uicompents.Bg1_img, SELECT_COLOR[is_select])
end

return ui
