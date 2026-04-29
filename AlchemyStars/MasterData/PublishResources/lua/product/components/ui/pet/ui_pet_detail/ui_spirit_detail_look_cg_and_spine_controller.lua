_class("UISpiritDetailLookCgAndSpineController", UIController)
UISpiritDetailLookCgAndSpineController = UISpiritDetailLookCgAndSpineController

function UISpiritDetailLookCgAndSpineController:Constructor()
end

function UISpiritDetailLookCgAndSpineController:OnShow(uiParams)
  local isCg = true
  if uiParams[2] then
    isCg = uiParams[2] ~= DynamicAndStaticState.Dynamic
  end
  self._isCg = uiParams[2]
  self._tr = self:GetUIComponent("Transform", "root")
  self._scaleRoot = self:GetUIComponent("Transform", "scale")
  self._rect = self:GetUIComponent("RectTransform", "root")
  self._backObj = self:GetGameObject("back")
  local pet = uiParams[1]
  self._pet = pet
  local cgGo = self:GetGameObject("cg")
  local spineGo = self:GetGameObject("spine")
  cgGo:SetActive(isCg)
  spineGo:SetActive(not isCg)
  if isCg then
    self._cg = self:GetUIComponent("RawImageLoader", "cg")
    local cgName = pet:GetPetStaticBody(PetSkinEffectPath.BODY_PET_DETAIL)
    self._cg:LoadImage(cgName)
    UICG.SetTransform(self._tr.transform, "UIPetDetailItem", cgName)
  else
    self._spine = self:GetUIComponent("SpineLoader", "spine")
    local dynamicCGName = pet:GetPetSpine(PetSkinEffectPath.BODY_PET_DETAIL)
    self._dcgHandle = DynamicCG.SyncLoad(dynamicCGName, self._spine)
    UICG.SetTransform(self._tr.transform, "UIPetDetailItem", dynamicCGName)
  end
  local imageLoader = self:GetUIComponent("RawImageLoader", "BgLoader")
  UICommonHelper:GetInstance():ChangePetTagBackground(pet:GetTemplateID(), imageLoader, true)
  local pos = Vector2(-10, 0)
  local cfg_pet_view_pos = Cfg.cfg_pet_view_pos[pet:GetTemplateID()]
  if cfg_pet_view_pos then
    if isCg then
      pos = Vector2(cfg_pet_view_pos.CgOffset[1], cfg_pet_view_pos.CgOffset[2])
    else
      pos = Vector2(cfg_pet_view_pos.SpineOffset[1], cfg_pet_view_pos.SpineOffset[2])
    end
  end
  local anchoredPosition = self._rect.anchoredPosition
  self._rect:DOAnchorPos(Vector2(anchoredPosition.x + pos.x, anchoredPosition.y + pos.y), 0.5)
  self._scaleK = 0.2
  self._touchScaleK = 0.001
  self._scaleMax = 1.5
  self._scaleMin = 0.5
  self._moveK = 1
  self._moveMaxX = 1000
  self._moveMinX = -1000
  self._moveMaxY = 500
  self._moveMinY = -500
  self._mousePos2 = 0
  self._mousePos = 0
  self._scaling = false
  self._draging = false
  self._touch0Pos = 0
  self._touch0Pos2 = 0
  self._touchDis = 0
  self._touchDis2 = 0
  local pixels = Cfg.cfg_aircraft_camera.clickAndDragPixelLength.Value
  self._startMove = pixels * pixels
  self:Init()
  GameGlobal.EngineInput().multiTouchEnabled = true
end

function UISpiritDetailLookCgAndSpineController:Init()
  self._mousePresent = GameGlobal.EngineInput().mousePresent
  UnityEngine.Input.multiTouchEnabled = true
end

function UISpiritDetailLookCgAndSpineController:OnHide()
  self._mousePresent = nil
  UnityEngine.Input.multiTouchEnabled = false
  if self._spineEvent then
    GameGlobal.Timer():CancelEvent(self._spineEvent)
    self._spineEvent = nil
    self._playSpineAnim = false
  end
end

