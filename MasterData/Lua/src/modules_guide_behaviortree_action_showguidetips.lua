local this = L_BevTree:registClass("guide.showGuideTips", L_BevTree.action)
local _guideWordsTpl = L_GameTpl:getGuideWordsTpl()

function this:param()
  self.tipsKey = ""
  self.showKeys = ""
  self.specialIcons = ""
  self.gamepadKeyInputAction = ""
end

function this:parse()
  self.tipsKey = self:getParam("tipsKey", true) or 0
  self.showKeys = self:getParam("showKeys")
  self.specialIcons = self:getParam("specialIcons")
  self.gamepadKeyInputAction = self:getParam("gamepadKeyInputAction")
end

function this:onEnter()
  printf("guide", "@guide not showGuideTips has been deprecated, please use pageGuideCombinedTip instead")
  if not self.onEvent_controlSchemeChangeHandle then
    self.onEvent_controlSchemeChangeHandle = handler(self, self.onEvent_controlSchemeChange)
    C_ExternalManager.AddEvent(C_EExternalEventType.ControlSchemeChange, self.onEvent_controlSchemeChangeHandle)
  end
  local tips = _guideWordsTpl:getWords(self.tipsKey)
  self.showTipData = {
    showTips = tips,
    showKeys = string.split(self.showKeys, "|"),
    specialIcons = string.split(self.specialIcons, "|"),
    gamepadKey = self.gamepadKeyInputAction
  }
  local status = L_UI:getPageStatus("pageGuideTipsPanel")
  if not status or status == L_UI.pageEvent.closed then
    L_UI:open("pageGuideTipsPanel", self.showTipData)
  end
  self.result = L_BevTree.taskResult.Running
end

function this:execute()
  if self.result == L_BevTree.taskResult.Running and L_UI:checkPageOpen("pageGuideTipsPanel") then
    return L_BevTree.taskResult.Success
  end
  return L_BevTree.taskResult.Running
end

function this:onReset()
  if self.lastResult == L_BevTree.taskResult.Success and L_UI:checkPageOpen("pageGuideTipsPanel") then
    L_UI:close("pageGuideTipsPanel")
  end
  if self.onEvent_controlSchemeChangeHandle then
    C_ExternalManager.RemoveEvent(C_EExternalEventType.ControlSchemeChange, self.onEvent_controlSchemeChangeHandle)
    self.onEvent_controlSchemeChangeHandle = nil
  end
end

function this:onEvent_controlSchemeChange()
  local page = L_UI:getPage("pageGuideTipsPanel")
  if not page then
    return
  end
  if not self.showTipData then
    return
  end
  local tips = L_GameTpl:getGuideWordsTpl():getWords(self.tipsKey)
  self.showTipData.showTips = tips
  page:refreshInfo(self.showTipData)
end

return this
