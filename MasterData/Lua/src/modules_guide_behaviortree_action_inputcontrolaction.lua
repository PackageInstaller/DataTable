local this = L_BevTree:registClass("guide.inputControlAction", L_BevTree.action)

function this:param()
  self.inputActions = ""
  self.isDisableHighLevelControl = 0
end

function this:parse()
  self.inputActions = self:getParam("inputActions")
  self.isDisableHighLevelControl = self:getParam("isDisableHighLevelControl", true)
end

function this:execute()
  if self.isDisableHighLevelControl == 0 then
    local actions = string.split(self.inputActions, "|")
    self.tree.inputActions = actions
    C_InputManager.EnableHighLevelControl(actions, nil)
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.GuideControlMouse, {key = "guideClick", isShow = true})
  else
    self.tree.inputActions = nil
    C_InputManager.DisableHighLevelControl()
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.GuideControlMouse, {key = "guideClick", isShow = false})
  end
  return L_BevTree.taskResult.Success
end

return this
