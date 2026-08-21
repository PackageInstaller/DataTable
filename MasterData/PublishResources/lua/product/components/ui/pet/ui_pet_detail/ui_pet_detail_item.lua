_class("UIPetDetailItem", UICustomWidget)
UIPetDetailItem = UIPetDetailItem

function UIPetDetailItem:Constructor()
  self._index = 0
  self._isCurrent = false
  self._dynamicAndStaticState = DynamicAndStaticState.None
  self._module = GameGlobal.GetModule(PetModule)
  self._open = true
end

function UIPetDetailItem:OnShow(uiParams)
  self._cg = self:GetUIComponent("RawImageLoader", "cg")
  self._rawImage = self:GetUIComponent("RawImage", "cg")
  self._cgGo = self:GetGameObject("cg")
  self._spineGo = self:GetGameObject("spine")
  self._center = self:GetUIComponent("RectTransform", "center")
  self._dcgHandle = nil
  self:AttachEvents()
end

function UIPetDetailItem:AttachEvents()
  self:AttachEvent(GameEventType.PetUpGradeEvent, self.ObservationUpGradeRefresh)
  self:AttachEvent(GameEventType.PetDetailChangeCgState, self.ChangeDynamicAndStatic)
  self:AttachEvent(GameEventType.CheckIsCurrent, self.CheckIsCurrent)
end

function UIPetDetailItem:RemoveEvents()
  self:DetachEvent(GameEventType.PetUpGradeEvent, self.ObservationUpGradeRefresh)
  self:DetachEvent(GameEventType.PetDetailChangeCgState, self.ChangeDynamicAndStatic)
  self:DetachEvent(GameEventType.CheckIsCurrent, self.CheckIsCurrent)
end

function UIPetDetailItem:ObservationUpGradeRefresh(pstid)
  if self._pstid == pstid then
    self._pet = self._module:GetPet(pstid)
    local matName = self._pet:GetPetStaticBody(PetSkinEffectPath.BODY_AWAKE)
    local spineName = self._pet:GetPetSpine(PetSkinEffectPath.BODY_AWAKE)
    self:LoadCgSync(matName, true)
    self:LoadSpineSync(spineName, true)
  end
end

function UIPetDetailItem:OnHide()
  self._index = 0
  if self._matAsset then
    self._matAsset:Dispose()
  end
  if self._dcgHandle then
    self._dcgHandle:Release()
  end
  if self._spineEvent then
    GameGlobal.Timer():CancelEvent(self._spineEvent)
    self._spineEvent = nil
    self._playSpineAnim = false
  end
  self:RemoveEvents()
end

function UIPetDetailItem:OnHideCallBack()
  if self._matAsset then
    self._matAsset:Dispose()
  end
  if self._dcgHandle then
    self._dcgHandle:Release()
  end
  self._dcgHandle = nil
  self._matAsset = nil
end

function UIPetDetailItem:SetData(index, pet, state, matName, spineName, spineRoot, idx)
  self._index = index
  self._isCurrent = self._index == idx
  self._pet = pet
  self._pstid = self._pet:GetPstID()
  self._petid = self._pet:GetTemplateID()
  self._spineRoot = spineRoot
  self._state = state
  local size = Cfg.cfg_global.ui_interface_common_size.ArrayValue
  self._cgGo:GetComponent("RectTransform").sizeDelta = Vector2(size[1], size[2])
  self:ChangeDynamicAndStatic(self._index, state)
  if self._isCurrent then
    self:LoadCgSync(matName)
    self:LoadSpineSync(spineName)
  else
    GameGlobal.TaskManager():StartTask(self.OnSetData, self, matName, true)
    GameGlobal.TaskManager():StartTask(self.OnSetDataSpine, self, spineName, true)
  end
end

function UIPetDetailItem:RefreshSkinAppearance(matName, spineName)
  self:LoadCgSync(matName, true)
  self:LoadSpineSync(spineName, true)
end

function UIPetDetailItem:LoadCgSync(matName, force)
  if not self._index or self._index == 0 then
    return
  end
  if self._matAsset == nil or force then
    if self._matAsset ~= nil then
      self._matAsset:Dispose()
    end
    local resName = ""
    if matName then
      resName = matName .. ".mat"
      if ResourceManager:GetInstance():HasResource(resName) then
        self._matAsset = ResourceManager:GetInstance():SyncLoadAsset(resName, LoadType.Mat)
      end
    end
  end
  if self._matAsset == nil or self._matAsset.Obj == nil then
    return
  end
  self._cg:SetMat(matName, self._matAsset.Obj, false)
  UICG.SetTransform(self._cgGo.transform, self:GetName(), matName)
  local alpha = 0
  if force then
    alpha = 1
  end
  self._rawImage.color = Color(1, 1, 1, alpha)
end

