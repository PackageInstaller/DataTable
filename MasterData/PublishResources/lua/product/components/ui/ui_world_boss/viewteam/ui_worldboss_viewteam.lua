_class("UIWorldBossViewTeam", UIController)
UIWorldBossViewTeam = UIWorldBossViewTeam

function UIWorldBossViewTeam:Constructor()
end

function UIWorldBossViewTeam:LoadDataOnEnter(TT, res, uiParams)
  self._simpleRank = uiParams[1]
  self._teamInfo = uiParams[2]
  if self._simpleRank == nil or self._teamInfo == nil then
    res:SetSucc(false)
  end
end

function UIWorldBossViewTeam:OnShow(uiParams)
  self._uiWidget = self:GetUIComponent("RectTransform", "uiWidget")
  self._btnAnywhere = self:GetUIComponent("RectTransform", "btnAnywhere")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._playerHeadLoader = self:GetUIComponent("RawImageLoader", "playerHead")
  self._playerName = self:GetUIComponent("UILocalizationText", "playerName")
  self._playerId = self:GetUIComponent("UILocalizationText", "playerId")
  self._indexContent = self:GetUIComponent("UISelectObjectPath", "indexContent")
  self._teamContent = self:GetUIComponent("UISelectObjectPath", "teamContent")
  self._atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._atlasAwake = self:GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
  self._uiHeartItemAtlas = self:GetAsset("UIHeartItem.spriteatlas", LoadType.SpriteAtlas)
  self:EnterFullScreenBg(false)
  self:FlushSimple()
  self:CreateIndex()
  self:FlushIndex()
  self:DefaultIndex()
end

function UIWorldBossViewTeam:OnHide()
end

function UIWorldBossViewTeam:BtnAnywhereOnClick(go)
  self:EnterFullScreenBg(false)
end

function UIWorldBossViewTeam:BtnCloseOnClick(go)
  self:CloseDialog()
end

function UIWorldBossViewTeam:EnterFullScreenBg(isEnter)
  self._uiWidget.gameObject:SetActive(not isEnter)
  self._btnAnywhere.gameObject:SetActive(isEnter)
end

function UIWorldBossViewTeam:FlushSimple()
  local cfg_header = Cfg.cfg_role_head_image[self._simpleRank.head]
  if cfg_header then
    self._playerHeadLoader:LoadImage(cfg_header.Icon)
  else
    self._playerHeadLoader.gameObject:SetActive(false)
  end
  local loginModule = self:GetModule(LoginModule)
  local showId = loginModule:GetShowIdByPstId(self._simpleRank.pstid)
  self._playerName:SetText(self._simpleRank.nick)
  self._playerId:SetText(string.format("ID:%d", showId))
end

