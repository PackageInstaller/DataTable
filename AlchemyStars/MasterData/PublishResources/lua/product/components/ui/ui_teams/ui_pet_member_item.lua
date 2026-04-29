_class("UIPetMemberItem", UICustomWidget)
UIPetMemberItem = UIPetMemberItem

function UIPetMemberItem:Constructor()
  self._heartItemInfo = nil
  self._heartItemData = nil
  self._maxStarLevel = 6
  self._index = 0
  self._slotId = 0
  self._height = 0
  self._callBack = nil
  self._dialLine2Hp = Cfg.cfg_global.UIWidgetBattlePet_dialLine2Hp.IntValue or 200
  self._bigDiaLine = Cfg.cfg_global.UIWidgetBattlePet_bigDiaLine.IntValue or 5
  self._eliminateIcons = {
    "bing_color",
    "huo_color",
    "sen_color",
    "lei_color"
  }
end

function UIPetMemberItem:OnShow()
  self._tryGo = self:GetGameObject("Try")
  self._tryGo:SetActive(false)
  self._firstPassGo = self:GetGameObject("FirstPass")
  self._firstPassGo:SetActive(false)
  self._lvPart = self:GetGameObject("LVPart")
  self._rawimage = self:GetUIComponent("RawImageLoader", "drawIcon")
  self._leaderGO = self:GetGameObject("leaderIcon")
  self._leaderCircleIconGO = self:GetGameObject("leaderCircleIcon")
  self._lvValueText = self:GetUIComponent("UILocalizationText", "lvValue")
  self._nameText = self:GetUIComponent("UILocalizationText", "name")
  self._imgLogo = self:GetUIComponent("RawImageLoader", "imgLogo")
  self._attrMain = self:GetUIComponent("Image", "attrMain")
  self._attrVice = self:GetUIComponent("Image", "attrVice")
  self._power = self:GetGameObject("power")
  self._powerValue = self:GetUIComponent("UILocalizationText", "powerValue")
  self._imgGrade = self:GetUIComponent("Image", "imgGrade")
  self._uiAtlas = self:RootUIOwner():GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
  self._petModule = GameGlobal.GameLogic():GetModule(PetModule)
  self.selfRect = self:GetGameObject().transform:GetComponent("RectTransform")
  self._guideWarnGO = self:GetGameObject("guidewarn")
  self._guideWarnGO:SetActive(false)
  self._guideWarnImage = self:GetUIComponent("Image", "guidewarn")
  self._guideWarnRect = self:GetUIComponent("RectTransform", "guidewarn")
  self._guideTxt1Rect = self:GetUIComponent("RectTransform", "guidetxt1")
  self._guideTxt2Rect = self:GetUIComponent("RectTransform", "guidetxt2")
  self._guideTxt1 = self:GetUIComponent("UILocalizationText", "guidetxt1")
  self._guideTxt2 = self:GetUIComponent("UILocalizationText", "guidetxt2")
  self._guideTxt1:SetText(StringTable.Get("str_guide_warn_level_speed"))
  self._guideTxt2:SetText(StringTable.Get("str_guide_warn_level_speed"))
  self._elementBg = self:GetUIComponent("RectTransform", "element")
  self._elementPos = self:GetUIComponent("RectTransform", "elementPos")
  self._detailBtnRect = self:GetGameObject("detailBtnRect")
  self._hp = self:GetGameObject("hp")
  self._hpvalue = self:GetUIComponent("Image", "hpvalue")
  self._hpUhp = self:GetUIComponent("UILocalizationText", "hpUhp")
  self._hpChp = self:GetUIComponent("UILocalizationText", "hpChp")
  self._hpvalueRect = self:GetUIComponent("RectTransform", "dialLines")
  self._dialLines = self:GetUIComponent("UISelectObjectPath", "dialLines")
  self._lostLand = self:GetGameObject("lostLand")
  self._recommend = self:GetGameObject("recommend")
  self._switchCount = self:GetGameObject("switchCount")
  self._switchCountTex = self:GetUIComponent("UILocalizationText", "switchCountTex")
  self._switchMask = self:GetGameObject("switchCountMask")
  self._uiDiff = self:GetUIComponent("UISelectObjectPath", "uiDiff")
  self._eliminateIcon = self:GetUIComponent("Image", "EliminateIcon")
  self._eliminateAreaObj = self:GetGameObject("EliminateArea")
  self._eliminatePowerObj = self:GetGameObject("eliminatePower")
  self._eliminatePowerValue = self:GetUIComponent("UILocalizationText", "eliminatePowerValue")
  self.atlasProperty = self:RootUIOwner():GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.PetDataChangeEvent, self.SetDataPet)
  self:AttachEvent(GameEventType.OnPetSkinChange, self.SetDataPet)
  self:AttachEvent(GameEventType.TeamMemberChanged, self.CheckEliminate)
