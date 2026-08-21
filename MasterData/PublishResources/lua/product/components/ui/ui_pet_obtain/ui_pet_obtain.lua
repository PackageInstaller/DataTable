_class("UIPetObtain", UIController)
UIPetObtain = UIPetObtain

function UIPetObtain:OnShow(uiParams)
  self._useNewEft = true
  self._petModule = self:GetModule(PetModule)
  local pets = uiParams[1]
  if not pets then
    self:Close()
    return
  end
  self._isSkin = uiParams[4] or false
  local gotTimes = {}
  for idx, pet in ipairs(pets) do
    local id = pets[idx].assetid
    if gotTimes[id] then
      gotTimes[id] = gotTimes[id] + 1
    else
      gotTimes[id] = 1
    end
  end
  self._dropPets = {}
  for idx, pet in ipairs(pets) do
    local id = pet.assetid
    local petId = 0
    local skinId = 0
    local isNew = true
    if self._isSkin then
      skinId = id
      local curSkinCfg = Cfg.cfg_pet_skin[skinId]
      if curSkinCfg then
        petId = curSkinCfg.PetId
        local skinData = self._petModule:GetPetSkinsData(petId)
        if skinData and skinData.skin_info then
          for index, value in ipairs(skinData.skin_info) do
            if value.skin_id == skinId then
              isNew = false
            end
          end
        end
      end
    else
      petId = id
      isNew = not self._petModule:BeInSnapshoot(id)
    end
    self._dropPets[idx] = ObtainPet:New(petId, isNew, skinId, gotTimes[petId])
    gotTimes[petId] = gotTimes[petId] - 1
  end
  self._callback = uiParams[2]
  local skipAnim = uiParams[3]
  self._atlas = self:GetAsset("UIPetObtain.spriteatlas", LoadType.SpriteAtlas)
  self._element2Img = {
    [1] = "obtain_donghua_bing",
    [2] = "obtain_donghua_huo",
    [3] = "obtain_donghua_sen",
    [4] = "obtain_donghua_lei",
    [5] = "obtain_donghua_lei",
    [6] = "obtain_donghua_wu"
  }
  self._animName = "uieff_uipetobtain_eff"
  self._cgRoot = self:GetGameObject("cgRoot")
  self._cg_mid = self:GetUIComponent("RawImageLoader", "cgMid")
  self._cgRect = self:GetUIComponent("RectTransform", "cgNormal")
  self._cgNormal = self:GetUIComponent("MultiplyImageLoader", "cgNormal")
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._img = self:GetUIComponent("RawImage", "cgNormal")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._imgElement = self:GetUIComponent("Image", "imgElement")
  self._txtNameEn = self:GetUIComponent("UILocalizationText", "txtNameEn")
  self._txtNameEn2 = self:GetUIComponent("UILocalizationText", "txtNameEn2")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._sop = self:GetUIComponent("UISelectObjectPath", "stars")
  self._uiStars = self:GetUIComponent("Transform", "stars")
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self._anim = self:GetGameObject():GetComponent("Animation")
  self._bgEffRoot = self:GetUIComponent("Transform", "Center")
  self._nickName = self:GetUIComponent("UILocalizationText", "nickName")
  self._nickName2 = self:GetUIComponent("UILocalizationText", "nickName2")
  self._tagTex = self:GetUIComponent("UILocalizationText", "tagTex")
  self.matTip = self:GetUIComponent("UISelectObjectPath", "matTip")
  self._smallLogo = self:GetUIComponent("RawImageLoader", "smallLogo")
  self._logo = self:GetUIComponent("RawImageLoader", "logo")
  self._elementBg = self:GetUIComponent("Image", "elementBg")
  self._elementAreaGo = self:GetGameObject("elementBg")
  self._matBgRect = self:GetUIComponent("RectTransform", "matBgImage")
  self._btnSkip = self:GetGameObject("btnSkip")
  self._endBtn = self:GetGameObject("btnEnd")
  self._simpleEff = self:GetGameObject("Eff")
  self._bgCanvas = self:GetGameObject("BGCanvas")
  self._left = self:GetGameObject("Left")
  self._leftUp = self:GetGameObject("LeftUp")
  self._down = self:GetGameObject("Down")
  self._rightDown = self:GetGameObject("RightDown")
  self._rightDownCanvas = self:GetUIComponent("CanvasGroup", "RightDown")
  self._downCanvas = self:GetUIComponent("CanvasGroup", "Down")
  self._matAnim = self:GetGameObject("matBg")
  self._effLogo = self:GetUIComponent("RawImageLoader", "effLogo")
  self._effStars = self:GetUIComponent("Transform", "effStars")
  self._effStars.gameObject:SetActive(false)
  self._curIdx = 1
  self._skipped = false
  self:InitData()
  self._petAudioModule = self:GetModule(PetAudioModule)
  self._curAnim = nil
  self._spine.gameObject:SetActive(false)
  self._cgRoot:SetActive(true)
  self._anims = {}
  if #self._dropPets == 1 and skipAnim then
    self:GetGameObject("Eff"):SetActive(false)
    self:StartTask(function(TT)
      YIELD(TT)
      self._petAudioModule:PlayPetAudio("Obtain", self._dropPets[1]:PetID())
    end)
    if 0 >= self._dropPets[1]:SkinID() and 4 < self._dropPets[1]:Star() then
      self._cgRoot:SetActive(false)
      local spineName = self:_GetFirstSpineName()
      if not self._dcgHandle then
        self._dcgHandle = DynamicCG.SyncLoad(spineName, self._spine)
      else
        self._dcgHandle:ChangeDynamicCGSync(spineName)
      end
      local spineRect = self:GetUIComponent("RectTransform", "spine")
      UICG.SetTransform(spineRect, "UIPetObtain", spineName)
      self._spine.gameObject:SetActive(true)
    end
  else
    for i, pet in ipairs(self._dropPets) do
      self._anims[i] = self:getAnim(pet)
    end
    self._anims[1]:SetAsFirst()
    self._anims[1]:Prepare()
    self:PlayAnimation()
  end
  self._depth = self:GetDepth()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.OnUIDepthChanged)
