local module = class("cellCatalogTaskItem", G_UIModuleBase)

function module.bind()
  return {
    fillAmount = 0,
    txtTaskName = "",
    txtExpNum = "",
    tickActive = false,
    ActiveGO = false
  }
end

function module:refresh()
  self.bind.ActiveGO = false
  local idx = self.bind.idx
  self.timerId = Timer.once(0.03 * (idx - 1), function()
    self.bind.ActiveGO = true
    self.bindComponents.anim:Play("Anim_cellTaskItem_catalog_In")
  end, self)
  local taskTpl = L_GameTpl:getIconographyTaskTpl():getTplById(self.bind.taskId)
  self.bind.txtExpNum = tostring(taskTpl.taskAward)
  if self.bind.isComplete then
    self.bind.txtTaskName = L_Config:provider(taskTpl.taskname)
    self.bind.fillAmount = 1
    self.bind.tickActive = true
  else
    local target = taskTpl.taskcondition[#taskTpl.taskcondition] or 1
    self.bind.txtTaskName = L_Config:provider(taskTpl.taskname) .. " (" .. self.bind.taskCnt .. "/" .. tostring(target) .. ")"
    self.bind.fillAmount = tonumber(self.bind.taskCnt) / (target == 0 and 1 or target)
    self.bind.tickActive = false
  end
end

function module:open()
  module.super.open(self)
  self.timerId = nil
end

function module:close()
  module.super.close(self)
  if self.timerId then
    Timer.remove(self.timerId)
    self.timerId = nil
  end
end

return module
