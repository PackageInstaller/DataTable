local this = {}
local dungeonGroupTpl = L_GameTpl:getDungeonGroupTpl()
local _kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
local _gameConstTpl = L_GameTpl:getGameConstTpl()
local _kiboDuelChapterTpl = L_GameTpl:getKiBoDuelChapterTpl()
local _kiboDuelGroupTpl = L_GameTpl:getKiBoDuelGroupTpl()
local _leveTpl = L_GameTpl:getKiboDuelAreaLevelTpl()
local _skillTpl = L_GameTpl:getKiboDuelSkillTpl()
local _trialPetTpl = L_GameTpl:getTrialPetTpl()
local petTpl = L_GameTpl:getPetTpl()

function this:init()
  this.super.init(self)
  self.data = {
    curLevelIds = {},
    curRealUseFormationSlot = 1,
    curUseFormationSlot = 1,
    petDuelFormationGroupInfo = {},
    curArenaUseFormationSlot = 1,
    petDuelArenaFormationGroupInfo = {},
    petDuelRecordInfo = {},
    petDuelAreaInfo = {},
    curChallengeLevelId = 1001,
    curChallengeGroupId = 1001,
    lastChapterModeLevelId = nil,
    trialPetGuids = {},
    petExpInfo = {},
    curHeroGuid = 0,
    areaLvUpQueue = L_Struct.getQueue(),
    unlockSkills = {},
    curMapId = 0
  }
end

function this:getNPCLevelIds()
  if self.data.curLevelIds[self.data.curChallengeGroupId] then
    return self.data.curLevelIds[self.data.curChallengeGroupId]
  end
  self.data.curLevelIds[self.data.curChallengeGroupId] = {}
  for _, v in pairs(dungeonGroupTpl:getValue()) do
    if v.groupId == self.data.curChallengeGroupId then
      table.insert(self.data.curLevelIds[self.data.curChallengeGroupId], v.id)
    end
  end
  table.sort(self.data.curLevelIds[self.data.curChallengeGroupId], function(a, b)
    local TplA = dungeonGroupTpl:getTplById(a)
    local TplB = dungeonGroupTpl:getTplById(b)
    return dungeonGroupTpl:getDungeonGroupOrder(TplA) < dungeonGroupTpl:getDungeonGroupOrder(TplB)
  end)
  return self.data.curLevelIds[self.data.curChallengeGroupId]
end

function this:checkLevelUnlocked(levelId)
  local levelIds = self:getNPCLevelIds()
  for i = #levelIds, 1, -1 do
    if L_PetDuelStore:getIsSuccess(levelIds[i]) and (levelId == levelIds[i] or levelId == levelIds[i] + 1) then
      return true
    end
  end
  return levelIds[1] == levelId
end

function this:getDefaultSelectLevelId()
  local levelIds = self:getNPCLevelIds()
  for i = #levelIds, 1, -1 do
    if self:checkLevelUnlocked(levelIds[i]) then
      return levelIds[i]
    end
  end
  return levelIds[1]
end

function this:getPetDuelHeroSkills()
  local curLevelId = self:getCurChallengeLevelId()
  if not self.data.petDuelHeroSkillInfo[curLevelId] then
    return {}
  end
  return self.data.petDuelHeroSkillInfo[curLevelId].hero_skills or {}
end

function this:getCurPetDuelFormationSlot()
  if _kiBoDuelTpl:isKiboLock(self:getCurChallengeLevelId()) or self:getIsTrailPetLevel() then
    return L_Const.kiBoDuelBlockSlot
  end
  return self.data.curUseFormationSlot
end

function this:getIsTrailPetLevel()
  local trialPets = _kiBoDuelTpl:getKiboList(_kiBoDuelTpl:getTplById(self:getCurChallengeLevelId()))
  if 0 < #trialPets then
    return true
  else
    return false
  end
end

function this:setCurPetDuelFormationSlot(slotId)
  if _kiBoDuelTpl:isKiboLock(self:getCurChallengeLevelId()) then
    return
  end
  if slotId < 1 then
    slotId = 1
  end
  self.data.curUseFormationSlot = slotId
end

