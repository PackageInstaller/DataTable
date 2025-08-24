local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local tinsert = table.insert
local offset = 640
local MODEL = {
  v_content = {
    "Content",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
end

function ui:ui_on_show(infinite_id)
  self.v_infinite_id = infinite_id
  self:init_privilege_node_cfg_list()
  self:init_obj_list()
  self:init_item_icon()
  self:init_node_show_state()
  self:bind_button()
  self:refresh_node_activate_state()
end

function ui:ui_on_hide()
  self.v_pre_index = nil
end

function ui:init_privilege_node_cfg_list()
  self.v_privilege_node_cfg_list = ChapterMgr:get_inf_privilege_node_cfg_list(self.v_infinite_id)
end

function ui:init_obj_list()
  self.button_list = {}
  self.select_eff_list = {}
  self.select_img_list = {}
  self.act_list = {}
  self.condition1_list = {}
  self.condition2_list = {}
  self.icon_list = {}
  for index, cfg in ipairs(self.v_privilege_node_cfg_list) do
    tinsert(self.button_list, Util.get_button(nil, self.v_uiobjects["Btn" .. index]))
    tinsert(self.select_eff_list, Util.get_child_gameobj("FX_UI_UnlockEffect", self.v_uiobjects["Btn" .. index]))
    tinsert(self.select_img_list, Util.get_child_gameobj("Select", self.v_uiobjects["Btn" .. index]))
    tinsert(self.act_list, Util.get_child_gameobj("Act", self.v_uiobjects["Btn" .. index]))
    tinsert(self.condition1_list, Util.get_child_gameobj("Condition1", self.v_uiobjects["Btn" .. index]))
    tinsert(self.condition2_list, Util.get_child_gameobj("Condition2", self.v_uiobjects["Btn" .. index]))
    tinsert(self.icon_list, Util.get_image("Icon", self.v_uiobjects["Btn" .. index]))
  end
end

function ui:init_scroll_pos()
  local lock_index = 1
  local is_all_unlock = true
  for index, cfg in ipairs(self.v_privilege_node_cfg_list) do
    if not ChapterMgr:inf_privilege_current_node_is_unlock(self.v_infinite_id, cfg.Id) then
      is_all_unlock = false
      lock_index = index
      break
    end
  end
  local object = self:get_object()
  local scroll = Util.get_scrollrect(nil, object)
  local content_rect = Util.get_rect_transform(nil, self.v_content)
  local half_width_content = content_rect.rect.width / 2
  if is_all_unlock then
    scroll.horizontalNormalizedPosition = 1
  else
    local content_pos = self.v_content.transform.localPosition
    local btn_obj = self.button_list[lock_index].gameObject
    local btn_pos = btn_obj.transform.localPosition
    local result_value = btn_pos.x - offset
    if result_value <= 0 then
      scroll.horizontalNormalizedPosition = 0
    elseif half_width_content <= result_value then
      scroll.horizontalNormalizedPosition = 1
    else
      self.v_content.transform:SetLocalPositionA(-1 * result_value, content_pos.y, content_pos.z)
    end
  end
end

function ui:init_item_icon()
  for index, item_icon in ipairs(self.icon_list) do
    local cfg = self.v_privilege_node_cfg_list[index]
    ResMgr:load_set_icon(item_icon, cfg.Icon)
  end
end

function ui:init_node_show_state()
  local node_cfg_list_length = #self.v_privilege_node_cfg_list
  local child_count = self.v_content.transform.childCount
  for index = 1, child_count do
    self.button_list[index].gameObject:SetActive(true)
  end
  if node_cfg_list_length < child_count then
    for index = node_cfg_list_length + 1, child_count do
      self.button_list[index].gameObject:SetActive(false)
    end
  end
end

function ui:bind_button()
  for index, button in ipairs(self.button_list) do
    self.select_img_list[index]:SetActive(false)
    self.select_eff_list[index]:SetActive(false)
    self:set_button_listener(button, function()
      self:click_privilege_node(index)
    end)
  end
end

function ui:click_privilege_node(index)
  if self.v_pre_index and self.v_pre_index == index then
    return
  end
  if self.v_pre_index == nil then
    self.v_pre_index = index
    self.select_img_list[index]:SetActive(true)
  else
    self.select_img_list[self.v_pre_index]:SetActive(false)
    self.select_img_list[index]:SetActive(true)
    self.v_pre_index = index
  end
  self.v_parent_ui:show_bottom_layout(self.v_privilege_node_cfg_list[index])
end

function ui:play_unlock_eff()
  self.select_eff_list[self.v_pre_index]:SetActive(false)
  self.select_eff_list[self.v_pre_index]:SetActive(true)
end

function ui:refresh_node_activate_state()
  local infinite_info = ChapterMgr:get_inf_chapter_data(self.v_infinite_id)
  local privilege_ids = {}
  if infinite_info.privilege_ids and next(infinite_info.privilege_ids) then
    for _, id in pairs(infinite_info.privilege_ids) do
      privilege_ids[id] = id
    end
  end
  for index, cfg in ipairs(self.v_privilege_node_cfg_list) do
    if privilege_ids[cfg.Id] then
      self.act_list[index]:SetActive(true)
      local pre_id_list = cfg.PreId
      local condition1_is_unlock = true
      local condition2_is_unlock = true
      if pre_id_list and next(pre_id_list) then
        if pre_id_list[1] and next(pre_id_list[1]) then
          for _, id in pairs(pre_id_list[1]) do
            if nil == privilege_ids[id] then
              condition1_is_unlock = false
              break
            end
          end
        else
          condition1_is_unlock = false
        end
        if pre_id_list[2] and next(pre_id_list[2]) then
          for _, id in pairs(pre_id_list[2]) do
            if nil == privilege_ids[id] then
              condition2_is_unlock = false
              break
            end
          end
        else
          condition2_is_unlock = false
        end
        self.condition1_list[index]:SetActive(condition1_is_unlock)
        self.condition2_list[index]:SetActive(condition2_is_unlock)
      else
        self.condition1_list[index]:SetActive(false)
        self.condition2_list[index]:SetActive(false)
      end
    else
      self.act_list[index]:SetActive(false)
      self.condition1_list[index]:SetActive(false)
      self.condition2_list[index]:SetActive(false)
    end
  end
end

return ui
