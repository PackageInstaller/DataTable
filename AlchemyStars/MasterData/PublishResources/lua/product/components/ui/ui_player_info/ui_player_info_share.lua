_class("UIPlayerInfoShare", UIController)
UIPlayerInfoShare = UIPlayerInfoShare

function UIPlayerInfoShare:Constructor()
  self._shareModule = self:GetModule(ShareModule)
  self._atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._atlas = self:GetAsset("UIPlayerInfo.spriteatlas", LoadType.SpriteAtlas)
  self._atlasAwake = self:GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
end

function UIPlayerInfoShare:OnShow(uiParams)
  self._infoData = uiParams[1]
  self:_GetComponents()
  self:_OnValue()
end

function UIPlayerInfoShare:OnHide()
  self._helpPetIcon = nil
end

function UIPlayerInfoShare:_GetComponents()
  self._background = self:GetUIComponent("RawImageLoader", "Background")
  self._missionProgressTex = self:GetUIComponent("UILocalizationText", "missionProgress")
  self._missionStarTex = self:GetUIComponent("UILocalizationText", "missionStar")
  self._petCountTex = self:GetUIComponent("UILocalizationText", "petCount")
  self._achievementPointTex = self:GetUIComponent("UILocalizationText", "achievementPoint")
  self._worldBossTex = self:GetUIComponent("UILocalizationText", "worldBossTex")
  self._worldBossTexObj = self:GetGameObject("worldBossTex")
  self._worldBossLevelTex = self:GetUIComponent("UILocalizationText", "worldBossLevelTex")
  self._worldBossIcon = self:GetUIComponent("RawImageLoader", "worldBossIcon")
  self._worldBossIconObj = self:GetGameObject("worldBossIcon")
  self._worldBossNode = self:GetUIComponent("RectTransform", "worldBossNode")
  self._sailingMissionTex = self:GetUIComponent("UILocalizationText", "sailingMissionTex")
  self._difficultyMissionTex = self:GetUIComponent("UILocalizationText", "difficultyMissionTex")
  self._tower_water = self:GetUIComponent("UILocalizationText", "tower_water")
  self._tower_fire = self:GetUIComponent("UILocalizationText", "tower_fire")
  self._tower_wood = self:GetUIComponent("UILocalizationText", "tower_wood")
  self._tower_thunder = self:GetUIComponent("UILocalizationText", "tower_thunder")
  self._helpPetGO = self:GetGameObject("helpPetGO")
  self._helppetholder = self:GetGameObject("helppetholder")
  self._friendhelppet = self:GetUIComponent("UISelectObjectPath", "friendhelppet")
  self._helpPetIcon = {}
  for i = 1, 4 do
    self._helpPetIcon[i] = {}
    self._helpPetIcon[i].go = self:GetGameObject("helppeticon" .. i)
    self._helpPetIcon[i].icon = self:GetUIComponent("RawImageLoader", "helppeticon" .. i)
    self._helpPetIcon[i].levelObj = self:GetGameObject("helppetlevelObj" .. i)
    self._helpPetIcon[i].level = self:GetUIComponent("UILocalizationText", "helppetlevel" .. i)
    self._helpPetIcon[i].awake = self:GetUIComponent("Image", "helppetawake" .. i)
    self._helpPetIcon[i].first = self:GetUIComponent("Image", "helppet" .. i .. "f")
    self._helpPetIcon[i].second = self:GetUIComponent("Image", "helppet" .. i .. "s")
  end
  self._noHelpTip = self:GetGameObject("noHelpTip")
  self._rank = self:GetGameObject("rank")
  self._rankTex = self:GetUIComponent("UILocalizationText", "rankTex")
  local medalWall = self:GetUIComponent("UISelectObjectPath", "medalWall")
  self._medalWall = medalWall:SpawnObject("UIMedalCard")
  self._medalWall:SetData(nil, true)
  self._playerInfoSwitchGo = self:GetGameObject("ScrollView")
end

function UIPlayerInfoShare:_OnValue()
  local icon
  if self._infoData.fifureUsed == 0 then
    local cfg = Cfg.cfg_item_fifure_extend({Order = 1})
    icon = cfg[1].PlayerInfoFifureIcon
  else
    icon = Cfg.cfg_item_fifure_extend[self._infoData.fifureUsed].PlayerInfoFifureIcon
  end
  self._background:LoadImage(icon)
  self:ShowScheduleInfo()
  self:RankValue()
  self:SetHelpPets()
end

function UIPlayerInfoShare:RankValue()
  local airModule = GameGlobal.GetModule(AircraftModule)
  local switchOpen = airModule:GetSwitchOpenState(16)
  self._rank:SetActive(switchOpen)
  if switchOpen then
    self._rankTex:SetText(self._infoData.rankValue)
  end
end

