require("pet_obtain_anim_base")
_class("PetObtainAnim5Star", PetObtainAnimBase)
PetObtainAnim5Star = PetObtainAnim5Star

function PetObtainAnim5Star:Constructor(pet, anim, atlas, uiStars, uiDepth, matAnim)
  self._pet = pet
  self._petID = self._pet:PetID()
  self._anim = anim
  self._atlas = atlas
  self._uiStars = uiStars
  self._depth = uiDepth
  self._matAnim = matAnim
  self._audioID1 = CriAudioIDConst.Drawcard_pet_obtain_5
  self._audioID2 = 1213
  self._petAudioModule = GameGlobal.GetModule(PetAudioModule)
  self._assetName = {}
  self._disposed = false
end

function PetObtainAnim5Star:_GetStaticBody(obtainPet)
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

function PetObtainAnim5Star:_GetSpine(obtainPet)
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

function PetObtainAnim5Star:Prepare()
  if self._state ~= ObtainAnimState.Wait then
    return
  end
  local cfg = Cfg.cfg_pet[self._petID]
  self._assetName.Root = "uieff_Chouka_5"
  self._assetName.Logo = cfg.Logo
  self._assetName.CG = self:_GetStaticBody(self._pet)
  AudioHelperController.RequestUISoundSync(self._audioID1)
  AudioHelperController.RequestUISoundSync(self._audioID2)
  self._cacheAudioReady = true
  if self._isFirst then
    self._state = ObtainAnimState.Prepare
    self:LoadAsset(self._assetName.Root, LoadType.GameObject)
    self:LoadAsset(self._assetName.Logo, LoadType.Mat)
    self:LoadAsset(self._assetName.CG, LoadType.Mat)
    self._state = ObtainAnimState.Ready
  else
    GameGlobal:TaskManager():StartTask(self._load, self)
  end
end

function PetObtainAnim5Star:_load(TT)
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
  self._state = ObtainAnimState.Ready
end

function PetObtainAnim5Star:Start()
  self._anim:Play("uieff_uipetobtain_hide")
  self:checkReady()
end

