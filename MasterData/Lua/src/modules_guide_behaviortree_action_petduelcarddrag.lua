local this = L_BevTree:registClass("guide.petDuelCardDrag", L_BevTree.action)

function this:param()
  self.effectPath = ""
  self.dimension = ""
  self.effectScale = ""
  self.offset = ""
end

function this:parse()
  self.effectPath = self:getParam("effectPath")
  self.dimension = "110|110"
  self.effectScale = self:getParam("effectScale")
  self.offset = self:getParam("offset")
  self.inputActions = "UI/Click|UI/Point|UI/Submit"
end

function this:onEnter()
  if self.isDestroy then
    self.result = L_BevTree.taskResult.Failure
    return
  end
  if not string.isEmpty(self.inputActions) then
    local actions = string.split(self.inputActions, "|")
    C_InputManager.EnableHighLevelControl(actions, nil)
  end
  self.onEvent_SummonStart = self.onEvent_SummonStart or handler(self, self.onSummonStart)
  AzurWorld.KiboArenaSystemMgr:RegisterEvent(C_EKiboArenaSystemEvent.SummonStart, self.onEvent_SummonStart)
  self.onEvent_SummonConfirm = self.onEvent_SummonConfirm or handler(self, self.onSummonConfirm)
  AzurWorld.KiboArenaSystemMgr:RegisterEvent(C_EKiboArenaSystemEvent.SummonConfirm, self.onEvent_SummonConfirm)
  self.onEvent_EnterNormal = self.onEvent_EnterNormal or handler(self, self.onEnterNormal)
  AzurWorld.KiboArenaSystemMgr:RegisterEvent(C_EKiboArenaSystemEvent.EnterNormal, self.onEvent_EnterNormal)
  local normalStateClass = require("modules.guide.states.petDuelCardDrag_normal")
  self.normalState = normalStateClass.new(self)
  local draggingStateClass = require("modules.guide.states.petDuelCardDrag_dragging")
  self.draggingState = draggingStateClass.new(self)
  self:enterNormalState()
  self.result = L_BevTree.taskResult.Running
end

function this:execute()
  if self.result == L_BevTree.taskResult.Running and self.curState ~= nil then
    self.curState:onUpdate()
  end
  return self.result
end

function this:onReset()
  C_MJLog.LogInfo("petDuelCardDrag onReset", C_ELogModule.Guide)
  self.result = L_BevTree.taskResult.Failure
  self:doDestroy()
end

function this:onFinish()
  C_MJLog.LogInfo("petDuelCardDrag onFinish", C_ELogModule.Guide)
  self:doDestroy()
end

function this:onDestroy()
  C_MJLog.LogInfo("petDuelCardDrag onDestroy", C_ELogModule.Guide)
  self:doDestroy()
end

function this:doDestroy()
  if self.onEvent_SummonStart then
    AzurWorld.KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.SummonStart, self.onEvent_SummonStart)
    self.onEvent_SummonStart = nil
  end
  if self.onEvent_SummonConfirm then
    AzurWorld.KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.SummonConfirm, self.onEvent_SummonConfirm)
    self.onEvent_SummonConfirm = nil
  end
  if self.onEvent_EnterNormal then
    AzurWorld.KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.EnterNormal, self.onEvent_EnterNormal)
    self.onEvent_EnterNormal = nil
  end
  self:exitCurState()
  C_InputManager.DisableHighLevelControl()
  if self.guideControlMouseState then
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.GuideControlMouse, {
      key = "petDuelCardDrag",
      isShow = false
    })
  end
end

function this:onSummonStart(_, varList)
  local cardGuid = varList:GetUlong(0)
  local isDrag = varList:GetBool(1)
  C_MJLog.LogInfo("petDuelCardDrag onSummonStart cardGuid: " .. tostring(cardGuid) .. " isDrag: " .. tostring(isDrag), C_ELogModule.Guide)
  if self.result ~= L_BevTree.taskResult.Running then
    return
  end
  self:enterDraggingState()
end

function this:onSummonConfirm(_, varList)
  local cardGuid = varList:GetUlong(0)
  C_MJLog.LogInfo("petDuelCardDrag onSummonConfirm cardGuid: " .. tostring(cardGuid), C_ELogModule.Guide)
  if self.result ~= L_BevTree.taskResult.Running then
    return
  end
  self.result = L_BevTree.taskResult.Success
  self:exitCurState()
end

function this:onEnterNormal(_, varList)
  C_MJLog.LogInfo("petDuelCardDrag onEnterNormal", C_ELogModule.Guide)
  if self.result ~= L_BevTree.taskResult.Running then
    return
  end
  self:enterNormalState()
end

function this:exitCurState()
  if self.curState then
    self.curState:exit("")
    self.curState = nil
  end
end

function this:enterNormalState()
  if self.curState ~= nil and self.curState.stateName == "normal" then
    return
  end
  local lastStateName = ""
  if self.curState ~= nil then
    lastStateName = self.curState.stateName
  end
  if self.curState ~= nil then
    self.curState:exit("normal")
  end
  self.curState = self.normalState
  self.curState:enter(lastStateName)
end

function this:enterDraggingState()
  if self.curState ~= nil and self.curState.stateName == "dragging" then
    return
  end
  local lastStateName = ""
  if self.curState ~= nil then
    lastStateName = self.curState.stateName
  end
  if self.curState ~= nil then
    self.curState:exit("dragging")
  end
  self.curState = self.draggingState
  self.curState:enter(lastStateName)
end

function this:showGuideControlMouse()
  if not self.guideControlMouseState then
    self.guideControlMouseState = true
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.GuideControlMouse, {
      key = "petDuelCardDrag",
      isShow = true
    })
  end
end

return this
