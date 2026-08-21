require("pet_obtain_anim_base")
_class("PetObtainAnim2Star", PetObtainAnimBase)
PetObtainAnim2Star = PetObtainAnim2Star

function PetObtainAnim2Star:Constructor(pet, anim, atlas, uiStars, uiDepth, matAnim)
  self._pet = pet
  self._petID = self._pet:PetID()
  self._anim = anim
  self._atlas = atlas
  self._uiStars = uiStars
  self._depth = uiDepth
  self._matAnim = matAnim
  self._petAudioModule = GameGlobal.GetModule(PetAudioModule)
end

function PetObtainAnim2Star:Prepare()
  if self._state ~= ObtainAnimState.Wait then
    return
  end
  local cfg = Cfg.cfg_pet[self._petID]
  self._assetName = {}
  self._assetName.Root = "uieff_Chouka_2"
  self._assetName.PetLogo = cfg.Logo
  self._assetName.Logo1 = "1001_force_logo"
  self._assetName.Logo2 = "1003_force_logo"
  self._assetName.Logo3 = "1002_force_logo"
  self._assetName.Logo4 = "1004_force_logo"
  self._assetName.Logo5 = "1006_force_logo"
  self._assetName.Logo6 = "1005_force_logo"
  if self._isFirst then
    self._state = ObtainAnimState.Prepare
    self:LoadAsset(self._assetName.Root, LoadType.GameObject)
    self:LoadAsset(self._assetName.PetLogo, LoadType.Mat)
    self:LoadAsset(self._assetName.Logo1, LoadType.Mat)
    self:LoadAsset(self._assetName.Logo2, LoadType.Mat)
    self:LoadAsset(self._assetName.Logo3, LoadType.Mat)
    self:LoadAsset(self._assetName.Logo4, LoadType.Mat)
    self:LoadAsset(self._assetName.Logo5, LoadType.Mat)
    self:LoadAsset(self._assetName.Logo6, LoadType.Mat)
    self._state = ObtainAnimState.Ready
  else
    GameGlobal:TaskManager():StartTask(self._load, self)
  end
end

function PetObtainAnim2Star:_load(TT)
  self._state = ObtainAnimState.Prepare
  self:LoadAssetAsync(TT, self._assetName.Root, LoadType.GameObject)
  if self:CheckClosed() then
    return
  end
  self:LoadAssetAsync(TT, self._assetName.PetLogo, LoadType.Mat)
  if self:CheckClosed() then
    return
  end
  self:LoadAssetAsync(TT, self._assetName.Logo1, LoadType.Mat)
  if self:CheckClosed() then
    return
  end
  self:LoadAssetAsync(TT, self._assetName.Logo2, LoadType.Mat)
  if self:CheckClosed() then
    return
  end
  self:LoadAssetAsync(TT, self._assetName.Logo3, LoadType.Mat)
  if self:CheckClosed() then
    return
  end
  self:LoadAssetAsync(TT, self._assetName.Logo4, LoadType.Mat)
  if self:CheckClosed() then
    return
  end
  self:LoadAssetAsync(TT, self._assetName.Logo5, LoadType.Mat)
  if self:CheckClosed() then
    return
  end
  self:LoadAssetAsync(TT, self._assetName.Logo6, LoadType.Mat)
  if self:CheckClosed() then
    return
  end
  self._state = ObtainAnimState.Ready
end

function PetObtainAnim2Star:Start()
  self._anim:Play("uieff_uipetobtain_hide")
  self:checkReady()
end