function this:getCurRealPetDuelFormationSlot()
  if _kiBoDuelTpl:isKiboLock(self:getCurChallengeLevelId()) then
    return L_Const.kiBoDuelBlockSlot
  end
  return self.data.curRealUseFormationSlot
end

function this:setCurRealPetDuelFormationSlot(slotId)
  if _kiBoDuelTpl:isKiboLock(self:getCurChallengeLevelId()) then
    return
  end
  self.data.curRealUseFormationSlot = slotId
end

function this:getPetDuelFormationGroupInfo(slotId)
  return self.data.petDuelFormationGroupInfo[slotId] or self:getDefaultKiboList(slotId)
end

function this:getDefaultKiboList(slotId)
  if not CS.Lens.Gameplay.Modules.BigWorld.Macro.IsKiboDuelSimulator then
    return {}
  end
  if self.data.petDuelFormationGroupInfo[slotId] then
    return self.data.petDuelFormationGroupInfo[slotId]
  end
  self.data.petDuelFormationGroupInfo[slotId] = {}
  local petUids = {}
  for i = 0, 7 do
    table.insert(petUids, {
      is_trial = false,
      id = 100 + i,
      guid = 100 + i
    })
    self.data.trialPetGuids[100 + i] = 100 + i
  end
  local skillData = C_KiboDuelSimulatorManager.instance.kiboDuelTeam.heroData.playerSkillList
  local skillList = {}
  for i = 0, 1 do
    table.insert(skillList, skillData[i])
  end
  self.data.petDuelFormationGroupInfo[slotId] = {
    slot = slotId,
    pet_guids = petUids,
    hero = C_KiboDuelSimulatorManager.instance.kiboDuelTeam.heroData:GetEntityId(),
    hero_skills = skillList,
    levelId = 1001,
    lockSlot = 0
  }
  return self.data.petDuelFormationGroupInfo[slotId]
end

function this:getArenaDefaultKiboList(slotId)
  if not CS.Lens.Gameplay.Modules.BigWorld.Macro.IsKiboDuelSimulator then
    return {}
  end
  if self.data.petDuelArenaFormationGroupInfo[slotId] then
    return self.data.petDuelArenaFormationGroupInfo[slotId]
  end
  self.data.petDuelArenaFormationGroupInfo[slotId] = {}
  local petUids = {}
  for i = 0, 7 do
    table.insert(petUids, {
      is_trial = false,
      id = 100 + i,
      guid = 100 + i
    })
    self.data.trialPetGuids[100 + i] = 100 + i
  end
  local skillData = C_KiboDuelSimulatorManager.instance.kiboDuelTeam.heroData.playerSkillList
  local skillList = {}
  for i = 0, 1 do
    table.insert(skillList, skillData[i])
  end
  self.data.petDuelArenaFormationGroupInfo[slotId] = {
    slot = slotId,
    pet_guids = petUids,
    hero = C_KiboDuelSimulatorManager.instance.kiboDuelTeam.heroData:GetEntityId(),
    hero_skills = skillList,
    levelId = 1001,
    lockSlot = 0
  }
  return self.data.petDuelArenaFormationGroupInfo[slotId]
end

function this:getPetDuelFormationPetGuids(slotId)
  local groupInfo = self:getPetDuelFormationGroupInfo(slotId)
  if groupInfo.pet_guids and #groupInfo.pet_guids > 0 then
    return groupInfo.pet_guids
  end
  local pet_guids = {}
  for i = 1, 8 do
    table.insert(pet_guids, {is_trial = false, id = 0})
  end
  return pet_guids
end

function this:getPetDuelFormationHeroGuid(slotId)
  local duelId = self:getCurChallengeLevelId()
  if C_KiboDuelSystemMgr:IsTrialDuel(duelId) then
    return self.data.curHeroGuid
  end
  local groupInfo = self:getPetDuelFormationGroupInfo(slotId)
  return groupInfo.hero or 0
end

function this:getPetDuelFormationHeroSkills(slotId)
  local groupInfo = self:getPetDuelFormationGroupInfo(slotId)
  return groupInfo.hero_skills or {}
end