end

function UIPetMemberItem:OnHide()
  self._hide = true
  self._heartItemInfo = nil
  self._heartItemData = nil
  self._callBack = nil
  self._rawimage = nil
  self._lvValueText = nil
  self._nameText = nil
  self._attrMain = nil
  self._attrVice = nil
  self._imgGrade = nil
  self._uiAtlas = nil
  self:DetachEvent(GameEventType.PetDataChangeEvent, self.SetDataPet)
end

function UIPetMemberItem:SetData(pstID, index, callBack, slotId, fromGuide)
  self._callBack = callBack
  self._fromGuide = fromGuide
  self._petPstID = pstID
  self._index = index
  self._slotId = slotId
  local module = self:GetModule(MissionModule)
  local ctx = module:TeamCtx()
  self._teamOpenerType = ctx.teamOpenerType
  self:SetDataPet()
end

function UIPetMemberItem:SMazeSetData(pet, detailCb)
  self._detailCb = detailCb
  self._heartItemInfo = pet
  self:RefreshEnhanceFlagArea(false)
  self._rawimage:LoadImage(self._heartItemInfo:GetPetTeamBody(PetSkinEffectPath.CARD_TEAM))
  self:ShowName()
  self:ShowLevel()
  self:ShowLogo()
  self:ShowElement()
  self:_SetStars()
  self:_SetEquipLv()
  self:_SetJobIcon()
  self:ShowLeaderMask()
  self:GetMazePower()
  self:GetLostLandRecommend()
  self:GetSwitchCount()
  self:ShowGrade()
  self:CheckGuideWarn()
  self:ShowPetDetailBtn()
  self:CheckEliminate(pet)
end

function UIPetMemberItem:GuideSetData(pet, fromGuide, slotId)
  self._slotId = slotId
  self._fromGuide = fromGuide
  local petInfo = pet
  if petInfo == nil then
    return
  end
  local oriPetInfo = petInfo
  local petInfo, isEnhanced = UIPetModule.ProcessSinglePetEnhance(oriPetInfo)
  if petInfo == nil then
    return
  end
  self:RefreshEnhanceFlagArea(isEnhanced)
  self._heartItemInfo = petInfo
  self._rawimage:LoadImage(petInfo:GetPetTeamBody(PetSkinEffectPath.CARD_TEAM))
  self:ShowName()
  self:ShowLevel()
  self:ShowLogo()
  self:ShowElement()
  self:_SetStars()
  self:_SetEquipLv()
  self:_SetJobIcon()
  self:ShowLeaderMask()
  self:GetMazePower()
  self:GetLostLandRecommend()
  self:GetSwitchCount()
  self:ShowGrade()
  self:CheckGuideWarn()
  self:ShowPetDetailBtn()
  self:CheckEliminate(petInfo)
end

