_class("UIHomelandFishing", UICustomWidget)
UIHomelandFishing = UIHomelandFishing
local EnumFishGameType = {
  NORMAL = 1,
  RACE = 3,
  INVIT = 5,
  NORMAL_CHANGE = 6
}
_enum("EnumFishGameType", EnumFishGameType)
local EnumEnergy = {
  LOWEDGE = -133,
  TOPEDGE = -46,
  A_MOVE = 3,
  B_MOVE = 4
}
_enum("EnumEnergy", EnumEnergy)

function UIHomelandFishing:Constructor()
  self._guideModule = self:GetModule(GuideModule)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  self._fishingManager = homelandClient:FishingManager()
  self._lockTable = {}
end

function UIHomelandFishing:OnShow(uiParams)
  self._status = nil
  self._floatPosition = nil
  self._go = self:GetGameObject()
  self:SetFishStatus(FishgingStatus.None)
  self._btnFishing = self:GetGameObject("BtnFishing")
  self._btnFishingImg = self:GetUIComponent("Image", "BtnFishing")
  self._btnCollect = self:GetGameObject("BtnCollect")
  self._btnDrag = self:GetGameObject("BtnDrag")
  self._fishingStatus = self:GetGameObject("FishingStatus")
  self._throwPowerImg = self:GetUIComponent("Image", "ThrowPower")
  self._throwPowerGo = self:GetGameObject("ThrowPowerPanel")
  self._floatGo = self:GetGameObject("Float")
  self._floatTran = self:GetUIComponent("RectTransform", "Float")
  self._normalGo = self:GetGameObject("Normal")
  self._biteGo = self:GetGameObject("Bite")
  self._floatParent = self:GetUIComponent("RectTransform", "FloatParent")
  self._powerTran = self:GetUIComponent("RectTransform", "Power")
  self._rangeImg = self:GetUIComponent("Image", "Range")
  self._rangeTran = self:GetUIComponent("RectTransform", "Range")
  self._progressImg = self:GetUIComponent("Image", "Progress")
  self._processSlider = self:GetUIComponent("RectTransform", "ProcessSlider")
  self._fishLengthTran = self:GetUIComponent("RectTransform", "FishLength")
  self._fishLengthPanel = self:GetGameObject("FishLengthPanel")
  self._btnExitGo = self:GetGameObject("BtnExit")
  self._circleHint = self:GetGameObject("Circle_hint")
  self._circleHint:SetActive(false)
  self._anim = self:GetUIComponent("Animation", "anim")
  self._matchObj = self:GetGameObject("match")
  self._matchAni = self:GetUIComponent("Animation", "match")
  self._cBG = self:GetGameObject("cBg")
  self._matchTitle = self:GetUIComponent("UILocalizationText", "matchTitle")
  self._numPet = self:GetUIComponent("UILocalizationText", "numPet")
  self._numPlayer = self:GetUIComponent("UILocalizationText", "numPlayer")
  self._matchTime = self:GetUIComponent("UILocalizationText", "matchTime")
  self._countDown = self:GetUIComponent("UILocalizedTMP", "countDown")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "canvasGroup")
  self._parent = self:GetGameObject("parent")
  self._playerGoal = 0
  self._petGoal = 0
  self._startTime = 3
  self._matchTotalTime = 0
  self._matchID = nil
  self._canFishSuccess = true
  self._throwPower = 0
  self._throwPowerSpeed = HomelandFishingConst.GetThrowPowerSpeed()
  self:AddButtonEvent(self._btnFishing, function()
    self:BtnFishingPress()
  end, function()
    self:BtnFishingRelase()
  end)
  self:AttachEvent(GameEventType.AppResume, self.OnAppResumeFish)
  self:AttachEvent(GameEventType.ChangeFishingStatus, self.SetFishStatus)
  self:AttachEvent(GameEventType.FishingFloatPositionChange, self.FishingFloatPositionChange)
  self:AttachEvent(GameEventType.FishThrowResult, self.OnFishThrowResult)
  self:AttachEvent(GameEventType.FishMatchReady, self.FishMatchReady)
  self:AttachEvent(GameEventType.FishMatchStart, self.FishMatchStart)
  self:AttachEvent(GameEventType.FishMatchEnd, self.FishMatchEnd)
  self:AttachEvent(GameEventType.FishMatchScore, self.PlayerFishGet)
  self:AttachEvent(GameEventType.FishMatchPetScore, self.PetFishGet)
  self:AddButtonEvent(self._btnDrag, function()
    self:BtnDragPress()
  end, function()
    self:BtnDragRelease()
  end)
  self._timerHandler = GameGlobal.Timer():AddEventTimes(1, TimerTriggerCount.Infinite, function()
    self:Update()
  end)
  self._isPlayFishOrPersionPowerOutRangeAnim = false
end

