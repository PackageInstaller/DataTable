local this = {}

function this:init()
  this.super.init(self)
end

function this:getFormationDataByType(fType)
  return AzurWorld.formationMgr:GetFormationGroupByType(fType)
end

function this:getFormationTeam(fType, formationIndex)
  formationIndex = formationIndex or self:getUsingTeamIndex(fType)
  return AzurWorld.formationMgr:GetFormation(fType, formationIndex)
end

function this:getUsingTeamIndex(fType)
  if AzurWorld.formationMgr:GetFormation(fType) then
    return AzurWorld.formationMgr:GetFormation(fType).index
  else
    return 1
  end
end

function this:getControl(fType)
  return AzurWorld.formationMgr:GetFormation(fType).mainControl
end

function this:getFormationPosData(fType, formationIndex)
  formationIndex = formationIndex or self:getUsingTeamIndex(fType)
  local formation = self:getFormationTeam(fType, formationIndex)
  if not formation then
    return {
      0,
      0,
      0
    }
  end
  local posData = formation.posData
  local res = {}
  for i = 0, posData.Count - 1 do
    if i < 3 or i == 3 and posData[3] ~= 0 then
      table.insert(res, posData[i])
    end
  end
  return res
end

function this:getAllPosData(formationType, formationIndex)
  local posData = L_FormationStore:getFormationPosData(formationType, formationIndex)
  local curPosData = {}
  for i, guid in ipairs(posData) do
    curPosData[i] = {
      hero_guid = guid,
      pet_guid = L_FormationStore:getFormationPosPetGuid(formationType, formationIndex, i)
    }
  end
  return curPosData
end

function this:getTeamHeroCount(formationType, formationIndex)
  formationIndex = formationIndex or self:getUsingTeamIndex(formationType)
  return AzurWorld.formationMgr:GetFormationHeroCount(formationType, formationIndex)
end

function this:getFormationName(formationType, formationIndex)
  formationIndex = formationIndex or self:getUsingTeamIndex(formationType)
  local formation = self:getFormationTeam(formationType, formationIndex)
  if not formation or formation and string.isEmpty(formation.formationName) then
    return L_WordsTpl:getValue(string.format("ui_formaiton_default_name_%s", formationIndex))
  end
  return formation.formationName
end

function this:getHeroPlaceInTeam(formationType, formationIndex, heorId)
  formationIndex = formationIndex or self:getUsingTeamIndex(formationType)
  return AzurWorld.formationMgr:GetHeroPlaceInFormation(formationType, formationIndex, heorId) + 1
end

function this:getPetPlaceInTeam(formationType, formationIndex, petGuid)
  if petGuid == 0 then
    return 0
  end
  formationIndex = formationIndex or self:getUsingTeamIndex(formationType)
  return AzurWorld.formationMgr:GetPetPlaceInFormation(formationType, formationIndex, petGuid) + 1
end

function this:getCurTeamValidHeroes(formationType)
  local posData = self:getFormationPosData(formationType)
  local res = {}
  for i, guid in ipairs(posData) do
    if not math.isEmpty(guid) then
      table.insert(res, guid)
    end
  end
  return res
end

function this:getFormationHeroHp(heroId)
  local hp_max = L_AttributeManager:getAttValueByHeroGuid(heroId, L_Const.battleAtt.MAXHP)
  local heroInfo = L_BattleStore:getObjBattleInfo(heroId)
  return heroInfo and heroInfo.hp or hp_max
end

function this:getFormationPosPetGuid(formationType, formationIndex, pos)
  return AzurWorld.formationMgr:GetPetByFormationPosIndex(formationType, formationIndex, pos - 1)
end

function this:getIsTrailFormation(formationType)
  return self:getUsingTeamIndex(formationType) == 0
end

function this:checkIsFullFormation(formationType)
  formationType = formationType or L_FormationManager:getCurFormationType()
  local heroGuidList = self:getCurTeamValidHeroes(formationType)
  return 3 <= #heroGuidList
end

