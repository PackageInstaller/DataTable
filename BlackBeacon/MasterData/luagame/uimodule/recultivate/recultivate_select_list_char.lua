local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SELECT_ITEM_CLASS = require("uimodule.recultivate.recultivate_select_list_item_char")
local _insert = table.insert
local GridLayoutGroup = UnityEngine.UI.GridLayoutGroup
local BUDDY_CFG = ShareRes.create("buddy.buddy")
local ITEM_TMP_KEY = "RECULTIVATE_SELECT_PANEL_ITEM_TMP_KEY_CHAR"
local SORT_RULE = {
  "lv",
  "break_lv",
  "quality",
  "id"
}

function ui:ui_finish_load()
  self:set_button("FullBg", function()
    if self.v_is_closing then
      return
    end
    self.v_is_closing = true
    self.v_uiobjects.Mask:SetActive(true)
    self:remove_delay_close_timer()
    self.v_is_closing = false
    self.v_uiobjects.Mask:SetActive(false)
    self:ui_hide()
  end)
  self:set_button("Btn_screen", function()
    if self.v_is_closing then
      return
    end
    UIMgr:get_ui("screen_buddy_tips"):ui_show(nil, nil, nil, self:get_no_screen_list())
  end)
  self.v_content_grid_layout_group = Util.get_component(nil, self.v_uiobjects.Content, typeof(GridLayoutGroup))
  self:register_exist_auto_template(ITEM_TMP_KEY, self.v_uiobjects.Tem, self.v_uiobjects.Content)
end

function ui:ui_on_show(item_id, selected_buddy_id)
  self.v_selected_id = selected_buddy_id
  self.v_target_range = ShareRes.get_item_reset_develop_list(item_id)
  self.v_is_closing = false
  self.v_uiobjects.Mask:SetActive(false)
  self:refresh_select_list()
  self:bind_auto_mq(Const.MSG_ON_BUDDY_CHANGE, self.refresh_select_list, self)
end

function ui:ui_on_hide()
  self:clear_wrap_item()
  self:remove_delay_close_timer()
  CharacterMgr:set_screen_condtion(1)
end

function ui:ui_on_destroy()
end

function ui:remove_delay_close_timer()
  if self.v_delay_close_timer then
    Timer:remove_timer(self.v_delay_close_timer)
    self.v_delay_close_timer = nil
  end
end

function ui:clear_wrap_item()
  if self.v_item_list then
    for _, item in pairs(self.v_item_list) do
      item.obj:ui_destroy()
      item.obj = nil
    end
    self.v_item_list = nil
  end
end

function ui:refresh_select_list()
  self:set_screen_list()
  local select_idx = 0
  self:clear_wrap_item()
  self.v_item_list = {}
  self:give_back_auto_cache(ITEM_TMP_KEY)
  for idx, screen_buddy_data in ipairs(self.v_screen_list) do
    local item = self:get_auto_cache(ITEM_TMP_KEY)
    local buddy_id = screen_buddy_data.id
    local select_obj = SELECT_ITEM_CLASS:ui_wrap_ex(self, item, true)
    select_obj.go = item
    select_obj:set_data(screen_buddy_data)
    select_obj:set_selected(false)
    local insert_data = {id = buddy_id, obj = select_obj}
    _insert(self.v_item_list, insert_data)
    if self.v_selected_id == buddy_id then
      select_obj:set_selected(true)
      select_idx = idx
    end
  end
  local total_row = math.ceil(#self.v_item_list / 4)
  local move_row = math.ceil(select_idx / 4) - 1
  if move_row < 0 or move_row > total_row - 5 then
    move_row = 0
  end
  local offset = self.v_content_grid_layout_group.spacing.y + self.v_content_grid_layout_group.cellSize.y
  self.v_uicompents.Content_rect:SetAnchoredPositionA(0, move_row * offset)
  self.v_uiobjects.EmptyTips:SetActiveEx(0 == #self.v_screen_list)
end

function ui:set_screen_list()
  local element_list = CharacterMgr.v_attr_screen_list
  local job_list = CharacterMgr.v_job_screen_list
  local tag_list = CharacterMgr.v_tag_screen_list
  self.v_screen_list = {}
  local own_list = UtilTable.copy_table(CharacterMgr:get_buddy_map())
  for _, info in pairs(own_list) do
    local cfg = BUDDY_CFG[info.id]
    local in_target_range = self.v_target_range and UtilTable.contains(self.v_target_range, info.id)
    if in_target_range and info.lv > 1 and 1 ~= cfg.IsShow and CharacterMgr:check_buddy_release(info.id) then
      local element_cond = not element_list or 0 == #element_list or UtilTable.contains(element_list, cfg.Element)
      local job_cond = not job_list or 0 == #job_list or UtilTable.contains(job_list, cfg.Job)
      local tag_cond = not tag_list or 0 == #tag_list or cfg.Tag and (UtilTable.contains(tag_list, cfg.Tag[1]) or UtilTable.contains(tag_list, cfg.Tag[2]))
      if element_cond and job_cond and tag_cond then
        info.element = cfg.Element
        info.fashion_id = FashionMgr:get_fashion_wearing_id(info.id)
        _insert(self.v_screen_list, info)
      end
    end
  end
  if self.v_item_list then
    for _, item in ipairs(self.v_item_list) do
      item.obj:set_selected(false)
    end
  end
  table.sort(self.v_screen_list, function(info_a, info_b)
    for _, type in ipairs(SORT_RULE) do
      if info_a[type] ~= info_b[type] then
        return info_a[type] > info_b[type]
      end
    end
  end)
end

function ui:get_no_screen_list()
  self.v_no_screen_list = {}
  local buddy_map = CharacterMgr:get_buddy_map()
  for _, info in pairs(buddy_map) do
    local cfg = BUDDY_CFG[info.id]
    local in_target_range = self.v_target_range and UtilTable.contains(self.v_target_range, info.id)
    if in_target_range and info.lv > 1 and 1 ~= cfg.IsShow and CharacterMgr:check_buddy_release(info.id) then
      _insert(self.v_no_screen_list, {
        id = info.id
      })
    end
  end
end

function ui:on_click_buddy(buddy_id)
  if self.v_is_closing then
    return
  end
  if buddy_id == self.v_selected_id then
    return
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ON_CHANGE_RECULTIVATE_TARGET)
  msg.mm_x = buddy_id
  self.v_selected_id = buddy_id
  if self.v_item_list then
    for _, item in ipairs(self.v_item_list) do
      if item.id ~= buddy_id then
        item.obj:set_selected(false)
      end
    end
  end
end

return ui