function UIHomelandFishing:ExitHomeland()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIHomelandFishing:OnHide()
  self:StopThrowPowerTimer()
  self:DetachEvent(GameEventType.AppResume, self.OnAppResumeFish)
  self:DetachEvent(GameEventType.ChangeFishingStatus, self.SetFishStatus)
  self:DetachEvent(GameEventType.FishingFloatPositionChange, self.FishingFloatPositionChange)
  self:DetachEvent(GameEventType.FishThrowResult, self.OnFishThrowResult)
  self:DetachEvent(GameEventType.ExitHomeland, self.ExitHomeland)
  self:DetachEvent(GameEventType.FishMatchStart, self.FishMatchStart)
  self:DetachEvent(GameEventType.FishMatchEnd, self.FishMatchEnd)
  self:DetachEvent(GameEventType.FishMatchScore, self.PlayerFishGet)
  self:DetachEvent(GameEventType.FishMatchPetScore, self.PetFishGet)
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  if self._animTask then
    GameGlobal.TaskManager():KillTask(self._animTask)
    for _, v in pairs(self._lockTable) do
      self:UnLock(v)
    end
    self._lockTable = nil
    self._animTask = nil
  end
  self:UnLock("UIHomelandFishing_Throw")
end

function UIHomelandFishing:Update()
  if self._status == FishgingStatus.Bite then
    self:UpdateFishing()
  end
  local camera = UnityEngine.Camera.main
  if not camera then
    return
  end
  if (self._status == FishgingStatus.Bite or self._status == FishgingStatus.Fishing) and self._floatPosition then
    local uiCamera = GameGlobal.UIStateManager():GetControllerCamera("UIHomelandMain")
    local screenPos = camera:WorldToScreenPoint(self._floatPosition)
    local uiPos = self:ScreenPointToLocalPointInRectangle(self._floatParent, screenPos, uiCamera)
    self._floatTran.anchoredPosition = uiPos
  end
end

function UIHomelandFishing:ScreenPointToLocalPointInRectangle(rect, screenPoint, camera)
  local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(rect, screenPoint, camera, nil)
  return pos
end

function UIHomelandFishing:UpdateThrowPower()
  local value = self._throwPowerSpeed * UnityEngine.Time.deltaTime
  self._throwPower = self._throwPower + value
  if self._throwPower >= 1 then
    self._throwPower = 1
    self._throwPowerSpeed = -self._throwPowerSpeed
  elseif self._throwPower <= 0 then
    self._throwPower = 0
    self._throwPowerSpeed = -self._throwPowerSpeed
  end
  self._throwPowerImg.fillAmount = self._throwPower * 0.239
end

function UIHomelandFishing:AddButtonEvent(go, pressCallback, releaseCallback)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(go), UIEvent.Press, pressCallback)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(go), UIEvent.Release, releaseCallback)
end

function UIHomelandFishing:OnAppResumeFish()
  Log.fatal("钓鱼恢复前台")
  if self._status == FishgingStatus.Throw then
    self:BtnFishingRelase()
  end
end

function UIHomelandFishing:SetFishStatus(status)
  self._status = status
  if status == FishgingStatus.None then
    self._go:SetActive(false)
    return
  else
    self._go:SetActive(true)
  end
  self:PlayPowerUIHideAnim(false)
  self._btnFishing:SetActive(false)
  self._btnCollect:SetActive(false)
  self._btnDrag:SetActive(false)
  self._fishLengthPanel:SetActive(false)
  self._floatGo:SetActive(false)
  self._btnExitGo:SetActive(false)
  self:PlayStatusUIHideAnim()
  self._canFishSuccess = true
  if status == FishgingStatus.Throw then
    self._btnFishing:SetActive(true)
    if self._btnFishing.activeInHierarchy then
      self:_CheckGuide()
    end
  elseif status == FishgingStatus.Fishing then
    self._btnCollect:SetActive(true)
    self._floatGo:SetActive(true)
    self._normalGo:SetActive(true)
    self._biteGo:SetActive(false)
  elseif status == FishgingStatus.Bite then
    self._btnDrag:SetActive(true)
    self:PlayStatusUIShowAnim()
    self._fishLengthPanel:SetActive(true)
    self._floatGo:SetActive(true)
    self._normalGo:SetActive(false)
    self._biteGo:SetActive(true)
    self._btnExitGo:SetActive(true)
    self:StartFishing()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Button)
  elseif status == FishgingStatus.FishDecoupling then
  elseif status == FishgingStatus.Finish then
    self._btnFishing:SetActive(true)
  elseif status == FishgingStatus.FishSuccess then
    self._go:SetActive(false)
  end
end

