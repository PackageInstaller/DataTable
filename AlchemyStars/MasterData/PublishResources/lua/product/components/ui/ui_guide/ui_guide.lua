_class("UIGuide", UICustomWidget)
UIGuide = UIGuide

function UIGuide:Constructor()
  self.rotation1 = Quaternion.Euler(0, 0, 0)
  self.rotation2 = Quaternion.Euler(0, 180, 0)
  self.position = Vector3.one
  self.fingerPosition = Vector3.zero
  self.info = nil
  self._guideModule = GameGlobal.GetModule(GuideModule)
  self._homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  self.describeStyle = -1
end

function UIGuide:OnShow()
  self.isShow = true
  self.selfTransform = self:GetGameObject().transform
  self.selectRect = self:GetUIComponent("RectTransform", "bg")
  self.selectTrans = self:GetUIComponent("Transform", "bg")
  self.animKuangTrans = self:GetUIComponent("Transform", "UIWeakKuang")
  self:SetForward()
  self.back = self:GetGameObject("Back")
  self.backs = {}
  self.backCGs = {}
  self.backGos = {}
  for i = 1, 4 do
    local name = "Back" .. i
    local back = self:GetUIComponent("RectTransform", name)
    local backCG = self:GetUIComponent("CanvasGroup", name)
    local backGo = self:GetGameObject("ebtn_empty" .. i)
    self.backs[i] = back
    self.backCGs[i] = backCG
    self.backGos[i] = backGo
    self:AddDragEvent(backGo)
  end
  self:AttachEvent(GameEventType.GuidePosChanged, self.OnGuidePosChanged)
  self.finger = self:GetGameObject("finger")
  self.fingerAni = self:GetUIComponent("Animation", "finger")
  self.fingerTrans = self:GetUIComponent("Transform", "finger")
  self.atlas = self:GetAsset("UIGuide.spriteatlas", LoadType.SpriteAtlas)
  self.effectHolderTrans = self:GetUIComponent("Transform", "effectholder")
  self.spotlightImage = self:GetUIComponent("Transform", "spot")
  self.spotlightrect = self:GetUIComponent("RectTransform", "spot")
  self.spotlightGO = self:GetGameObject("spot")
  self.spotlightGO:SetActive(false)
  self.fillTriggerGO = self:GetGameObject("filltrigger")
  self.btnSelfGO = self:GetGameObject("btnself")
  self.p_black = self:GetGameObject("p_black")
  self.p_black_mask = self:GetUIComponent("RectTransform", "p_black_mask")
  self.p_black_masked = self:GetUIComponent("Image", "p_black_masked")
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CancelChainPath)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HideChainPathCancelArea)
end

function UIGuide:OnGuidePosChanged(guideStep)
  if self.info and self.info.guideStep ~= guideStep then
    return
  end
  self:UpdateGuide()
end

function UIGuide:OnHide()
  self.isShow = false
  self:RemoveClick()
  self:RemoveTick()
end

function UIGuide:Back1OnClick()
  self:OnClickBack()
end

function UIGuide:Back2OnClick()
  self:OnClickBack()
end

function UIGuide:Back3OnClick()
  self:OnClickBack()
end

function UIGuide:Back4OnClick()
  self:OnClickBack()
end

function UIGuide:OnClickBack()
  if not self.info then
    return
  end
  if self.info.btnGuideCfg.completeRule == GuideCompleteType.AnyClickOnlyTrigger then
    local step = self.info.guideStep
    self:BingoDone(step)
  elseif self.lockScreen then
    self:AddTick()
  end
end

function UIGuide:Init(info, callBack)
  self._guideModule = GameGlobal.GetModule(GuideModule)
  self._homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  self.isHomeland = false
  self.info = info
  self:SetForward()
  self.once = false
  GuideHelper.GuideLoadLock(false, "Button")
  if not self.info then
    return
  end
  if not info.owner:View() then
    local root = self:RootUIOwner()
    if root then
      root:CloseGuid()
    end
    return
  end
  self.lockScreen = self.info.cfg.lockScreen
  self:LockHomeLandInput(self.lockScreen)
  self:SetCharacterSay()
  self:SetMaskShow()
  self:ShowFinger()
  self:ShowCompleteType()
  self:UpdateGuide()
  self:AddTick()
  self:PlayEffect(self.info.btnGuideCfg)