end

function UIPetObtain:_GetFirstSpineName()
  local info = self._dropPets[1]
  if info then
    if info:SkinID() > 0 then
      local cfgv = Cfg.cfg_pet_skin[info:SkinID()]
      if cfgv then
        return cfgv.Spine
      end
    else
      local spine = HelperProxy:GetInstance():GetPetSpine(info:PetID(), 0, 0, PetSkinEffectPath.NO_EFFECT)
      if spine then
        return spine
      end
    end
  end
  return ""
end

function UIPetObtain:getAnim(pet)
  local star = Cfg.cfg_pet[pet:PetID()].Star
  if 6 <= star then
    return PetObtainAnim6Star:New(pet, self._anim, self._atlas, self._uiStars, self:GetDepth(), self._matAnim)
  elseif 5 <= star then
    return PetObtainAnim5Star:New(pet, self._anim, self._atlas, self._uiStars, self:GetDepth(), self._matAnim)
  elseif 3 <= star then
    return PetObtainAnimSimple:New(pet, self._anim, self._effStars, self._uiStars, self._matAnim)
  else
    return PetObtainAnimSimple:New(pet, self._anim, self._effStars, self._uiStars, self._matAnim)
  end
end

function UIPetObtain:OnHide()
  if self._curAnim then
    self._curAnim:Dispose()
    self._curAnim = nil
  end
  self._petAudioModule:StopAll()
end

function UIPetObtain:OnUpdate(dtMS)
  if self._curAnim and self._isPlaying then
    self._curAnim:Update(dtMS)
    if self._curAnim:IsOver() then
      if not self._skipped then
        self._btnSkip:SetActive(true)
      end
      self._endBtn:SetActive(true)
      self._isPlaying = false
    end
  end
end

function UIPetObtain:_GetStaticBody(obtainPet)
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
        Log.fatal("### [error] pet obtain get cf fail . id = [", obtainPet:PetID(), "]")
      end
    end
  end
  return ""
end

