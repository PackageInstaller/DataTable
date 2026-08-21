_class("UISpineBg", UICustomWidget)
UISpineBg = UISpineBg

function UISpineBg:OnShow()
  self._petAudioModule = self:GetModule(PetAudioModule)
  self._roleModule = GameGlobal.GetModule(RoleModule)
  self._freeTime = 0
  self._maxFreeTime = Cfg.cfg_global.MainUIFreeTime.IntValue * 1000
  self._cgSpineGo = self:GetGameObject("posAndScale")
  self._spineGo = self:GetGameObject("spine")
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._changePetPosAndScaleRoot = self:GetUIComponent("RectTransform", "posAndScale")
  self._spineBgRoot = self:GetUIComponent("RectTransform", "spineHolder")
  self._spineLoader2 = self:GetUIComponent("SpineLoader", "bg_spine2")
  self._spineLoaderObj2 = self:GetGameObject("bg_spine2")
  self._spineLoader1 = self:GetUIComponent("SpineLoader", "bg_spine1")
  self._spineLoaderObj1 = self:GetGameObject("bg_spine1")
end

function UISpineBg:OnHide()
  if self._spineEvent then
    GameGlobal.Timer():CancelEvent(self._spineEvent)
    self._spineEvent = nil
  end
end

function UISpineBg:SetData(skinId)
  self._skinId = skinId
  self._cfg = Cfg.cfg_senior_skin[skinId]
  if not self._cfg then
    Log.error("UISpineBg can't find cfg_pet_skin : ", skinId)
    return
  end
  self._spineName = self._cfg.Spine
  self:ShowSkinSpine()
end

function UISpineBg:ShowSkinSpine()
  self._assistantSkinID = self._skinId
  self._cgSpineGo:SetActive(true)
  if not self._spineLoaded then
    self._spine:DestroyCurrentSpine()
    self._spine:LoadSpine(self._spineName)
    self._spineLoaded = true
  end
  self._spineSke = self._spine.CurrentSkeleton
  if not self._spineSke then
    self._spineSke = self._spine.CurrentMultiSkeleton
  end
  self._spineGo:SetActive(true)
  local spineAnim = self._cfg.EnterAnim
  if spineAnim then
    self:PlayEnterAni(spineAnim)
  end
end

function UISpineBg:PlayEnterAni(spineAnim)
  if spineAnim then
    if not self._spineSke then
      Log.debug("###[UISpineBg] not self._spineSke spine --> ", self._spineName)
      return
    end
    local entry
    
    local function _f()
      self._spineSke:Initialize(true)
      entry = self._spineSke.AnimationState:SetAnimation(0, spineAnim, false)
      self._spine.AnimationState.Data.DefaultMix = 0
      self._spineSke:Update(0)
    end
    
    local succ = pcall(_f)
    if not succ then
      Log.error("###[UISpineBg] set spine anim fail ! spine[", self._spineName, "] anim[", spineAnim, "]")
      return
    end
    if not entry then
      Log.error("###[UISpineBg] entry is nil ! spine[", self._spineName, "] anim[", spineAnim, "]")
      return
    end
    local anim = entry.Animation
    local duration = anim.Duration
    local yieldTime = math.floor(duration * 1000)
    self._playSpineAnim = true
    if self._spineEvent then
      GameGlobal.Timer():CancelEvent(self._spineEvent)
      self._spineEvent = nil
    end
    self._spineEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._playSpineAnim = false
      local animationName = "idle"
      self._spineSke.AnimationState:SetAnimation(0, animationName, true)
      self._spine.AnimationState.Data.DefaultMix = 0
      self._spineSke:Update(0)
    end)
  end
end

function UISpineBg:PlayClickAni()
  self:PlaySpineAnim(self._skinId)
end

function UISpineBg:PlaySpineAnim(skinid)
  if not self._spineSke or not self._cfg then
    return
  end
  if self._playSpineAnim then
    return
  end
  local cfg_pet_skin = self._cfg
  local spineAnims = cfg_pet_skin.ClickAni
  if not spineAnims then
    return
  end
  local animList = {}
  for i = 1, #spineAnims do
    local spineAnim = spineAnims[i]
    table.insert(animList, spineAnim)
  end
  if #animList == 0 then
    Log.error("###[UISpineBg] animList is nil ! skinid --> ", skinid)
    return
  end
  local randomVal = math.random(#animList)
  local anim = animList[randomVal]
  local animationName = anim
  local entry = self._spineSke.AnimationState:SetAnimation(0, animationName, false)
  self._spine.AnimationState.Data.DefaultMix = 0
  self._spineSke:Update(0)
  if not entry then
    return
  end
  local anim = entry.Animation
  local duration = anim.Duration
  local yieldTime = math.floor(duration * 1000)
  self._playSpineAnim = true
  if self._spineEvent then
    GameGlobal.Timer():CancelEvent(self._spineEvent)
    self._spineEvent = nil
  end
  self._spineEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
    self._playSpineAnim = false
    local animationName = "idle"
    self._spineSke.AnimationState:SetAnimation(0, animationName, true)
    self._spine.AnimationState.Data.DefaultMix = 0
    self._spineSke:Update(0)
  end)
  Log.debug("###[UISpineBg] spine 动画名字[", animationName, "] 动画时长[", duration, "]")
end