end

function UIGuide:ShowCompleteType()
  if self.info.btnGuideCfg.completeRule == GuideCompleteType.AnyClickOnlyTrigger then
    self.fillTriggerGO:SetActive(true)
    self.btnSelfGO:SetActive(false)
  elseif self.info.btnGuideCfg.completeRule == GuideCompleteType.SelfClick then
    self.fillTriggerGO:SetActive(false)
    self.btnSelfGO:SetActive(true)
  elseif self.info.btnGuideCfg.completeRule == GuideCompleteType.CompleteImmediately then
    self.fillTriggerGO:SetActive(false)
    self.btnSelfGO:SetActive(false)
  else
    self.fillTriggerGO:SetActive(false)
    self.btnSelfGO:SetActive(false)
    self:AddGuideClick()
  end
end

function UIGuide:ShowFinger()
  if not self.once then
    self.finger:SetActive(self.info.btnGuideCfg.showFinger)
    if self.info.btnGuideCfg.showFinger then
      self.fingerAni:Play("uieff_click")
    end
    self.once = true
  end
end

function UIGuide:UpdateGuide()
  if not self.isShow then
    return
  end
  local info = self.info
  if info.pos then
    self.selfTransform.position = info.pos
    local anchor = self.selfTransform.anchoredPosition
    self.selfTransform.anchoredPosition = Vector2.zero
    info.x = info.sx + anchor.x
    info.y = info.sy + anchor.y
  else
    info.x = info.sx - info.w / 2
    info.y = info.sy - info.h / 2
  end
  if info.btnGuideCfg and info.btnGuideCfg.ForceOffset and #info.btnGuideCfg.ForceOffset > 1 then
    info.x = info.x + info.btnGuideCfg.ForceOffset[1]
    info.y = info.y + info.btnGuideCfg.ForceOffset[2]
  end
  self.animKuangTrans.localScale = info.scale
  self.selectRect.anchoredPosition = Vector2(info.x, info.y)
  self.selectRect.sizeDelta = Vector2(info.w, info.h)
  self.p_black_mask.anchoredPosition = Vector2(info.x, info.y)
  self.p_black_mask.sizeDelta = Vector2(info.w, info.h)
  local color = Color(0, 0, 0, 0)
  if info.btnGuideCfg and info.btnGuideCfg.isBlackScreen then
    color.a = 0.4
  end
  self.p_black_masked.color = color
  self:SetCharacterSayPos()
  if self.lockScreen then
    self:SetMaskPos()
  end
end

function UIGuide:SetCharacterSay()
  local cfg = self.info.btnGuideCfg
  if self.isHomeland then
    self.characterImage:LoadImage(cfg.icon)
  else
    self.characterImage.sprite = self.atlas:GetSprite(cfg.icon)
  end
  if cfg.describe then
    self.forward.text:SetText(HelperProxy:GetInstance():ReplacePlayerName(StringTable.Get(cfg.describe)))
    local settings = self.forward.text:GetGenerationSettings(self.forward.text.rectTransform.rect.size)
    local tg = self.forward.text.cachedTextGenerator
    tg:Invalidate()
    tg:Populate(self.forward.text.text, settings)
    UnityEngine.Canvas.ForceUpdateCanvases()
    if tg.lines.Count > 4 then
      self.forward.bgRect.sizeDelta = Vector2(self.forward.bgOldWidth, self.forward.bgOldHeight + (tg.lines.Count - 4) * self.forward.text.fontSize)
    else
      self.forward.bgRect.sizeDelta = Vector2(self.forward.bgOldWidth, self.forward.bgOldHeight)
    end
    if not self.info.btnGuideCfg.position or self.info.btnGuideCfg.position == 1 then
      self.forward.gameObject.transform.localScale = Vector3(1, 1, 1)
      self.forward.textTrans.localScale = Vector3(1, 1, 1)
    else
      self.forward.gameObject.transform.localScale = Vector3(-1, 1, 1)
      self.forward.textTrans.localScale = Vector3(-1, 1, 1)
    end
    self.forward.gameObject:SetActive(true)
  else
    self.forward.gameObject:SetActive(false)
  end
