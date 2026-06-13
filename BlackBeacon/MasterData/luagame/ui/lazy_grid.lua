local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local _insert, _remove = table.insert, table.remove
local UnityGrid = UnityEngine.UI.GridLayoutGroup
local UnityRectTransform = _ENV.UnityRectTransform
ui.Constraint_None = 0
ui.Constraint_Column = 1
ui.Constraint_Row = 2

function ui:ui_wrap(parent, gameobj)
  self = Base.ui_wrap(self, parent, gameobj)
  local trans = gameobj.transform
  local csgrid = trans:GetComponent(UnityGrid)
  self.constraint = csgrid.constraint
  self.constraint_count = csgrid.constraintCount
  self.spacing = csgrid.spacing
  self.cellsize = csgrid.cellSize
  self.v_has_init = false
  csgrid.enabled = false
  self.v_object:SetActive(true)
  return self
end

function ui:setup(template, template_model, show_range_callback, arg)
  self.v_range_cb = show_range_callback
  self.v_arg = arg
  self.v_rect_trans = self:get_rect_transform()
  self.v_offset_y = self.v_old_posy
  self.v_template = template
  self.v_template_model = template_model
  self.v_childs = {}
  self.v_total_count = 0
  self.v_frees = {}
  self.v_start_idx = 0
  self.v_end_idx = -1
  self.v_no_margin_start_idx = 0
  self.v_no_margin_end_idx = 1
end

function ui:reallocate(count, margin)
  self.v_total_count = count
  self.v_margin = margin or 0
end

function ui:add(index)
  self.v_total_count = self.v_total_count + 1
  if index <= self.v_end_idx then
    local start_idx = self.v_start_idx
    index = index >= start_idx and start_idx or index
    self:_add_range(index, index)
  end
  self:update(true)
end

function ui:remove(index)
  self.v_total_count = self.v_total_count - 1
  assert(self.v_total_count >= 0)
  if index <= self.v_end_idx then
    local start_idx = self.v_start_idx
    index = index >= start_idx and start_idx or index
    self:_remove_range(index, index)
  end
  self:update(true)
end

function ui:get_current_state()
  return self.v_start_idx, self.v_end_idx, self.v_childs
end

function ui:reset_current_data()
  self:_create_items(self.v_start_idx, self.v_end_idx, self.v_childs)
end

function ui:_update_grid()
  local cell_count_x = 1
  local cell_count_y = 1
  local child_count = self.v_total_count
  local cellx = self.cellsize.x
  local celly = self.cellsize.y
  local spacex = self.spacing.x
  local spacey = self.spacing.y
  if self.constraint == ui.Constraint_Column then
    cell_count_x = self.constraint_count
    cell_count_y = math.ceil(child_count / cell_count_x)
  end
  local require_w = cell_count_x * cellx + (cell_count_x - 1) * spacex
  local require_h = cell_count_y * celly + (cell_count_y - 1) * spacey
  self.v_rect_trans:SetSizeWithCurrentAnchors(0, require_w)
  self.v_rect_trans:SetSizeWithCurrentAnchors(1, require_h)
  for i = self.v_start_idx, self.v_end_idx do
    local idx = i - self.v_start_idx + 1
    local trans = self.v_childs[idx].trans
    if not trans then
      Global.log.Debug(i, trans, self.v_childs, self.v_start_idx, self.v_end_idx)
    end
    local posx = (i - 1) % cell_count_x
    local posy = math.floor((i - 1) / cell_count_x)
    posx = posx * (cellx + spacex)
    posy = posy * (celly + spacey)
    trans:rectTransform():SetInsetAndSizeFromParentEdge(0, posx, cellx)
    trans:rectTransform():SetInsetAndSizeFromParentEdge(2, posy, celly)
  end
end

function ui:_init_bound()
  if self.v_has_init then
    return true
  end
  local trans = self.v_object_transform.parent:GetComponentInParent(UnityRectTransform)
  if not trans then
    return false
  end
  local rect = trans.rect
  self.boundx = rect.center.x
  self.boundy = rect.center.y
  self.boundw = rect.size.x / 2
  self.boundh = rect.size.y / 2
  self.v_has_init = true
end

function ui:_check_out_bounds(posx, posy, cellx, celly)
  return posx - cellx > self.boundx + self.boundw or posx + cellx < self.boundx - self.boundw or posy - celly > self.boundy + self.boundh or posy + celly < self.boundy - self.boundh
end