function UIPetMemberItem:SetDataPet()
  if self._fromGuide then
    return
  end
  local petInfo = self._petModule:GetPet(self._petPstID)
  if petInfo == nil then
    if self._teamOpenerType == TeamOpenerType.Vampire then
      petInfo = UIN25VampireUtil.CreatePetData(self._petPstID)
      if petInfo == nil then
        return
      end
    else
      return
    end
  end
  local oriPetInfo = petInfo
  local petInfo, isEnhanced = UIPetModule.ProcessSinglePetEnhance(oriPetInfo)
  if petInfo == nil then
    return
  end
  self:RefreshEnhanceFlagArea(isEnhanced)
  self._heartItemInfo = petInfo
  self._rawimage:LoadImage(petInfo:GetPetTeamBody(PetSkinEffectPath.CARD_TEAM))
  self:ShowName()
  self:ShowLevel()
  self:ShowLogo()
  self:ShowElement()
  self:_SetStars()
  self:_SetEquipLv()
  self:_SetJobIcon()
  self:ShowLeaderMask()
  self:GetMazePower()
  self:GetLostLandRecommend()
  self:GetSwitchCount()
  self:ShowGrade()
  self:CheckGuideWarn()
  self:ShowPetDetailBtn()
  self:ShowUIDiff()
  if self._teamOpenerType == TeamOpenerType.Vampire then
    self._lvPart:SetActive(false)
    if UIN25VampireUtil.IsTryPet(self._heartItemInfo:GetTemplateID()) then
      self._tryGo:SetActive(true)
    else
      self._tryGo:SetActive(false)
    end
    if UIN25VampireUtil.PetCompleteFirstPass(self._heartItemInfo:GetTemplateID()) then
      self._firstPassGo:SetActive(true)
    else
      self._firstPassGo:SetActive(false)
    end
  end
  self:CheckEliminate()
end

function UIPetMemberItem:ShowUIDiff()
  self._teamItemDiff = self._uiDiff:SpawnObject("UITeamItemDiff")
  self._teamItemDiff:SetData(self._petPstID, self._teamOpenerType)
end

function UIPetMemberItem:ShowPetDetailBtn()
  if self._fromMaze then
  elseif self._fromGuide then
    local hpm = self:GetModule(HelpPetModule)
    local helpPetKey = hpm:UI_GetHelpPetKey()
    if 0 < helpPetKey and self._slotId == 5 then
      self._detailBtnRect:SetActive(true)
    else
      self._detailBtnRect:SetActive(false)
    end
  else
    self._detailBtnRect:SetActive(true)
  end
end

function UIPetMemberItem:GetSwitchCount()
  local hpm = self:GetModule(HelpPetModule)
  local helpPetKey = hpm:UI_GetHelpPetKey()
  local isHelp = false
  if 0 < helpPetKey and self._slotId == 5 then
    isHelp = true
  end
  local fromAir = self._teamOpenerType and self._teamOpenerType == TeamOpenerType.Air
  self._switchCount:SetActive(fromAir and not isHelp)
  if fromAir and not isHelp then
    local airModule = GameGlobal.GetModule(AircraftModule)
    local countMax = Cfg.cfg_aircraft_values[35].IntValue or 2
    local room = airModule:GetRoomByRoomType(AirRoomType.TacticRoom)
    local count = room:GetPetRemainFightNum(self._petPstID)
    local countStr = ""
    if count <= 0 then
      countStr = "<color=#f34141>" .. count .. "/" .. countMax .. "</color>"
    else
      countStr = count .. "<color=#f34141>/</color>" .. countMax
    end
    self._switchCountTex:SetText(countStr)
    self._switchMask:SetActive(count <= 0)
  end
end

function UIPetMemberItem:GetLostLandRecommend()
  local hpm = self:GetModule(HelpPetModule)
  local helpPetKey = hpm:UI_GetHelpPetKey()
  local isHelp = false
  if 0 < helpPetKey and self._slotId == 5 then
    isHelp = true
  end
  local fromLostLand = self._teamOpenerType and self._teamOpenerType == TeamOpenerType.LostLand
  self._lostLand:SetActive(fromLostLand and isHelp)
  if fromLostLand and isHelp then
    local UILostModule = GameGlobal.GetUIModule(LostAreaModule)
    local recommend = UILostModule:CheckPetRecommend(self._petPstID)
    self._recommend:SetActive(recommend)
  end
