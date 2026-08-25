local NewbieGuideManager, Super = System.NewClass("NewbieGuideManager", Manager)

function NewbieGuideManager:ctor()
  Super.ctor(self)
  self.currentStep = nil
  self.guideSteps = {}
  self.isGuiding = false
  self._enabled = false
  self.newbieGoMap = {}
  self.newbiePanelMap = {}
  self.panelOpenedInGuiding = {}
end

function NewbieGuideManager:InitGuideConfig()
  self:ClearGuides()
  for tid, stepConfig in pairs(DT.NewbieGuide) do
    if not self:IsGuideFinished(tid) then
      local guideStep = self.binder:BindComponent(NewbieGuideStep(tid, stepConfig))
      table.insert(self.guideSteps, guideStep)
    end
  end
  table.sort(self.guideSteps, function(a, b)
    return a:GetPriority() < b:GetPriority()
  end)
  self:CheckUnlockedGuide()
end

function NewbieGuideManager:CheckUnlockedGuide()
  if self.currentStep then
    return
  end
  for _, step in ipairs(self.guideSteps) do
    if step:CheckToGuide() then
      self.currentStep = step
      return
    end
  end
end

function NewbieGuideManager:Awake(binder)
  self.binder = binder
  binder:BindEvent(EventMgr.Instance.OnPanelOpened, System.fn(self, self.OnPanelOpened))
  binder:BindEvent(EventMgr.Instance.CloseUIPanel, System.fn(self, self.OnCloseUIPanel))
  binder:BindEvent(EventMgr.Instance.NewbieGuideClick, System.fn(self, self.OnNewbieGuideClick))
  binder:BindEvent(EventMgr.Instance.OnClientDataInit, System.fn(self, self.OnClientDataInit))
  binder:BindEvent(EventMgr.Instance.ClosePanelEvent, System.fn(self, self.OnPanelClose))
  binder:BindTimer(0.15, -1, System.fn(self, self.OnTick))
end

function NewbieGuideManager:ClearGuides()
  self.currentStep = nil
  for i = #self.guideSteps, 1, -1 do
    self.guideSteps[i].binder:teardown()
  end
  self.guideSteps = {}
end

function NewbieGuideManager:SetEnabled(enabled, reason)
  self._enabled = enabled
end

function NewbieGuideManager:PrintInfo()
  if self.currentStep then
    Logger.Info("当前引导:", table.tostring(self.currentStep.config.CnID))
  else
    Logger.Info("当前无引导")
  end
end

function NewbieGuideManager:IsInGuidePanel()
  if UIManager.Instance:GetWindow(Urls.NewbieGuideView) then
    return true
  end
end

function NewbieGuideManager:IsHaveGuideStep()
  return self.currentStep ~= nil
end

function NewbieGuideManager:IsInForceGuide()
  local newBieGuidePanel = UIManager.Instance:GetWindow(Urls.NewbieGuideView)
  if newBieGuidePanel and newBieGuidePanel:IsForceGuide() then
    return true
  end
  local battlePanel = UIManager.Instance:GetWindow(Urls.NewbieGuideBattleView)
  if battlePanel then
    return true
  end
  return false
end

function NewbieGuideManager:IsBusy()
  if self:IsInGuidePanel() then
    return true
  end
  if not SceneMgr.Instance:IsInTown() then
    return
  end
  if table.next(self.panelOpenedInGuiding) then
    return true
  end
end

function NewbieGuideManager:GetBusyReason()
  if self:IsInGuidePanel() then
    return "InGuidePanel"
  end
  if not SceneMgr.Instance:IsInTown() then
    return "NotInTown"
  end
  if table.next(self.panelOpenedInGuiding) then
    do return string.format, "PanelOpenedInGuiding:%s-%s", self:GetCurrentGuideName(), table.concat(table.keys(self.panelOpenedInGuiding), ",") end
    return string.format, "PanelOpenedInGuiding:%s-%s", self:GetCurrentGuideName(), table.concat(table.keys(self.panelOpenedInGuiding), ",")
  end
end

function NewbieGuideManager:OnTick()
  if self:IsDirty() then
    if GuidePanelUtils.IsViewAtTop(Urls.MainPanel) then
      return
    end
    self:CheckToGuide()
  end
end

function NewbieGuideManager:IsDirty()
  return self._dirtyCount and self._dirtyCount > 0
end

function NewbieGuideManager:SetDirty()
  self._dirtyCount = 10
end

function NewbieGuideManager:ClearDirty()
  self._dirtyCount = 0
end

function NewbieGuideManager:MinusDirtyCount()
  if self._dirtyCount then
    self._dirtyCount = self._dirtyCount - 1
  end
end

function NewbieGuideManager:OnClientDataInit()
  self:InitGuideConfig()
  if UIManager.Instance:GetWindow(Urls.MainPanel) then
    self:SetDirty()
  end
end