function UIHomelandFishing:StartFishing()
  self._inFishingStatusTimer = 0
  self._fish = HomelandFishingConst.GetBiteFish()
  self._biteLength = self._fish:GetDecouplingTime()
  self._fishrod = HomelandFishingConst.GetCurrentFishRod()
  self._fishingTimer = 0
  self._powerErrorTime = self._fish:GetLineBreakTime()
  self._minValue, self._maxValue = self._fish:GetPowerRange()
  self._successMinValue, self._successMaxValue = self._fish:GetRightPowerRange()
  self._fishSpeed = -1
  self._playerSpeed = HomelandFishingConst.GetPlayerPowerNormalSpeed()
  self._playerLongPressSpeed = HomelandFishingConst.GetPlayerPowerHighSpeed()
  self._fishingLength = self._fishrod:GetFishingLength()
  self._fishingSuccessTimer = 0
  self._isPressedFishing = false
  self._currentValue = (self._successMinValue + self._successMaxValue) / 2
  self._fishPlayType = EnumFishGameType.NORMAL
  if self._matchID then
    local cfg = Cfg.cfg_homeland_fishmatch_main[self._matchID]
    self._fishPlayType = cfg.Type
  end
  self._count = 2
  self:GetFishOperateDate(self._fishPlayType)
  self.tagtype = 0
  self._speed = self._fish:GetGameMoveSpeed(self._fishPlayType, 1)
  if self._speed == nil and self._fishPlayType ~= 1 then
    self.tagtype = self._fishPlayType
    self._fishPlayType = EnumFishGameType.NORMAL
  elseif self._speed ~= nil and self._fishPlayType == EnumFishGameType.NORMAL then
    self._fishPlayType = EnumFishGameType.NORMAL_CHANGE
  end
  if self._fishPlayType == EnumFishGameType.NORMAL and self.tagtype == EnumFishGameType.RACE then
    self._minValue, self._maxValue = self._fish:GetRacePowerRange()
    self._successMinValue, self._successMaxValue = self._fish:GetRaceRightPowerRange()
    self._currentValue = (self._successMinValue + self._successMaxValue) / 2
  elseif self._fishPlayType == EnumFishGameType.NORMAL and self.tagtype == EnumFishGameType.INVIT then
    self._minValue, self._maxValue = self._fish:GetInvitePowerRange()
    self._successMinValue, self._successMaxValue = self._fish:GetInviteRightPowerRange()
    self._currentValue = (self._successMinValue + self._successMaxValue) / 2
  end
  if self._fishPlayType == EnumFishGameType.NORMAL then
    self:GetFishOperateDate(self._fishPlayType)
    self:InitFishingUI()
    self:RefreshFishingUI()
  else
    if self._fishPlayType == EnumFishGameType.RACE then
      self._minValue, self._maxValue = self._fish:GetRacePowerRange()
      self._successMinValue, self._successMaxValue = self._fish:GetRaceRightPowerRange()
      self._currentValue = (self._successMinValue + self._successMaxValue) / 2
    elseif self._fishPlayType == EnumFishGameType.INVIT then
      self._minValue, self._maxValue = self._fish:GetInvitePowerRange()
      self._successMinValue, self._successMaxValue = self._fish:GetInviteRightPowerRange()
      self._currentValue = (self._successMinValue + self._successMaxValue) / 2
    end
    self:GetFishOperateDate(self._fishPlayType)
    self:InitFishingUI()
    self._fishtime = 0
    self:RefreshDificultFishingUI()
  end
end

function UIHomelandFishing:GetFishOperateDate(type)
  local totalValue = self._maxValue - self._minValue
  self._totalProcess = 0.239
  self._successValue = self._successMaxValue - self._successMinValue
  self._startFillAmount = self._successValue / totalValue * self._totalProcess
  local percent = (self._successMinValue - self._minValue) / totalValue
  self._targetAnglea2 = 86.3 * percent - 133
  self._speed = self._fish:GetGameMoveSpeed(type, 1)
  if self._speed == nil then
    return
  end
  self._movetime = self._fish:GetMoveTime(type, 1)
  self._changetime = self._fish:GetChangeTime(type, 1)
  self._changeLength = self._fish:GetChangeLength(type, 1) * 0.028
  self._changeup = self._startFillAmount + self._changeLength
  if 0.028 > self._changeup then
    self._changeup = 0.028
  end
  self._changedown = self._targetAnglea2 - self._changeLength / 2 * 360
  self._length = self._speed * self._movetime * 5.754
  self._movedirection = math.random(1, 2)
  self._movedirection = self._movedirection == 1 and 1 or -1
  self._addchange = self._changeLength / 2 * 360
  self._moveLength = self._targetAnglea2 - self._addchange + self._length * self._movedirection
  local fillamount = self._rangeImg.fillAmount
  self._topedge = self._moveLength + fillamount * 360 + self._changeLength / 2 * 360
  if self._moveLength < EnumEnergy.LOWEDGE then
    self._tagmovedirection = true
  else
    self._tagmovedirection = false
  end
  if self._tagmovedirection == false then
    if self._topedge > EnumEnergy.TOPEDGE then
      self._tagmovedirection = true
    else
      self._tagmovedirection = false
    end
  end
  if self._movedirection < 0 and self._changeLength < 0 then
    self._tag1 = EnumEnergy.A_MOVE
  end
  if self._movedirection > 0 and self._changeLength > 0 then
    self._tag1 = EnumEnergy.B_MOVE
  end
end

