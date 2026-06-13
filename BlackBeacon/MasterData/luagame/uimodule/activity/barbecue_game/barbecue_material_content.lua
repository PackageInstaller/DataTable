local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local HorizontalLayoutGroup = typeof(UnityEngine.UI.HorizontalLayoutGroup)
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder

function ui:ui_finish_load()
  self:set_button_listener(nil, function()
    self:on_click()
  end)
end

function ui:ui_on_show()
  self:bind_auto_mq(Const.MSG_BBQ_TRY_MOVE_MATERIAL_TO_CONTENT, self.on_try_move_mat_to_content, self)
  self:bind_auto_mq(Const.MSG_ON_BBQ_SYS_UPDATE, self.on_upgrade, self)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(material_cfg)
  self.v_material_id = material_cfg.Id
  self.v_cfg = material_cfg
  self.v_limit_sys_id = material_cfg.LimitSysId
  self.v_output_sys_id = material_cfg.OutputSysId
  self:reset_ui()
end

function ui:reset_ui()
  self:reset_limit_num()
  self:init_child_objs()
  self:reset_child_objs()
end

function ui:reset_limit_num()
  self.v_max_num = nil
  self.v_current_num = nil
  if not self.v_limit_sys_id then
    return
  end
  self.v_max_num = BarbecueGameMgr:get_val_by_sys_id(self.v_limit_sys_id)
  self.v_current_num = self.v_max_num
  if self.v_uicompents.CurrentNum_txt then
    self.v_uicompents.CurrentNum_txt.text = self.v_max_num
    self.v_uicompents.MaxNum_txt.text = self.v_max_num
  end
end

function ui:init_child_objs()
  self.v_child_objs = nil
  self.v_line_layouts = nil
  if not self.v_limit_sys_id then
    return
  end
  self.v_child_objs = {}
  self.v_line_layouts = {}
  local single_line_rect = self.v_uicompents.SingleLine_rect
  local multiple_line_rect = self.v_uicompents.MultipleLine_rect
  if single_line_rect then
    self.v_line_layouts[1] = {
      comp = Util.get_component(nil, self.v_uiobjects.SingleLine, HorizontalLayoutGroup),
      trans = single_line_rect
    }
    for i = 1, single_line_rect.childCount do
      local obj = single_line_rect:GetChild(i - 1).gameObject
      self.v_child_objs[i] = obj
    end
  elseif multiple_line_rect then
    for i = 1, multiple_line_rect.childCount do
      local line_trans = multiple_line_rect:GetChild(i - 1)
      for j = 1, line_trans.childCount do
        local obj = line_trans:GetChild(j - 1).gameObject
        self.v_child_objs[#self.v_child_objs + 1] = obj
        obj:SetActive(true)
      end
      self.v_line_layouts[i] = {
        comp = Util.get_component(nil, line_trans.gameObject, HorizontalLayoutGroup),
        trans = line_trans
      }
    end
  end
end

function ui:reset_child_objs()
  if not self.v_child_objs then
    return
  end
  for i, obj in ipairs(self.v_child_objs) do
    obj:SetActiveEx(i <= self.v_max_num)
  end
  if not self.v_line_layouts then
    return
  end
  for _, layout in ipairs(self.v_line_layouts) do
    layout.comp.enabled = true
    LayoutRebuilder.ForceRebuildLayoutImmediate(layout.trans)
    layout.comp.enabled = false
  end
end

function ui:refresh_child_objs()
  if not self.v_child_objs then
    return
  end
  for i, obj in ipairs(self.v_child_objs) do
    obj:SetActiveEx(i <= self.v_current_num)
  end
  if self.v_uicompents.CurrentNum_txt then
    self.v_uicompents.CurrentNum_txt.text = self.v_current_num
  end
end

function ui:on_click()
  if (not self.v_current_num or self.v_current_num > 0) and self.v_parent_ui:try_use_mat(self.v_material_id, self.v_object_transform) then
    self:on_reduce()
  end
end

function ui:on_upgrade()
  if not self.v_limit_sys_id then
    return
  end
  self:reset_limit_num()
  self:reset_child_objs()
end

function ui:on_try_move_mat_to_content(msg)
  if msg.mm_x ~= self.v_material_id then
    return
  end
  if not self.v_current_num or self.v_current_num >= self.v_max_num then
    return false
  end
  local current_num = self.v_current_num + BarbecueGameMgr:get_val_by_sys_id(self.v_output_sys_id)
  self.v_current_num = current_num > self.v_max_num and self.v_max_num or current_num
  self:refresh_child_objs()
  local _msg = MsgGame:mq_publish2(Const.MSG_BBQ_MATERIAL_MOVE_TO_CONTENT)
  _msg.mm_x = self.v_material_id
end

function ui:on_reduce()
  if not self.v_current_num or self.v_current_num <= 0 then
    return false
  end
  self.v_current_num = self.v_current_num - 1
  self:refresh_child_objs()
  local _msg = MsgGame:mq_publish2(Const.MSG_ON_BBQ_MATERIAL_CONTENT_REDUCE)
  _msg.mm_x = self.v_material_id
  return true
end

return ui