function UIWorldBossViewTeam:CreateIndex()
  self._dataIndexPool = {}
  for k, v in pairs(self._teamInfo.infos) do
    table.insert(self._dataIndexPool, k)
  end
  table.sort(self._dataIndexPool, function(a, b)
    return a < b
  end)
  self._widgetIndexPool = self._indexContent:SpawnObjects("UIWorldBossViewTeamIndex", #self._dataIndexPool)
end

function UIWorldBossViewTeam:FlushIndex()
  for k, v in pairs(self._dataIndexPool) do
    local ui = self._widgetIndexPool[k]
    ui:Flush(v)
  end
end

function UIWorldBossViewTeam:DefaultIndex()
  local index = self._dataIndexPool[1]
  self:SelectIndex(index)
end

function UIWorldBossViewTeam:SelectIndex(index)
  if self._selIndex == index then
    return
  else
    self._selIndex = index
  end
  for k, v in pairs(self._dataIndexPool) do
    local ui = self._widgetIndexPool[k]
    ui:SetSelected(v == index)
  end
  local petList = self._teamInfo.infos[index]
  self:FlushTeam(petList)
end

function UIWorldBossViewTeam:IndexOnClick(go, index)
  self:SelectIndex(index)
end

function UIWorldBossViewTeam:FlushTeam(petList)
  local widgetTeamPool = self._teamContent:SpawnObjects("UIWorldBossViewTeamPet", #petList)
  for k, v in pairs(petList) do
    local ui = widgetTeamPool[k]
    ui:SetData(v)
    ui:Flush(v)
  end
end

function UIWorldBossViewTeam:GetAtlasProperty()
  return self._atlasProperty
end

function UIWorldBossViewTeam:GetAtlasAwake()
  return self._atlasAwake
end

function UIWorldBossViewTeam:GetHeartItemAtlas()
  return self._uiHeartItemAtlas
end

_class("UIWorldBossViewTeamIndex", UICustomWidget)
UIWorldBossViewTeamIndex = UIWorldBossViewTeamIndex

function UIWorldBossViewTeamIndex:Constructor()
end

function UIWorldBossViewTeamIndex:OnShow(uiParams)
  self._txtNameSel = self:GetUIComponent("UILocalizationText", "txtNameSel")
  self._txtNameUnsel = self:GetUIComponent("UILocalizationText", "txtNameUnsel")
  self._uiSelected = self:GetUIComponent("RectTransform", "uiSelected")
  self._uiUnselected = self:GetUIComponent("RectTransform", "uiUnselected")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIWorldBossViewTeamIndex:OnHide()
end

function UIWorldBossViewTeamIndex:BtnOnClick(go)
  self:RootUIOwner():IndexOnClick(go, self._index)
end

function UIWorldBossViewTeamIndex:Flush(index)
  self._index = index
  local key = string.format("str_world_boss_n31_team_%d", self._index)
  local label = StringTable.Get(key)
  self._txtNameSel:SetText(label)
  self._txtNameUnsel:SetText(label)
  self:SetSelected(false)
end

function UIWorldBossViewTeamIndex:SetSelected(isChecked)
  self._uiSelected.gameObject:SetActive(isChecked)
  self._uiUnselected.gameObject:SetActive(not isChecked)
end

function UIWorldBossViewTeamIndex:PlayAnimation(animName)
  self._animation:Play(animName)
end

_class("UIWorldBossViewTeamPet", UICustomWidget)
UIWorldBossViewTeamPet = UIWorldBossViewTeamPet

function UIWorldBossViewTeamPet:Constructor()
end

function UIWorldBossViewTeamPet:OnShow(uiParams)
  self._nameText = self:GetUIComponent("UILocalizationText", "name")
  self._lvValueText = self:GetUIComponent("UILocalizationText", "lvValue")
  self._gradeIcon = self:GetUIComponent("Image", "grade")
  self._firstGo = self:GetGameObject("first")
  self._secondGo = self:GetGameObject("second")
  self._firstAttIcon = self:GetUIComponent("Image", "firstAttribute")
  self._secondAttribute = self:GetUIComponent("Image", "secondAttribute")
  self._rawDrawIcon = self:GetUIComponent("RawImageLoader", "drawIcon")
  self._qualityIcon = self:GetUIComponent("Image", "qualityIcon")
  self._logo = self:GetUIComponent("RawImageLoader", "logo")
  self._stars = self:GetUIComponent("UISelectObjectPath", "stars")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._equipLv = self:GetUIComponent("RectTransform", "_equipLv")
  self._openDetail = self:GetUIComponent("RectTransform", "openDetail")
  self._root = self:GetUIComponent("RectTransform", "root")
  self._diLayer = self:GetUIComponent("RectTransform", "diLayer")
  self._lvPart = self:GetUIComponent("RectTransform", "LVPart")
end

function UIWorldBossViewTeamPet:OnHide()
end

function UIWorldBossViewTeamPet:GetTemplateID()
  return self._petData.pet_template_id
end

function UIWorldBossViewTeamPet:GetPetFirstElement()
  return self._cfg_pet.FirstElement
end

function UIWorldBossViewTeamPet:GetPetSecondElement()
  if self._petData.grade >= self._cfg_pet.Element2NeedGrade and self._cfg_pet.SecondElement > 0 then
    return self._cfg_pet.SecondElement
  end
  return nil
end

function UIWorldBossViewTeamPet:GetPetGrade()
  return self._petData.grade
end

function UIWorldBossViewTeamPet:GetSkinId()
  local skinId = 1
  if self:GetPetGrade() == 0 then
    skinId = self._cfg_pet.SkinId
  else
    skinId = self._cfg_grade.SkinId
  end
  return skinId or 1
end

function UIWorldBossViewTeamPet:GetPetStar()
  return self._cfg_pet.Star
end

function UIWorldBossViewTeamPet:GetPetAwakening()
  return self._petData.awake
end

function UIWorldBossViewTeamPet:GetPetLogo()
  return self._cfg_pet.Logo
end

function UIWorldBossViewTeamPet:GetEquipLv()
  return self._petData.equip_level
end

function UIWorldBossViewTeamPet:GetEquipRefineLv()
  return self._petData.equip_refine_level
end

function UIWorldBossViewTeamPet:SetEquipLv()
  local obj = UIWidgetHelper.SpawnObject(self, "_equipLv", "UIPetEquipLvIcon")
  obj:SetData(self, true)
end

function UIWorldBossViewTeamPet:SetData(petData)
  self._petData = petData
  if petData.pet_template_id == nil or petData.pet_template_id == 0 then
    return
  end
  local cfg_pet = Cfg.cfg_pet[petData.pet_template_id]
  self._cfg_pet = cfg_pet
  self._cfg_grade = Cfg.cfg_pet_grade({
    PetID = self:GetTemplateID(),
    Grade = self:GetPetGrade()
  })
  if self._cfg_grade ~= nil then
    self._cfg_grade = self._cfg_grade[1]
  end
end

function UIWorldBossViewTeamPet:Flush(petData)
  if self._petData.pet_template_id == nil or self._petData.pet_template_id == 0 then
    self._root.gameObject:SetActive(false)
    return
  else
    self._root.gameObject:SetActive(true)
  end
  self._nameText:SetText(StringTable.Get(self._cfg_pet.Name))
  self._lvValueText:SetText(StringTable.Get("str_pet_config_level") .. self._petData.level)
  local atlasAwake = self:RootUIOwner():GetAtlasAwake()
  self._gradeIcon.sprite = atlasAwake:GetSprite(UIPetModule.GetAwakeSpriteName(self._petData.pet_template_id, self._petData.grade))
  local cfg_pet_element = Cfg.cfg_pet_element({})
  if cfg_pet_element ~= nil then
    local atlasProperty = self:RootUIOwner():GetAtlasProperty()
    local firstElement = self:GetPetFirstElement()
    local secondElement = self:GetPetSecondElement()
    local firstIcon = cfg_pet_element[firstElement].Icon
    local firstSpriteName = UIPropertyHelper:GetInstance():GetColorBlindSprite(firstIcon)
    self._firstAttIcon.sprite = atlasProperty:GetSprite(firstSpriteName)
    self._secondGo:SetActive(false)
    if secondElement ~= nil and 0 < secondElement then
      self._secondGo:SetActive(true)
      local secondIcon = cfg_pet_element[secondElement].Icon
      local secondSpriteName = UIPropertyHelper:GetInstance():GetColorBlindSprite(secondIcon)
      self._secondAttribute.sprite = atlasProperty:GetSprite(secondSpriteName)
    end
  end
  local skinEffectPath = PetSkinEffectPath.CARD_PET_LIST
  local petBody = HelperProxy:GetInstance():GetPetBody(self:GetTemplateID(), self:GetPetGrade(), self:GetSkinId(), skinEffectPath)
  if petBody ~= nil then
    self._rawDrawIcon:LoadImage(petBody)
  end
  local petStar = self:GetPetStar()
  local uiHeartItemAtlas = self:RootUIOwner():GetHeartItemAtlas()
  self._qualityIcon.sprite = uiHeartItemAtlas:GetSprite("map_biandui_pin" .. petStar)
  self._logo:LoadImage(self:GetPetLogo())
  self:SetEquipLv()
  if self._stars ~= nil then
    local petStar = self:GetPetStar()
    local awakenStep = self:GetPetAwakening()
    self._starSp1 = uiHeartItemAtlas:GetSprite("spirit_xing3_frame")
    self._starSp2 = uiHeartItemAtlas:GetSprite("spirit_xing2_frame")
    self._stars:SpawnObjects("UIHeartItemStar", petStar)
    local stars = self._stars:GetAllSpawnList()
    local awakenStartIndex = petStar - awakenStep
    for i = 1, #stars do
      local sp
      if i > awakenStartIndex then
        sp = self._starSp1
      else
        sp = self._starSp2
      end
      stars[i]:SetData(sp)
    end
  end
end

function UIWorldBossViewTeamPet:PlayAnimation(animName)
  self._animation:Play(animName)
end
