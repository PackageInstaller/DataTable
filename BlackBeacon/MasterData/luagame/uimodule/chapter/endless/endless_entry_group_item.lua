local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local QUALITY_PATH = Config.ENTRY_QUALITY_PATH
local INFINITE_ENTRY_TYPE = Config.CommonDefine.INFINITE_ENTRY_TYPE
local ENTRY_SELECT_IMAGE_PATH = {
  [INFINITE_ENTRY_TYPE.GAIN] = "Endless_btn_xzx2_",
  [INFINITE_ENTRY_TYPE.NEGATIVE] = "Endless_btn_xzx_"
}
local ENTRY_BG_IMAGE_PATH = {
  [INFINITE_ENTRY_TYPE.GAIN] = "UIEndless/Endless_db_bz2",
  [INFINITE_ENTRY_TYPE.NEGATIVE] = "UIEndless/Endless_db_bz1"
}

local function sort(a, b)
  if a.DifficultyCeof ~= b.DifficultyCeof then
    return a.DifficultyCeof < b.DifficultyCeof
  else
    return false
  end
end

function ui:on_click_button(entry_id, ignore_player_prefs)
  local cfg = ShareRes.get_infinite_entry_cfg(entry_id)
  if not ChapterEndlessMgr:check_entry_is_unlock(entry_id) then
    local desc = ShareRes.get_condition_desc(cfg.Condition)
    Util.show_message_tip(desc)
    return
  end
  local last_entry_id = self.v_select_entry_id
  local count, limit = self.v_parent_ui:get_type_select_count_and_limit(cfg.Type)
  if nil == last_entry_id and limit < count + 1 then
    Util.show_message_tip(2254)
    return
  end
  if last_entry_id ~= entry_id then
    if last_entry_id then
      local last_entry_cfg = ShareRes.get_infinite_entry_cfg(last_entry_id)
      if last_entry_cfg.Type ~= cfg.Type then
        if not self.v_parent_ui:check_type_select_entry_count(cfg.Type) then
          Util.show_message_tip(2254)
          return
        end
        self.v_parent_ui:on_select_entry(self.v_group_id, nil, last_entry_cfg.Type, last_entry_id)
      end
    end
    self.v_select_entry_id = entry_id
  elseif not self.v_parent_ui:check_is_must_select(self.v_group_id) then
    self.v_select_entry_id = nil
    self:reset_bg_image()
  else
    return
  end
  self.v_parent_ui:on_select_entry(self.v_group_id, self.v_select_entry_id, cfg.Type, last_entry_id)
  self:refresh_select_entry()
  self:refresh_group_data()
end

function ui:ui_finish_load()
  self.v_button_list = {}
end

function ui:ui_on_show()
end

function ui:set_data(group_cfg, infinite_id)
  self.v_infinite_id = infinite_id
  self.v_group_id = group_cfg.Id
  self:refresh_group_data()
  self:refresh_entry_button()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:refresh_group_data()
  local cfg, desc, icon_path, quality
  cfg = ShareRes.get_infinite_entry_group_cfg(self.v_group_id)
  self.v_group_type = cfg.Type
  self.v_must_select = cfg.Must
  self.v_uiobjects.MustSelect:SetActive(self.v_must_select)
  self.v_select_entry_id = self.v_parent_ui:get_select_entry_id(self.v_group_id)
  if self.v_select_entry_id then
    cfg = ShareRes.get_infinite_entry_cfg(self.v_select_entry_id)
  end
  if not cfg then
    return
  end
  desc = cfg.Desc
  icon_path = cfg.Icon
  quality = cfg.Quality
  self.v_uicompents.BuffDesc_txt.text = desc
  self:reset_bg_image()
  ResMgr:load_set_icon(self.v_uicompents.BuffIcon_img, icon_path)
  ResMgr:load_set_icon(self.v_uicompents.Quality_img, QUALITY_PATH[quality])
end

