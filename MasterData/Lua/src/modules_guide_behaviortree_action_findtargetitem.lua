local this = L_BevTree:registClass("guide.findTargetItem", L_BevTree.action)
local guideStuckTime = L_GameTpl:getGameConstTpl():getData("GUIDE_SKIP_BUTTON_DISPLAY_TIME", L_Const.GameTplType.int)

function this:param()
  self.pageName = ""
  self.targetPath = ""
end

function this:parse()
  self.pageName = self:getParam("pageName")
  self.targetPath = self:getParam("targetPath")
end

function this:onEnter()
  self.lastStuck = false
  self.curCheckTime = C_Time.time
  self.result = L_BevTree.taskResult.Running
end

function this:execute()
  if string.isEmpty(self.targetPath) then
    return L_BevTree.taskResult.Failure
  end
  if self.result ~= L_BevTree.taskResult.Running then
    return L_BevTree.taskResult.Running
  end
  local page = L_UI:getPage(self.pageName)
  if page == nil then
    self:checkUIShow()
    return L_BevTree.taskResult.Running
  end
  if page.status ~= "shown" or page.animating then
    self:checkUIShow()
    return L_BevTree.taskResult.Running
  end
  local node = page.gameObject.transform:Find(self.targetPath)
  if node ~= nil and node.gameObject.activeSelf then
    self.tree.targetListItem = node.gameObject
    return L_BevTree.taskResult.Success
  end
  self:checkUIShow()
  return L_BevTree.taskResult.Running
end

function this:checkUIShow()
  local isStuck = C_Time.time - self.curCheckTime >= guideStuckTime
  if isStuck ~= self.lastStuck then
    C_MJLog.LogInfo(string.format("[GuideSkip] source=findTargetItem.checkUIShow guideId=%s isShow=%s skipNotSave=%s elapsed=%s threshold=%s pageName=%s targetPath=%s", tostring(self.tree.param.guideId), tostring(isStuck), tostring(self.skipNotSave), tostring(C_Time.time - self.curCheckTime), tostring(guideStuckTime), tostring(self.pageName), tostring(self.targetPath)), C_ELogModule.Guide)
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.ShowSkipGuide, {
      skipNotSave = self.skipNotSave,
      guideId = self.tree.param.guideId,
      isShow = isStuck
    })
  end
  self.lastStuck = isStuck
end

return this