end

function UIPetMemberItem:GetMazePower()
  self._fromMaze = self._teamOpenerType == TeamOpenerType.Maze
  local mazeModule = GameGlobal.GetModule(MazeModule)
  if self._fromMaze and not mazeModule:IsPetActiveSkillUseLegendEnergy(self._petPstID) then
    self._power:SetActive(true)
    if mazeModule == nil then
      Log.fatal("[error] petCard --> mazeModule is nil !")
    end
    local powerCurrent, powerUpper = mazeModule:GetPetPower(self._petPstID)
    if powerCurrent < 0 then
      powerCurrent = powerUpper
    end
    self._powerValue:SetText(powerCurrent)
  else
    self._power:SetActive(false)
  end
  self._hp:SetActive(self._fromMaze)
  self._lvValueText.gameObject:SetActive(not self._fromMaze)
  if self._fromMaze then
    local mazePet = mazeModule:GetMazePetInfoByPstId(self._petPstID)
    local blood = mazePet.blood
    local upper = math.floor(mazeModule:GetCalPetMaxHp(self._petPstID))
    local hp = math.floor(blood * upper + 0.5)
    self._hpChp:SetText(hp)
    self._hpUhp:SetText(upper)
    local hpvaluewidth = self._hpvalueRect.sizeDelta.x
    local dialLineCount = math.ceil(upper / self._dialLine2Hp) - 1
    self._dialLines:SpawnObjects("UITeamPetMemberMazeHpDialLineItem", dialLineCount)
    local dialLines = self._dialLines:GetAllSpawnList()
    for i = 1, #dialLines do
      local posx = hpvaluewidth / upper * self._dialLine2Hp * i
      local middleImg = i % self._bigDiaLine == 0
      local show = hp > i * self._dialLine2Hp
      dialLines[i]:SetData(i, posx, middleImg, show)
    end
    self._hpvalue.fillAmount = blood
  end
end

function UIPetMemberItem:ShowName()
  if self._heartItemInfo == nil then
    return
  end
  self._nameText:SetText(StringTable.Get(self._heartItemInfo:GetPetName()))
end

function UIPetMemberItem:ShowLevel()
  local petLevel = self._heartItemInfo:GetPetLevel()
  self._lvValueText:SetText(petLevel)
end

function UIPetMemberItem:ShowLogo()
  if self._heartItemInfo == nil then
    return
  end
  self._imgLogo:LoadImage(self._heartItemInfo:GetPetLogo())
end

function UIPetMemberItem:ShowElement()
  if self._heartItemInfo == nil then
    return
  end
  local cfg_pet_element = Cfg.cfg_pet_element({})
  if cfg_pet_element then
    local _1stElement = self._heartItemInfo:GetPetFirstElement()
    if _1stElement then
      self._attrMain.gameObject:SetActive(true)
      self._attrMain.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[_1stElement].Icon))
    else
      self._attrMain.gameObject:SetActive(false)
    end
    local _2ndElement = self._heartItemInfo:GetPetSecondElement()
    if _2ndElement then
      self._attrVice.gameObject:SetActive(true)
      self._attrVice.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[_2ndElement].Icon))
    else
      self._attrVice.gameObject:SetActive(false)
    end
  end
end

function UIPetMemberItem:_SetStars()
  local obj = UIWidgetHelper.SpawnObject(self, "_stars", "UIPetIntimacyStarGroup")
  obj:SetData(self._heartItemInfo, 0.8, -5)
end

function UIPetMemberItem:_SetEquipLv()
  local obj = UIWidgetHelper.SpawnObject(self, "_equipLv", "UIPetEquipLvIcon")
  obj:SetData(self._heartItemInfo, true)
end

function UIPetMemberItem:_SetJobIcon()
  local obj = UIWidgetHelper.SpawnObject(self, "_jobIcon", "UIPetJobIcon")
  obj:SetData(self._heartItemInfo, 1)
end

