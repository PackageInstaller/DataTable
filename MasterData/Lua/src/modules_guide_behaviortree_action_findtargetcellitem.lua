local this = L_BevTree:registClass("guide.findTargetCellItem", L_BevTree.action)
local guideStuckTime = L_GameTpl:getGameConstTpl():getData("GUIDE_SKIP_BUTTON_DISPLAY_TIME", L_Const.GameTplType.int)

function this:param()
  self.pageName = ""
  self.guideSerializeId = 0
  self.inputActions = ""
  self.guideParam = 0
  self.isExecuteOnly = 0
end

function this:parse()
  self.pageName = self:getParam("pageName")
  self.guideSerializeId = self:getParam("guideSerializeId", true)
  self.guideParam = self:getParam("guideParam", true)
  self.inputActions = self:getParam("inputActions")
  local tempIsExecuteOnly = self:getParam("isExecuteOnly", true)
  self.isExecuteOnly = tempIsExecuteOnly ~= nil and tempIsExecuteOnly ~= 0
end

function this:onEnter()
  self.lastStuck = false
  self.curCheckTime = C_Time.time
  self:dealHighInputAction()
  self.result = L_BevTree.taskResult.Running
end

function this:onFinish()
  self:dealDisableHighInputAction()
end

function this:dealHighInputAction()
  if not string.isEmpty(self.inputActions) then
    local actions = string.split(self.inputActions, "|")
    C_InputManager.EnableHighLevelControl(actions, nil)
    return true
  end
  return false
end

function this:dealDisableHighInputAction()
  if not string.isEmpty(self.inputActions) then
    C_InputManager.DisableHighLevelControl()
  end
end

function this:execute()
  if self.result ~= L_BevTree.taskResult.Running then
    return L_BevTree.taskResult.Running
  end
  local page = L_UI:getPage(self.pageName)
  if page == nil then
    self:checkUIShow()
    return L_BevTree.taskResult.Running
  end
  if self.canFind == nil then
    self.canFind = page.cls:CheckCanFindTargetCellItem(self.guideSerializeId, self.guideParam)
    if self.canFind == false then
      return L_BevTree.taskResult.Failure
    end
  end
  local targetItem = page.cls:FindTargetCellItem(self.guideSerializeId, self.guideParam)
  if self.isExecuteOnly then
    return L_BevTree.taskResult.Success
  end
  if targetItem == nil then
    self:checkUIShow()
    return L_BevTree.taskResult.Running
  end
  self.tree.targetListItem = targetItem
  if not L_CommonUtil.isValid(self.tree.targetListItem) then
    self:checkUIShow()
    return L_BevTree.taskResult.Running
  end
  return L_BevTree.taskResult.Success
end

function this:checkUIShow()
  local isStuck = C_Time.time - self.curCheckTime >= guideStuckTime
  if string.isEmpty(self.inputActions) then
    if isStuck then
      L_GuideManager:clearAllControl()
      L_GuideManager:forceEndGuide(self.tree.param.guideId)
    end
    return
  end
  if isStuck ~= self.lastStuck then
    C_MJLog.LogInfo(string.format("[GuideSkip] source=findTargetCellItem.checkUIShow guideId=%s isShow=%s skipNotSave=%s elapsed=%s threshold=%s pageName=%s inputActions=%s", tostring(self.tree.param.guideId), tostring(isStuck), tostring(self.skipNotSave), tostring(C_Time.time - self.curCheckTime), tostring(guideStuckTime), tostring(self.pageName), tostring(self.inputActions)), C_ELogModule.Guide)
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.ShowSkipGuide, {
      skipNotSave = self.skipNotSave,
      guideId = self.tree.param.guideId,
      isShow = isStuck
    })
    if not isStuck then
      self:dealHighInputAction()
    end
  end
  self.lastStuck = isStuck
end

return this