function this:getCurPetDuelArenaFormationSlot()
  self.data.curArenaUseFormationSlot = C_PetDuelArenaManager.GetPetDuelArenaCurSlot()
  return self.data.curArenaUseFormationSlot
end

function this:setCurPetDuelArenaFormationSlot(slotId)
  if slotId < 1 then
    slotId = 1
  end
  self.data.curArenaUseFormationSlot = slotId
end

function this:getPetDuelArenaFormationGroupInfo(slotId)
  local info = C_PetDuelArenaManager.GetPetDuelArenaSlotFormationInfo(slotId)
  local petUids = {}
  for i = 0, info.pet_guids.Count - 1 do
    table.insert(petUids, {
      is_trial = info.pet_guids[i].isTrial,
      id = info.pet_guids[i].id or 0
    })
  end
  local heroSkills = {}
  for i = 0, info.hero_skills.Count - 1 do
    table.insert(heroSkills, {
      skill_id = info.hero_skills[i].skillId,
      skill_lv = info.hero_skills[i].skillLv,
      skill_slot = info.hero_skills[i].skillSlot,
      type = info.hero_skills[i].type
    })
  end
  self.data.petDuelArenaFormationGroupInfo[slotId] = {
    slot = info.slot,
    pet_guids = petUids,
    hero = info.hero,
    hero_skills = heroSkills,
    levelId = info.levelId,
    lockSlot = info.lockSlot
  }
  return self.data.petDuelArenaFormationGroupInfo[slotId] or self:getArenaDefaultKiboList(slotId)
end

function this:getPetDuelArenaFormationPetGuids(slotId)
  local groupInfo = self:getPetDuelArenaFormationGroupInfo(slotId)
  if groupInfo.pet_guids and #groupInfo.pet_guids > 0 then
    return groupInfo.pet_guids
  end
  local pet_guids = {}
  for i = 1, 8 do
    table.insert(pet_guids, {is_trial = false, id = 0})
  end
  return pet_guids
end

function this:getPetDuelArenaFormationHeroGuid(slotId)
  local duelId = self:getCurChallengeLevelId()
  if C_KiboDuelSystemMgr:IsTrialDuel(duelId) then
    return self.data.curHeroGuid
  end
  local groupInfo = self:getPetDuelArenaFormationGroupInfo(slotId)
  return groupInfo.hero or 0
end

function this:getPetDuelArenaFormationHeroSkills(slotId)
  local groupInfo = self:getPetDuelArenaFormationGroupInfo(slotId)
  return groupInfo.hero_skills or {}
end

function this:tmpSetPetDuelArenaFormationGroupInfo(slotId, petGuids, heroGuid, heroSkills, levelId, index)
  self.data.petDuelArenaFormationGroupInfo[slotId] = {
    slot = slotId,
    pet_guids = self:shallow_copy(petGuids),
    hero = heroGuid,
    hero_skills = heroSkills,
    levelId = levelId,
    lockSlot = index
  }
end

function this:shallow_copy(original)
  local copy = {}
  for k, v in pairs(original) do
    copy[k] = {
      is_trial = v.is_trial,
      id = v.id
    }
  end
  return copy
end

function this:getCurChallengeLevelId()
  return self.data.curChallengeLevelId
end

function this:getTrialPetLevel(level)
  if 0 < level then
    return level
  end
  local kiBoDuelCfg = _kiBoDuelTpl:getTplById(self.data.curChallengeLevelId)
  return _kiBoDuelTpl:getRecommendLevel(kiBoDuelCfg)
end

function this:setCurChallengeLevelId(levelId)
  self.data.curChallengeLevelId = levelId
end

function this:setActivityData(activityId, kiboDuleUid)
  self.data.activityId = activityId
  self.data.kiboDuleUid = kiboDuleUid
end

function this:getChapterChallengeSuccessSaveKey(chapterId)
  return string.format("%s_%s_%s", L_PlayerStore:getPlayerId(), "pageDuelChapterPass", chapterId)
end

function this:getModeChallengeSuccessSaveKey(modeId)
  return string.format("%s_%s_%s", L_PlayerStore:getPlayerId(), "pageDuelModeUnlock", modeId)
end