function UIPetMemberItem:ShowLeaderMask()
  self._leaderGO:SetActive(self._slotId == 1)
  self._leaderCircleIconGO:SetActive(self._slotId == 1)
end

function UIPetMemberItem:ShowGrade()
  local petId = self._heartItemInfo:GetTemplateID()
  local petGradeLevel = self._heartItemInfo:GetPetGrade()
  self._imgGrade.sprite = self._uiAtlas:GetSprite(UIPetModule.GetAwakeSpriteName(petId, petGradeLevel))
end

function UIPetMemberItem:CheckGuideWarn()
  if not self._guideAtlas then
    self._guideAtlas = self:RootUIOwner():GetAsset("UIGuide.spriteatlas", LoadType.SpriteAtlas)
  end
  local missionModule = self:GetModule(MissionModule)
  local needMissionId = Cfg.cfg_guide_const.guide_team_mission.IntValue
  if not missionModule:IsPassMissionID(needMissionId) then
    return
  end
  local ctx = missionModule:TeamCtx()
  local _teamOpenerType = ctx.teamOpenerType
  local param = ctx.param
  local curNeedLevel = 0
  local needGradeLevel = 0
  local isTape = false
  if _teamOpenerType == TeamOpenerType.Air then
    isTape = true
  elseif _teamOpenerType == TeamOpenerType.Diff then
    isTape = false
  elseif param and type(param) == "table" and (param[2] == ECampaignMissionComponentId.ECampaignMissionComponentId_CamSimulator or param[2] == ECampaignMissionComponentId.ECampaignMissionComponentId_AircraftNormal or param[2] == ECampaignMissionComponentId.ECampaignMissionComponentId_SimulatorBlackfist or param[2] == ECampaignMissionComponentId.ECampaignMissionComponentId_AircraftBlackfist) then
    isTape = true
  end
  if _teamOpenerType == TeamOpenerType.Stage then
    local id = param
    local cfg = Cfg.cfg_waypoint[id]
    curNeedLevel = cfg and cfg.RecommendLV or 0
    needGradeLevel = cfg and cfg.RecommendAwaken or 0
  elseif isTape then
    local map = param[3]
    local cardid = map[ECampaignMissionParamKey.ECampaignMissionParamKey_CartridgePstId]
    local hardid = map[ECampaignMissionParamKey.ECampaignMissionParamKey_CSHardId]
    local itemModule = GameGlobal.GetModule(ItemModule)
    local item = itemModule:FindItem(cardid)
    local itemid = item:GetTemplateID()
    local cfg_item_cartridge = Cfg.cfg_item_cartridge[itemid]
    if not cfg_item_cartridge then
      Log.error("###[UIPetMemberItem] cfg_item_cartridge is nil ! id --> ", itemid)
    end
    local hardList = cfg_item_cartridge.HardID
    local idx = hardid
    for i = 1, #hardList do
      if hardList[i] == hardid then
        idx = i
        break
      end
    end
    if cfg_item_cartridge.RecommendAwaken and cfg_item_cartridge.RecommendAwaken[idx] then
      needGradeLevel = cfg_item_cartridge.RecommendAwaken[idx]
    end
    if cfg_item_cartridge.RecommendLV and cfg_item_cartridge.RecommendLV[idx] then
      curNeedLevel = cfg_item_cartridge.RecommendLV[idx]
    end
  elseif param and type(param) == "table" and param.SeasonOnceMission then
    local id = param[1]
    local cfg = Cfg.cfg_campaign_mission[id]
    curNeedLevel = cfg and cfg.RecommendLV or 0
    needGradeLevel = cfg and cfg.RecommendAwaken or 0
  elseif _teamOpenerType == TeamOpenerType.ResInstance then
    local module = GameGlobal.GetModule(ResDungeonModule)
    local instanceId = module:GetEnterInstanceId()
    local cfg = Cfg.cfg_res_instance_detail[instanceId]
    curNeedLevel = cfg and cfg.Lv or 0
    needGradeLevel = cfg and cfg.GradeLevel or 0
  elseif _teamOpenerType == TeamOpenerType.Tower then
    local layerID = ctx:GetTowerLayerID()
    local cfg = Cfg.cfg_tower_detail[layerID]
    local petGradeLevel = self._heartItemInfo:GetPetGrade()
    local petLevel = self._heartItemInfo:GetPetLevel()
    curNeedLevel = cfg.NeedLevel or 0
    needGradeLevel = cfg.NeedAwake or 0
    if 1 <= needGradeLevel - petGradeLevel or 3 <= curNeedLevel - petLevel then
    else
      self._guideWarnGO:SetActive(false)
      return
    end
  elseif _teamOpenerType == TeamOpenerType.Trail then
    local id = param
    local cfg = Cfg.cfg_waypoint[id]
    curNeedLevel = cfg and cfg.RecommendLV or 0
    needGradeLevel = cfg and cfg.RecommendAwaken or 0
  elseif _teamOpenerType == TeamOpenerType.Sailing then
    local id = param
    local cfg = Cfg.cfg_sailing_mission[id[2]]
    curNeedLevel = cfg and cfg.RecommendLV or 0
    needGradeLevel = cfg and cfg.RecommendAwaken or 0
  elseif _teamOpenerType == TeamOpenerType.Vampire then
    local cfg = Cfg.cfg_bloodsucker_mission[param[1]]
    curNeedLevel = cfg and cfg.RecomendLV or 0
    needGradeLevel = cfg and cfg.RecommendAwaken or 0
  elseif _teamOpenerType == TeamOpenerType.Campaign then
    local id = param[1]
    if param[4] and param[4][1] then
      curNeedLevel = param[4][2] or 0
      needGradeLevel = param[4][3] or 0
    else
      local cfg = Cfg.cfg_campaign_mission[id]
      curNeedLevel = cfg and cfg.RecommendLV or 0
      needGradeLevel = cfg and cfg.RecommendAwaken or 0
    end
  elseif _teamOpenerType == TeamOpenerType.Conquest then
    local missionId = param[1]
    local day = param[4]
    local cfg = Cfg.cfg_conquest_mission({MissionID = missionId, RandomID = day})
    curNeedLevel = cfg[1].RecomendLV
    needGradeLevel = cfg[1].RecommendAwaken
  elseif _teamOpenerType == TeamOpenerType.BlackFist then
    local missionId = param[1]
    local cfg = Cfg.cfg_blackfist_mission({MissionID = missionId})
    curNeedLevel = cfg[1].RecomendLV
    needGradeLevel = cfg[1].RecommendAwaken
  elseif _teamOpenerType == TeamOpenerType.Season then
    local id = param[1]
    if param[4] and param[4][1] then
      curNeedLevel = param[4][2] or 0
      needGradeLevel = param[4][3] or 0
    else
      local cfg = Cfg.cfg_season_mission[id]
      curNeedLevel = 0
      needGradeLevel = 0
    end
  else
    self._guideWarnGO:SetActive(false)
    return
  end
  local gradeLevel = self._heartItemInfo:GetPetGrade()
  if needGradeLevel < gradeLevel then
    self._guideWarnGO:SetActive(false)
  elseif gradeLevel == needGradeLevel then
    local minLevel = Cfg.cfg_guide_const.guide_team_min.IntValue
    local maxLevel = Cfg.cfg_guide_const.guide_team_max.IntValue
    local petLevel = self._heartItemInfo:GetPetLevel()
    if petLevel < curNeedLevel - minLevel and petLevel >= curNeedLevel - maxLevel then
      self:DoGuide(false)
    elseif petLevel < curNeedLevel - maxLevel then
      self:DoGuide(true)
    else
      self._guideWarnGO:SetActive(false)
    end
  else
    self:DoGuide(true)
  end