function UIHomelandFishing:GetFishOperateDateChange(type, n)
  self._speed = self._fish:GetGameMoveSpeed(type, n)
  if self._speed == nil then
    return
  end
  self._movetime = self._fish:GetMoveTime(type, n)
  self._changetime = self._fish:GetChangeTime(type, n)
  self._changeLength = self._fish:GetChangeLength(type, n) * 0.028
  self._targetAnglea2 = self._rangeTran.localEulerAngles.z - 360
  local fillamount = self._rangeImg.fillAmount
  self._changeup = fillamount + self._changeLength
  if 0.028 > self._changeup then
    self._changeup = 0.028
  end
  self._changedown = self._targetAnglea2 - self._changeLength / 2 * 360
  if self._tagmovedirection == false or self._tagmovedirection == nil then
    self._movedirection = math.random(1, 2)
    self._movedirection = self._movedirection == 1 and 1 or -1
  else
    self._movedirection = -self._movedirection
  end
  self._length = self._speed * self._movetime * 5.754
  self._addchange = self._changeLength / 2 * 360
  self._moveLength = self._targetAnglea2 - self._addchange + self._length * self._movedirection
  local fillamount = self._rangeImg.fillAmount
  self._topedge = self._moveLength + fillamount * 360 + self._changeLength / 2 * 360
  if self._movedirection < 0 and self._changeLength < 0 then
    self._tag1 = EnumEnergy.A_MOVE
  end
  if self._movedirection > 0 and self._changeLength > 0 then
    self._tag1 = EnumEnergy.B_MOVE
  end
  if self._moveLength < EnumEnergy.LOWEDGE then
    self._tagmovedirection = true
  else
    self._tagmovedirection = false
  end
  if self._tagmovedirection == false then
    if self._topedge > EnumEnergy.TOPEDGE then
      self._tagmovedirection = true
    else
      self._tagmovedirection = false
    end
  end
end

function UIHomelandFishing:UpdateFishing()
  if self._status == FishgingStatus.Bite and self._guideModule:IsGuideProcessKey("guide_fishing") then
    return
  end
  local deltaTime = UnityEngine.Time.deltaTime
  self._inFishingStatusTimer = self._inFishingStatusTimer + deltaTime
  if self._fishPlayType == EnumFishGameType.RACE then
    self._fishSpeed = self._fish:GetRaceFishPowerSpeed(self._inFishingStatusTimer * 1000)
  elseif self._fishPlayType == EnumFishGameType.INVIT then
    self._fishSpeed = self._fish:GetInviteFishPowerSpeed(self._inFishingStatusTimer * 1000)
  else
    self._fishSpeed = self._fish:GetFishPowerSpeed(self._inFishingStatusTimer * 1000)
  end
  self._currentValue = self._currentValue + deltaTime * self._fishSpeed
  if self._isPressedFishing then
    self._currentValue = self._currentValue + deltaTime * self._playerLongPressSpeed
  end
  if self._currentValue <= self._minValue then
    self._currentValue = self._minValue
    self:FishingPowerError(FishgingFailureReason.FishPowerGreat)
    self:OnFishingPowerChange(-1)
  elseif self._currentValue >= self._maxValue then
    self._currentValue = self._maxValue
    self:FishingPowerError(FishgingFailureReason.PersonPowerGreat)
    self:OnFishingPowerChange(1)
  else
    self:StopFishAndPersionPowerOutRangeAnim()
    self._fishingTimer = 0
    if self._currentValue >= self._successMinValue and self._currentValue <= self._successMaxValue then
      self:OnFishingPowerChange(0)
      self._fishingSuccessTimer = self._fishingSuccessTimer + deltaTime
      if self._fishingSuccessTimer >= self._fishingLength and self._canFishSuccess then
        self:FishingSuccess()
      end
    elseif self._currentValue < self._successMinValue then
      self:OnFishingPowerChange(-1)
    elseif self._currentValue > self._successMaxValue then
      self:OnFishingPowerChange(1)
    end
  end
  if self._fishPlayType == EnumFishGameType.NORMAL then
    self:RefreshFishingUI()
  else
    self._fishtime = self._fishtime + deltaTime
    if self._fishtime > self._totaltime then
      self._fishtime = 0
      self:GetFishOperateDateChange(self._fishPlayType, self._count)
      self._totaltime = math.max(self._changetime, self._movetime)
      self._count = self._count + 1
    end
    self:RefreshDificultFishingUI()
  end
end

function UIHomelandFishing:OnFishingPowerChange(value)
  local percent = -1
  if value == 0 then
    percent = -1
  elseif 0 < value then
    percent = (self._currentValue - self._successMaxValue) / (self._maxValue - self._successMaxValue)
  elseif value < 0 then
    percent = self._currentValue / (self._successMinValue - self._minValue)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FishingPowerChange, value, percent)
end

function UIHomelandFishing:InitFishingUI()
  self._progressImg.fillAmount = 0
  self._processSlider.localEulerAngles = Vector3(0, 0, -41.7)
  local totalProcess = 0.239
  local angle = -133
  local remainAngle = 86.3
  local totalValue = self._maxValue - self._minValue
  local successValue = self._successMaxValue - self._successMinValue
  self._rangeImg.fillAmount = successValue / totalValue * totalProcess
  local percent = (self._successMinValue - self._minValue) / totalValue
  local targetAngle = remainAngle * percent + angle
  self._rangeTran.localEulerAngles = Vector3(0, 0, targetAngle)
end