function this:getLastLevelIdSaveKey(modeId)
  if not modeId then
    return string.format("%s_%s", L_PlayerStore:getPlayerId(), "pageDuelLastChallengeLevelId")
  end
  return string.format("%s_%s_%s", L_PlayerStore:getPlayerId(), "pageDuelLastChallengeLevelId", modeId)
end

function this:getLastChapterModeLevelId()
  if not self.data.lastChapterModeLevelId then
    local modeInfo = _kiboDuelChapterTpl:getModeInfo(1)
    local chapterCfg = modeInfo[1]
    local chapterInfo = _kiboDuelGroupTpl:getChapterLevelInfo(_kiboDuelChapterTpl:getChapterId(chapterCfg))
    self.data.lastChapterModeLevelId = _kiboDuelGroupTpl:getLevelId(chapterInfo[1])
  end
  return self.data.lastChapterModeLevelId
end

function this:setLastChapterModeLevelId(levelId)
  self.data.lastChapterModeLevelId = levelId
end

function this:getCurChallengeGroupId()
  return self.data.curChallengeGroupId
end

function this:setCurChallengeGroupId(groupId)
  self.data.curChallengeGroupId = groupId
end

function this:getCurPetDuelFormationPetGuids()
  return self:getPetDuelFormationPetGuids(self:getCurPetDuelFormationSlot())
end

function this:getCurPetDuelFormationHeroGuid()
  return self:getPetDuelFormationHeroGuid(self:getCurPetDuelFormationSlot())
end

function this:getCurPetDuelFormationHeroSkills()
  return self:getPetDuelFormationHeroSkills(self:getCurPetDuelFormationSlot())
end

function this:getKiBoDuelLevelInfo(levelId)
  return self.data.petDuelRecordInfo[levelId] or {}
end

function this:getIsSuccess(levelId)
  local levelInfo = self:getKiBoDuelLevelInfo(levelId)
  if not table.isEmpty(levelInfo) then
    return not math.isEmpty(levelInfo.success_time)
  end
  return false
end

function this:getKiBoDuelStar(levelId)
  local levelInfo = self:getKiBoDuelLevelInfo(levelId)
  if not table.isEmpty(levelInfo) then
    return L_CommonUtil.numberToBool(levelInfo.star)
  end
  return {}
end

function this:getKiBoDuelNpcShow(levelId)
  local tpl = _kiBoDuelTpl:getTplById(levelId)
  local challengeTask = _kiBoDuelTpl:getChallenge(tpl)
  local tempStarData = self:getKiBoDuelStar(levelId)
  local count = 1
  for i, v in pairs(challengeTask) do
    if not tempStarData[count] then
      return false
    end
    count = count + 1
  end
  return true
end

function this:getKiBoDuelStarNum(levelId)
  local starNum = 0
  local starData = self:getKiBoDuelStar(levelId)
  if starData ~= nil then
    for j, k in pairs(starData) do
      if k then
        starNum = starNum + 1
      end
    end
  end
  return starNum
end

function this:getChallengeCount(levelId)
  local tpl = _kiBoDuelTpl:getTplById(levelId)
  local challenges = _kiBoDuelTpl:getChallenge(tpl)
  if challenges then
    return #challenges
  end
  return 0
end

function this:checkSkillCanUse(levelId, skillId)
  local kiBoDuelCfg = _kiBoDuelTpl:getTplById(levelId)
  local canUseSkillList = _kiBoDuelTpl:getSkillList(kiBoDuelCfg)
  return table.containsValue(canUseSkillList, skillId)
end

function this:getCanUseSkillNum()
  if not self.data.canUseSkillNum then
    self.data.canUseSkillNum = _gameConstTpl:getData("KIBO_DUEL_FORMATION_CHAR_SKILL_NUM", L_Const.GameTplType.int)
  end
  return self.data.canUseSkillNum
end

function this:getCanUseSkillPool()
  if not self.data.canUseSkillPool then
    self.data.canUseSkillPool = _skillTpl:getSkillIds()
  end
  return self.data.canUseSkillPool
end

