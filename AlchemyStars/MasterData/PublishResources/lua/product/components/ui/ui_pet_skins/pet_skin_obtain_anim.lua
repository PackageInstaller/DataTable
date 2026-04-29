require("pet_obtain_anim_base")
_class("PetSkinObtainAnim", PetObtainAnimBase)
PetSkinObtainAnim = PetSkinObtainAnim

function PetSkinObtainAnim:Constructor(pet, anim, parentGo)
  self._pet = pet
  self._petID = self._pet:PetID()
  self._petSkinID = self._pet:SkinID()
  self._anim = anim
  self._parentGo = parentGo
  self._petAudioModule = GameGlobal.GetModule(PetAudioModule)
  self._assetName = {}
  self._cgGoNames = {
    "cg1",
    "cg2",
    "cg3",
    "cg4"
  }
  self._skinNameStrGoNames = {
    "SkinName1",
    "SkinName2",
    "SkinName3",
    "SkinName4"
  }
  self._charNameStrGoNames = {
    "CharName1",
    "CharName2",
    "CharName3",
    "CharName4"
  }
end

function PetSkinObtainAnim:_GetStaticBody(obtainPet)
  if obtainPet then
    if obtainPet:SkinID() > 0 then
      local cfgv = Cfg.cfg_pet_skin[obtainPet:SkinID()]
      if cfgv then
        return cfgv.StaticBody
      end
    else
      local cg = HelperProxy:GetInstance():GetPetStaticBody(obtainPet:PetID(), 0, 0, PetSkinEffectPath.NO_EFFECT)
      if cg then
        return cg
      else
        Log.fatal("### [error] pet obtain anim 5 star get cg fail. id = [", obtainPet:PetID(), "]")
      end
    end
  end
  return ""
end

function PetSkinObtainAnim:_GetSpine(obtainPet)
  if obtainPet then
    if obtainPet:SkinID() > 0 then
      local cfgv = Cfg.cfg_pet_skin[obtainPet:SkinID()]
      if cfgv then
        return cfgv.Spine
      end
    else
      local spine = HelperProxy:GetInstance():GetPetSpine(obtainPet:PetID(), 0, 0, PetSkinEffectPath.NO_EFFECT)
      if spine then
        return spine
      end
    end
  end
  return ""
end

function PetSkinObtainAnim:Prepare()
  if self._state ~= ObtainAnimState.Wait then
    return
  end
  local cfg = Cfg.cfg_pet[self._petID]
  local cfgv = Cfg.cfg_pet_skin[self._petSkinID]
  local prefabName = cfgv.Prefab
  local preFix = string.gsub(prefabName, ".prefab", "")
  self._assetName.Root = cfgv.ObtainAnim
  self._assetName.Logo = cfg.Logo
  self._assetName.CG = self:_GetStaticBody(self._pet)
  self._assetName.Spine = cfgv.Spine
  if self._isFirst then
    self._state = ObtainAnimState.Prepare
    self:LoadAsset(self._assetName.Root, LoadType.GameObject)
    self:LoadAsset(self._assetName.Logo, LoadType.Mat)
    self:LoadAsset(self._assetName.CG, LoadType.Mat)
    self:LoadAsset(self._assetName.Spine, LoadType.GameObject)
    self._state = ObtainAnimState.Ready
  else
    GameGlobal:TaskManager():StartTask(self._load, self)
  end
end

function PetSkinObtainAnim:_load(TT)
  self._state = ObtainAnimState.Prepare
  self:LoadAssetAsync(TT, self._assetName.Root, LoadType.GameObject)
  if self:CheckClosed() then
    return
  end
  self:LoadAssetAsync(TT, self._assetName.Logo, LoadType.Mat)
  if self:CheckClosed() then
    return
  end
  self:LoadAssetAsync(TT, self._assetName.CG, LoadType.Mat)
  if self:CheckClosed() then
    return
  end
  self:LoadAssetAsync(TT, self._assetName.Spine, LoadType.GameObject)
  if self:CheckClosed() then
    return
  end
  self._state = ObtainAnimState.Ready
end

function PetSkinObtainAnim:Start()
  if self._anim then
    self._anim:Play("uieff_uipetobtain_hide")
  end
  self:checkReady()
end

