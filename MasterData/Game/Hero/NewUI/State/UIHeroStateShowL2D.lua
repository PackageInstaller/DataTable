local base = UIBaseNode
local UIHeroStateShowL2D = class("UIHeroStateShowL2D", base)
local UINCommonSwitchToggle = require("Game.CommonUI.CommonSwitchToggle.UINCommonSwitchToggle")
local cs_tweening = CS.DG.Tweening
local cs_DOTween = cs_tweening.DOTween
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local heroDragScaleLimit = {max = 1.7, min = 0.7}

function UIHeroStateShowL2D:OnInit()
  self._loginAnimTime = 0
  self.isDragMode = false
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_ShowMain, self, self.OnClickExitShowSkinL2D)
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self.OnClickSkipLive2dAnim)
  UIUtil.AddButtonListener(self.ui.btn_BlockMask, self, self.OnClickShowSkinL2DMask)
  self.__OnGesture = BindCallback(self, self.OnGesture)
  self.__OnSwitchDragMode = BindCallback(self, self.SwitchDragMode)
  self._switchDragModeTog = UINCommonSwitchToggle.New()
  self._switchDragModeTog:Init(self.ui.tog_Switch)
end

function UIHeroStateShowL2D:InitUIHeroStateShowL2D(heroCubismInteration, cubismInterationController, exitCallback)
  self.heroCubismInteration = heroCubismInteration
  self.heroCubismInteration.__PlayCvCallback = BindCallback(self, self.__PlayCv)
  self.cs_CubismInterationController = cubismInterationController
  self.l2dBinding = {}
  UIUtil.LuaUIBindingTable(self.cs_CubismInterationController.gameObject, self.l2dBinding)
  self.exitCallback = exitCallback
  self.isDragMode = false
  self._switchDragModeTog:InitCommonSwitchToggle(false, self.__OnSwitchDragMode)
end

function UIHeroStateShowL2D:OnSwitchHero()
  if self._loginAnimTimerId ~= nil then
    TimerManager:StopTimer(self._loginAnimTimerId)
    self._loginAnimTimerId = nil
  end
  if self.__animTimerId ~= nil then
    TimerManager:StopTimer(self.__animTimerId)
    self.__animTimerId = nil
  end
  self:ShowHeroVoiceText(false)
  AudioManager:StopSource(eAudioSourceType.Live2DSource)
  if self._lastHomeVoicePlayback ~= nil then
    AudioManager:StopAudioByBack(self._lastHomeVoicePlayback)
    self._lastHomeVoicePlayback = nil
  end
  self.isDragMode = false
  self._switchDragModeTog:SetCommonSwitchToggleValue(false, true)
end

function UIHeroStateShowL2D:__PlayCv(cvId, timeLength, OpenMouseListen)
  local heroId = self.heroCubismInteration:GetCubismHeroId()
  local skinId = self.heroCubismInteration:GetCubismSkinId()
  local voiceId = cvId
  local animLength = timeLength
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  if self._lastHomeVoicePlayback ~= nil then
    AudioManager:StopAudioByBack(self._lastHomeVoicePlayback)
    self._lastHomeVoicePlayback = nil
  end
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  OpenMouseListen = OpenMouseListen and skinCtrl:CheckMouseOpen(heroId, skinId)
  if animLength ~= nil then
    self.__aniPlayEnd = false
    TimerManager:StopTimer(self.__animTimerId)
    self.__animTimerId = TimerManager:StartTimer(animLength, function()
      self.__aniPlayEnd = true
      self:TryResetShowHeroVoice()
    end)
  end
  self._lastHomeVoicePlayback = cvCtr:PlayCv(heroId, voiceId, function()
    self._lastHomeVoicePlayback = nil
    self:TryResetShowHeroVoice()
  end, OpenMouseListen, skinId)
  local audioLength = cvCtr:GetVoiceLength(heroId, voiceId, skinId)
  local voiceTextDuration = audioLength / 1000
  local text = cvCtr:GetCvText(heroId, voiceId, skinId)
  self:ShowHeroVoiceText(true, text, false, voiceTextDuration)
end

function UIHeroStateShowL2D:TryResetShowHeroVoice()
  if self._lastHomeVoicePlayback == nil and self.__aniPlayEnd then
    self:ShowHeroVoiceText(false)
  end
end

function UIHeroStateShowL2D:OnClickShowSkinL2DMask()
  if not self.hasSkip then
    if self._loginAnimTime > 0 then
      self.ui.btn_Skip.gameObject:SetActive(true)
    else
      self.hasSkip = true
      self.ui.btn_BlockMask.gameObject:SetActive(false)
    end
  end