function this:getDefaultSkillIds(levelId)
  local defaultSkillNum = self:getCanUseSkillNum()
  local skillPoolList = self:getCanUseSkillPool()
  local skillIds = {}
  local kiBoDuelCfg = _kiBoDuelTpl:getTplById(levelId)
  local canUseSkillList = _kiBoDuelTpl:getSkillList(kiBoDuelCfg)
  for _, skillId in ipairs(skillPoolList) do
    if table.containsValue(canUseSkillList, skillId) then
      table.insert(skillIds, skillId)
    end
    if defaultSkillNum <= #skillIds then
      break
    end
  end
  return skillIds
end

function this:getDefaultSkillInfos(levelId)
  local defaultSkillNum = self:getCanUseSkillNum()
  local skillPoolList = self:getCanUseSkillPool()
  local skillInfos = {}
  local kiBoDuelCfg = _kiBoDuelTpl:getTplById(levelId)
  local canUseSkillList = _kiBoDuelTpl:getSkillList(kiBoDuelCfg)
  local startIndex = 701
  for _, skillId in ipairs(skillPoolList) do
    if table.containsValue(canUseSkillList, skillId) then
      table.insert(skillInfos, {
        skill_id = skillId,
        skill_lv = 1,
        skill_slot = startIndex,
        type = L_Const.ModuleGamingType.MGT_KIBO_DUEL
      })
      startIndex = startIndex + 1
    end
    if defaultSkillNum <= #skillInfos then
      break
    end
  end
  return skillInfos
end

function this:checkChapterModeUnlock(modeId, bShowTips)
  local modeInfo = _kiboDuelChapterTpl:getModeInfo(modeId)
  local tpl = modeInfo[1]
  local isComplete, results, lockIndex = L_ConditionManager:isComplete(_kiboDuelChapterTpl:getCondition(tpl))
  if not bShowTips then
    return isComplete
  end
  if not isComplete then
    local results = L_ConditionManager:getDescs(_kiboDuelChapterTpl:getCondition(tpl))
    L_FlyMsgManager:showNormalMsg(results[lockIndex])
    return false
  end
  return true
end

function this:checkChapterUnlock(chapterId, bShowTips)
  local chapterCfg = _kiboDuelChapterTpl:getTplById(chapterId)
  local modeInfo = _kiboDuelChapterTpl:getModeInfo(_kiboDuelChapterTpl:getModeId(chapterCfg))
  local lastChapterInfo = modeInfo[_kiboDuelChapterTpl:getIndex(chapterCfg) - 1]
  if lastChapterInfo then
    for _, levelId in ipairs(_kiboDuelChapterTpl:getKiBoDuelGroupId(lastChapterInfo)) do
      if not self:getIsSuccess(levelId) then
        if bShowTips then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_petDuelStore_02"))
        end
        return false
      end
    end
  end
  local isComplete, results, lockIndex = L_ConditionManager:isComplete(_kiboDuelChapterTpl:getCondition(chapterCfg))
  if not bShowTips then
    return isComplete
  end
  if not isComplete then
    local results = L_ConditionManager:getDescs(_kiboDuelChapterTpl:getCondition(chapterCfg))
    L_FlyMsgManager:showNormalMsg(results[lockIndex])
    return false
  end
  return true
end

function this:checkChapterLevelUnlocked(levelId, bShowTips)
  local preCondition = _kiboDuelGroupTpl:getPreCondition(levelId)
  if not preCondition then
    return true
  end
  for _, v in ipairs(preCondition) do
    if not self:getIsSuccess(v) then
      if bShowTips then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_petDuelStore_01"))
      end
      return false
    end
  end
  return true
end

local _cellWidth = 200
local _cellHeight = 100
local _widthDelta = 100
local _heightDelta = 50
local _heightSize = 5
local _startFixWidth = 100
local _endFixWidth = 0

function this:getChapterLevelPos(levelId)
  local cfg = _kiboDuelGroupTpl:getTplById(levelId)
  local offset = _kiboDuelGroupTpl:getOffset(cfg)
  local x = (offset[1] - 1) * (_cellWidth + _widthDelta) + _startFixWidth
  local y = ((_heightSize + 1) / 2 - offset[2]) * (_cellHeight + _heightDelta)
  return C_Vector3(x, y, 0)
