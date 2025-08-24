local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("BgClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnJump", function()
    if not self.v_group_id then
      Log.Error("获取中台事件组失败，请检查配置", debug.traceback())
      return
    end
    local task_event_id = TaskMgr:get_task_event_by_group_id(self.v_group_id)
    if not task_event_id then
      Log.Error("获取中台事件失败，请检查配置", debug.traceback())
      return
    end
    UIMgr:get_ui("ui_task_new"):ui_show(1, task_event_id)
    self:ui_hide()
  end)
end

function ui:ui_on_show(task_id, show_jump)
  self:refresh_desc(task_id)
  self.v_uiobjects.BtnJump:SetActive(show_jump)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:refresh_desc(task_id)
  local task_cfg = ShareRes.get_adventrue_task_cfg(task_id)
  self.v_uicompents.BirdTaskDesc_txt.text = task_cfg.AcceptDesc
  self.v_uicompents.BirdTaskName_txt.text = task_cfg.AcceptTitle
  self.v_group_id = task_cfg.ChainCentreEventId
end

return ui