end

function UIGuide:SetCharacterSayPos()
  local forward = self.forward
  local w, h = self.info.w, self.info.h
  local x, y = self.info.x, self.info.y
  local cfg = self.info.btnGuideCfg
  local anchorX, anchorY
  local offset = cfg.offset or {0, 0}
  anchorX = x + offset[1]
  anchorY = y + offset[2]
  forward.rect.anchoredPosition = Vector2(anchorX, anchorY)
end

function UIGuide:SetMaskShow()
  if not self.lockScreen then
    self.back:SetActive(false)
    self.p_black:SetActive(false)
  else
    self.back:SetActive(true)
    self.p_black:SetActive(true)
  end
end

function UIGuide:SetMaskPos()
  local w, h = self.info.w, self.info.h
  local x, y = self.info.x, self.info.y
  local screenWidth = ResolutionManager.RealWidth()
  local screenHeight = ResolutionManager.RealHeight()
  local width = ResolutionManager.ScreenWidth()
  local height = ResolutionManager.ScreenHeight()
  local wc, hc = screenWidth / width, screenHeight / height
  if wc ~= hc then
    if wc < hc then
      screenHeight = height * wc
    else
      screenWidth = width * hc
    end
  end
  local rects = {
    {
      x = 0,
      y = 0,
      width = x,
      height = screenHeight
    },
    {
      x = x,
      y = y + h,
      width = screenWidth - x,
      height = screenHeight - y - h
    },
    {
      x = x + w,
      y = 0,
      width = screenWidth - x - w,
      height = y + h
    },
    {
      x = x,
      y = 0,
      width = w,
      height = y
    }
  }
  for i = 1, 4 do
    local back = self.backs[i]
    local data = rects[i]
    self.backCGs[i].alpha = self.info.btnGuideCfg.isBlackScreen and 0.4 or 0
    back.sizeDelta = Vector2(data.width, data.height)
    back.anchoredPosition = Vector2(data.x, data.y)
  end
end

function UIGuide:AddGuideClick()
  local btn = self.info.btn
  local name = btn.name
  self[name .. "OnClick"] = function()
    local step = self.info.guideStep
    if step:IsClickDone() then
      if self.info.scrollRect then
        self.info.scrollRect.enabled = true
      end
      self:BingoDone(step)
    end
  end
  self.info.owner:View():AddGuideClick(btn, self)
  if self.info.scrollRect then
    self.info.scrollRect.enabled = false
  end
end

function UIGuide:BingoDone(step)
  local root = self:RootUIOwner()
  if root then
    root:CloseGuid()
  end
  step:Done()
  if self.lockScreen and self.info.scrollRect then
    self.info.scrollRect.enabled = true
  end
end

function UIGuide:RemoveClick()
  self._homelandCameraMgr = nil
  self._seasonCamera = nil
  self:LockHomeLandInput(false)
  self:PlayEffect(nil)
  if self.info and self.info.btnGuideCfg then
    local cfg = self.info.btnGuideCfg
    if cfg.completeRule == GuideCompleteType.AnyClickOnlyTrigger or cfg.completeRule == GuideCompleteType.SelfClick or cfg.completeRule == GuideCompleteType.CompleteImmediately then
      return
    end
  end
  local UI = GameGlobal.UIStateManager()
  if not self.info then
    Log.error("why no self.info????")
    return
  end
  if UI and not UI:IsShow(self.info.btnGuideCfg.guideController) then
    return
  end
  self.info.owner:View():RemoveGuideClick(self.info.btn)
end

local spotlightDuration = 500
local startRadius = 3
local endRadius = 1