end

function this:getChapterContentWidth(chapterId)
  local chapterColMax = _kiboDuelGroupTpl:getChapterColMax(chapterId)
  return (chapterColMax - 1) * (_cellWidth + _widthDelta) + _cellWidth + _startFixWidth
end

function this:getChapterLevelCellWidth()
  return _cellWidth
end

function this:checkPetValid(pet, levelId)
  if pet.id <= 0 then
    return true
  end
  local kiBoDuelCfg = _kiBoDuelTpl:getTplById(levelId)
  if kiBoDuelCfg == nil then
    return true
  end
  local levelType = _kiBoDuelTpl:getLevelType(kiBoDuelCfg)
  local systemKiBoList = _kiBoDuelTpl:getKiboList(kiBoDuelCfg)
  if pet.is_trial and not table.indexOf(systemKiBoList, pet.id, 1) then
    return false
  end
  if levelType == L_Const.kiBoDuelLevelType.mix then
    return true
  end
  if pet.is_trial and levelType == L_Const.kiBoDuelLevelType.player then
    return false
  end
  if not pet.is_trial and levelType == L_Const.kiBoDuelLevelType.system then
    return false
  end
  return true
end

function this:getTrialPetGuid(id)
  return self.data.trialPetGuids[id]
end

local nameEnumList = {
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z"
}

function this:getPetName(data)
  local petInfo = {}
  local result = {}
  
  local function checkRepeat(cfgId, color, name)
    local repeatNum = 0
    if petInfo[cfgId] then
      if petInfo[cfgId][color] then
        for _, v in ipairs(petInfo[cfgId][color]) do
          if v.name == name then
            repeatNum = repeatNum + 1
          end
        end
        return repeatNum
      else
        return repeatNum
      end
    else
      return repeatNum
    end
  end
  
  for index, v in ipairs(data) do
    if v.id <= 0 then
      table.insert(result, string.empty)
    elseif v.is_trial then
      local trialPetCfg = _trialPetTpl:getTplById(v.id)
      local petCfgId
      if trialPetCfg == nil then
        petCfgId = v.id
      else
        petCfgId = _trialPetTpl:getTrialPet(trialPetCfg)
      end
      local name = _trialPetTpl:getTrialPetName(trialPetCfg)
      name = petTpl:getName(petTpl:getTplById(petCfgId))
      local repeatNum = checkRepeat(petCfgId, name)
      if 0 < repeatNum then
        if repeatNum == 1 then
          result[petInfo[petCfgId][1].index] = name .. nameEnumList[repeatNum]
        end
        local finalName = name .. nameEnumList[repeatNum + 1]
        table.insert(petInfo[petCfgId], {name = name, index = index})
        table.insert(result, finalName)
      else
        petInfo[petCfgId] = {}
        table.insert(petInfo[petCfgId], {name = name, index = index})
        table.insert(result, name)
      end
    else
      local petItem = L_PetStore:getPetItem(v.id)
      if not petItem then
        table.insert(result, string.empty)
      else
        local repeatNum = checkRepeat(petItem:petCfgId(), petItem:isSpecialPet(), petItem:getPetName())
        if 0 < repeatNum then
          if repeatNum == 1 then
            result[petInfo[petItem:petCfgId()][petItem:isSpecialPet()][1].index] = petItem:getPetName() .. nameEnumList[repeatNum]
          end
          local finalName = petItem:getPetName() .. nameEnumList[repeatNum + 1]
          table.insert(petInfo[petItem:petCfgId()][petItem:isSpecialPet()], {
            name = petItem:getPetName(),
            index = index
          })
          table.insert(result, finalName)
        else
          if petInfo[petItem:petCfgId()] then
            petInfo[petItem:petCfgId()][petItem:isSpecialPet()] = {}
          else
            petInfo[petItem:petCfgId()] = {}
            petInfo[petItem:petCfgId()][petItem:isSpecialPet()] = {}
          end
          table.insert(petInfo[petItem:petCfgId()][petItem:isSpecialPet()], {
            name = petItem:getPetName(),
            index = index
          })
          table.insert(result, petItem:getPetName())
        end
      end
    end
  end
  return result