function ui:update(force)
  if not self:_init_bound() then
    return
  end
  local now_posx, now_posy = self.v_rect_trans:GetLocalPositionA()
  if force or now_posx ~= self.v_old_posx or now_posy ~= self.v_old_posy then
    self.v_old_posx, self.v_old_posy = now_posx, now_posy
    local cell_count_x = 1
    local cellx = self.cellsize.x
    local celly = self.cellsize.y
    local spacex = self.spacing.x
    local spacey = self.spacing.y
    if self.constraint == ui.Constraint_Column then
      cell_count_x = self.constraint_count
    end
    local new_start_idx, new_end_idx = 0, 0
    for i = 1, self.v_total_count do
      local posx = (i - 1) % cell_count_x
      local posy = math.floor((i - 1) / cell_count_x + 0.001)
      posx = posx * (cellx + spacex) - cellx / 2 + now_posx
      posy = -posy * (celly + spacey) - celly / 2 + now_posy
      if not self:_check_out_bounds(posx, posy, cellx / 2, celly / 2) then
        if 0 == new_start_idx then
          new_start_idx = i
        end
      elseif new_start_idx > 0 and 0 == new_end_idx then
        new_end_idx = i
      end
    end
    if 0 == new_end_idx then
      new_end_idx = self.v_total_count
    end
    if 0 == new_start_idx then
      new_start_idx = 1
    end
    self.v_no_margin_start_idx = new_start_idx
    self.v_no_margin_end_idx = new_end_idx
    if new_start_idx > self.v_margin then
      new_start_idx = new_start_idx - self.v_margin
    end
    if new_end_idx < self.v_total_count - self.v_margin then
      new_end_idx = new_end_idx + self.v_margin
    end
    if new_start_idx ~= self.v_start_idx or new_end_idx ~= self.v_end_idx then
      if new_end_idx < self.v_start_idx or new_start_idx > self.v_end_idx then
        self:_remove_range(self.v_start_idx, self.v_end_idx)
        self:_add_range(new_start_idx, new_end_idx)
      elseif new_start_idx <= self.v_start_idx and new_end_idx >= self.v_end_idx then
        self:_add_range(new_start_idx, self.v_start_idx - 1)
        self:_add_range(self.v_end_idx + 1, new_end_idx)
      elseif new_start_idx >= self.v_start_idx and new_end_idx <= self.v_end_idx then
        self:_remove_range(self.v_start_idx, new_start_idx - 1)
        self:_remove_range(new_end_idx + 1, self.v_end_idx)
      elseif new_start_idx > self.v_start_idx then
        self:_remove_range(self.v_start_idx, new_start_idx - 1)
        self:_add_range(self.v_end_idx + 1, new_end_idx)
      elseif new_end_idx < self.v_end_idx then
        self:_remove_range(new_end_idx + 1, self.v_end_idx)
        self:_add_range(new_start_idx, self.v_start_idx - 1)
      end
      self.v_start_idx = new_start_idx
      self.v_end_idx = new_end_idx
      self:_update_grid()
    end
  end
end

function ui:_create_one_item(index, obj)
  self.v_range_cb(self.v_arg, index, index, {obj})
end

function ui:_create_items(start_idx, end_idx, childs)
  self.v_range_cb(self.v_arg, start_idx, end_idx, childs)
end

function ui:_get_new_child()
  local free_count = #self.v_frees
  if free_count > 0 then
    local model = self.v_frees[free_count]
    _remove(self.v_frees, free_count)
    return model
  end
  local obj = Global.res_mgr:instantiate(self.v_template)
  obj:SetActive(true)
  local trans = obj.transform
  trans:SetParent(self.v_object_transform, false)
  local model = self.v_parent_ui:get_model_list(obj, self.v_template_model)
  model.trans = trans
  model.go = obj
  return model
end

function ui:_release_child(model)
  if model then
    model.trans:SetLocalPositionA(200000, 0, 0)
    _insert(self.v_frees, model)
  end
end

function ui:_add_range(start_idx, end_idx)
  if end_idx < start_idx then
    return
  end
  local childs = {}
  if end_idx <= self.v_start_idx then
    for i = start_idx, end_idx do
      local child = self:_get_new_child()
      _insert(self.v_childs, 1, child)
      _insert(childs, 1, child)
    end
  else
    for i = start_idx, end_idx do
      local child = self:_get_new_child()
      _insert(self.v_childs, child)
      _insert(childs, child)
    end
  end
  self:_create_items(start_idx, end_idx, childs)
end

function ui:_remove_range(start_idx, end_idx)
  if end_idx < start_idx then
    return
  end
  if start_idx < self.v_start_idx then
    return
  end
  for i = end_idx, start_idx, -1 do
    local index = i - self.v_start_idx + 1
    local obj = self.v_childs[index]
    self:_release_child(obj)
    _remove(self.v_childs, index)
  end
end

function ui:get_child_trans(idx)
  return self.v_childs[idx - self.v_start_idx + 1] and self.v_childs[idx - self.v_start_idx + 1].trans
end

function ui:get_child_trans_without_margin(idx)
  if idx < self.v_no_margin_start_idx or idx > self.v_no_margin_end_idx then
    return nil
  end
  return self:get_child_trans(idx)
end

function ui:get_real_idx(idx)
  return idx + self.v_start_idx - 1
end

function ui:ui_on_destroy()
  if self.v_frees then
    for i = #self.v_frees, 1 do
      Global.res_mgr:destroy_gameobj(self.v_frees[i].go)
      self.v_frees[i] = nil
    end
    self.v_frees = nil
  end
  if self.v_childs then
    for i = #self.v_childs, 1 do
      Global.res_mgr:destroy_gameobj(self.v_childs[i].go)
      self.v_childs[i] = nil
    end
    self.v_childs = nil
  end
  self.v_template = nil
end

return ui
