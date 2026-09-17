local this = L_BevTree:registClass("guideWait", L_BevTree.action)
local tag = "guide"

function this:param()
  self.time = 1
  self.isPause = 0
  self.limitInput = 1
  self.inputActions = ""
end

function this:parse()
  self.time = self:getParam("time", true)
  self.isPause = 0 < (self:getParam("isPause", true) or 0)
  self.limitInput = 0 < (self:getParam("limitInput", true) or 0)
  self.inputActions = self:getParam("inputActions")
end

function this:onEnter()
  if self.time == -1 then
    return
  end
  self.curTime = C_Time.time
  self.firstRun = true
  self.curStateIndex = 0
end

function this:execute()
  if self.time == -1 then
    return L_BevTree.taskResult.Running
  end
  if C_Time.time - self.curTime >= self.time then
    self:afterWait()
    return L_BevTree.taskResult.Success
  else
    if self.firstRun then
      self:beforeWait()
    end
    return L_BevTree.taskResult.Running
  end
end

function this:beforeWait()
  self.curStateIndex = 1
  self.firstRun = false
  L_UI:setTempTopGuideMask(true)
  if self.limitInput then
    local actions = string.split(self.inputActions, "|")
    self.tree.inputActions = actions
    C_InputManager.EnableHighLevelControl(actions, nil)
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.GuideControlMouse, {key = "guideClick", isShow = true})
  end
  if self.isPause then
    L_GuideManager:setWorldPause(true, self.tree.param.guideId)
  end
end

function this:afterWait()
  self.curStateIndex = 2
  L_UI:setTempTopGuideMask(false)
  if self.limitInput then
    self.tree.inputActions = nil
    C_InputManager.DisableHighLevelControl()
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.GuideControlMouse, {key = "guideClick", isShow = false})
  end
  if self.isPause then
    L_GuideManager:setWorldPause(false, self.tree.param.guideId)
  end
end

function this:onAbortSelf()
  if self.curStateIndex == 1 then
    self:afterWait()
  end
end

function this:onDestroy()
  if self.curStateIndex == 1 then
    self:afterWait()
  end
end

return this