end

function this:getRepeatPetParam(data)
  local cardRecord = {}
  local result = {}
  for i = 1, #data do
    local petCfgId = 0
    if data[i].is_trial then
      local trialPetCfg = _trialPetTpl:getTplById(data[i].id)
      petCfgId = _trialPetTpl:getTrialPet(trialPetCfg)
    else
      local petItem = L_PetStore:getPetItem(data[i].id)
      if petItem ~= nil then
        petCfgId = petItem:petCfgId()
      end
    end
    if petCfgId ~= 0 then
      if not cardRecord[petCfgId] then
        cardRecord[petCfgId] = true
        result[i] = false
      else
        result[i] = true
      end
    else
      result[i] = false
    end
  end
  return result
end

function this:checkRepeatKibo(data)
  if _gameConstTpl:getData("KIBO_DUEL_PVP_SAME_CARD", L_Const.GameTplType.int) == 1 then
    return false
  end
  local cardRecord = {}
  for i = 1, #data do
    local petCfgId = 0
    if data[i].is_trial then
      local trialPetCfg = _trialPetTpl:getTplById(data[i].id)
      petCfgId = _trialPetTpl:getTrialPet(trialPetCfg)
    else
      local petItem = L_PetStore:getPetItem(data[i].id)
      if petItem ~= nil then
        petCfgId = petItem:petCfgId()
      end
    end
    if petCfgId ~= 0 then
      if not cardRecord[petCfgId] then
        cardRecord[petCfgId] = true
      else
        return true
      end
    end
  end
  return false
end

function this:checkKiboRepeat(isTrial, petGuid, targetSlot, data)
  if _gameConstTpl:getData("KIBO_DUEL_PVP_SAME_CARD", L_Const.GameTplType.int) == 1 then
    return false
  end
  local _configId = 0
  if isTrial then
    _configId = petGuid
  else
    _configId = L_PetStore:getPetItem(petGuid):petCfgId()
  end
  for i = 1, #data do
    local petCfgId = 0
    if data[i].is_trial then
      local trialPetCfg = _trialPetTpl:getTplById(data[i].id)
      petCfgId = _trialPetTpl:getTrialPet(trialPetCfg)
    else
      local petItem = L_PetStore:getPetItem(data[i].id)
      if petItem ~= nil then
        petCfgId = petItem:petCfgId()
      end
    end
    if petCfgId ~= 0 and _configId == petCfgId and petGuid ~= data[i].id and targetSlot ~= i then
      return true
    end
  end
  return false
end

function this:calKiboDuelFormationCost(data)
  local cost = 0
  for i = 1, #data do
    local petCfgId = 0
    if data[i].is_trial then
      local trialPetCfg = _trialPetTpl:getTplById(data[i].id)
      petCfgId = _trialPetTpl:getTrialPet(trialPetCfg)
    else
      local petItem = L_PetStore:getPetItem(data[i].id)
      if petItem ~= nil then
        petCfgId = petItem:petCfgId()
      end
    end
    if petCfgId ~= 0 then
      cost = cost + L_PetStore:getPetOriginalCost(petCfgId)
    end
  end
  return cost
end

function this:checkCostCondition(data)
  local cost = self:calKiboDuelFormationCost(data)
  if cost > _gameConstTpl:getData("KIBO_DUEL_ARENA_MODE_COST_LIMIT", L_Const.GameTplType.int) then
    return true
  else
    return false
  end
end

function this:getPetNameBySlot(slotIndex)
  local result = self:getPetName(self:getCurPetDuelFormationPetGuids())
  return result[slotIndex]
end

function this:getPetExpInfo()
  return self.data.petExpInfo
end

function this:resetPetExpInfo()
  self.data.petExpInfo = {}
end

function this:isLockKiBo(formationSlotId, slotIndex)
  local info = self:getPetDuelFormationGroupInfo(formationSlotId)
  return slotIndex <= info.lockSlot
end

function this:getPetDuelAreaInfos()
  return self.data.petDuelAreaInfo
end

function this:getAreaInfo(areaType)
  return self.data.petDuelAreaInfo[areaType]