function UISpiritDetailLookCgAndSpineController:BgOnClick()
  self._backObj:SetActive(not self._backObj.activeSelf)
  if self._isCg ~= DynamicAndStaticState.Dynamic then
    return
  end
  if self._playSpineAnim then
    return
  end
  local dynamicCGName = self._pet:GetPetSpine(PetSkinEffectPath.BODY_PET_DETAIL)
  local cfg_pet_skin = Cfg.cfg_pet_skin({Spine = dynamicCGName})
  if not cfg_pet_skin then
    Log.error("###[UIMainLobbyFinal] cfg_pet_skin is nil ! id --> ", skinid)
    return
  else
    cfg_pet_skin = cfg_pet_skin[1]
  end
  local spineAnims = cfg_pet_skin.MainLobbySpineAnim
  if not spineAnims then
    return
  end
  local animList = {}
  for i = 1, #spineAnims do
    local spineAnim = spineAnims[i]
    table.insert(animList, spineAnim)
  end
  if #animList == 0 then
    Log.error("###[UIMainLobbyFinal] animList is nil ! skinid --> ", skinid)
    return
  end
  local randomVal = math.random(#animList)
  local anim = animList[randomVal]
  local animationName = anim
  if not self._dcgHandle then
    Log.debug("###[UIMainLobbyFinal] self._dcgHandle is nil --> ", self._dynamicSpineSettings)
    return
  end
  local entry = self._dcgHandle:SetAnimationWithTrackEntryReturn(0, animationName, false)
  self._dcgHandle:SetAnimMixTime(0)
  self._dcgHandle:Update(0)
  if self._dcgHandle:GetCurDynamicCGType() == DynamicCGType.Spine or self._dcgHandle:GetCurDynamicCGType() == DynamicCGType.None then
    self:PlayClickAnimBackIdleBySpine(entry)
  elseif self._dcgHandle:GetCurDynamicCGType() == DynamicCGType.Live2D then
    self:PlayClickAnimBackIdleByLive2d(entry)
  end
end

function UISpiritDetailLookCgAndSpineController:PlayClickAnimBackIdleBySpine(entry)
  if not entry then
    return
  end
  local anim = entry.Animation
  local duration = anim.Duration
  local yieldTime = math.floor(duration * 1000)
  if self._spineEvent then
    GameGlobal.Timer():CancelEvent(self._spineEvent)
    self._spineEvent = nil
    self._playSpineAnim = false
  end
  self._playSpineAnim = true
  self._spineEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
    self._playSpineAnim = false
    local animationName = "idle"
    self._dcgHandle:SetAnimation(0, animationName, true)
    self._dcgHandle:SetAnimMixTime(0)
    self._dcgHandle:Update(0)
  end)
  Log.debug("###[UIMainLobbyFinal] spine 动画名字[", animationName, "] 动画时长[", duration, "]")
end

function UISpiritDetailLookCgAndSpineController:PlayClickAnimBackIdleByLive2d(anim)
  if anim then
    local duration = anim.length
    local yieldTime = math.floor(duration * 1000)
    if self._spineEvent then
      GameGlobal.Timer():CancelEvent(self._spineEvent)
      self._spineEvent = nil
      self._playSpineAnim = false
    end
    self._playSpineAnim = true
    self._spineEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._playSpineAnim = false
      local animationName = "idle"
      self._dcgHandle:SetAnimationWithTrackEntryReturn(0, animationName, true)
    end)
  end
end

function UISpiritDetailLookCgAndSpineController:BackOnClick()
  if self._draging then
    return
  end
  if self._scaling then
    return
  end
  self:CloseDialog()
end

function UISpiritDetailLookCgAndSpineController:Update(deltaTimeMS)
  if self._mousePresent then
    self:EditorInput(deltaTimeMS / 1000)
  else
    self:TouchInput(deltaTimeMS / 1000)
  end
end

