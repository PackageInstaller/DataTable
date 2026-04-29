_class("UISeasonBuildEntryBtn", UICustomWidget)
UISeasonBuildEntryBtn = UISeasonBuildEntryBtn

function UISeasonBuildEntryBtn:OnShow(uiParams)
  self:InitWidget()
  self._seaonModule = GameGlobal.GetModule(SeasonModule)
  self._context = self._seaonModule:GetSeasonBuildContext()
  if not self._context then
    self._context = UISeasonBuildContextS3:New()
    self._context:Init()
    self._seaonModule:SetSeasonBuildContext(self._context)
  end
  self:RefreshStatus()
  self:AttachEvent(GameEventType.OnSeasonBuildLevelUp, self.RefreshStatus)
  self:AttachEvent(GameEventType.OnSeasonTaskReset, self.RefreshStatus)
  self:AttachEvent(GameEventType.OnSeasonTaskRefreshed, self.RefreshStatus)
end

function UISeasonBuildEntryBtn:OnHide()
  self:DetachEvent(GameEventType.OnSeasonBuildLevelUp, self.RefreshStatus)
  self:DetachEvent(GameEventType.OnSeasonTaskReset, self.RefreshStatus)
  self:DetachEvent(GameEventType.OnSeasonTaskRefreshed, self.RefreshStatus)
end

function UISeasonBuildEntryBtn:InitWidget()
  self.tip1Go = self:GetGameObject("tip1Go")
end

function UISeasonBuildEntryBtn:RefreshStatus()
  local canBuild = self._context:CanBuild()
  self.tip1Go:SetActive(canBuild)
end

function UISeasonBuildEntryBtn:BtnOnClick(go)
  if not self._seaonModule:CheckSeasonBuildOpen() then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
    return
  end
  local mgr = self._seaonModule.uiModule:SeasonManager()
  local eventPoint = mgr:SeasonMapManager():GetEventPoint(8003301)
  mgr:SeasonInputManager():GetInput():SetClickUnLockZone(eventPoint:IsUnlock())
  mgr:SeasonInputManager():GetInput():GetClickEffect():Click()
  mgr:SeasonInputManager():GetInput():SetCurClickEventPoint(eventPoint)
  local guideModule = GameGlobal.GetModule(GuideModule)
  if guideModule:IsGuideDone(80030101) then
    eventPoint:AutoMoveToMe()
  else
    eventPoint:GuideMove()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Button)
  end
end