function PetSkinObtainAnim:checkReady()
  if self._state == ObtainAnimState.Ready then
    self._state = ObtainAnimState.Playing
    Log.debug("时装获得展示开始:", self._petSkinID)
    self._eff = self:GetAsset(self._assetName.Root)
    if not self._eff then
      Log.error("###[PetSkinObtainAnim] not eff --> ", self._assetName.Root)
      return
    end
    if self._parentGo then
      self._eff.transform.parent = self._parentGo.transform
    end
    self._eff:SetActive(true)
    local cfg = Cfg.cfg_pet[self._petID]
    local skinCfg = Cfg.cfg_pet_skin[self._petSkinID]
    local uiView = self._eff:GetComponent(typeof(UIView))
    self._skinNameCmpts = {}
    for _, name in ipairs(self._skinNameStrGoNames) do
      local txt = uiView:GetUIComponent("UILocalizationText", name)
      if txt then
        txt:SetText(StringTable.Get(skinCfg.SkinName))
        table.insert(self._skinNameCmpts, txt)
      end
    end
    self._charNameCmpts = {}
    for _, name in ipairs(self._charNameStrGoNames) do
      local txt = uiView:GetUIComponent("UILocalizationText", name)
      if txt then
        local nameStr = StringTable.Get(cfg.EnglishName)
        if skinCfg.UnlockSkinID then
          local otherSkinCfg = Cfg.cfg_pet_skin[skinCfg.UnlockSkinID]
          if otherSkinCfg then
            local otherPetCfg = Cfg.cfg_pet[otherSkinCfg.PetId]
            if otherPetCfg then
              nameStr = nameStr .. "/" .. StringTable.Get(otherPetCfg.EnglishName)
            end
          end
        end
        txt:SetText(nameStr)
        table.insert(self._charNameCmpts, txt)
      end
    end
    local versionName = uiView:GetUIComponent("UILocalizationText", "VersionName")
    if versionName then
      versionName:SetText(StringTable.Get(skinCfg.ObtainVersionName))
    end
    self._logoImg = uiView:GetUIComponent("RawImage", "Logo")
    if self._logoImg then
      self._logoImg.texture = self:GetAsset(self._assetName.Logo):GetTexture("_MainTex")
    end
    local cgTex = self:GetAsset(self._assetName.CG):GetTexture("_MainTex")
    self._cgCmpts = {}
    for _, name in ipairs(self._cgGoNames) do
      local rawImg = uiView:GetUIComponent("RawImage", name)
      if rawImg then
        rawImg.texture = cgTex
        table.insert(self._cgCmpts, rawImg)
      end
    end
    local dynamicCG = DynamicCG.ReplaceL2D(self:_GetSpine(self._pet))
    if string.startwith(dynamicCG, "l2d_") then
      local l2dLoader = uiView:GetUIComponent("Live2DLoader", "l2d")
      if l2dLoader then
        l2dLoader:LoadLive2D(dynamicCG)
        DynamicCG.ProcessLive2DCamSize(dynamicCG, l2dLoader)
      end
    else
      local spineLoader = uiView:GetUIComponent("SpineLoader", "spine")
      if spineLoader then
        spineLoader:LoadSpine(dynamicCG)
      end
    end
    local tls = {}
    tls[#tls + 1] = EZTL_Wait:New(2000, "等一下")
    self._tl = EZTL_Parallel:New({
      EZTL_Sequence:New(tls, "时间线1，串行")
    }, EZTL_EndTag.All, nil, "总时间线，并行")
    self._tl:Start()
    self._audio = AudioHelperController.PlayUISoundResource(CriAudioIDConst.PetSkinObtain)
  end
end

function PetSkinObtainAnim:Update(dtMS)
  if self._state == ObtainAnimState.Playing then
    if self._tl then
      self._tl:Update(dtMS)
      if self._tl:Over() then
        self._state = ObtainAnimState.Finished
      end
    end
  elseif self._state == ObtainAnimState.Prepare or self._state == ObtainAnimState.Ready then
    self:checkReady()
  end
end

function PetSkinObtainAnim:IsOver()
  return self._state == ObtainAnimState.Finished
end

function PetSkinObtainAnim:Dispose()
  if self._state == ObtainAnimState.Wait then
  elseif self._state == ObtainAnimState.Prepare then
    self._state = ObtainAnimState.Closed
    self:ReleaseAsset()
  elseif self._state == ObtainAnimState.Ready then
    self:ReleaseAsset()
  elseif self._state == ObtainAnimState.Playing then
    if self._tl then
      self._tl:Stop()
    end
    self:ReleaseAsset()
  elseif self._state == ObtainAnimState.Finished then
    self:ReleaseAsset()
  elseif self._state == ObtainAnimState.Closed then
  end
  self._petAudioModule:StopAll()
  if self._audio then
    AudioHelperController.StopUISound(self._audio)
  end
end

function PetSkinObtainAnim:InitData()
end
