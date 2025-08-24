local Base = require("ui.uiobject")
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
local VIEW_TYPE = Config.PUZZLE_OPERATE_PANEL_VIEW_TYPE
local M = Util.create_child_mt(Base)

function M:ui_finish_load()
  self.v_btn = Util.get_button(nil, self.v_object)
  self.v_btn_del = Util.get_button("Choose_/BtnDel_", self.v_object)
  local obj = self.v_object.gameObject
  Util.set_start_drag(obj, self, function(x, y)
    self:drag_start(x, y)
  end)
  Util.set_drag(obj, self, function(x, y)
    self:on_drag(x, y)
  end)
  Util.set_end_drag(obj, self, function(x, y)
    self:drag_end(x, y)
  end)
end

function M:ui_on_hide()
  self.v_data = nil
end

function M:set_linked_parent(parent)
  self.v_linked_parent = parent
end

function M:on_data_update(msg)
  if self.v_data and msg.mm_x == self.v_data.uuid then
    local puzzle_data = PuzzleMgr:get_puzzle_data(msg.mm_x)
    self.v_data.buddy_id = puzzle_data.buddy_id
    self.v_data.quality = puzzle_data.quality
    self:update_view()
  end
end

function M:on_operating(msg)
  if self.v_data and self.v_object.activeInHierarchy then
    self.v_uiobjects.Select:SetActiveEx(msg.mm_x == self.v_data.uuid)
  end
end

function M:clear_operating(msg)
  if self.v_data and msg.mm_x == self.v_data.uuid and self.v_object.activeInHierarchy then
    self.v_uiobjects.Select:SetActiveEx(false)
  end
end

function M:set_data(go, data_list, index)
  self:set_data_ex(data_list[index])
end

function M:set_data_ex(data)
  self:bind_auto_mq(Const.MSG_ON_PUZZLE_ITEM_UPDATE, self.on_data_update, self)
  self:bind_auto_mq(Const.MSG_ON_SHOW_PUZZLE_ITEM_TIPS, self.update_state, self)
  self:bind_auto_mq(Const.MSG_ON_HIDE_PUZZLE_ITEM_TIPS, self.update_state, self)
  self:bind_auto_mq(Const.MSG_ON_UPDATE_PUZZLE_ITEM_STATE, self.update_state, self)
  self.v_data = data
  self:update_view()
  self:set_button_listener(self.v_btn, function()
    if self.v_uiobjects.BanMask.activeSelf or self.v_uiobjects.OperateMask.activeSelf then
      return
    end
    if self.v_draging then
      return
    end
    self.v_linked_parent:on_click_puzzle_item(self.v_data.uuid)
    self:update_state()
  end)
  self:set_button_listener(self.v_btn_del, function()
    self.v_linked_parent:on_click_remove_puzzle_item(self.v_data.uuid)
    self:update_using_cost()
  end)
end

function M:update_view()
  local item_id = self.v_data.id
  local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(item_id)
  local puzzle_data = PuzzleMgr:get_puzzle_data(self.v_data.uuid)
  self.v_data.buddy_id = puzzle_data.buddy_id
  self.v_data.quality = puzzle_data.quality
  local item_icon_path = ShareRes.get_item_icon_path(item_id)
  local item_quality_path = ShareRes.get_quality_path(self.v_data.quality)
  local graph_show_cfg = ShareRes.get_buddy_puzzle_graph_show_cfg(self.v_data.graph_id)
  ResMgr:load_set_icon(self.v_uicompents.Icon_img, item_icon_path)
  ResMgr:load_set_icon(self.v_uicompents.Quality_img, item_quality_path)
  ResMgr:load_set_icon(self.v_uicompents.Size_img, graph_show_cfg.SmallIcon, nil, true)
  self.v_uicompents.Name_txt.text = puzzle_cfg.Name
  local owner = self.v_data.buddy_id or 0
  self.v_uiobjects.Hero:SetActive(0 ~= owner)
  if 0 ~= owner then
    local path = CharacterMgr:get_buddy_icon_path(owner)
    ResMgr:load_set_icon(self.v_uicompents.hero_head_icon_img, path)
  end
  self:update_state()
  self:update_attr_preview()
end

function M:update_state()
  if not self.v_data or not self.v_visible then
    return
  end
  self:update_selected()
  self:update_settle_done()
  self:update_using_cost()
  self:update_ban_mask()
  self:update_operate_mask()
end

function M:update_selected()
  local is_operating_uuid = self.v_linked_parent:is_operating_uuid(self.v_data.uuid)
  self.v_uiobjects.Select:SetActiveEx(is_operating_uuid)
end

function M:update_settle_done()
  self.v_is_operate_view = self.v_linked_parent:get_cur_view_type() == VIEW_TYPE.OPERATE
  local buddy_id = self.v_linked_parent:get_cur_buddy_id()
  self.v_settle_done = buddy_id == self.v_data.buddy_id
  self.v_uiobjects.ItsSet:SetActiveEx(self.v_is_operate_view and self.v_settle_done)
end

function M:update_using_cost()
  local is_cost_uuid = self.v_linked_parent:is_cost_uuid(self.v_data.uuid)
  self.v_uiobjects.Choose:SetActiveEx(is_cost_uuid)
end

function M:update_ban_mask()
  local show_mask = self.v_data.show_ban_mask == true
  local show_same_attr = true == self.v_data.show_same_attr
  self.v_uiobjects.BanMask:SetActiveEx(show_mask)
  self.v_uiobjects.SameAttr:SetActiveEx(show_same_attr)
end

function M:update_operate_mask()
  local show_mask = self.v_data.show_operate_mask == true
  self.v_uiobjects.OperateMask:SetActiveEx(show_mask)
end

function M:update_attr_preview()
  local attr_list = self.v_data.attr_list
  for i = 1, 3 do
    local id = attr_list[i]
    if id then
      local attr_id = ShareRes.get_buddy_puzzle_attr_cfg(id).AttrId
      Util.load_attr_icon(self.v_uicompents["AttrIcon" .. i .. "_img"], ShareRes.get_attr_icon(attr_id))
    end
    self.v_uiobjects["AttrTem" .. i]:SetActiveEx(nil ~= id)
  end
end

function M:is_visible_item()
  return self.v_visible
end

function M:drag_start()
  self.v_dragDirectionDetermined = false
  self.v_shouldPassEvent = false
  self.v_draging = false
end

function M:on_drag(x, y)
  if not self.v_is_operate_view then
    return
  end
  if x ~= y and not self.v_dragDirectionDetermined and not self.v_settle_done then
    self.v_shouldPassEvent = math.abs(x) > math.abs(y)
    self.v_dragDirectionDetermined = true
    if self.v_shouldPassEvent then
      self.v_linked_parent:on_drag_start(self.v_data)
      self.v_uiobjects.Select:SetActiveEx(true)
    end
  end
  if self.v_shouldPassEvent then
    self.v_linked_parent:on_drag(self.v_data)
    self.v_draging = true
  end
end

function M:drag_end()
  if self.v_draging then
    self.v_draging = false
    self.v_linked_parent:on_drag_end()
  end
end

return M
