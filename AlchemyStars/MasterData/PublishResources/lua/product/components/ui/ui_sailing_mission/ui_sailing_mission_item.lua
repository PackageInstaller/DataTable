_class("UISailingPetItem", UICustomWidget)
UISailingPetItem = UISailingPetItem

function UISailingPetItem:Constructor()
  self._parent = nil
  self._pet_pstid = 0
  self._petGuide = nil
end

function UISailingPetItem:OnShow()
  self._headImage = self:GetUIComponent("RawImageLoader", "headImage")
  self._attribute1 = self:GetUIComponent("Image", "attribute1")
  self._attribute2 = self:GetUIComponent("Image", "attribute2")
end

function UISailingPetItem:OnHide()
end

function UISailingPetItem:Init(parent, pet_pstid)
  self._parent = parent
  self._pet_pstid = pet_pstid
  local petData
  if self._pet_pstid ~= nil then
    local petModule = GameGlobal.GetModule(PetModule)
    petData = petModule:GetPet(self._pet_pstid)
  end
  self:UpdatePetItem(petData)
end

function UISailingPetItem:InitGuide(parent, cfgGuide)
  self._parent = parent
  self._petGuide = cfgGuide
  local petData
  if self._petGuide ~= nil then
    local petIndo = pet_data:New()
    petIndo.template_id = self._petGuide[1]
    petIndo.level = self._petGuide[2]
    petIndo.grade = self._petGuide[3]
    petIndo.awakening = self._petGuide[4]
    petIndo.affinity_level = 1
    petIndo.current_skin = 0
    petData = Pet:New(petIndo)
  end
  self:UpdatePetItem(petData)
end

function UISailingPetItem:UpdatePetItem(petData)
  self._headImage.gameObject:SetActive(petData ~= nil)
  self._attribute1.gameObject:SetActive(petData ~= nil)
  self._attribute2.gameObject:SetActive(petData ~= nil)
  if petData ~= nil then
    self._headImage:LoadImage(petData:GetPetHead(PetSkinEffectPath.HEAD_ICON_CHAIN_SKILL_PREVIEW))
    self._parent:SetAtlasProperty(self._attribute1, petData:GetPetFirstElement())
    self._parent:SetAtlasProperty(self._attribute2, petData:GetPetSecondElement())
  end
end

_class("UISailingMissionItem", UICustomWidget)
UISailingMissionItem = UISailingMissionItem

function UISailingMissionItem:Constructor()
  self._inDraging = false
  self._luaIndex = 1
  self._cfgMission = nil
  self._infoMission = nil
end

function UISailingMissionItem:OnShow()
  self._clearImage = self:GetUIComponent("Image", "clearImage")
  self._unclearImage = self:GetUIComponent("Image", "unclearImage")
  self._txtMissionValue = self:GetUIComponent("UILocalizationText", "txtMissionValue")
  self._bossImage = self:GetUIComponent("RawImage", "bossImage")
  self._bossImageLoader = self:GetUIComponent("RawImageLoader", "bossImage")
  self._bossAttributeBg1 = self:GetUIComponent("Image", "bossAttributeBg1")
  self._bossAttribute = self:GetUIComponent("Image", "bossAttribute")
  self._bossAttributeBg2 = self:GetUIComponent("Image", "bossAttributeBg2")
  self._bossAttribute1 = self:GetUIComponent("Image", "bossAttribute1")
  self._bossAttribute2 = self:GetUIComponent("Image", "bossAttribute2")
  self._memLoaders = {}
  self._memLoaders[1] = self:GetUIComponent("UISelectObjectPath", "mem1Loader")
  self._memLoaders[2] = self:GetUIComponent("UISelectObjectPath", "mem2Loader")
  self._memLoaders[3] = self:GetUIComponent("UISelectObjectPath", "mem3Loader")
  self._memLoaders[4] = self:GetUIComponent("UISelectObjectPath", "mem4Loader")
  self._memLoaders[5] = self:GetUIComponent("UISelectObjectPath", "mem5Loader")
  self._btnMission = self:GetUIComponent("Button", "btnMission")
  local btnMissionEvent = UICustomUIEventListener.Get(self._btnMission.gameObject)
  self:AddUICustomEventListener(btnMissionEvent, UIEvent.Press, function(a)
    self:BtnMissionOnPress(a)
  end)
  self:AddUICustomEventListener(btnMissionEvent, UIEvent.BeginDrag, function(a)
    self:BtnMissionOnBeginDrag(a)
  end)
  self:AddUICustomEventListener(btnMissionEvent, UIEvent.Drag, function(a)
    self:BtnMissionOnDrag(a)
  end)
  self:AddUICustomEventListener(btnMissionEvent, UIEvent.EndDrag, function(a)
    self:BtnMissionOnEndDrag(a)
  end)
end

function UISailingMissionItem:OnHide()
end

function UISailingMissionItem:Init(luaIndex, cfg, infoMission)
  self._luaIndex = luaIndex
  self._cfgMission = cfg
  self._infoMission = infoMission
  self:UpdateMissionTitle()
  self:UpdateMissionStatus()
  self:UpdateBossAttribute()
  self:UpdateTeamPetList()
end

