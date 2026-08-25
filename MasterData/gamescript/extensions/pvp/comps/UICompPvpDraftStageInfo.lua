local UICompPvpDraftStageInfo, Super = NewViewComponent("UICompPvpDraftStageInfo")

function UICompPvpDraftStageInfo:ctor(uiNode, view)
  Super.ctor(self, uiNode, view)
  self.ui = UI_PVP_Item_Rotation_StageInfoResource(uiNode)
end

function UICompPvpDraftStageInfo:OnEnterComponent()
  self:_RefreshView()
end

function UICompPvpDraftStageInfo:_RefreshView()
  local draftRelicTid = PvpDraftModel.Instance:GetDraftRelicTid()
  local relicCfg = RelicCfgUtils.GetCfg(draftRelicTid)
  if not relicCfg then
    return
  end
  self:SetImage(self.ui.Icon_Relic, relicCfg.Icon)
  self:SetText(self.ui.Text_Relic_Name, LT.Text(relicCfg.Name))
  self:SetText(self.ui.Text_Relic_Desc, RelicDataUtils.GetRelicDesc(draftRelicTid))
  StrUtils.SetPreferredHeight(self.ui.Text_Relic_Desc)
end

function UICompPvpDraftStageInfo:SetCountDownTimer(endTs, totalTime, timerEndCb)
  self._endTs = endTs
  self._totalTime = totalTime
  self._timerEndCb = timerEndCb
  self:ClearTimer()
  self:_RefreshCountDown()
  self._timer = self:BindTimer(1, -1, function()
    self:_RefreshCountDown()
    if TimeUtils.GetServerTime() >= self._endTs then
      self:ClearTimer()
    end
    if TimeUtils.GetServerTime() >= self._endTs - 1 and self._timerEndCb then
      self._timerEndCb()
      self._timerEndCb = nil
    end
    if self._endTs <= TimeUtils.GetServerTime() then
      self:ClearTimer()
    end
  end)
end

function UICompPvpDraftStageInfo:_GetCountDown()
  return self._endTs - TimeUtils.GetServerTime()
end

function UICompPvpDraftStageInfo:_RefreshCountDown()
  local txtColorType = CommonDefine.ColorType.Light
  local colorCfg = ColorCfgUtils.GetCfg("UIPvpRotationSliderTime")
  local imgColor = colorCfg.Light
  local isEnemySelectPhase = PvpDraftModel.Instance:IsEnemySelectingPhase()
  local isStartPhase = PvpDraftModel.Instance:GetDraftPvpPhase() == PvpDefine.PvpDraftPhase.Start
  if isEnemySelectPhase or isStartPhase then
    txtColorType = CommonDefine.ColorType.Dark
    imgColor = colorCfg.Dark
  end
  local needAlert = self:_GetCountDown() <= 5
  if needAlert then
    AudioManager.Instance:PostSoundEvent("Play_NTC_PVP_Countdown_10to1s")
  end
  self:SetText(self.ui.Text_Cutdown, self:_GetCountDown())
  self:SetTextColorType(self.ui.Text_Cutdown, txtColorType)
  self:SetImageFillAmount(self.ui.Image_Cutdown, self:_GetCountDown() / self._totalTime)
  self:SetImageColorByHtml(self.ui.Image_Cutdown, imgColor)
end

function UICompPvpDraftStageInfo:ClearTimer()
  if self._timer then
    self:StopTimer(self._timer)
    self._timer = nil
  end
end

function UICompPvpDraftStageInfo:OnExitComponent()
  self:ClearTimer()
  Super.OnExitComponent(self)
end

return UICompPvpDraftStageInfo