function ui:refresh_entry_button()
  local all_entry_cfg = ShareRes.get_infinite_entry_group(self.v_group_id)
  if all_entry_cfg then
    UtilTable.clear_map(self.v_button_list)
    local temp_list = {}
    local child, num, btn, select_obj, lock, color, is_select, icon, text
    local num_name = "DifficultyNum"
    local root = self.v_uiobjects.TogGroup.transform
    for key, entry_cfg in pairs(all_entry_cfg) do
      temp_list[#temp_list + 1] = entry_cfg
    end
    table.sort(temp_list, sort)
    local max_index = 0
    local is_unlock
    for index, entry_cfg in ipairs(temp_list) do
      is_unlock = ChapterEndlessMgr:check_entry_is_unlock(entry_cfg.Id)
      if index > root.childCount then
        child = root:GetChild(0)
        UnityGameObject.Instantiate(child.gameObject, root)
      end
      child = root:GetChild(index - 1)
      child:SetActive(true)
      num = self:get_text(num_name, child)
      num.text = entry_cfg.DifficultyCeof >= 0 and "+ " .. entry_cfg.DifficultyCeof or entry_cfg.DifficultyCeof
      is_select = self.v_select_entry_id == entry_cfg.Id
      select_obj = self:get_child_gameobj("Select", child.gameObject)
      select_obj:SetActive(is_select)
      local image = self:get_image(nil, select_obj)
      ResMgr:load_set_icon(image, ENTRY_SELECT_IMAGE_PATH[entry_cfg.Type])
      if is_select then
        ResMgr:load_set_icon(self.v_uicompents.Bg_img, ENTRY_BG_IMAGE_PATH[entry_cfg.Type], nil, true, self)
      end
      color = self.v_parent_ui:get_select_bg_color(is_select)
      icon = self:get_image("Icon", child.gameObject)
      self:refresh_obj_color_and_alpha(icon, color, is_select)
      text = self:get_text("DifficultyNum", child.gameObject)
      self:refresh_obj_color_and_alpha(text, color, is_select)
      lock = self:get_child_gameobj("Lock", child.gameObject)
      lock:SetActive(not is_unlock)
      btn = self:get_button(nil, child.gameObject)
      self:set_button_listener(btn, function()
        self:on_click_button(entry_cfg.Id)
      end)
      self.v_button_list[entry_cfg.Id] = btn
      max_index = max_index + 1
    end
    if not self.v_select_entry_id and self.v_parent_ui:check_is_must_select(self.v_group_id) then
      local first_id = temp_list[1].Id
      self.v_button_list[first_id].gameObject:SetActive(true)
      self:on_click_button(first_id)
    end
    if max_index < root.childCount then
      for index = max_index + 1, root.childCount do
        child = root:GetChild(index - 1)
        child:SetActive(false)
      end
    end
  end
end

function ui:refresh_select_entry()
  local select_entry_id = self.v_parent_ui:get_select_entry_id(self.v_group_id)
  local is_select, entry_cfg, color, select_obj, icon, text
  for id, btn in pairs(self.v_button_list) do
    entry_cfg = ShareRes.get_infinite_entry_cfg(id)
    is_select = id == select_entry_id
    if is_select then
      ResMgr:load_set_icon(self.v_uicompents.Bg_img, ENTRY_BG_IMAGE_PATH[entry_cfg.Type], nil, true, self)
    end
    color = self.v_parent_ui:get_select_bg_color(is_select)
    select_obj = self:get_child_gameobj("Select", btn.gameObject)
    select_obj:SetActive(is_select)
    icon = self:get_image("Icon", btn.gameObject)
    self:refresh_obj_color_and_alpha(icon, color, is_select)
    text = self:get_text("DifficultyNum", btn.gameObject)
    self:refresh_obj_color_and_alpha(text, color, is_select)
  end
end

function ui:refresh_obj_color_and_alpha(obj, color, is_select)
  local alpha = 0.6
  if is_select then
    alpha = 1
  end
  Util.set_color(obj, color, alpha)
end

function ui:reset_bg_image()
  ResMgr:load_set_icon(self.v_uicompents.Bg_img, ENTRY_BG_IMAGE_PATH[self.v_group_type], nil, true, self)
end

function ui:clear_select_data()
  self.v_select_entry_id = nil
end

return ui