end

function UIHeroStateShowL2D:OnClickExitShowSkinL2D()
  self:PlayShowSkinL2DTween(false)
  self.ui.obj_ShowSkinLive2d:SetActive(false)
  self.cs_CubismInterationController.OpenGuiJudge = true
  self.heroCubismInteration:SetInterationOpenRayCast(false)
  self.cs_CubismInterationController:RestartBodyAnimation()
  UIUtil.ReShowTopStatus()
  if self.exitCallback ~= nil then
    self.exitCallback()
  end
  if self._loginAnimTimerId ~= nil then
    TimerManager:StopTimer(self._loginAnimTimerId)
    self._loginAnimTimerId = nil
  end
  if self.__animTimerId ~= nil then
    TimerManager:StopTimer(self.__animTimerId)
    self.__animTimerId = nil
  end
end

function UIHeroStateShowL2D:OnClickSkipLive2dAnim()
  if self.hasSkip then
    return
  end
  self.hasSkip = true
  self:ShowHeroVoiceText(false)
  self.ui.btn_Skip.gameObject:SetActive(false)
  local sequence = cs_DOTween.Sequence()
  sequence:Append(self.ui.img_BlockMask:DOColor(Color.black, 0.25))
  sequence:AppendCallback(function()
    self.cs_CubismInterationController:RestartBodyAnimation()
    self.cs_CubismInterationController.IsCVOver = true
    AudioManager:StopSource(eAudioSourceType.Live2DSource)
  end)
  sequence:Append(self.ui.img_BlockMask:DOColor(Color.clear, 0.25))
  sequence:AppendCallback(function()
    self.ui.btn_BlockMask.gameObject:SetActive(false)
  end)
  sequence:SetLink(self.gameObject)
  sequence:Play()
end

function UIHeroStateShowL2D:EnterShowMode(loginType)
  self.ui.obj_ShowSkinLive2d:SetActive(true)
  self:SwitchDragMode(false)
  self._switchDragModeTog:SetCommonSwitchToggleValue(false, false)
  AudioManager:PlayAudioById(1061)
  UIUtil.HideTopStatus()
  self.ui.btn_Skip.gameObject:SetActive(false)
  self.ui.btn_BlockMask.gameObject:SetActive(true)
  self._loginAnimTime = self.heroCubismInteration:PlayLoginAnimation(loginType)
  if self._loginAnimTimerId ~= nil then
    TimerManager:StopTimer(self._loginAnimTimerId)
    self._loginAnimTimerId = nil
  end
  if self._loginAnimTime ~= nil and self._loginAnimTime > 0 then
    self._loginAnimTimerId = TimerManager:StartTimer(self._loginAnimTime, function()
      if not IsNull(self.ui.btn_Skip) then
        self.ui.btn_Skip.gameObject:SetActive(false)
        self._loginAnimTime = 0
      end
    end)
  end
  self:PlayShowSkinL2DTween(true)
end

function UIHeroStateShowL2D:PlayShowSkinL2DTween(isforward)
  if isforward then
    self.hasSkip = false
  end
  if self.__showSkinL2DTweener ~= nil and self.__showSkinL2DTweener:IsActive() then
    self.__showSkinL2DTweener:Complete(false)
    self.__showSkinL2DTweener:Kill()
    self.__showSkinL2DTweener = nil
  end
  if not isforward then
    self.ui.obj_Center.gameObject:SetActive(true)
    self.ui.obj_Buttom.gameObject:SetActive(true)
  end
  local originSizeDelta = self.ui.obj_Center.sizeDelta
  local originPosition = self.ui.obj_Buttom.localPosition
  if isforward then
    self.ui.canvasgroup:DOFade(0, 1):From(false):SetEase(cs_tweening.Ease.OutQuint):SetLink(self.ui.canvasgroup.gameObject)
    self.ui.heroHolder.transform:DOLocalMove(Vector3.New(0, -100, -100), 1):SetEase(cs_tweening.Ease.OutQuint):SetLink(self.ui.heroHolder.gameObject)
  else
    self.ui.canvasgroup:DOFade(0, 0):From(true):SetEase(cs_tweening.Ease.OutQuint):SetLink(self.ui.canvasgroup.gameObject)
    self.ui.heroHolder.transform:DOLocalMove(Vector3.New(0, 0, 0), 1):SetEase(cs_tweening.Ease.OutQuint):SetLink(self.ui.heroHolder.gameObject)
  end
  self.__showSkinL2DTweener = cs_DOTween.To(function()
    return 0
  end, function(x)
    self.ui.obj_Center.sizeDelta = isforward and originSizeDelta * Vector3.Temp(Mathf.Lerp(1, 3, x), 1, 1) or originSizeDelta * Vector3.Temp(Mathf.Lerp(1, 0.3333333333333333, x), 1, 1)
    self.ui.obj_Buttom.localPosition = isforward and originPosition + Vector3.Temp(0, -300 * x, 0) or originPosition + Vector3.Temp(0, 300 * x, 0)
  end, 1, 1):SetEase(CS.DG.Tweening.Ease.OutCubic):SetLink(self.ui.obj_Center.transform.parent.gameObject):OnComplete(function()
    if isforward then
      self.ui.obj_Center.gameObject:SetActive(false)
      self.ui.obj_Buttom.gameObject:SetActive(false)
    end
  end)