function UIHomelandFishing:RefreshFishingUI()
  local totalFishingProgress = 0.237
  local process = totalFishingProgress * self._fishingSuccessTimer / self._fishingLength
  self._progressImg.fillAmount = process
  local totalAngle = 85.7
  self._processSlider.localEulerAngles = Vector3(0, 0, -41.7 + totalAngle * process / totalFishingProgress)
  local angle = -42.5
  local remainAngle = 85
  local totalValue = self._maxValue - self._minValue
  local percent = (self._currentValue - self._minValue) / totalValue
  local targetAngle = remainAngle * percent + angle
  self._powerTran.localEulerAngles = Vector3(0, 0, targetAngle)
  local totalWidth = 1004
  local width = (self._biteLength - self._inFishingStatusTimer) / self._biteLength * totalWidth
  self._fishLengthTran.sizeDelta = Vector2(width, 9)
end

function UIHomelandFishing:RefreshDificultFishingUI()
  local totalFishingProgress = 0.237
  local process = totalFishingProgress * self._fishingSuccessTimer / self._fishingLength
  self._progressImg.fillAmount = process
  local totalAngle = 85.7
  self._processSlider.localEulerAngles = Vector3(0, 0, -41.7 + totalAngle * process / totalFishingProgress)
  local angle = -42.5
  local remainAngle = 85
  local totalValue = self._maxValue - self._minValue
  local percent = (self._currentValue - self._minValue) / totalValue
  local targetAngle = remainAngle * percent + angle
  self._powerTran.localEulerAngles = Vector3(0, 0, targetAngle)
  local totalWidth = 1004
  local width = (self._biteLength - self._inFishingStatusTimer) / self._biteLength * totalWidth
  self._fishLengthTran.sizeDelta = Vector2(width, 9)
  self._totaltime = math.max(self._changetime, self._movetime)
  local rotationz = self._rangeTran.localEulerAngles.z - 360
  if self._fishtime == 0 or self._fishtime == nil then
    self._tweenning = false
  end
  if rotationz < -132.9 then
    self._rangeTran:DOKill()
    self._rangeImg:DOKill()
    self._rangeTran.localEulerAngles = Vector3(0, 0, -132.9)
  end
  local fillamount = self._rangeImg.fillAmount
  self._topedge = rotationz + fillamount * 360
  if self._topedge > -46.5 then
    self._rangeTran:DOKill()
    self._rangeImg:DOKill()
    self._rangeImg.fillAmount = (-46.8 - rotationz) / 360
  end
  if not self._tweenning then
    local tweenCnt = 0
    self._tweenning = true
    
    local function TweenCallBack()
      if tweenCnt == 2 then
        self._tweenning = false
      end
    end
    
    if self._tag1 ~= nil then
      self._rangeImg:DOKill()
      self._rangeTran:DOKill()
      if self._tag1 == EnumEnergy.A_MOVE then
        self._rangeImg:DOFillAmount(self._changeup, self._changetime / 2):SetEase(DG.Tweening.Ease.Linear)
        self._rangeTran:DOLocalRotate(Vector3(0, 0, self._changedown), self._changetime / 2, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
          self._rangeTran:DOLocalRotate(Vector3(0, 0, self._moveLength), self._movetime, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
            tweenCnt = 2
            TweenCallBack()
          end)
        end)
      else
        self._rangeImg:DOFillAmount(self._changeup, self._changetime / 2):SetEase(DG.Tweening.Ease.Linear)
        self._rangeTran:DOLocalRotate(Vector3(0, 0, self._changedown), self._changetime / 2, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
          self._rangeTran:DOLocalRotate(Vector3(0, 0, self._moveLength), self._movetime, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
            tweenCnt = 2
            TweenCallBack()
          end)
        end)
      end
      self._tag1 = nil
    else
      self._rangeImg:DOKill()
      self._rangeTran:DOKill()
      do
        local t1 = self._rangeImg:DOFillAmount(self._changeup, self._changetime / 2):SetEase(DG.Tweening.Ease.Linear)
        local t2 = self._rangeTran:DOLocalRotate(Vector3(0, 0, self._moveLength), self._movetime, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.Linear)
        t1:OnComplete(function()
          tweenCnt = tweenCnt + 1
          TweenCallBack()
        end)
        t2:OnComplete(function()
          tweenCnt = tweenCnt + 1
          TweenCallBack()
        end)
      end
    end
  end
  local rotationz = self._rangeTran.localEulerAngles.z
  local successMinValue = (-227 + rotationz) / 5.754
  self._successMinValue = successMinValue
  local fillamount = self._rangeImg.fillAmount
  local successMaxValue = fillamount / 0.015983
  self._successMaxValue = self._successMinValue + successMaxValue
end

function UIHomelandFishing:FishingPowerError(failureReason)
  self:PlayFishAndPersionPowerOutRangeAnim()
  self._fishingTimer = self._fishingTimer + UnityEngine.Time.deltaTime
  if self._fishingTimer >= self._powerErrorTime then
    self:FishingFailure(failureReason)
  end
end

function UIHomelandFishing:FishingFloatPositionChange(pos)
  self._floatPosition = pos
end

function UIHomelandFishing:BtnFishingPress()
  if self:IsDashing() then
    return
  end
  self._btnFishingImg.color = Color(1, 1, 1, 1)
  self:StopThrowPowerTimer()
  self:Lock("UIHomelandFishing_Throw")
  self:StopFishAndPersionPowerOutRangeAnim()
  self._btnFishing.transform.localScale = Vector3(0.95, 0.95, 0.95)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FishingStartThrow)
  self:PlayPowerUIShowAnim()
  self._throwPower = 0
  self._throwPowerImg.fillAmount = self._throwPower
  self._throwPowerTimerHandler = GameGlobal.Timer():AddEventTimes(1, TimerTriggerCount.Infinite, function()
    self:UpdateThrowPower()
  end)
  self:ForbiddenMove(true)