function UIGuide:AddTick()
  self.spotLerp = GuideLerp:New(startRadius, endRadius, spotlightDuration, "slowDown")
  self.spotlightGO:SetActive(true)
  if not self.timerEvent then
    self.timerEvent = GameGlobal.Timer():AddEventTimes(0, TimerTriggerCount.Infinite, function()
      self:Tick()
    end)
  end
end

function UIGuide:RemoveTick()
  if self.timerEvent ~= nil then
    GameGlobal.Timer():CancelEvent(self.timerEvent)
    self.timerEvent = nil
  end
  self.spotlightGO:SetActive(false)
end

function UIGuide:Tick()
  if self.spotLerp then
    local value, isOver = self.spotLerp:Lerp()
    self.spotlightImage.transform.localScale = Vector3(value, value, 1)
    if isOver then
      self:RemoveTick()
    end
  end
end

function UIGuide:btnselfOnClick()
  if self.info.btnGuideCfg.completeRule == GuideCompleteType.SelfClick then
    local step = self.info.guideStep
    self:BingoDone(step)
  end
end

function UIGuide:filltriggerOnClick()
  if self.info.btnGuideCfg.completeRule == GuideCompleteType.AnyClickOnlyTrigger then
    local step = self.info.guideStep
    self:BingoDone(step)
  end
end

function UIGuide:SetForward()
  local oldStyle = self.describeStyle
  if self.info and self.info.btnGuideCfg then
    local cfg = self.info.btnGuideCfg
    self.describeStyle = cfg.describeStyle or 0
  end
  local isHomeland = self._homeLandModule:IsRunning()
  if self.isHomeland ~= isHomeland or oldStyle == self.describeStyle then
  end
  self.isHomeland = isHomeland
  self.forward = {}
  self.forward.gameObject = self:GetGameObject("g_kuang")
  self.forward.rect = self.forward.gameObject:GetComponent("RectTransform")
  self.p_bg = self.forward.gameObject.transform:Find("p_bg")
  self.p_bg_hl = self.forward.gameObject.transform:Find("p_bg_hl")
  self.p_bg_style1 = self.forward.gameObject.transform:Find("p_bg_style1")
  local oldSizeKey = ""
  if self.describeStyle > 0 then
    self.p_bg.gameObject:SetActive(false)
    self.p_bg_hl.gameObject:SetActive(false)
    self.p_bg_style1.gameObject:SetActive(self.describeStyle == 1)
    if self.describeStyle == 1 then
      self.forward.bgTrans = self.p_bg_style1
      oldSizeKey = "p_bg_style1"
    end
  else
    self.p_bg.gameObject:SetActive(not self.isHomeland)
    self.p_bg_hl.gameObject:SetActive(self.isHomeland)
    self.p_bg_style1.gameObject:SetActive(false)
    if self.isHomeland then
      self.forward.bgTrans = self.p_bg_hl
      oldSizeKey = "p_bg_h1"
    else
      self.forward.bgTrans = self.p_bg
      oldSizeKey = "p_bg"
    end
  end
  self.forward.bgRect = self.forward.bgTrans:GetComponent("RectTransform")
  if not self._oldSize then
    self._oldSize = {}
  end
  local sizeValue = self._oldSize[oldSizeKey]
  if not sizeValue then
    sizeValue = {}
    sizeValue.w = self.forward.bgRect.sizeDelta.x
    sizeValue.h = self.forward.bgRect.sizeDelta.y
    self._oldSize[oldSizeKey] = sizeValue
  end
  self.forward.bgOldWidth = sizeValue.w
  self.forward.bgOldHeight = sizeValue.h
  if self.describeStyle > 0 then
    self.forward.textTrans = self.forward.bgTrans.transform:Find("et_text")
  elseif self.isHomeland then
    self.forward.textTrans = self.forward.bgTrans.transform:Find("et_text_hl")
  else
    self.forward.textTrans = self.forward.bgTrans.transform:Find("et_text")
  end
  self.forward.textRect = self.forward.textTrans:GetComponent("RectTransform")
  self.forward.text = self.forward.textTrans:GetComponent("UILocalizationText")
  if self.describeStyle > 0 then
    self.character = self:GetGameObject("charactor")
    self.characterImage = self.character:GetComponent("Image")
    self.characterRect = self.character:GetComponent("RectTransform")
  elseif self.isHomeland then
    self.character = self:GetGameObject("ep_charactor_hl")
    self.characterImage = self.character:GetComponent("RawImageLoader")
    self.characterRect = self.character:GetComponent("RectTransform")
  else
    self.character = self:GetGameObject("charactor")
    self.characterImage = self.character:GetComponent("Image")
    self.characterRect = self.character:GetComponent("RectTransform")
  end