end

function UIHeroStateShowL2D:ShowHeroVoiceText(show, text, notShowWave, voiceDuration)
  if show then
    self.ui.text_Dialog.text = text
  end
  self.ui.obj_DialogNode:SetActive(show)
end

function UIHeroStateShowL2D:SwitchDragMode(isOn)
  self.isDragMode = isOn
  local value = self.isDragMode and "+" or "-"
  CS_LeanTouch.OnGesture("-", self.__OnGesture)
  CS_LeanTouch.OnGesture(value, self.__OnGesture)
  self.cs_CubismInterationController.OpenGuiJudge = self.isDragMode
  self.heroCubismInteration:SetInterationOpenRayCast(not self.isDragMode)
end

function UIHeroStateShowL2D:OnGesture(fingerList)
  if fingerList.Count == 0 then
    return
  end
  local result = CS_LeanTouch.RaycastGui(fingerList[0].ScreenPosition)
  if result.Count == 0 or not result[0].gameObject.transform:IsChildOf(self.transform) then
    return
  end
  if self._heroNodeTween ~= nil then
    return
  end
  if fingerList.Count == 1 then
    local touch = fingerList[0]
    local lastPos = UIManager:Screen2UIPosition(touch.LastScreenPosition, self.transform.gameObject:GetComponent(typeof(CS.UnityEngine.RectTransform)), UIManager.UICamera)
    local curPos = UIManager:Screen2UIPosition(touch.ScreenPosition, self.transform.gameObject:GetComponent(typeof(CS.UnityEngine.RectTransform)), UIManager.UICamera)
    local diffPos = curPos - lastPos
    diffPos = Vector3.New(diffPos.x, diffPos.y, 0)
    if self._heroDragPosLimit == nil then
      self:CalcaluteDragLimit()
    end
    local targetPos = self.ui.heroHolder.transform.localPosition + diffPos
    self:LimitDragPos(targetPos)
    self.ui.heroHolder.transform.localPosition = targetPos
    self.ui.heroHolder.transform.localPosition = targetPos
  elseif fingerList.Count == 2 then
    local touch1 = fingerList[0]
    local touch2 = fingerList[1]
    local lastDiffX = touch1.LastScreenPosition.x - touch2.LastScreenPosition.x
    local lastDiffY = touch1.LastScreenPosition.y - touch2.LastScreenPosition.y
    local curDiffX = touch1.ScreenPosition.x - touch2.ScreenPosition.x
    local curDiffY = touch1.ScreenPosition.y - touch2.ScreenPosition.y
    local diff = Mathf.Sqrt(Mathf.Pow(curDiffX, 2) + Mathf.Pow(curDiffY, 2)) - Mathf.Sqrt(Mathf.Pow(lastDiffX, 2) + Mathf.Pow(lastDiffY, 2))
    local scale = self.ui.heroHolder.transform.localScale.x + diff / 500 * (heroDragScaleLimit.max - heroDragScaleLimit.min)
    scale = math.clamp(scale, heroDragScaleLimit.min, heroDragScaleLimit.max)
    self.ui.heroHolder.transform.localScale = Vector3.New(scale, scale, scale)
    self.ui.heroHolder.transform.localScale = Vector3.New(scale, scale, scale)
    self:CalcaluteDragLimit(true)
    local targetPos = self.ui.heroHolder.transform.localPosition
    self:LimitDragPos(targetPos)
    self.ui.heroHolder.transform.localPosition = targetPos
    self.ui.heroHolder.transform.localPosition = targetPos
  end
end