end

function UIHomelandFishing:BtnFishingRelase()
  if self:IsDashing() or not self._throwPowerTimerHandler then
    Log.fatal("release返回了")
    return
  end
  self:UnLock("UIHomelandFishing_Throw")
  self._btnFishing.transform.localScale = Vector3(1.0, 1.0, 1.0)
  self:ForbiddenMove(false)
  self:StopThrowPowerTimer()
  if not self._guideModule:IsGuideProcessKey("guide_fishing") then
    self._btnFishing:SetActive(false)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FishingThrowPower, self._throwPower)
end

function UIHomelandFishing:StopThrowPowerTimer()
  if self._throwPowerTimerHandler then
    GameGlobal.Timer():CancelEvent(self._throwPowerTimerHandler)
    self._throwPowerTimerHandler = nil
  end
end

function UIHomelandFishing:BtnCollectOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FishingCollect)
end

function UIHomelandFishing:BtnDragPress()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  self._btnDrag.transform.localScale = Vector3(0.95, 0.95, 0.95)
  local deltaTime = UnityEngine.Time.deltaTime
  local fishValue = deltaTime * self._playerSpeed
  self._currentValue = self._currentValue + fishValue
  self._isPressedFishing = true
end

function UIHomelandFishing:BtnDragRelease()
  self._btnDrag.transform.localScale = Vector3(1.0, 1.0, 1.0)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ForceFinishGuideStep, GuideType.Button)
  self._isPressedFishing = false
end

function UIHomelandFishing:ForbiddenMove(forbidden)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterManager = homelandClient:CharacterManager()
  local mainCharacterController = characterManager:MainCharacterController()
  mainCharacterController:SetForbiddenMove(forbidden)
end

function UIHomelandFishing:IsDashing()
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  if not homelandClient then
    return true
  end
  local characterManager = homelandClient:CharacterManager()
  local mainCharacterController = characterManager:MainCharacterController()
  return mainCharacterController:State() == HomelandActorStateType.Dash
end

function UIHomelandFishing:SetIdleState()
  if self._status == FishgingStatus.None then
  elseif self._status == FishgingStatus.Fishing then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FishingCollect)
  elseif self._status == FishgingStatus.Bite then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FishingCancelFish)
    self._fishingManager:ExistFishing()
  end
end

function UIHomelandFishing:FishingSuccess()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FishingSuccess)
end

function UIHomelandFishing:FishingFailure(failureReason)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FishingFailure, failureReason)
end

function UIHomelandFishing:BtnExitOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FishingCancelFish)
  self._fishingManager:ExistFishing()
end

function UIHomelandFishing:BtnFishingOnClick()
end

function UIHomelandFishing:BtnDragOnClick()
end

function UIHomelandFishing:StopBtnOnClick()
  GameGlobal.TaskManager():CoreGameStartTask(self._CancelMatch, self)
end

function UIHomelandFishing:_CancelMatch(TT)
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local reply = homelandModule:HandleFishMatchCancel(TT, self._matchID)
  if reply:GetSucc() then
    self._btnFishing:SetActive(false)
    self._btnCollect:SetActive(false)
    CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeStoryController .. "DirectIn")
    YIELD(TT, 500)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FishMatchEnd, FishMatchEndType.MATCHEND_CLOSE, self._playerGoal, self._petGoal)
    YIELD(TT, 500)
    CutsceneManager.ExcuteCutsceneOut()
  else
    Log.fatal("取消钓鱼比赛异常")
  end
end

function UIHomelandFishing:PlayFishAndPersionPowerOutRangeAnim()
  if self._isPlayFishOrPersionPowerOutRangeAnim then
    return
  end
  self._circleHint:SetActive(true)
  self._anim:Stop()
  self._anim:Play("uieffanim_N17_UIFishing_hint_out")
  self._isPlayFishOrPersionPowerOutRangeAnim = true
end

function UIHomelandFishing:StopFishAndPersionPowerOutRangeAnim()
  self._circleHint:SetActive(false)
  self._isPlayFishOrPersionPowerOutRangeAnim = false
end

function UIHomelandFishing:OnFishThrowResult(result)
  if result then
    self:PlayPowerUIHideAnim(false)
  else
    self:PlayPowerUIHideAnim(true)
  end
end

function UIHomelandFishing:PlayPowerUIHideAnim(playAnim)
  if not playAnim then
    if not self._isPlayPowerHideAnim then
      self._throwPowerGo:SetActive(false)
    end
    return
  end
  if self._isPlayPowerHideAnim then
    return
  end
  self._isPlayPowerHideAnim = true
  self:PlayAnim("uieffanim_N17_UIFishing_Power_out", function()
    self._throwPowerGo:SetActive(false)
    self._isPlayPowerHideAnim = false
  end)
end