end

function UIPetMemberItem:DoGuide(yellow)
  self._guideWarnGO:SetActive(true)
  self:StartTask(function(TT)
    YIELD(TT)
    YIELD(TT)
    if self._hide then
      return
    end
    self._guideWarnRect.sizeDelta = Vector2(self.selfRect.sizeDelta.x, self._guideWarnRect.sizeDelta.y)
    if self._guideTxt1Rect.sizeDelta.x > 384 then
      self._guideWarnLength = self._guideTxt1Rect.sizeDelta.x
    else
      self._guideWarnLength = 384
    end
    self:GuideMove1()
    self:GuideMove2()
  end)
end

function UIPetMemberItem:GuideMove1()
  if self.t then
    self.t:Kill()
  end
  self._guideTxt1Rect.anchoredPosition = Vector2(self._guideWarnLength, 1)
  self.t = self._guideTxt1Rect:DOLocalMoveX(0, 6):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
    self:GuideMove1()
  end)
end

function UIPetMemberItem:GuideMove2()
  if self.t2 then
    self.t2:Kill()
  end
  self._guideTxt2Rect.anchoredPosition = Vector2(0, 1)
  self.t2 = self._guideTxt2Rect:DOLocalMoveX(-self._guideWarnLength, 6):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
    self:GuideMove2()
  end)