function this:getAverageHeroLevelOfCurFormation(formationType)
  formationType = formationType or L_FormationManager:getCurFormationType()
  local heroGuidList = self:getCurTeamValidHeroes(formationType)
  local averageHeroLevel = 0
  local sumOfHeroLevel = 0
  for _, heroGuid in pairs(heroGuidList) do
    local hero = L_HeroStore:getHero(heroGuid)
    local heroLevel = L_HeroStore:getHeroLevel(hero)
    sumOfHeroLevel = sumOfHeroLevel + heroLevel
  end
  averageHeroLevel = sumOfHeroLevel / #heroGuidList
  return averageHeroLevel
end

function this:doAutoQuickFormation(selectPosData)
  local _petTpl = L_GameTpl:getPetTpl()
  local allHero = L_HeroStore:getAllHero()
  local hero_temp = {}
  for i, v in pairs(allHero) do
    local configData = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(v))
    local node, index = table.ipairsFind(selectPosData, function(value)
      return value.hero_guid == L_HeroStore:getHeroGuid(v)
    end)
    if not index then
      table.insert(hero_temp, {
        guid = L_HeroStore:getHeroGuid(v),
        configId = L_HeroStore:getHeroConfigId(v),
        lv = L_HeroStore:getHeroLevel(v),
        quality = configData.quality,
        petGuid = L_HeroStore:getHeroPetGuid(v),
        heroRank = v.heroRank,
        heroGrade = v.heroGrade
      })
    end
  end
  L_CommonUtil.multipleSortByKey(hero_temp, {
    "lv",
    "heroRank",
    "quality",
    "configId"
  })
  local insertIndex = 1
  local needPet = false
  local tempCount = #hero_temp
  for i, v in ipairs(selectPosData) do
    if math.isEmpty(v.hero_guid) and insertIndex <= tempCount then
      selectPosData[i].hero_guid = hero_temp[insertIndex].guid
      selectPosData[i].pet_guid = hero_temp[insertIndex].petGuid
      insertIndex = insertIndex + 1
    end
    if not math.isEmpty(selectPosData[i].hero_guid) and math.isEmpty(selectPosData[i].pet_guid) then
      needPet = true
    end
  end
  if needPet then
    local allPet = L_PetStore:getPetList()
    local pet_temp = {}
    for i, v in pairs(allPet) do
      local node, index = table.ipairsFind(selectPosData, function(value)
        return value.pet_guid == v.guid
      end)
      if not index then
        local status = v:getGameplayStatus()
        if status == L_Const.PetState.PET_NORMAL or status == L_Const.PetState.PET_RIDE or status == L_Const.PetState.PET_ROULETTE then
          local tpl = _petTpl:getTplById(v.id)
          table.insert(pet_temp, {
            guid = v.guid,
            isFree = status == L_Const.PetState.PET_NORMAL and 1 or 0,
            lv = v.lv,
            configId = v.id,
            grade = v.grade or 0,
            stage = tpl and _petTpl:getPetStage(tpl) or 0
          })
        end
      end
    end
    L_CommonUtil.multipleSortByKey(pet_temp, {
      "lv",
      "stage",
      "grade",
      "configId"
    })
    local insertIndex_pet = 1
    local tempCount_pet = #pet_temp
    for i, v in ipairs(selectPosData) do
      if not math.isEmpty(v.hero_guid) and math.isEmpty(v.pet_guid) and insertIndex_pet <= tempCount_pet then
        selectPosData[i].pet_guid = pet_temp[insertIndex_pet].guid
        insertIndex_pet = insertIndex_pet + 1
      end
    end
  end
end

function this:OpenBlackMask()
  local options = {}
  options.mode = L_Const.loadingMode.saveFormation
  
  function options.showCallback()
    C_UIMgr.OpenCutin(1, handler(self, self._onCutinEnd_saveWorldFormationClosePage))
  end
  
  L_LoadingManager:openSaveFormationLoading(options, function()
  end)
end

function this:_onCutinEnd_saveWorldFormationClosePage()
  L_UI:close("pageDungeonEntrustEntrance")
  local adapter = AzurWorld.playerMgr and AzurWorld.playerMgr.myPlayerUnitAdapter
  if adapter then
    adapter.pause = false
    adapter:ResumePlayerUnit(nil, true, true)
  end
  C_UIMgr.CloseCutin()
end

return this
