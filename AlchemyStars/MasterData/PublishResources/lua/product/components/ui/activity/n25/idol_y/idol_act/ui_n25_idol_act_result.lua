_class("UIN25IdolActResult", UIController)
UIN25IdolActResult = UIN25IdolActResult

function UIN25IdolActResult:Constructor()
  AudioHelperController.RequestUISoundSync(CriAudioIDConst.HomelandAudioGood)
end

function UIN25IdolActResult:OnShow(uiParams)
  self.idolAcID = uiParams[1]
  self.callback = uiParams[2]
  self:CreateData()
  self:GetComponents()
  self:OnValue()
end

function UIN25IdolActResult:CreateData()
  self.cfg = Cfg.cfg_component_idol_activity[self.idolAcID]
end

function UIN25IdolActResult:GetComponents()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtn")
  self.backBtns = backBtns:SpawnObject("UINewCommonTopButton")
  self.backBtns:SetData(function()
    self:CloseDialog()
  end, nil, nil, true)
  local resultPool = self:GetUIComponent("UISelectObjectPath", "ResultPool")
  self.resultItem = resultPool:SpawnObject("UIN25IdolCommonResultItem")
end

function UIN25IdolActResult:OnHide()
  if self.callback then
    self.callback()
  end
  AudioHelperController.ReleaseUISoundById(CriAudioIDConst.HomelandAudioGood)
end

function UIN25IdolActResult:OnValue()
  local valuePlus = self.cfg.Fans or 0
  local desc1 = self.cfg.Desc1
  local desc2 = self.cfg.Desc2
  self.resultItem:SetData(UIIdolResultType.Act, valuePlus, desc1, desc2)
  self:_PlayAudio()
end

function UIN25IdolActResult:_PlayAudio()
  local lockName = "UIN25IdolActResult_PlayAudio"
  GameGlobal.UIStateManager():Lock(lockName)
  self:StartTask(function(TT)
    self._soundPlayingID = AudioHelperController.PlayUISoundResource(CriAudioIDConst.HomelandAudioGood, true)
    YIELD(TT, 2000)
    if self._soundPlayingID then
      AudioHelperController.StopUISound(self._soundPlayingID)
    end
    GameGlobal.UIStateManager():UnLock(lockName)
  end)
end

function UIN25IdolActResult:ResultBtnOnClick(go)
  self:CloseDialog()
end
