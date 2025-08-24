local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local TASK_CONFIG = require("gamelogic.task.task_config")
local TASK_STATE = TASK_CONFIG.TASK_STATE

function ui:on_select_item(node_id)
  self.v_uiobjects.Select:SetActive(self.v_node_id == node_id)
end

function ui:on_click_btn(is_click)
  self.v_parent_ui:on_select_course_item(self.v_node_id, is_click)
end

function ui:ui_finish_load()
end

function ui:ui_on_show()
  self:bind_auto_mq(Const.MSG_ON_TASK_UPDATE, self.on_task_update, self)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(node_cfg, is_main_node)
  self.v_is_main_node = is_main_node
  self.v_node_id = node_cfg.Id
  self.v_node_cfg = node_cfg
  self:refresh_node_data()
end

function ui:refresh_node_data()
  if not self.v_is_main_node then
    local task_state
    if self.v_node_cfg.TaskId then
      task_state = TaskMgr:get_task_state(self.v_node_cfg.TaskId)
    else
      Log.Error("获取历程节点获取任务ID失败，节点ID：", self.v_node_id)
      return
    end
    local is_unlock = FateBookMgr:check_curse_node_is_unlock(self.v_node_id)
    self.v_uiobjects.RedPoint:SetActive(is_unlock and task_state == TASK_STATE.receive)
    if not self.v_uiobjects.Complete then
      Log.Error("self.v_node_cfg", self.v_node_cfg.Id)
    end
    self.v_uiobjects.Complete:SetActive(is_unlock and task_state == TASK_STATE.received)
  end
  self.v_uiobjects.Select:SetActive(false)
  if not Util.is_empty(self.v_node_cfg.IconPath) then
    ResMgr:load_set_icon(self.v_uicompents.Icon_img, self.v_node_cfg.IconPath)
  end
  self.v_uicompents.NodeName_txt.text = self.v_node_cfg.Name
  local x_y_pos = self.v_node_cfg.XYPos
  if x_y_pos then
    self.v_object_transform.anchoredPosition = UnityVector2(x_y_pos[1], x_y_pos[2])
  end
  self:set_button_listener(self:get_button(), function()
    self:on_click_btn(true)
  end)
end

function ui:refresh_main_node_data(can_get, complete)
  self.v_uiobjects.RedPoint:SetActive(can_get)
end

function ui:on_task_update()
  self:refresh_node_data()
end

return ui