end

function this:getLevelUnLockSkill(areaType, level)
  local tpl = _leveTpl:getTpl(areaType, level)
  local skill = _leveTpl:getKiboDuelSkill(tpl)
  if not skill then
    return
  end
  local skillIds = {}
  local skillTpl
  for _, v in ipairs(skill) do
    skillTpl = _skillTpl:getTplById(v)
    if skillTpl then
      table.insert(skillIds, _skillTpl:getSkillId(skillTpl))
    end
  end
  return skillIds
end

function this:getAreaLevel(areaType)
  local info = self:getAreaInfo(areaType)
  return info and info:getlvl() or 1
end

function this:getAreaExp(areaType)
  local info = self:getAreaInfo(areaType)
  return info and info:getExp()
end

function this:getAreaCompleteLevel(areaType)
  local info = self:getAreaInfo(areaType)
  return info and info:getCompleteLvls()
end

function this:isGetAreaLevelReward(areaType)
  local levels = self:getAreaCompleteLevel(areaType)
  return not table.isEmpty(levels) or C_PetDuelArenaManager.GetHasRankReward()
end

function this:getAreaLevelStatus(areaType, level)
  local info = self:getAreaInfo(areaType)
  if not info then
    return L_Const.commonRewardStatus.notComp
  end
  return info:getLvlStatus(level)
end

function this:deQueueAreaLevelUpInfo()
  return self.data.areaLvUpQueue:deQueue()
end

function this:toNextAreaLevelUp()
  local options = self:deQueueAreaLevelUpInfo()
  if not options then
    return
  end
  Timer.once(1, function()
    L_UI:open("pageAreaLevelUpgrade", options)
  end)
end

function this:getAreaLevelRewardReddotKey(areaType, level)
  local key = table.concat({areaType, level}, "_")
  return string.format(L_ReddotManager.DotDef.kiBoDuelAreaLevel_Reward, key)
end

function this:isUnlockSkill(skillId)
  return self.data.unlockSkills[skillId] ~= nil
end

function this:getUnlockSkills()
  return self.data.unlockSkills
end

function this:isUnlockAreaLevel(levelId)
  local tpl = _kiBoDuelTpl:getTplById(levelId)
  local areaLevel = _kiBoDuelTpl:getAreaLevel(tpl)
  if math.isEmpty(areaLevel) then
    return true
  end
  local type = _kiBoDuelTpl:getAreaType(tpl)
  local level = self:getAreaLevel(type)
  return areaLevel <= level
end

function this:getAreaLevelRewards(areaType, level)
  local tpl = _leveTpl:getTpl(areaType, level)
  if not tpl then
    return false
  end
  local reward = _leveTpl:getReward(tpl)
  local rewards = L_DataUtil.parseRewardConfig(reward)
  if not rewards or #rewards == 0 then
    return false
  end
  local status = self:getAreaLevelStatus(areaType, level)
  local isReceived = status == L_Const.commonRewardStatus.got
  for _, v in ipairs(rewards) do
    v.isReceived = isReceived
  end
  return true, rewards
end

function this:resetAreaLevelRecordData()
  for _, areaData in pairs(self.data.petDuelAreaInfo) do
    areaData:resetRecordData()
  end
end

function this:getDefaultPetExpInfos()
  local petGuids = C_KiboDuelSystemMgr:GetPetGuids()
  local defaultPetExpInfos = {}
  local petItem, level, exp
  for i = 0, petGuids.Count - 1 do
    local data = petGuids[i]
    petItem = L_PetStore:getPetItem(data.guid)
    if petItem then
      level = petItem:petLv()
      exp = petItem:getExp()
      table.insert(defaultPetExpInfos, {
        guid = data.guid,
        oldLevel = level,
        nowLevel = level,
        oldExp = exp,
        nowExp = exp
      })
    end
  end
  return defaultPetExpInfos
end

function this:changePetDuelMode()
  L_PetDuelStore:call(L_PetDuelStore.event.changePetDuelMode)
end

function this:changePetDuelMap(mapId)
  self.data.curMapId = mapId
end

function this:getPetDuelMap()
  return self.data.curMapId
end

return this