function PetObtainAnim2Star:checkReady()
  if self._state == ObtainAnimState.Ready then
    self._state = ObtainAnimState.Playing
    Log.debug("2星卡牌展示开始:", self._petID)
    self._eff = self:GetAsset(self._assetName.Root)
    self._eff:SetActive(true)
    local cfg = Cfg.cfg_pet[self._petID]
    local uiView = self._eff:GetComponent(typeof(UIView))
    self:OnUIDepthChanged(self._depth)
    local videos = {
      [PetFilterType.BaiYeCheng] = "chouka_byc.mp4",
      [PetFilterType.BaiYeXiaCheng] = "chouka_byxc.mp4",
      [PetFilterType.QiGuang] = "chouka_qg.mp4",
      [PetFilterType.BeiJing] = "chouka_bj.mp4",
      [PetFilterType.HongYouBanShou] = "chouka_hybs.mp4",
      [PetFilterType.TaiYangJiaoTuan] = "chouka_zljs.mp4",
      [PetFilterType.YouMin] = "chouka_wzy.mp4",
      [PetFilterType.LongZhou] = "chouka_lz.mp4"
    }
    local logoMat = self:GetAsset(self._assetName.PetLogo)
    local tag = cfg.Tags[1]
    if tag == PetFilterType.YouMin then
      local ym_logo = uiView:GetUIComponent("MeshRenderer", "Logo_ym")
      ym_logo.sharedMaterial:SetTexture("_MainTex", logoMat:GetTexture("_MainTex"))
    else
    end
    local url = HelperProxy:GetInstance():GetVideoUrl(videos[tag])
    if url == nil then
      url = HelperProxy:GetInstance():GetVideoUrl(videos[PetFilterType.QiGuang])
      Log.fatal("暂时找不到阵营视频，用启光代替：", tag)
    end
    uiView:GetUIComponent("MeshRenderer", "logo1").sharedMaterial:SetTexture("_MainTex", self:GetAsset(self._assetName.Logo1):GetTexture("_MainTex"))
    uiView:GetUIComponent("MeshRenderer", "logo2").sharedMaterial:SetTexture("_MainTex", self:GetAsset(self._assetName.Logo2):GetTexture("_MainTex"))
    uiView:GetUIComponent("MeshRenderer", "logo3").sharedMaterial:SetTexture("_MainTex", self:GetAsset(self._assetName.Logo3):GetTexture("_MainTex"))
    uiView:GetUIComponent("MeshRenderer", "logo4").sharedMaterial:SetTexture("_MainTex", self:GetAsset(self._assetName.Logo4):GetTexture("_MainTex"))
    uiView:GetUIComponent("MeshRenderer", "logo5").sharedMaterial:SetTexture("_MainTex", self:GetAsset(self._assetName.Logo5):GetTexture("_MainTex"))
    uiView:GetUIComponent("MeshRenderer", "logo6").sharedMaterial:SetTexture("_MainTex", self:GetAsset(self._assetName.Logo6):GetTexture("_MainTex"))
    self._petObtain = uiView:GetUIComponent("UIView", "UIPetObtain")
    self:InitData()
    local cgMid = self._petObtain:GetUIComponent("RawImageLoader", "cgMid")
    local cgRect = self._petObtain:GetUIComponent("RectTransform", "cgMid")
    local _cg = self:_GetCG(self._pet)
    cgMid:LoadImage(_cg)
    UICG.SetTransform(cgRect, "UIPetObtain", _cg)
    local tls = {}
    tls[#tls + 1] = EZTL_Wait:New(2000, "先等2.0秒")
    tls[#tls + 1] = EZTL_Wait:New(5700, "再等3.7秒")
    local tl1 = EZTL_Sequence:New(tls, "2星卡牌时间线1，串行")
    local tl2_tls = {
      EZTL_Wait:New(4433, "等8.433s显示重复获得材料"),
      EZTL_Callback:New(function()
        self._anim:Play("uieff_Card_PetObtain_6")
        self._petAudioModule:PlayPetAudio("Obtain", self._petID)
      end, "ui动效")
    }
    tl2_tls[#tl2_tls + 1] = EZTL_Wait:New(100, "出现星星前等0.1s")
    for i = 1, 2 do
      local star = self._uiStars:GetChild(i - 1).gameObject
      star:SetActive(false)
      tl2_tls[#tl2_tls + 1] = EZTL_Callback:New(function()
        star:SetActive(true)
      end, "显示第" .. i .. "个星星")
      tl2_tls[#tl2_tls + 1] = EZTL_Wait:New(33, "等33ms")
    end
    self._matAnim:SetActive(false)
    if not self._pet:IsNew() then
      tl2_tls[#tl2_tls + 1] = EZTL_Callback:New(function()
        self._matAnim:SetActive(true)
      end, "播放重复获得材料动画")
    end
    tl2_tls[#tl2_tls + 1] = EZTL_Wait:New(1500, "再等1.5s")
    local tl2 = EZTL_Sequence:New(tl2_tls, "2星抽卡时间线2")
    local audioTl = {}
    local tl3 = EZTL_Parallel:New(audioTl, EZTL_EndTag.All, nil, "2星抽卡音效时间线")
    self._tl = EZTL_Parallel:New({
      tl1,
      tl2,
      tl3
    }, EZTL_EndTag.All, nil, "2星抽卡总时间线，并行")
    self._tl:Start()
    self._running = true
    self._audio = AudioHelperController.RequestAndPlayUIVoiceAutoRelease(CriAudioIDConst.Drawcard_pet_obtain_5)
  end
end

function PetObtainAnim2Star:Update(dtMS)
  if self._state == ObtainAnimState.Playing then
    self._tl:Update(dtMS)
    if self._tl:Over() then
      self._state = ObtainAnimState.Finished
    end
  elseif self._state == ObtainAnimState.Prepare or self._state == ObtainAnimState.Ready then
    self:checkReady()
  end
end

function PetObtainAnim2Star:IsOver()
  return self._state == ObtainAnimState.Finished
end

function PetObtainAnim2Star:Dispose()
  if self._state == ObtainAnimState.Wait then
  elseif self._state == ObtainAnimState.Prepare then
    self._state = ObtainAnimState.Closed
    self:ReleaseAsset()
  elseif self._state == ObtainAnimState.Ready then
    self:ReleaseAsset()
  elseif self._state == ObtainAnimState.Playing then
    self._tl:Stop()
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

function PetObtainAnim2Star:InitData()
  self._spine = self._petObtain:GetUIComponent("SpineLoader", "spine")
  self._spineRect = self._petObtain:GetUIComponent("RectTransform", "spine")
  local spine = self:_GetSpine(self._pet)
  self._dcgHandle = DynamicCG.SyncLoad(spine, self._spine)
  UICG.SetTransform(self._spineRect, "UIPetObtain", spine)
end

function PetObtainAnim2Star:_GetSpine(obtainPet)
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

function PetObtainAnim2Star:_GetCG(obtainPet)
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
      end
    end
  end
  return ""
end

function PetObtainAnim2Star:OnUIDepthChanged(depth)
  depth = depth * 10
  local uiView = self._eff:GetComponent(typeof(UIView))
  local cam = uiView:GetUIComponent("Camera", "Camera1")
  cam.depth = depth + 2
  cam = uiView:GetUIComponent("Camera", "Camera2")
  cam.depth = depth + 3
end