function UISpiritDetailLookCgAndSpineController:TouchInput(deltaTime)
  local touchCount = GameGlobal.EngineInput().touchCount
  local touch0
  if 0 < touchCount then
    touch0 = GameGlobal.EngineInput().GetTouch(0)
  end
  local touch1
  if 1 < touchCount then
    touch1 = GameGlobal.EngineInput().GetTouch(1)
  end
  if touch0 and touch0.phase == TouchPhase.Began then
    self._touch0DownPos = touch0.position
  end
  if not touch1 and touch0 and touch0.phase == TouchPhase.Moved then
    self._touch0Pos = touch0.position
    if self._touch0Pos2 ~= 0 and self._touch0DownPos then
      if self._draging == false and (self._touch0Pos - self._touch0DownPos).sqrMagnitude > self._startMove then
        self._draging = true
      end
      local offset = self._touch0Pos - self._touch0Pos2
      self._moveGap = offset * self._moveK
      local targetPos = self._rect.anchoredPosition + Vector2(self._moveGap.x, self._moveGap.y)
      if targetPos.x < self._moveMaxX and targetPos.x > self._moveMinX then
        self._rect.anchoredPosition = Vector2(targetPos.x, self._rect.anchoredPosition.y)
      end
      if targetPos.y < self._moveMaxY and targetPos.y > self._moveMinY then
        self._rect.anchoredPosition = Vector2(self._rect.anchoredPosition.x, targetPos.y)
      end
    end
    self._touch0Pos2 = self._touch0Pos
  end
  if touchCount == 0 then
    self._draging = false
    self._scaling = false
    self._touchDis = 0
    self._touchDis2 = 0
    self._touchDownDis = 0
    self._touch0Pos = 0
    self._touch0Pos2 = 0
  end
  if touch1 then
    self._scaling = true
    local lastLength = Vector2.Distance(touch0.position - touch0.deltaPosition, touch1.position - touch1.deltaPosition)
    local length = Vector2.Distance(touch0.position, touch1.position)
    local offset = length - lastLength
    self._scaleValue = offset * self._touchScaleK
    local targetScale = self._scaleRoot.localScale + Vector3(self._scaleValue, self._scaleValue, self._scaleValue)
    if targetScale.x < self._scaleMax and targetScale.x > self._scaleMin then
      self._scaleRoot.localScale = targetScale
    end
  end
end

function UISpiritDetailLookCgAndSpineController:EditorInput(deltaTime)
  if GameGlobal.EngineInput().GetMouseButtonDown(0) then
    self._mousePos2 = 0
    self._mousePos = 0
    self._mouseDpwnPos = GameGlobal.EngineInput().mousePosition
  end
  if GameGlobal.EngineInput().GetMouseButton(0) then
    self._mousePos = GameGlobal.EngineInput().mousePosition
    if self._mousePos2 ~= 0 and self._mouseDpwnPos then
      if self._draging == false and (self._mousePos - self._mouseDpwnPos).sqrMagnitude > self._startMove then
        self._draging = true
      end
      local offset = self._mousePos - self._mousePos2
      self._moveGap = offset * self._moveK
      local targetPos = self._rect.anchoredPosition + Vector2(self._moveGap.x, self._moveGap.y)
      if targetPos.x < self._moveMaxX and targetPos.x > self._moveMinX then
        self._rect.anchoredPosition = Vector2(targetPos.x, self._rect.anchoredPosition.y)
      end
      if targetPos.y < self._moveMaxY and targetPos.y > self._moveMinY then
        self._rect.anchoredPosition = Vector2(self._rect.anchoredPosition.x, targetPos.y)
      end
    end
    self._mousePos2 = self._mousePos
  end
  self._scaleLength = GameGlobal.EngineInput().GetAxis("Mouse ScrollWheel")
  if 0 < self._scaleLength or 0 > self._scaleLength then
    local gap = self._scaleLength * self._scaleK
    local targetScale = self._scaleRoot.localScale + Vector3(gap, gap, gap)
    if targetScale.x < self._scaleMax and targetScale.x > self._scaleMin then
      self._scaleRoot.localScale = targetScale
    end
  end
  if GameGlobal.EngineInput().GetMouseButtonUp(0) then
    self._mousePos2 = 0
    self._mousePos = 0
    if self._draging then
      self._draging = false
    end
  end
end