function UIHeroStateShowL2D:CalcaluteDragLimit(isInDrag)
  if not IsNull(self.bigImgGameObject) then
    if isInDrag and self._viewScaleRecord == self.ui.heroHolder.transform.localScale.y then
      return
    end
    self._viewScaleRecord = self.ui.heroHolder.transform.localScale.y
    if not isInDrag or self._bigImgGameObjectHeight == nil then
      local rectTr = self.bigImgGameObject.transform
      self._bigImgGameObjectHeight = rectTr.rect.height * rectTr.localScale.y
      self._bigImgGameObjectWidth = rectTr.rect.width * rectTr.localScale.x
    end
    local limitYMin = (-self._bigImgGameObjectHeight / 2 - self.bigImgGameObject.transform.localPosition.y) * self._viewScaleRecord
    local limitYMax = (self._bigImgGameObjectHeight / 2 - self.bigImgGameObject.transform.localPosition.y) * self._viewScaleRecord
    local limitXMax = (self._bigImgGameObjectWidth / 2 - self.bigImgGameObject.transform.localPosition.x) * self._viewScaleRecord
    local limitXMin = (-self._bigImgGameObjectWidth / 2 - self.bigImgGameObject.transform.localPosition.x) * self._viewScaleRecord
    if self._heroDragPosLimit == nil then
      self._heroDragPosLimit = {}
    end
    self._heroDragPosLimit.xMin = limitXMin
    self._heroDragPosLimit.xMax = limitXMax
    self._heroDragPosLimit.yMax = limitYMax
    self._heroDragPosLimit.yMin = limitYMin
  elseif not IsNull(self.l2dBinding) then
    if isInDrag and self._viewScaleRecord == self.ui.heroHolder.transform.localScale.y then
      return
    end
    self._viewScaleRecord = self.ui.heroHolder.transform.localScale.y
    if not isInDrag or self._l2dModelHeight == nil then
      local leftUp, rightBottom = GetL2dBorderVec(self.cs_CubismInterationController)
      local inverseleftUp = self.cs_CubismInterationController.transform:TransformPoint(leftUp)
      inverseleftUp = self.ui.heroHolder.transform:InverseTransformPoint(inverseleftUp)
      local inverserightBottom = self.cs_CubismInterationController.transform:TransformPoint(rightBottom)
      inverserightBottom = self.ui.heroHolder.transform.parent:InverseTransformPoint(inverserightBottom)
      self._l2dModelHeight = inverseleftUp.y - inverserightBottom.y
      self._l2dModelWidth = inverserightBottom.x - inverseleftUp.x
      self._l2dCenterRatio = Vector2.New(-leftUp.x / (rightBottom.x - leftUp.x), leftUp.y / (leftUp.y - rightBottom.y))
    end
    local limitYMin = (-self._l2dModelHeight * self._l2dCenterRatio.y - self.cs_CubismInterationController.transform.localPosition.y) * self._viewScaleRecord
    local limitYMax = (self._l2dModelHeight * (1 - self._l2dCenterRatio.y) - self.cs_CubismInterationController.transform.localPosition.y) * self._viewScaleRecord
    local limitXMax = (self._l2dModelWidth * self._l2dCenterRatio.x - self.cs_CubismInterationController.transform.localPosition.x) * self._viewScaleRecord
    local limitXMin = (-self._l2dModelWidth * (1 - self._l2dCenterRatio.x) - self.cs_CubismInterationController.transform.localPosition.x) * self._viewScaleRecord
    if self._heroDragPosLimit == nil then
      self._heroDragPosLimit = {}
    end
    self._heroDragPosLimit.xMin = limitXMin
    self._heroDragPosLimit.xMax = limitXMax
    self._heroDragPosLimit.yMax = limitYMax
    self._heroDragPosLimit.yMin = limitYMin
  end
end

function UIHeroStateShowL2D:LimitDragPos(targetPos)
  targetPos.x = math.clamp(targetPos.x, self._heroDragPosLimit.xMin, self._heroDragPosLimit.xMax)
  targetPos.y = math.clamp(targetPos.y, self._heroDragPosLimit.yMin, self._heroDragPosLimit.yMax)
end

function UIHeroStateShowL2D:OnDelete()
  if self.__showSkinL2DTweener ~= nil then
    self.__showSkinL2DTweener:Kill()
    self.__showSkinL2DTweener = nil
  end
  CS_LeanTouch.OnGesture("-", self.__OnGesture)
  if self._loginAnimTimerId ~= nil then
    TimerManager:StopTimer(self._loginAnimTimerId)
    self._loginAnimTimerId = nil
  end
  if self.__animTimerId ~= nil then
    TimerManager:StopTimer(self.__animTimerId)
    self.__animTimerId = nil
  end
  if self._switchDragModeTog ~= nil then
    self._switchDragModeTog:Delete()
    self._switchDragModeTog = nil
  end
end

return UIHeroStateShowL2D
