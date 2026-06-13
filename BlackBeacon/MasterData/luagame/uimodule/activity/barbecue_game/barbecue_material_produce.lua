local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
end

function ui:ui_on_show()
  self:bind_auto_mq(Const.MSG_BBQ_MATERIAL_MOVE_TO_CONTENT, self.on_move_to_content, self)
  self:bind_auto_mq(Const.MSG_ON_BBQ_MATERIAL_CONTENT_REDUCE, self.on_content_mat_reduce, self)
  self:bind_auto_mq(Const.MSG_ON_BBQ_SYS_UPDATE, self.on_upgrade, self)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(material_cfg)
  self.v_material_id = material_cfg.Id
  self.v_cfg = material_cfg
  self.v_duration_sys_id = material_cfg.DurationSysId
  self.v_duration_second = BarbecueGameMgr:get_val_by_sys_id(self.v_duration_sys_id)
  self.v_is_running = false
  self:reset_ui()
end

function ui:pass_ct(delta_time)
  if not (self.v_pass_second and self.v_duration_second) or self.v_pass_second >= self.v_duration_second then
    return
  end
  self.v_pass_second = self.v_pass_second + delta_time
  self.v_uicompents.Slider_sld.value = self.v_pass_second / self.v_duration_second
  if self.v_pass_second >= self.v_duration_second then
    self:on_produce_finish()
  else
    local uiobjs = self.v_uiobjects
    if uiobjs.Stop then
      uiobjs.Stop:SetActiveEx(false)
    end
    if uiobjs.Running then
      uiobjs.Running:SetActiveEx(true)
    end
    if uiobjs.Finish then
      uiobjs.Finish:SetActiveEx(false)
    end
  end
end

function ui:reset_ui()
  self.v_pass_second = 0
  self.v_uicompents.Slider_sld.value = 0
  local uiobjs = self.v_uiobjects
  if uiobjs.Stop then
    uiobjs.Stop:SetActiveEx(true)
  end
  if uiobjs.Running then
    uiobjs.Running:SetActiveEx(false)
  end
  if uiobjs.Finish then
    uiobjs.Finish:SetActiveEx(false)
  end
end

function ui:on_produce_finish()
  local uiobjs = self.v_uiobjects
  if uiobjs.Stop then
    uiobjs.Stop:SetActiveEx(true)
  end
  if uiobjs.Running then
    uiobjs.Running:SetActiveEx(false)
  end
  if uiobjs.Finish then
    uiobjs.Finish:SetActiveEx(true)
  end
  self:try_move_mat_to_content()
end

function ui:on_upgrade()
  if not self.v_duration_sys_id then
    return
  end
  self.v_duration_second = BarbecueGameMgr:get_val_by_sys_id(self.v_duration_sys_id)
end

function ui:on_content_mat_reduce(msg)
  local mat_id = msg.mm_x
  if self.v_material_id ~= mat_id then
    return
  end
  self:try_move_mat_to_content()
end

function ui:try_move_mat_to_content()
  if not self.v_pass_second or self.v_pass_second < self.v_duration_second then
    return
  end
  local msg = MsgGame:mq_publish2(Const.MSG_BBQ_TRY_MOVE_MATERIAL_TO_CONTENT)
  msg.mm_x = self.v_material_id
end

function ui:on_move_to_content(msg)
  local mat_id = msg.mm_x
  if self.v_material_id ~= mat_id then
    return
  end
  self:reset_ui()
end

return ui