function UIPlayerInfoShare:ShowScheduleInfo()
  local currMissionID = self._infoData.currMissionID
  local cfg_mission = Cfg.cfg_mission[currMissionID]
  if cfg_mission then
    local cfgName = DiscoveryStage.GetStageIndexString(currMissionID)
    self._missionProgressTex:SetText(cfgName)
  else
    self._missionProgressTex:SetText("")
  end
  local star = self._infoData.star
  self._missionStarTex:SetText(star)
  local petCount = self._infoData.petCount
  self._petCountTex:SetText(petCount)
  local achievementPoint = self._infoData.achievementPoint
  local achievementPointAll = self._infoData.achievementPointAll
  self._achievementPointTex:SetText(achievementPoint .. "/" .. achievementPointAll)
  self._tower_water:SetText(string.format(StringTable.Get("str_tower_cur_layer"), self._infoData.towerWater))
  self._tower_fire:SetText(string.format(StringTable.Get("str_tower_cur_layer"), self._infoData.towerFire))
  self._tower_wood:SetText(string.format(StringTable.Get("str_tower_cur_layer"), self._infoData.towerWood))
  self._tower_thunder:SetText(string.format(StringTable.Get("str_tower_cur_layer"), self._infoData.towerThunder))
  local diffMiss = self._infoData.difficultyMission
  self._difficultyMissionTex:SetText(diffMiss)
  local sailingMission = self._infoData.sailingMission
  self._sailingMissionTex:SetText(sailingMission)
  local dan = self._infoData.dan
  local grading = self._infoData.grading
  local danName = UIWorldBossHelper.GetDanName(dan, grading)
  if UIWorldBossHelper.IsNoDan(dan, grading) then
    self._worldBossIconObj:SetActive(false)
    self._worldBossLevelTex:SetText(StringTable.Get(danName))
    self._worldBossTexObj:SetActive(false)
  else
    local badgeBase = UIWorldBossHelper.GetDanBadgeBase(dan, grading)
    self._worldBossIconObj:SetActive(true)
    self._worldBossIcon:LoadImage(badgeBase)
    self._worldBossLevelTex:SetText(StringTable.Get(danName))
    self._worldBossTexObj:SetActive(true)
    self._worldBossTex:SetText(grading)
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._worldBossNode)
end

function UIPlayerInfoShare:SetHelpPets()
  local module = self:GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_HelpPet)
  if isLock then
    self._helpPetGO:SetActive(false)
    self:StartTask(function(TT)
      self:Share(TT)
    end)
    return
  end
  self._helpPetGO:SetActive(true)
  self:StartTask(function(TT)
    local helpPetModule = self:GetModule(HelpPetModule)
    local res = helpPetModule:RequestHelpPet_SupportInfo(TT)
    if res:GetSucc() then
      local elements = {
        [1] = ElementType.ElementType_Blue,
        [2] = ElementType.ElementType_Red,
        [3] = ElementType.ElementType_Green,
        [4] = ElementType.ElementType_Yellow
      }
      local infos = {}
      for i = 1, #elements do
        local elem = elements[i]
        local info = helpPetModule:UI_FindSupportPet(elem)
        if info then
          table.insert(infos, info)
        end
      end
      if not self._helpPetIcon then
        return
      end
      local petModule = self:GetModule(PetModule)
      local showHelpPetCount = 4
      local noHelpPetCount = 0
      for i = 1, showHelpPetCount do
        local helpPetIcon = self._helpPetIcon[i]
        if helpPetIcon and infos[i] then
          helpPetIcon.go:SetActive(true)
          local tempId = infos[i] and infos[i].m_nTemplateID or 0
          local helpPetLevel = infos[i].m_nLevel
          local pet = petModule:GetPetByTemplateId(tempId)
          if pet then
            local grade = pet:GetPetGrade()
            local head = HelperProxy:GetInstance():GetPetHead(tempId, grade, pet:GetSkinId(), PetSkinEffectPath.HEAD_ICON_PLAYER_INFO_HELP)
            helpPetIcon.icon:LoadImage(head)
            helpPetIcon.icon.gameObject:SetActive(true)
            helpPetIcon.level:SetText("Lv." .. helpPetLevel)
            helpPetIcon.levelObj.gameObject:SetActive(true)
            self:ShowElement(helpPetIcon, pet)
            helpPetIcon.awake.gameObject:SetActive(true)
            local spriteName = UIPetModule.GetAwakeSpriteName(tempId, grade)
            helpPetIcon.awake.sprite = self._atlasAwake:GetSprite(spriteName)
          else
            helpPetIcon.icon.gameObject:SetActive(false)
            helpPetIcon.go:SetActive(false)
            helpPetIcon.awake.gameObject:SetActive(false)
            helpPetIcon.levelObj.gameObject:SetActive(false)
            helpPetIcon.first.gameObject:SetActive(false)
            helpPetIcon.second.gameObject:SetActive(false)
            noHelpPetCount = noHelpPetCount + 1
          end
        else
          helpPetIcon.go:SetActive(false)
          helpPetIcon.awake.gameObject:SetActive(false)
          helpPetIcon.first.gameObject:SetActive(false)
          helpPetIcon.second.gameObject:SetActive(false)
          helpPetIcon.levelObj.gameObject:SetActive(false)
          noHelpPetCount = noHelpPetCount + 1
        end
      end
      if noHelpPetCount == showHelpPetCount then
        self._helppetholder:SetActive(false)
        self._noHelpTip:SetActive(true)
      else
        self._helppetholder:SetActive(true)
        self._noHelpTip:SetActive(false)
      end
      self:Share(TT)
    end
  end)
end

function UIPlayerInfoShare:ShowElement(trans, pet)
  if pet == nil then
    return
  end
  local cfg_pet_element = Cfg.cfg_pet_element({})
  if cfg_pet_element then
    local firstElement = pet:GetPetFirstElement()
    if firstElement then
      trans.first.gameObject:SetActive(true)
      trans.first.sprite = self._atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[firstElement].Icon .. "_battle"))
    else
      trans.first.gameObject:SetActive(false)
    end
    local SecondElement = pet:GetPetSecondElement()
    if SecondElement then
      trans.second.gameObject:SetActive(true)
      trans.second.sprite = self._atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[SecondElement].Icon .. "_battle"))
    else
      trans.second.gameObject:SetActive(false)
    end
  end
end

function UIPlayerInfoShare:Share(TT)
  self:Lock("UIPlayerInfoShare")
  YIELD(TT)
  self:ShowDialog("UIShare", self:GetName(), nil, function()
    self:CloseDialog()
  end, nil, nil, nil, ShareSceneType.PlayerInfo)
  self:UnLock("UIPlayerInfoShare")
end