end

function UIPetMemberItem:btnDetailOnClick()
  if self._detailCb then
    self._detailCb()
    return
  end
  local hpm = self:GetModule(HelpPetModule)
  local helpPetKey = hpm:UI_GetHelpPetKey()
  if 0 < helpPetKey and self._slotId == 5 then
    local pet = hpm:UI_GetTeamMaxPet()
    self:ShowDialog("UIHelpPetInfoController", pet)
    return
  end
  if self._teamOpenerType == TeamOpenerType.Vampire then
    self:VampireShowPetInfo(self._petPstID)
  else
    local pstids = {}
    local module = self:GetModule(MissionModule)
    local ctx = module:TeamCtx()
    local teamid = ctx:GetCurrTeamId()
    local team = ctx:Teams()
    local temp_team = team.list[teamid]
    local pets = temp_team.pets
    for i = 1, #pets do
      local pstid = pets[i]
      if pstid ~= 0 then
        table.insert(pstids, pstid)
      end
    end
    self._petModule.uiModule:SetTeamPets(pstids)
    local petid = self._petModule:GetPet(self._petPstID):GetTemplateID()
    self:ShowDialog("UISpiritDetailGroupController", petid, self._fromMaze)
  end
end

function UIPetMemberItem:VampireShowPetInfo(curPetId)
  local customPetDatas = {}
  local module = self:GetModule(MissionModule)
  local ctx = module:TeamCtx()
  local teamid = ctx:GetCurrTeamId()
  local team = ctx:Teams()
  local temp_team = team.list[teamid]
  local pets = temp_team.pets
  local curData
  for i = 1, #pets do
    local petid = pets[i]
    if petid ~= 0 then
      local cfgs = Cfg.cfg_component_bloodsucker_pet_attribute({
        ComponentID = UIN25VampireUtil.GetComponentConfigId(),
        PetId = petid
      })
      local customPetData
      for _, cfg in pairs(cfgs) do
        local petData = MatchPetInfo:New()
        petData.pet_pstid = curPetId
        petData.awakening = cfg.Awakening
        petData.level = 1
        petData.grade = cfg.Grade
        petData.equip_lv = cfg.Equip
        petData.template_id = cfg.PetId
        petData.attack = cfg.Attack
        petData.max_hp = cfg.Hp
        petData.defense = cfg.Def
        customPetData = Pet:New(petData)
        
        function customPetData.IsShowBtnInfo()
          return true
        end
        
        function customPetData.GetBtnInfoCallback()
          GameGlobal.UIStateManager():ShowDialog("UIN25VampireTips")
        end
        
        function customPetData.GetBtnInfoName()
          return "N25_mcwf_btn6"
        end
        
        break
      end
      if curPetId == petid then
        curData = customPetData
      end
      table.insert(customPetDatas, customPetData)
    end
  end
  self._petModule.uiModule:SetTeamCustomPets(customPetDatas)
  self:ShowDialog("UISpiritDetailGroupController", curPetId, false, curData)