function PetObtainAnim5Star:checkReady()
  if self._state == ObtainAnimState.Ready then
    self._state = ObtainAnimState.Playing
    Log.debug("5星卡牌展示开始:", self._petID)
    self._eff = self:GetAsset(self._assetName.Root)
    self._eff:SetActive(true)
    local cfg = Cfg.cfg_pet[self._petID]
    local uiView = self._eff:GetComponent(typeof(UIView))
    self:OnUIDepthChanged(self._depth)
    local en4 = uiView:GetUIComponent("UILocalizationText", "En4")
    local cn1 = uiView:GetUIComponent("UILocalizationText", "Cn1")
    local cn2 = uiView:GetUIComponent("UILocalizationText", "Cn2")
    local en6 = uiView:GetUIComponent("UILocalizationText", "En6")
    en4:SetText(StringTable.Get(cfg.NickName))
    cn1:SetText(StringTable.Get(cfg.Name))
    local lang = Localization.GetCurLanguage()
    if lang == LanguageType.jp then
      cn2:SetText(PetObtainHelper.InsertChar(StringTable.Get(cfg.ChinaTag), " "))
    else
      cn2:SetText(PetObtainHelper.InsertChar(StringTable.Get(cfg.ChinaTag), "  "))
    end
    en6:SetText(StringTable.Get(cfg.NickName))
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
    local logoMat = self:GetAsset(self._assetName.Logo)
    local tag = cfg.Tags[1]
    local mov
    local ym_logo_parent = uiView:GetGameObject("Logo_parent_ym")
    if tag == PetFilterType.YouMin then
      mov = uiView:GetUIComponent("VideoPlayer", "Mov_ym")
      local ym_logo = uiView:GetUIComponent("MeshRenderer", "Logo_ym")
      ym_logo.sharedMaterial:SetTexture("_MainTex", logoMat:GetTexture("_MainTex"))
      ym_logo_parent:SetActive(true)
    else
      mov = uiView:GetUIComponent("VideoPlayer", "Mov")
    end
    local url = HelperProxy:GetInstance():GetVideoUrl(videos[tag])
    if url == nil then
      url = HelperProxy:GetInstance():GetVideoUrl(videos[PetFilterType.QiGuang])
      Log.error("暂时找不到阵营视频，用启光代替：", tag)
    end
    mov.url = url
    mov:Prepare()
    mov.gameObject:SetActive(true)
    local mr = uiView:GetUIComponent("MeshRenderer", "Logo")
    mr.sharedMaterial:SetTexture("_MainTex", logoMat:GetTexture("_MainTex"))
    local width = UnityEngine.Screen.width
    local height = UnityEngine.Screen.height
    local canvasT = uiView:GetUIComponent("Transform", "Canvas")
    local scale = width / height / 1.77777
    canvasT.localScale = Vector3(scale, scale, scale)
    self._petObtain = uiView:GetUIComponent("UIView", "UIPetObtain")
    self:InitData()
    local tls = {}
    tls[#tls + 1] = EZTL_Wait:New(4033, "5星等4.033s")
    tls[#tls + 1] = EZTL_Callback:New(function()
      self._anim:Play("uieff_Card_PetObtain_6")
      self._petAudioModule:PlayPetAudio("Obtain", self._petID)
    end, "ui动效")
    for i = 1, 5 do
      local star = self._uiStars:GetChild(i - 1).gameObject
      star:SetActive(false)
      tls[#tls + 1] = EZTL_Callback:New(function()
        star:SetActive(true)
      end, "显示第" .. i .. "个星星")
      tls[#tls + 1] = EZTL_Wait:New(33, "等33ms")
    end
    self._matAnim:SetActive(false)
    if not self._pet:IsNew() then
      tls[#tls + 1] = EZTL_Callback:New(function()
        self._matAnim:SetActive(true)
      end, "播放重复获得材料动画")
    end
    tls[#tls + 1] = EZTL_Wait:New(500, "5星再等0.5s")
    self._tl = EZTL_Sequence:New(tls, "5星抽卡时间线1，串行")
    self._tl:Start()
    GameGlobal:TaskManager():StartTask(self._audioTask, self)
  end
end

function PetObtainAnim5Star:Update(dtMS)
  if self._state == ObtainAnimState.Playing then
    self._tl:Update(dtMS)
    if self._tl:Over() then
      self._state = ObtainAnimState.Finished
    end
  elseif self._state == ObtainAnimState.Prepare or self._state == ObtainAnimState.Ready then
    self:checkReady()
  end
end

function PetObtainAnim5Star:IsOver()
  return self._state == ObtainAnimState.Finished
end

function PetObtainAnim5Star:Dispose()
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
  if self._playerID1 then
    AudioHelperController.StopUISound(self._playerID1)
    self._playerID1 = nil
  end
  if self._playerID2 then
    AudioHelperController.StopUISound(self._playerID2)
    self._playerID2 = nil
  end
  if self._cacheAudioReady then
    AudioHelperController.ReleaseUISoundById(self._audioID1)
    AudioHelperController.ReleaseUISoundById(self._audioID2)
  end
  self._disposed = true
end

function PetObtainAnim5Star:InitData()
  self._cg_mid = self._petObtain:GetUIComponent("RawImage", "cgMid")
  self._cg_mid_rect = self._petObtain:GetUIComponent("RectTransform", "cgMid")
  self._spine = self._petObtain:GetUIComponent("SpineLoader", "spine")
  self._spineRect = self._petObtain:GetUIComponent("RectTransform", "spine")
  local spine = self:_GetSpine(self._pet)
  self._dcgHandle = DynamicCG.SyncLoad(spine, self._spine)
  UICG.SetTransform(self._spineRect, "UIPetObtain", spine)
  local staticBody = self:_GetStaticBody(self._pet)
  self._cg_mid.texture = self:GetAsset(self._assetName.CG):GetTexture("_MainTex")
  UICG.SetTransform(self._cg_mid_rect, "UIPetObtain_mid", staticBody)
end

function PetObtainAnim5Star:OnUIDepthChanged(depth)
  depth = depth * 10
  local uiView = self._eff:GetComponent(typeof(UIView))
  local cam = uiView:GetUIComponent("Camera", "Camera1")
  cam.depth = depth + 2
  cam = uiView:GetUIComponent("Camera", "Camera2")
  cam.depth = depth + 3
end

function PetObtainAnim5Star:_audioTask(TT)
  self._playerID1 = AudioHelperController.PlayRequestedUISound(self._audioID1)
  YIELD(TT, 300)
  if self._disposed then
    return
  end
  self._playerID2 = AudioHelperController.PlayRequestedUISound(self._audioID2)
end