function UIPetDetailItem:LoadSpineSync(dcgName, force)
  if not self._index or self._index == 0 then
    return
  end
  if self._dcgHandle == nil or force then
    if self._dcgHandle ~= nil then
      self._dcgHandle:ChangeDynamicCGSync(dcgName)
    else
      self._dcgHandle = DynamicCG.SyncLoad(dcgName, nil, self._spineGo)
    end
  end
  self:SetSpineMat()
  UICG.SetTransform(self._spineGo.transform, self:GetName(), dcgName)
  local alpha = 0
  if force then
    alpha = 1
  end
  self._dcgHandle:SetAlpha(alpha)
end

function UIPetDetailItem:FullScreenAnimBtnOnClick()
  if self._playSpineAnim then
    return
  end
  local cfg_pet_skin = Cfg.cfg_pet_skin[self._pet:GetSkinId()]
  if not cfg_pet_skin then
    Log.error("###[UIMainLobbyFinal] cfg_pet_skin is nil ! id --> ", skinid)
    return
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

function UIPetDetailItem:PlayClickAnimBackIdleBySpine(entry)
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
    if self._dcgHandle then
      self._dcgHandle:SetAnimation(0, animationName, true)
      self._dcgHandle:SetAnimMixTime(0)
      self._dcgHandle:Update(0)
    end
  end)
  Log.debug("###[UIMainLobbyFinal] spine 动画名字[", animationName, "] 动画时长[", duration, "]")
end

function UIPetDetailItem:PlayClickAnimBackIdleByLive2d(anim)
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

function UIPetDetailItem:SetAnimAlpha(alpha)
  self._rawImage.color = Color(1, 1, 1, alpha)
  self._dcgHandle:SetAlpha(alpha)
end

function UIPetDetailItem:OpenAndCloseOtherAlpha(open)
  self._open = open
end

function UIPetDetailItem:OnSetData(TT, matName, hideAlpha)
  if not self._index or self._index == 0 then
    return
  end
  if self._matAsset == nil then
    local resName = ""
    if matName then
      resName = matName .. ".mat"
      if ResourceManager:GetInstance():HasResource(resName) then
        self._matAsset = ResourceManager:GetInstance():AsyncLoadAsset(TT, resName, LoadType.Mat)
      end
    end
    local logMatName = matName or "nil"
    if self._matAsset == nil then
      Log.fatal("###[UIPetDetailItem] error --> the load asset is nil ! id --> ", self._petid, " , name is ", logMatName)
      return
    end
    if self._matAsset.Obj == nil then
      Log.fatal("###[UIPetDetailItem] error --> the load asset obj is nil ! id --> ", self._petid, " , name is ", logMatName)
      return
    end
  end
  if not self._index or self._index == 0 then
    self._matAsset:Dispose()
    return
  end
  self._cg:SetMat(matName, self._matAsset.Obj, false)
  UICG.SetTransform(self._cgGo.transform, self:GetName(), matName)
  local alpha = 1
  if hideAlpha then
    alpha = 0
  end
  self._rawImage.color = Color(1, 1, 1, alpha)
end

function UIPetDetailItem:OnSetDataSpine(TT, spineName, hideAlpha)
  if not self._index or self._index == 0 then
    return
  end
  if self._dcgHandle == nil then
    self._dcgHandle = DynamicCG.AsyncLoad(TT, spineName, nil, self._spineGo)
  end
  if not self._index or self._index == 0 then
    self._dcgHandle:Release()
    self._dcgHandle = nil
    return
  end
  self:SetSpineMat()
  UICG.SetTransform(self._spineGo.transform, self:GetName(), spineName)
  local alpha = 1
  if hideAlpha then
    alpha = 0
  end
  self._dcgHandle:SetAlpha(alpha)
end

function UIPetDetailItem:SetSpineMat()
  if self._dcgHandle then
    self._dcgHandle:SetMatFloat("_StencilComp", 2)
  end
end

function UIPetDetailItem:ChangeDynamicAndStatic(index, state)
  if index ~= self._index then
    return
  end
  if self._dynamicAndStaticState ~= state then
    self._dynamicAndStaticState = state
    if self._dynamicAndStaticState == DynamicAndStaticState.Dynamic then
      self._cgGo:SetActive(false)
      self._spineGo:SetActive(true)
    elseif self._dynamicAndStaticState == DynamicAndStaticState.Static then
      self._cgGo:SetActive(true)
      self._spineGo:SetActive(false)
    end
  end
end

function UIPetDetailItem:ChangeCanvasGroupAlpha(all, centerX)
  if not self._open then
    return
  end
  local dis = math.abs(self._center.position.x - centerX)
  local rate = dis / (all * 0.5)
  if 1 < rate then
    rate = 1
  elseif rate < 0 then
    rate = 0
  end
  local alpha = 1 - rate
  if self._dcgHandle ~= nil then
    self._dcgHandle:SetAlpha(alpha)
  end
  self._rawImage.color = Color(1, 1, 1, alpha)
end

function UIPetDetailItem:CheckIsCurrent(curridx)
  self._isCurrent = self._index == curridx
end