function UIHomelandFishing:PlayPowerUIShowAnim()
  self._throwPowerGo:SetActive(true)
  self._anim:Play("uieffanim_N17_UIFishing_Power_out")
  local state = self._anim:get_Item("uieffanim_N17_UIFishing_Power_out")
  if state then
    state.time = 0
    self._anim:Sample()
    state.enabled = false
  end
  self._anim:Stop()
end

function UIHomelandFishing:PlayStatusUIHideAnim(playAnim)
  if not self._isFighting then
    if not self._isPlayStatusHideAnim then
      self._fishingStatus:SetActive(false)
    end
    return
  end
  if self._isPlayStatusHideAnim then
    return
  end
  self._isPlayStatusHideAnim = true
  self:PlayAnim("uieffanim_N17_UIFishing_Status_out", function()
    self._fishingStatus:SetActive(false)
    self._isPlayStatusHideAnim = false
    self._isFighting = false
  end)
end

function UIHomelandFishing:PlayStatusUIShowAnim()
  self._isFighting = true
  self._fishingStatus:SetActive(true)
  self._anim:Play("uieffanim_N17_UIFishing_Status_out")
  local state = self._anim:get_Item("uieffanim_N17_UIFishing_Status_out")
  if state then
    state.time = 0
    self._anim:Sample()
    state.enabled = false
  end
  self._anim:Stop()
end

function UIHomelandFishing:PlayAnim(animationName, callback)
  self._animTask = GameGlobal.TaskManager():StartTask(self.PlayAnimCoro, self, animationName, callback)
end

function UIHomelandFishing:PlayAnimCoro(TT, animationName, callback)
  local lockUIName = "UIHomelandFishing_PlayAnimCoro" .. animationName
  self:Lock(lockUIName)
  table.insert(self._lockTable, lockUIName)
  local index = #self._lockTable
  self._anim:Stop()
  self._anim:Play(animationName)
  local time = 0
  local clip = self._anim:GetClip(animationName)
  if clip then
    time = clip.length
  end
  YIELD(TT, time * 1000)
  if callback then
    callback()
  end
  self._animTask = nil
  self:UnLock(lockUIName)
  table.remove(self._lockTable, index)
end

function UIHomelandFishing:_CheckGuide()
  if self._fishingManager:IsRiverFishing() then
    local cfg = Cfg.cfg_guide_const.guide_fishing
    if self._guideModule:GetLastCompleteGuide() ~= cfg.IntValue then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIHomelandFishing)
    end
  end
end

function UIHomelandFishing:FishMatchReady(matchID, matchManager)
  self._matchID = matchID
  self._matchManager = matchManager
  GameGlobal.TaskManager():CoreGameStartTask(self._FishMatchReady, self)
end

function UIHomelandFishing:_FishMatchReady(TT)
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local reply = homelandModule:HandleFishMatchBegin(TT, self._matchID)
  if reply:GetSucc() then
    self._matchObj:SetActive(true)
    self._go:SetActive(false)
    self._btnFishing:SetActive(false)
    self._fishLengthPanel:SetActive(false)
    self._throwPowerGo:SetActive(false)
    self._fishingStatus:SetActive(false)
    self._numPlayer.color = Color(0.3843137254901961, 0.3843137254901961, 0.3843137254901961)
    self._startTime = 3
    self._canvasGroup.alpha = 0
    self._countDown:SetText("" .. self._startTime)
    YIELD(TT, 500)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FishMatchHideDash)
    self._go:SetActive(true)
    self._cBG:SetActive(true)
    self._matchTime.color = Color(0.15294117647058825, 0.6784313725490196, 0.9725490196078431)
    self._req = ResourceManager:GetInstance():SyncLoadAsset("ui_fishmatch_countdown.mat", LoadType.Mat)
    if self._req and self._req.Obj then
      self.material = self._req.Obj
      local oldMaterial = self._countDown.fontMaterial
      self._countDown.fontMaterial = self.material
      self._countDown.fontMaterial:SetTexture("_MainTex", oldMaterial:GetTexture("_MainTex"))
    end
    self._matchAni:Play("uieffanim_N24_UIHomelandFishing_Match_cBg_alp_innew")
    local cfg = Cfg.cfg_homeland_fishmatch_main[self._matchID]
    self._matchTotalTime = Cfg.cfg_homeland_fishmatch_pet_ability[homelandModule.m_pet_ability_id].Time - 4
    self:SetShowTime(self._matchTotalTime)
    if cfg.MatchType == 1 then
      self._matchTitle:SetText(StringTable.Get("str_homeland_fishmatch_matchtitle1"))
    else
      self._matchTitle:SetText(StringTable.Get("str_homeland_fishmatch_matchtitle2"))
    end
    self._numPet:SetText(self._petGoal)
    self._numPlayer:SetText(self._playerGoal)
    YIELD(TT, 500)
    self._matchAni:Play("uieffanim_N24_UIHomelandFishing_Match_count_scale")
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameStart)
    self._readyTimerHandler = GameGlobal.Timer():AddEventTimes(1000, 4, function()
      self._startTime = self._startTime - 1
      if self._startTime > 0 then
        self._matchAni:Play("uieffanim_N24_UIHomelandFishing_Match_count_scale")
        self._countDown:SetText("" .. self._startTime)
      elseif self._startTime == 0 then
        self._countDown:SetText("GO!")
        AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1GameSkillLoop)
        self._matchAni:Play("uieffanim_N24_UIHomelandFishing_Match_count_GO_scale")
      elseif self._startTime < 0 then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.FishMatchStart, homelandModule.m_match_end_time, homelandModule.m_pet_ability_id)
      end
    end)
  else
    Log.fatal("请求钓鱼比赛失败", reply:GetResult())
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FishMatchEnd, FishMatchEndType.MATCHEND_CLOSE)
  end