end

function UIPetMemberItem:CheckEliminate(petInfo)
  local missionModule = self:GetModule(MissionModule)
  local ctx = missionModule:TeamCtx()
  local teams = ctx:Teams()
  local teamOpenerType = ctx.teamOpenerType
  if teamOpenerType == TeamOpenerType.PopStarPro then
    local param = ctx.param
    local missionID = param[1]
    local cfg = Cfg.cfg_component_line_popstar_mission({MissionID = missionID})[1]
    local guideCfg = Cfg.cfg_mission_guide[missionID]
    local isEliminate, eliminateID
    if guideCfg then
      isEliminate, eliminateID = EliminateHelper.GuideCheckFetter(missionID, cfg.Fetters, petInfo:GetTemplateID())
    else
      local team = teams:Get(ctx.popStarTeamId):Clone()
      isEliminate, eliminateID = EliminateHelper.CheckFetter(cfg.Fetters, team.pets, self._petPstID)
    end
    if isEliminate then
      local eliminatePetCfg = Cfg.cfg_pet[eliminateID]
      self._eliminateAreaObj:SetActive(true)
      self._eliminateIcon.sprite = self.atlasProperty:GetSprite(self._eliminateIcons[eliminatePetCfg.FirstElement])
    else
      self._eliminateAreaObj:SetActive(false)
    end
  elseif teamOpenerType == TeamOpenerType.AniPopStar then
    local param = ctx.param
    local missionID = param[1]
    local seasonCfg = Cfg.cfg_anipop_season[param[4]]
    local fetterID = seasonCfg.FettersId
    local guideCfg = Cfg.cfg_mission_guide[missionID]
    local isEliminate, eliminateID
    local anipopModule = GameGlobal.GetModule(AnipopModule)
    if guideCfg then
      isEliminate, eliminateID = EliminateHelper.GuideCheckFetter(missionID, fetterID, petInfo:GetTemplateID())
    else
      local team = teams:Get(ctx.aniPopStarTeamId):Clone()
      isEliminate, eliminateID = EliminateHelper.CheckFetter(fetterID, team.pets, self._petPstID)
    end
    if isEliminate then
      local eliminatePetCfg = Cfg.cfg_pet[eliminateID]
      self._eliminateAreaObj:SetActive(true)
      self._eliminateIcon.sprite = self.atlasProperty:GetSprite(self._eliminateIcons[eliminatePetCfg.FirstElement])
    else
      self._eliminateAreaObj:SetActive(false)
    end
    local powerCurrent, powerUpper = anipopModule:GetPetPower(self._petPstID)
    if powerCurrent < 0 then
      powerCurrent = powerUpper
    end
    self._eliminatePowerValue:SetText(powerCurrent)
    local petMd = GameGlobal:GetInstance().GetModule(PetModule)
    local pet = petMd:GetPet(self._petPstID)
    local activeSkillID = pet:GetPetActiveSkill()
    local cfg = BattleSkillCfg(activeSkillID)
    self._eliminatePowerObj:SetActive(cfg.TriggerType ~= SkillTriggerType.LegendEnergy)
  else
    self._eliminatePowerObj:SetActive(false)
    self._eliminateAreaObj:SetActive(false)
  end
end

function UIPetMemberItem:recommendBtnOnClick(go)
  local module = self:GetModule(MissionModule)
  local ctx = module:TeamCtx()
  local missionid = ctx.param
  self:ShowDialog("UILostLandMissionInfoController", missionid)
end

function UIPetMemberItem:RefreshEnhanceFlagArea(isEnhanced)
  local flagGo = self:GetGameObject("EnhanceFlagArea")
  local flagSop = self:GetUIComponent("UISelectObjectPath", "EnhanceFlagArea")
  if not flagGo then
    return
  end
  flagGo:SetActive(isEnhanced)
  if isEnhanced then
    local flagWidget = flagSop:SpawnObject("UIPetEnhancedFlag")
  else
  end
end