function NewbieGuideManager:OnPanelOpened(url)
  if url == Urls.NewbieGuideView then
    return
  end
  if not SceneMgr.Instance:IsInTown() then
    return
  end
  if not GuidePanelUtils.IsViewAtTop(Urls.MainPanel) then
    self:SetDirty()
  end
  if url == Urls.MainPanel then
    table.clear(self.panelOpenedInGuiding)
  elseif self:IsInGuidePanel() then
    self.panelOpenedInGuiding[url] = true
  end
end

function NewbieGuideManager:OnCloseUIPanel(url)
  if url == Urls.NewbieGuideView then
    return
  end
  self:ClearNewbieGo(url)
  self.panelOpenedInGuiding[url] = nil
  self:SetDirty()
end

function NewbieGuideManager:OnPanelClose(panel)
  if self:IsInGuidePanel() then
    FrameWaiter.OnNextFrame(function()
      self:CheckCurrentStep()
    end, 2)
  end
end

function NewbieGuideManager:OnNewbieGuideClick()
  self:SetDirty()
end

function NewbieGuideManager:IsGuideFinished(guideTid)
  local guideState = ClientDataUtils.GetData(cd.ClientDataMainKey.NewbieGuide, guideTid)
  return guideState == cd.NewbieGuideFinishState
end

function NewbieGuideManager:GetCurrentGuideName()
  if self.currentStep then
    return self.currentStep.config.CnID
  end
  return nil
end

function NewbieGuideManager:MarkGuideFinish(guideTid)
  ClientDataUtils.SetData(cd.ClientDataMainKey.NewbieGuide, guideTid, cd.NewbieGuideFinishState)
end

function NewbieGuideManager:SetGuideFinish(guideTid)
  self:MarkGuideFinish(guideTid)
  for index, step in ipairs(self.guideSteps) do
    if step.tid == guideTid then
      table.remove(self.guideSteps, index)
      break
    end
  end
  print("------------set guide finish", guideTid, debug.traceback())
  if self.currentStep and self.currentStep.tid == guideTid then
    self.currentStep.binder:teardown()
    self.currentStep = nil
  end
end

function NewbieGuideManager:SetGuideStepFinish(guideTid, guideStep)
  print("-------------SetGuideStepFinish", guideTid, guideStep, debug.traceback())
  self:MarkGuideFinish(guideTid)
  for index, step in ipairs(self.guideSteps) do
    if step == guideStep then
      table.remove(self.guideSteps, index)
      break
    end
  end
  self.currentStep = nil
  if guideStep then
    guideStep.binder:teardown()
  end
  self:SetDirty()
end

function NewbieGuideManager:GmSkipAllGuide()
  for guideTid in pairs(DT.NewbieGuide) do
    self:MarkGuideFinish(guideTid)
  end
  self.currentStep = nil
  self.guideSteps = {}
  UIManager.Instance:CloseByUrl(Urls.NewbieGuideView)
end

function NewbieGuideManager:CheckCurrentStep()
  if self.currentStep then
    self.currentStep:Continue()
    return
  end
end

function NewbieGuideManager:CheckToGuide()
  if not self._enabled then
    return
  end
  self:MinusDirtyCount()
  if self.currentStep then
    self.currentStep:Continue()
    if self:IsInGuidePanel() then
      self:ClearDirty()
    end
    return
  end
  for _, step in ipairs(self.guideSteps) do
    if step:CheckToGuide() then
      self.currentStep = step
      step:Continue()
      return
    end
  end
  self:ClearDirty()
  UIManager.Instance:CloseByUrl(Urls.NewbieGuideView)
end

function NewbieGuideManager:GetRegisterGameObject(name)
  if self.newbieGoMap[name] then
    return self.newbieGoMap[name].go
  end
end

function NewbieGuideManager:RegisterNewbieGo(name, go, relatedUrl)
  print("-------------RegisterNewbieGo", name, go, relatedUrl)
  self.newbieGoMap[name] = {go = go, relatedUrl = relatedUrl}
  self:SetEnabled(true)
  self:SetDirty()
end

function NewbieGuideManager:UnregisterNewbieGo(name)
  self.newbieGoMap[name] = nil
  self:SetDirty()
end

function NewbieGuideManager:GetRegisterNewbiePanel(name)
  if self.newbiePanelMap[name] then
    return self.newbiePanelMap[name].panel
  end
end

function NewbieGuideManager:RegisterNewbiePanel(name, panel, relatedUrl)
  self.newbiePanelMap[name] = {panel = panel, relatedUrl = relatedUrl}
  self:SetEnabled(true)
  self:SetDirty()
end

function NewbieGuideManager:UnregisterNewbiePanel(name)
  self.newbiePanelMap[name] = nil
  self:SetDirty()
end

function NewbieGuideManager:ClearNewbieGo(relatedUrl)
  for name, data in pairs(self.newbieGoMap) do
    if data.relatedUrl == relatedUrl then
      self.newbieGoMap[name] = nil
    end
  end
  self:SetDirty()
end

return NewbieGuideManager
