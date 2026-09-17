local this = L_BevTree:registClass("guide.showInfoWindow", L_BevTree.action)
local pageType = {default = 0, typeOne = 1}
local pageTypeToPageName = {
  [pageType.default] = "pageGuideInfoWindow",
  [pageType.typeOne] = "pageGuideBossInfo"
}

function this:param()
  self.guidePic = ""
  self.tutorialId = 0
  self.showTime = 0
  self.pageType = 0
end

function this:parse()
  self.guidePic = self:getParam("guidePic")
  self.tutorialId = self:getParam("tutorialId", true) or 0
  self.showTime = self:getParam("showTime", true) or 0
  self.pageType = self:getParam("pageType", true) or 0
  self.pageName = pageTypeToPageName[self.pageType]
end

function this:onEnter()
  self.isDestroy = false
  L_GuideManager:addListener(G_GuideClasses.GuideEvent.TutotialGuideEnd, self.onTutotialGuideEnd, self)
  C_MJLog.LogInfo("guide.showInfoWindow onEnter = " .. tostring(self.tree.param.guideId), C_ELogModule.Guide)
  self.mainTutorialKeyHandler = self.mainTutorialKeyHandler or handler(self, self.onTutotialGuideEnd)
  if string.isEmpty(self.guidePic) and self.tutorialId == 0 then
    self.result = L_BevTree.taskResult.Failure
  else
    self.result = L_BevTree.taskResult.Running
  end
end

function this:execute()
  if self.isDestroy then
    return self.result
  end
  if self.result == L_BevTree.taskResult.Running then
    if self.waitGuideInfoClose then
      return self.result
    end
    if self.waitTutorial then
      return self.result
    end
    if self.tutorialId ~= 0 then
      self:dealTutorial()
      return self.result
    end
    if not string.isEmpty(self.guidePic) then
      self:dealOpenGuideInfoWindow()
    end
  end
  return self.result
end

function this:onTutotialGuideEnd(isPress)
  self:disposeTimer()
  if not self.isDestroy then
    self:dealOpenGuideInfoWindow()
  end
  self.waitTutorial = false
end

function this:dealTutorial()
  self.waitTutorial = true
  local args = CS.Lens.Gameplay.UI.ModuleTutorialEventArgs()
  args.luaTable = {
    tutorialId = self.tutorialId,
    showTime = self.showTime,
    guideId = self.tree.param.guideId,
    mainTutorialKeyHandler = self.mainTutorialKeyHandler
  }
  C_ExternalManager.DispatchEvent(C_EExternalEventType.GuideTutorialStart, args)
  local tutorialTpl = L_GameTpl:getTutorialTpl()
  local tutorialConfig = tutorialTpl:getTplById(self.tutorialId)
  self.showInfoGuidPic = tutorialTpl:getGuidePicId(tutorialConfig)
  self:disposeTimer()
  self.tutorialTimer = Timer.once(self.showTime, function()
    self.result = L_BevTree.taskResult.Success
    self.waitTutorial = false
  end)
end

function this:dealOpenGuideInfoWindow()
  local status = L_UI:getPageStatus(self.pageName)
  if not status or status == "closed" then
    L_GuideManager:setWorldPause(true, self.tree.param.guideId)
    local pic = string.split(self.guidePic, "|")
    if self.showInfoGuidPic ~= nil then
      pic = self.showInfoGuidPic
    end
    L_UI:open(self.pageName, {
      pics = pic,
      finishCallback = function()
        self.waitGuideInfoClose = false
        self.result = L_BevTree.taskResult.Success
      end
    })
    self.waitGuideInfoClose = true
  end
end

function this:doDestroy()
  self:dispose()
  L_GuideManager:removeListener(G_GuideClasses.GuideEvent.TutotialGuideEnd, self.onTutotialGuideEnd)
  C_MJLog.LogInfo("guide.showInfoWindow doDestroy = " .. tostring(self.tree.param.guideId), C_ELogModule.Guide)
  local args = CS.Lens.Gameplay.UI.ModuleTutorialEventArgs()
  args.luaTable = {
    guideId = self.tree.param.guideId
  }
  C_ExternalManager.DispatchEvent(C_EExternalEventType.GuideTutorialEnd, args)
end

function this:onDestroy()
  self:doDestroy()
end

function this:onReset()
  self:doDestroy()
end

function this:onFinish()
  self:dispose()
end

function this:dispose()
  self.isDestroy = true
  if self.waitGuideInfoClose and L_UI:checkPageOpen(self.pageName) then
    L_UI:close(self.pageName)
  end
  L_GuideManager:removeListener(G_GuideClasses.GuideEvent.TutotialGuideEnd, self.onTutotialGuideEnd, self)
  L_GuideManager:setWorldPause(false, self.tree.param.guideId)
  self:disposeTimer()
end

function this:disposeTimer()
  if self.tutorialTimer ~= nil then
    Timer.remove(self.tutorialTimer)
    self.tutorialTimer = nil
  end
end

return this
