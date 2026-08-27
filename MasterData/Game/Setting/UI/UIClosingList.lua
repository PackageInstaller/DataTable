local UIClosingList = class("UIClosingList", UIBaseWindow)
local base = UIBaseWindow
local cs_Ease = CS.DG.Tweening.Ease
local CS_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder

function UIClosingList:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.CloseSettingClicked)
  UIUtil.AddButtonListener(self.ui.btn_bk, self, self.OnClickBk)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Delete):PushTopStatusDataToBackStack()
  self.isDelete = false
end

function UIClosingList:InitClosingList()
  AudioManager:RecordCurBgm()
  AudioManager:StopSource(eAudioSourceType.BgmSource)
  local oasisCtrl = ControllerManager:GetController(ControllerTypeId.OasisController)
  if oasisCtrl ~= nil then
    oasisCtrl.weatherCtrl:StopWeatherEffect()
  end
  local homeController = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeController ~= nil then
    homeController:ResetShowHeroVoiceImme()
  end
  AudioManager:RemoveAllVoice(true)
  AudioManager:PlayAudio("Mus_OP", "Mus_OP", eAudioSourceType.BgmSource)
  self.ui.btn_Return.gameObject:SetActive(false)
  self.ui.group_return.alpha = 0
  CS_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.trans_group)
  local path = PathConsts:GetStaffVideoFullPath()
  self.moviePlayer = UIManager:ShowWindow(UIWindowTypeID.MoviePlayer)
  self.moviePlayer:PlayMovie(path, nil, 1, false, function()
    self.moviePlayer = nil
    if self.isDelete then
      return
    end
    local targetPos = self.ui.trans_group.sizeDelta.y - UIManager.BackgroundStretchSize.y / 2 + self.ui.endOffset
    self.ui.group_main:DOFade(1, 0.5)
    self.moveTween = self.ui.trans_group:DOAnchorPosY(targetPos, self.ui.rollTime):SetDelay(self.ui.delayRollTime):SetEase(cs_Ease.Linear):OnComplete(function()
      self.moveTween = nil
      self:OnClickBk()
    end)
  end)
  self.moviePlayer:SetMovieFade(9, 1)
end

function UIClosingList:CloseSettingClicked()
  UIUtil.OnClickBackByUiTab(self)
end

function UIClosingList:OnClickBk()
  self.ui.btn_Return.gameObject:SetActive(true)
  self.returnFadeTween = self.ui.group_return:DOFade(1, 0.5):OnComplete(function()
    self.returnFadeTween = nil
    self:CloseReturnTimer()
    self.returnTimer = TimerManager:StartTimer(3, function()
      self.ui.btn_Return.gameObject:SetActive(false)
      self.ui.group_return.alpha = 0
    end, nil, true, nil)
  end)
end

function UIClosingList:CloseReturnTimer()
  if self.returnTimer ~= nil then
    TimerManager:StopTimer(self.returnTimer)
    self.returnTimer = nil
  end
end

function UIClosingList:OnDelete()
  if self.moveTween then
    self.moveTween:Kill()
    self.moveTween = nil
  end
  if self.returnFadeTween then
    self.returnFadeTween:Kill()
    self.returnFadeTween = nil
  end
  self:CloseReturnTimer()
  AudioManager:ResumeLastBgm()
  local oasisCtrl = ControllerManager:GetController(ControllerTypeId.OasisController)
  if oasisCtrl ~= nil then
    oasisCtrl.weatherCtrl:RandomNewWeather()
  end
  self.isDelete = true
  if self.moviePlayer ~= nil then
    self.moviePlayer:CloseMoviePlayer()
    self.moviePlayer = nil
  end
  base.OnDelete(self)
end

return UIClosingList