function UISailingMissionItem:HandleBtnMissionOnClick(TT, callback)
  self:Lock("UISailing_BtnMissionOnClick")
  YIELD(TT, 500)
  local uiOwner = self:RootUIOwner()
  local chapterID = uiOwner:GetChapterCfg().ID
  self:ShowDialog("UISailingLevelDetail", chapterID, self._cfgMission.ID)
  local challengeKey = UISailing:ChapterIDKey(chapterID)
  LocalDB.SetInt(challengeKey, 1)
  self:UnLock("UISailing_BtnMissionOnClick")
end

function UISailingMissionItem:BtnMissionOnClick(go)
  GameGlobal.TaskManager():StartTask(self.HandleBtnMissionOnClick, self)
end

function UISailingMissionItem:BtnMissionOnPress(eventData)
  self:RootUIOwner():MissionItemOnPress(self, eventData)
end

function UISailingMissionItem:BtnMissionOnBeginDrag(eventData)
  self._inDraging = true
  self:RootUIOwner():MissionItemOnBeginDrag(self, eventData)
end

function UISailingMissionItem:BtnMissionOnDrag(eventData)
  self._inDraging = true
  self:RootUIOwner():MissionItemOnDrag(self, eventData)
end

function UISailingMissionItem:BtnMissionOnEndDrag(eventData)
  self._inDraging = false
  self:RootUIOwner():MissionItemOnEndDrag(self, eventData)
end

function UISailingMissionItem:SetAtlasProperty(img, idProperty)
  local cfgSingle
  local cfg_pet_element = Cfg.cfg_pet_element({})
  if cfg_pet_element then
    cfgSingle = cfg_pet_element[idProperty]
  end
  if cfgSingle then
    img.gameObject:SetActive(true)
    local atlasProperty = self:RootUIOwner():GetAtlasProperty()
    img.sprite = atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfgSingle.Icon))
  else
    img.gameObject:SetActive(false)
  end
end

function UISailingMissionItem:UpdateMissionTitle()
  local missionTitle = StringTable.Get(self._cfgMission.MissionName)
  self._txtMissionValue:SetText(missionTitle)
end

function UISailingMissionItem:UpdateMissionStatus()
  local countPet = 0
  if self._infoMission ~= nil and self._infoMission.pet_list ~= nil then
    countPet = #self._infoMission.pet_list
  end
  local showClear = countPet == 5
  local showUnclear = countPet ~= 5
  self._clearImage.gameObject:SetActive(showClear)
  self._unclearImage.gameObject:SetActive(showUnclear)
end

function UISailingMissionItem:UpdateBossAttribute()
  self._bossImageLoader:LoadImage(self._cfgMission.BossDrawing)
  local localPosition = Vector2.zero
  local localScale = Vector3.one
  local transform = self._bossImage.transform
  local sizeDelta = transform.sizeDelta
  local bossDrawingSize = self._cfgMission.BossDrawingSize
  if bossDrawingSize ~= nil and 2 <= #bossDrawingSize then
    sizeDelta = Vector2(bossDrawingSize[1], bossDrawingSize[2])
  end
  local cfgBossTransform = self._cfgMission.BossTransform
  if cfgBossTransform ~= nil and 3 <= #cfgBossTransform then
    localPosition = Vector3(cfgBossTransform[1], cfgBossTransform[2], 0)
    localScale = Vector3(cfgBossTransform[3], cfgBossTransform[3], 1)
  end
  transform.sizeDelta = sizeDelta
  transform.localPosition = localPosition
  transform.localScale = localScale
  if self._cfgMission.BossAttribute2 == nil then
    self._bossAttributeBg1.gameObject:SetActive(true)
    self._bossAttributeBg2.gameObject:SetActive(false)
    self:SetAtlasProperty(self._bossAttribute, self._cfgMission.BossAttribute1)
  else
    self._bossAttributeBg1.gameObject:SetActive(false)
    self._bossAttributeBg2.gameObject:SetActive(true)
    self:SetAtlasProperty(self._bossAttribute1, self._cfgMission.BossAttribute1)
    self:SetAtlasProperty(self._bossAttribute2, self._cfgMission.BossAttribute2)
  end
end

function UISailingMissionItem:UpdateTeamPetList()
  local missionID = -1
  if self._infoMission ~= nil then
    missionID = self._infoMission.mission_id
  end
  local cfgBattlePetList
  local cfg_guide = Cfg.cfg_mission_guide({})[missionID]
  if cfg_guide ~= nil then
    cfgBattlePetList = cfg_guide.BattlePetList
  end
  if cfgBattlePetList ~= nil and #cfgBattlePetList == 5 then
    for i = 1, 5 do
      local uiPetItem = self._memLoaders[i]:SpawnObject("UISailingPetItem")
      uiPetItem:InitGuide(self, cfgBattlePetList[i])
    end
  else
    for i = 1, 5 do
      local uiPetItem = self._memLoaders[i]:SpawnObject("UISailingPetItem")
      local petId
      if self._infoMission ~= nil then
        petId = self._infoMission.pet_list[i]
      end
      uiPetItem:Init(self, petId)
    end
  end
end

function UISailingMissionItem:GetMissionCfg()
  return self._cfgMission
end

function UISailingMissionItem:GetGuideArea()
  return self:GetGameObject("team")
end