end

function UIGuide:AddDragEvent(go)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(go), UIEvent.Drag, function(pointerEventData)
    self:OnDrag(pointerEventData)
  end)
end

function UIGuide:OnDrag(pointerEventData)
  local homelandGuide = self._guideModule:IsGuideProcessKey("guide_homeland_base")
  local seasonGuide = self._guideModule:IsGuideProcessKey("guide_season_s1_drag")
  if (homelandGuide or seasonGuide) and self.info and self.info.guideStep then
    local guideStep = self.info.guideStep
    local cfg = guideStep.btnGuideCfg
    local param = guideStep:GetGuideParams()
    if cfg and cfg.completeRule == GuideCompleteType.OperationComplete then
      local delta = pointerEventData.delta * 0.015
      if homelandGuide then
        if not self._homelandCameraMgr then
          local homelandClient = self._homeLandModule:GetClient()
          self._homelandCameraMgr = homelandClient:CameraManager():FollowCameraController()
          self._dragDelta = Vector2(math.abs(delta.x) + param[2], math.abs(delta.y) + param[3])
        end
        self._homelandCameraMgr:HandleRotate(delta.x, delta.y)
      end
      if seasonGuide then
        if not self._seasonCamera then
          local uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
          self._seasonCamera = uiSeasonModule:SeasonManager():SeasonCameraManager():SeasonCamera()
          self._seasonCamera:SwitchMode(SeasonCameraMode.Drag)
          self._dragDelta = Vector2(math.abs(delta.x) + param[2], math.abs(delta.y) + param[3])
        end
        local position = Vector3(self._seasonCamera:Position().x + delta.x, 0, self._seasonCamera:Position().z + delta.y)
        self._seasonCamera:SetPosition(position)
      end
      self._dragDelta.x = self._dragDelta.x - math.abs(delta.x)
      self._dragDelta.y = self._dragDelta.y - math.abs(delta.y)
      if self._dragDelta.x <= 0 or self._dragDelta.y <= 0 then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Button)
      end
    end
  end
end

function UIGuide:LockHomeLandInput(Lock)
  local homelandClient = self._homeLandModule:GetClient()
  if homelandClient then
    homelandClient:InputManager():GetControllerChar():SetGuideLock(Lock)
    homelandClient:InputManager():GetControllerBuild():SetGuideLock(Lock)
  end
end

function UIGuide:PlayEffect(cfg)
  if not cfg or not cfg.Effect then
    if self._effectReq then
      self._effectReq:Dispose()
      self._effectReq = nil
    end
    if self._effect then
      self._effect:Destroy()
      self._effect = nil
    end
    return
  end
  self._effectReq = ResourceManager:GetInstance():SyncLoadAsset(cfg.Effect .. ".prefab", LoadType.GameObject)
  if self._effectReq and self._effectReq.Obj then
    self._effect = self._effectReq.Obj
    self._effect.transform:SetParent(self.forward.gameObject.transform)
    local offset = Vector3(0, 0, 0)
    if cfg.EffectOffset then
      offset = Vector3(cfg.EffectOffset[1], cfg.EffectOffset[2], cfg.EffectOffset[3])
    end
    self._effect.transform.localPosition = offset
    self._effect.transform.localScale = Vector3(1, 1, 1)
    self._effect:SetActive(true)
  end
end