end

function UIHomelandFishing:FishMatchStart()
  self._btnFishing:SetActive(true)
  self._cBG:SetActive(false)
  self._anim:Play("uieffanim_N24_UIHomelandFishing_parent_BtnFishing_alp")
  self._matchAni:Play("uieffanim_N24_UIHomelandFishing_Match_l_alp")
  self._startTimerHandler = GameGlobal.Timer():AddEventTimes(1000, self._matchTotalTime + 1, function()
    self._matchTotalTime = self._matchTotalTime - 1
    if self._matchTotalTime > 0 then
      self:SetShowTime(self._matchTotalTime)
      if self._matchTotalTime == 3 then
        self._matchTime.color = Color(0.9411764705882353, 0.6901960784313725, 0.1568627450980392)
      end
    elseif self._matchTotalTime == 0 then
      self._btnFishing:SetActive(false)
      self._btnCollect:SetActive(false)
      self._canFishSuccess = false
      self._matchAni:Play("uieffanim_N24_UIHomelandFishing_match_time_shanshuo")
      self._matchTime:SetText(StringTable.Get("str_homeland_fishmatch_timeout"))
    elseif self._matchTotalTime < 0 then
      GameGlobal.TaskManager():CoreGameStartTask(self._FishMatchEnd, self)
    end
  end)
end

function UIHomelandFishing:_FishMatchEnd(TT)
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local reply, result = homelandModule:HandleFishMatchEnd(TT, self._petGoal)
  if reply:GetSucc() then
    local replyEvent = reply:GetResult()
    Log.debug("======钓鱼比赛结果为：", result)
    local playerGoal = self._playerGoal
    local petGoal = self._petGoal
    local res = result == 0 and FishMatchEndType.MATCHEND_WIN or FishMatchEndType.MATCHEND_LOSE
    local cfg = Cfg.cfg_homeland_fishmatch_main[self._matchID]
    res = cfg.MatchType == 1 and res or FishMatchEndType.MATCHEND_COMPLETE
    CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeStoryController .. "DirectIn")
    YIELD(TT, 500)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FishMatchEnd, res, playerGoal, petGoal)
    YIELD(TT, 500)
    CutsceneManager.ExcuteCutsceneOut()
  else
    Log.fatal("钓鱼比赛结束异常：", reply:GetResult())
  end
end

function UIHomelandFishing:FishMatchEnd(res, playerGoal, petGoal)
  if self._readyTimerHandler then
    GameGlobal.Timer():CancelEvent(self._readyTimerHandler)
    self._readyTimerHandler = nil
  end
  if self._startTimerHandler then
    GameGlobal.Timer():CancelEvent(self._startTimerHandler)
    self._startTimerHandler = nil
  end
  self._matchObj:SetActive(false)
  self:SwitchState(UIStateType.UIHomelandFishMatchEnd, res, playerGoal, petGoal)
  self._fishPlayType = EnumFishGameType.NORMAL
  self._playerGoal = 0
  self._petGoal = 0
  self._matchID = nil
  self:SetIdleState()
end

function UIHomelandFishing:PlayerFishGet()
  if not self._canFishSuccess then
    return
  end
  self._playerGoal = self._playerGoal + 1
  self._numPlayer:SetText(self._playerGoal)
  if self._playerGoal > self._petGoal then
    self._numPlayer.color = Color(0.9490196078431372, 0.5137254901960784, 0.023529411764705882)
  elseif self._playerGoal == self._petGoal then
    self._numPlayer.color = Color(0.3843137254901961, 0.3843137254901961, 0.3843137254901961)
  else
    self._numPlayer.color = Color(0.17647058823529413, 0.5137254901960784, 0.8352941176470589)
  end
end

function UIHomelandFishing:PetFishGet()
  if not self._canFishSuccess then
    return
  end
  self._petGoal = self._petGoal + 1
  self._numPet:SetText(self._petGoal)
  if self._playerGoal > self._petGoal then
    self._numPlayer.color = Color(0.9490196078431372, 0.5137254901960784, 0.023529411764705882)
  elseif self._playerGoal == self._petGoal then
    self._numPlayer.color = Color(0.3843137254901961, 0.3843137254901961, 0.3843137254901961)
  else
    self._numPlayer.color = Color(0.17647058823529413, 0.5137254901960784, 0.8352941176470589)
  end
end

function UIHomelandFishing:SetShowTime(time)
  local m = math.floor(time / 60)
  local s = time % 60
  if m < 10 then
    m = "0" .. m
  end
  if s < 10 then
    s = "0" .. s
  end
  local timeTxt = m .. ":" .. s
  self._matchTime:SetText(timeTxt)
end