function UIPetObtain:_GetNickName(obtainPet)
  if obtainPet then
    if obtainPet:SkinID() > 0 then
      local cfgv = Cfg.cfg_pet_skin[obtainPet:SkinID()]
      if cfgv then
        return cfgv.SkinName
      end
    else
      local cfgv = Cfg.cfg_pet[obtainPet:PetID()]
      if cfgv then
        return cfgv.ChinaTag
      else
        Log.fatal("### [error] cfg_pet no pet. id = [", petId, "]")
      end
    end
  end
  return ""
end

function UIPetObtain:_GetSpine(obtainPet)
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

function UIPetObtain:InitData()
  local petAsset = self._dropPets[self._curIdx]
  if not petAsset then
    return false
  end
  local petId = petAsset:PetID()
  local cfgv = Cfg.cfg_pet[petId]
  if not cfgv then
    Log.fatal("### [error] cfg_pet no pet. id = [", petId, "]")
  end
  local staticBody = self:_GetStaticBody(petAsset)
  if staticBody then
    UICG.SetTransform(self._cgRect, self:GetName(), staticBody)
    self._cgNormal:Load(staticBody)
    self._cg_mid:LoadImage(staticBody)
    UICG.SetTransform(self._cg_mid.transform, self:GetName() .. "_mid", staticBody)
  else
    Log.fatal("### [error] pet [", petId, "] no StaticBody")
  end
  self:LoadElement(cfgv.FirstElement)
  self._logo:DestoryLastImage()
  self._logo:LoadImage(cfgv.Logo)
  self._effLogo:LoadImage(cfgv.Logo)
  self._txtNameEn:SetText(StringTable.Get(cfgv.EnglishName))
  self._txtNameEn2:SetText(StringTable.Get(cfgv.EnglishName))
  self._txtName:SetText(StringTable.Get(cfgv.Name))
  local txtDesc, cfg_pet_voice
  local cfgs = Cfg.cfg_pet_voice({
    PetID = petId,
    SkinID = petAsset:SkinID()
  })
  if cfgs and next(cfgs) then
    cfg_pet_voice = cfgs[1]
  else
    cfg_pet_voice = Cfg.cfg_pet_voice({PetID = petId, SkinID = nil})[1]
  end
  if cfg_pet_voice then
    if cfg_pet_voice.Obtain then
      local voiceID = cfg_pet_voice.Obtain[1][1]
      local cfg_audio = AudioHelperController.GetCfgAudio(voiceID)
      if cfg_audio then
        txtDesc = cfg_audio.Content
      else
        Log.fatal("###cfg_audio is nil ! id --> ", voiceID)
      end
    end
  else
    Log.fatal("###cfg_pet_voice is nil ! id --> ", petId)
  end
  if txtDesc then
    self._txtDesc:SetText(HelperProxy:GetInstance():ReplacePlayerName(StringTable.Get(txtDesc)))
  else
    self._txtDesc:SetText("")
  end
  local nickName = "\"" .. StringTable.Get(self:_GetNickName(petAsset)) .. "\""
  self._nickName:SetText(nickName)
  self._nickName2:SetText(nickName)
  local cfg_tag = Cfg.cfg_pet_tags[cfgv.Tags[1]]
  self._tagTex:SetText(StringTable.Get(cfg_tag.Name))
  if cfg_tag.Icon then
    self._smallLogo.gameObject:SetActive(true)
    self._smallLogo:LoadImage(cfg_tag.Icon)
  else
    self._smallLogo.gameObject:SetActive(false)
  end
  self._star = cfgv.Star or 0
  self.gambleModule = self:GetModule(GambleModule)
  if self.gambleModule and self.gambleModule:Context() then
    self.gambleModule:Context():SetMaxStarPetId(self._star, petId)
  end
  self._sop:SpawnObjects("UIEmptyWidget", self._star)
  local isDuplicate = not petAsset:IsNew()
  self.newGo = self:GetGameObject("new")
  if isDuplicate then
    self.newGo:SetActive(false)
    local awards = petAsset:ConvertItems()
    if 1 < #awards then
      self._matBgRect.anchoredPosition = Vector2(0, 0)
    else
      self._matBgRect.anchoredPosition = Vector2(130, 0)
    end
    local mats = self:GetUIComponent("UISelectObjectPath", "mats")
    mats:SpawnObjects("UIItemsWidgetSingle", #awards)
    local items = mats:GetAllSpawnList()
    for i = 1, #awards do
      local val = awards[i]
      items[i]:SetData(val.assetid, val.count, function(_id, pos)
        self:OnMatClick(_id, pos)
      end, UIItemScale.Level4)
    end
  else
    self.newGo:SetActive(true)
    self._matAnim:SetActive(false)
  end
  if self._isSkin then
    self._matAnim:SetActive(false)
    self._down:SetActive(false)
    self._rightDown:SetActive(false)
    self._elementAreaGo:SetActive(false)
    self._rightDownCanvas.alpha = 0
    self._downCanvas.alpha = 0
  end
end

function UIPetObtain:LoadElement(fstElement)
  local cfg_pet_element = Cfg.cfg_pet_element({})
  if not cfg_pet_element then
    return
  end
  if fstElement then
    self._imgElement.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[fstElement].IconWhite))
    self._elementBg.sprite = self._atlas:GetSprite(self._element2Img[fstElement])
  end
end

function UIPetObtain:PlayAnimation()
  if self._curAnim then
    self._curAnim:Dispose()
    self._curAnim = nil
  end
  self._endBtn:SetActive(false)
  self._curAnim = self._anims[self._curIdx]
  self._curAnim:Start()
  if self._curIdx + 1 <= #self._anims then
    self._anims[self._curIdx + 1]:Prepare()
  end
  local pet = self._dropPets[self._curIdx]
  self._btnSkip:SetActive(pet:CanSkip())
  self._isPlaying = true
end

function UIPetObtain:btnSkipOnClick(go)
  self._skipped = true
  local pets = {}
  local anims = {}
  for i = self._curIdx + 1, #self._dropPets do
    local pet = self._dropPets[i]
    if pet:CanSkip() then
      self._anims[i]:Dispose()
    else
      pets[#pets + 1] = pet
      anims[#anims + 1] = self._anims[i]
    end
  end
  if #pets == 0 then
    self:Close()
  else
    self._dropPets = pets
    self._anims = anims
    self._anims[1]:SetAsFirst()
    self._anims[1]:Prepare()
    self._curIdx = 1
    self:InitData()
    self:PlayAnimation()
  end
end

function UIPetObtain:btnEndOnClick(go)
  self._curIdx = self._curIdx + 1
  if self._curIdx > #self._dropPets then
    self:Close()
  else
    self:InitData()
    self:PlayAnimation()
  end
end

function UIPetObtain:Close()
  if self._callback then
    self._callback()
  end
end

function UIPetObtain:OnMatClick(matId, pos)
  if self.matTipWidget == nil then
    self.matTipWidget = self.matTip:SpawnObject("UISelectInfo")
  end
  self.matTipWidget:SetData(matId, pos)
end

function UIPetObtain:SkipAndShow()
end

function UIPetObtain:OnUIDepthChanged()
  local depth = self:GetDepth()
  if depth ~= self._depth then
    self._depth = depth
    for i = self._curIdx, #self._anims do
      self._anims[i]:OnUIDepthChanged(depth)
    end
  end
end

_class("ObtainPet", Object)
ObtainPet = ObtainPet

function ObtainPet:Constructor(id, isNew, skinId, times)
  self._petID = id
  self._skinID = skinId
  self._isNew = isNew
  if Cfg.cfg_pet[id] == nil then
    Log.exception("找不到星灵：", id)
  end
  self._star = Cfg.cfg_pet[id].Star
  self._viewData = UIDrawCardViewDataItem:New(id)
  self._viewData:SetDuplicate(not isNew, times)
end

function ObtainPet:PetID()
  return self._petID
end

function ObtainPet:SkinID()
  return self._skinID
end

function ObtainPet:IsNew()
  return self._isNew
end

function ObtainPet:Star()
  return self._star
end

function ObtainPet:CanSkip()
  local pet = GameGlobal.GetModule(PetModule):GetPetByTemplateId(self._petID)
  if pet:GetPetStar() == 3 or pet:GetPetStar() == 4 then
    return true
  end
  return not self._isNew
end

function ObtainPet:ConvertItems()
  return self._viewData:ConvertItems()
end
