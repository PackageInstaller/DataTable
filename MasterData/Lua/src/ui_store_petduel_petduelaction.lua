local this = {}
local _skillTpl = L_GameTpl:getKiboDuelSkillTpl()
local _kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
local _filterMarkTpl = L_GameTpl:getWorldFilterMarkTpl()

function this:req_setPetDuelFormation(slotId, petGuids, heroGuid, heroSkills, levelId, index, callback)
  local isSame = self:checkFormationChange(slotId, petGuids, heroGuid, heroSkills)
  if isSame then
    return
  end
  local data = {
    slot = slotId,
    pet_guids = petGuids,
    hero = heroGuid,
    hero_skills = heroSkills,
    duel_id = levelId,
    index = index
  }
  L_Net:sendMessage(MsgGenCode.CSProtoKiboDuelGroupInfoChange, data, function(rspData, errorCode)
    if 0 < errorCode then
      return
    end
    if callback then
      callback()
    end
  end)
end

function this:req_setPetDuelArenaFormation(slotId, petGuids, heroGuid, heroSkills, levelId, index, callback)
  local data = {
    type = L_Const.GroupManagerType.GMT_KIBODUEL_ARENA,
    group = {
      slot = slotId,
      pet_guids = petGuids,
      hero = heroGuid,
      hero_skills = heroSkills,
      duel_id = levelId,
      index = index
    }
  }
  L_Net:sendMessage(MsgGenCode.CSProtoKiboDuelGroupChange, data, function(rspData, errorCode)
    if 0 < errorCode then
      return
    end
    if callback then
      callback()
    end
  end)
end

function this:checkFormationChange(slotId, petGuids, heroGuid, heroSkills)
  local function normalizeTrialValue(val)
    return val == true
  end
  
  local curSaveFormationUids = self:getPetDuelFormationPetGuids(slotId)
  local isSame = true
  for i = 1, #petGuids do
    if normalizeTrialValue(curSaveFormationUids[i].is_trial) ~= normalizeTrialValue(petGuids[i].is_trial) or curSaveFormationUids[i].id ~= petGuids[i].id then
      isSame = false
      break
    end
  end
  if isSame and heroGuid ~= self:getPetDuelFormationHeroGuid(slotId) then
    isSame = false
  end
  if isSame then
    local curSaveFormationSkills = self:getPetDuelFormationHeroSkills(slotId)
    if #curSaveFormationSkills <= 0 then
      isSame = false
    else
      for i = 1, #curSaveFormationSkills do
        if curSaveFormationSkills[i].skill_id ~= heroSkills[i].skill_id then
          isSame = false
          break
        end
      end
    end
  end
  return isSame
end

function this:checkArenaFormationChange(slotId, petGuids, heroGuid, heroSkills)
  local function normalizeTrialValue(val)
    return val == true
  end
  
  local curSaveFormationUids = self:getPetDuelArenaFormationPetGuids(slotId)
  local isSame = true
  for i = 1, #petGuids do
    local savedPetId = curSaveFormationUids[i].id
    local isOwn = false
    if L_PetStore.isOwnPet then
      isOwn = L_PetStore:isOwnPet(savedPetId)
    else
      isOwn = L_PetStore:getPetItem(savedPetId) ~= nil
    end
    if 0 < savedPetId and not curSaveFormationUids[i].is_trial and not isOwn then
      savedPetId = 0
    end
    if normalizeTrialValue(curSaveFormationUids[i].is_trial) ~= normalizeTrialValue(petGuids[i].is_trial) or savedPetId ~= petGuids[i].id then
      isSame = false
      break
    end
  end
  if isSame and heroGuid ~= self:getPetDuelArenaFormationHeroGuid(slotId) then
    isSame = false
  end
  return isSame
end

function this:req_setPetCurDuelFormation(slotId, callback)
  local data = {u32 = slotId}
  L_Net:sendMessage(MsgGenCode.CSProtoKiboDuelSetCurGroup, data, function(rspData, errorCode)
    if 0 < errorCode then
      return
    end
    if callback then
      callback()
    end
  end)
end

function this:req_setPetCurDuelArenaFormation(slotId, callback)
  local data = {
    type = L_Const.GroupManagerType.GMT_KIBODUEL_ARENA,
    cur_group = slotId
  }
  L_Net:sendMessage(MsgGenCode.CSProtoSetKiboDuelCurGroup, data, function(rspData, errorCode)
    if 0 < errorCode then
      return
    end
    if callback then
      callback()
    end
  end)
end

function this:rsp_petDuelFightingInfoSync(data, errorCode)
  if not data or data.id == 0 then
    return
  end
end

function this:rsp_petDuelFormationData(data, errorCode)
  if not data then
    return
  end
  L_PetDuelStore:setCurRealPetDuelFormationSlot(data.use_slot or 0)
  L_PetDuelStore:setCurPetDuelFormationSlot(data.use_slot or 1)
  if data.groups then
    for _, v in ipairs(data.groups) do
      local petUids = {}
      if v.pet_guids then
        for _, v1 in ipairs(v.pet_guids) do
          table.insert(petUids, {
            is_trial = v1.is_trial,
            id = v1.id or 0
          })
        end
      end
      self.data.petDuelFormationGroupInfo[v.slot] = {
        slot = v.slot,
        pet_guids = petUids,
        hero = v.hero,
        hero_skills = v.hero_skills,
        levelId = v.duel_id,
        lockSlot = v.index
      }
    end
  end
  if data.records then
    for _, v in ipairs(data.records) do
      self.data.petDuelRecordInfo[v.id] = {
        id = v.id,
        star = v.star,
        success_time = v.success_time
      }
    end
    L_PetDuelStore:call(L_PetDuelStore.event.refresh_recordInfo)
  end
  self:updatePetDuelAreaInfo(data.area_infos)
  self:updateUnlockSkills(data.unlock_skills)
  L_PetDuelStore:call(L_PetDuelStore.event.refresh_formationInfo)
end

function this:updateUnlockSkills(unlockSkills)
  if unlockSkills then
    local tpl, skillId
    for _, id in ipairs(unlockSkills) do
      tpl = _skillTpl:getTplById(id)
      skillId = _skillTpl:getSkillId(tpl)
      if not self.data.unlockSkills[skillId] then
        L_ReddotManager:markNew(L_ReddotManager.DotDef.kiBoDuel_Skill_New, skillId)
      end
      self.data.unlockSkills[skillId] = id
    end
    L_PetDuelStore:call(L_PetDuelStore.event.refresh_unlockSkill)
  end
end

function this:updatePetDuelAreaInfo(areaInfos)
  if areaInfos then
    for _, v in ipairs(areaInfos) do
      local areaInfo = self.data.petDuelAreaInfo[v.id]
      if areaInfo == nil then
        areaInfo = require(L_R.store .. "petDuel.petDuelAreaInfoData").new()
        self.data.petDuelAreaInfo[v.id] = areaInfo
      end
      areaInfo:updateServerData(v)
    end
    L_PetDuelStore:call(L_PetDuelStore.event.refresh_areaInfo)
  end
end

function this:handAreaLevelUpgrade(areaInfo)
  local oldLv = areaInfo:getLastlvl()
  if not oldLv then
    return
  end
  local newLv = areaInfo:getlvl()
  if oldLv < newLv then
    local areaType = areaInfo:getId()
    local options = {
      areaType = areaType,
      fromLv = oldLv,
      toLv = newLv
    }
    self:handArealLevelUpgradeReddot(areaType, oldLv, newLv)
    local isInKiBoDuel = C_KiBoDuelLuaWrapper:IsInKiBoDuel()
    if not L_UI:checkPageOpen("pageAreaLevelUpgrade") and not L_UI:checkPageOpen("pagePetFinishDuel") and not L_UI:checkPageOpen("PageFailureKiboDuel") and not isInKiBoDuel then
      L_UI:open("pageAreaLevelUpgrade", options)
    else
      self.data.areaLvUpQueue:enQueue(options)
    end
    L_PetDuelStore:call(L_PetDuelStore.event.areaLevel_changed)
  end
end

function this:handArealLevelUpgradeReddot(areaType, oldLv, level)
  local list = _filterMarkTpl:getTplListByMarkType(L_MapConst.mapSievingType.kiboDuel)
  local levelId, _type, _level, _tpl
  local reddotMgr = L_ReddotManager
  for _, tpl in ipairs(list) do
    levelId = _filterMarkTpl:getParam(tpl)
    if levelId and levelId ~= 0 then
      _tpl = _kiBoDuelTpl:getTplById(levelId)
      _level = _kiBoDuelTpl:getAreaLevel(_tpl)
      _type = _kiBoDuelTpl:getAreaType(_tpl)
      if areaType == _type and oldLv < _level and level >= _level then
        reddotMgr:markNew(reddotMgr.DotDef.KiboDuel_NPC_New, levelId)
      end
    end
  end
end

function this:req_CSProtoKiboDuelBattleFinish(status, callback)
  local data = {status = status}
  L_Net:sendMessage(MsgGenCode.CSProtoKiboDuelBattleFinish, data, function(rspData, errorCode)
    if callback then
      callback()
    end
  end)
end

function this:req_CSProtoKiboDuelStart(duelId, callback)
  local data = {u32 = duelId}
  printLog("KIBODUEL_DEBUG:req_CSProtoKiboDuelStart", duelId)
  L_Net:sendMessage(MsgGenCode.CSProtoKiboDuelStart, data, function(rspData, errorCode)
    if 0 < errorCode then
      return
    end
    if callback then
      callback()
    end
  end)
end

function this:req_CSProtoKiboDuelQuit(callback)
  L_Net:sendMessage(MsgGenCode.CSProtoKiboDuelQuit, nil, function(rspData, errorCode)
    if callback then
      callback()
    end
  end)
end

function this:rsp_CSProtoKiboDuelAttrInfoSync(data)
  for _, info in ipairs(data.infos) do
    self.data.trialPetGuids[info.pet_guid.id] = info.pet_guid.guid
  end
  if data ~= nil and data.hero_info ~= nil then
    self.data.curHeroGuid = data.hero_info.hero_guid
  end
end

function this:rsp_CSProtoKiboDuelBattleFinish(data)
  if not data or not data.infos then
    return
  end
  self.data.petExpInfo = {}
  for _, info in ipairs(data.infos) do
    table.insert(self.data.petExpInfo, {
      guid = info.pet_guid,
      oldLevel = info.old_lv,
      nowLevel = info.now_lv,
      oldExp = info.old_exp,
      nowExp = info.now_exp
    })
  end
  printf("self.data.petExpInfo", self.data.petExpInfo)
end

function this:req_CSProtoKiboRealStart(callback)
  L_Net:sendMessage(MsgGenCode.CSProtoKiboRealStart, nil, function(rspData, errorCode)
    if callback then
      callback()
    end
  end)
end

function this:req_CSProtoKiboDuelGetGroup(levelId, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoKiboDuelGetGroup, {u32 = levelId}, function(rspData, errorCode)
    if callback then
      callback()
    end
  end)
end

function this:req_CSProtoKiboDuelGetAreaRearwd(areaType, level, callback)
  local data = {area = areaType, lvl = level}
  L_Net:sendMessage(MsgGenCode.CSProtoKiboDuelGetAreaReward, data, function(rspData, errorCode)
    local rewards = rspData.rewards
    if errorCode == L_Const.errorCode.ErrCodeSucc and not table.isEmpty(rewards) then
      L_RewardManager:showPage(rewards, rspData.src)
    end
    if callback then
      callback()
    end
  end)
end

function this:SyncChangePetDuelMap(mapId)
  self.data.curMapId = mapId
  L_PetDuelStore:call(L_PetDuelStore.event.changePetDuelMap)
end

function this:req_CSProtoStartMatch(dungeonId, callback)
  local data = {dungeon_id = dungeonId}
  L_Net:sendMessage(MsgGenCode.CSProtoStartMatch, data, function(rspData, errorCode)
    if 0 < errorCode then
      return
    end
    if data ~= nil then
    end
    if callback then
      callback()
    end
  end)
end

function this:req_CSProtoStopMatch(callback)
  L_Net:sendMessage(MsgGenCode.CSProtoStopMatch, nil, function(rspData, errorCode)
    if 0 < errorCode then
      return
    end
    if callback then
      callback()
    end
  end)
end

function this:req_CSProtoMultiCampaignCreate(dungeonId, callback)
  local data = {dungeon_id = dungeonId}
  L_Net:sendMessage(MsgGenCode.CSProtoMultiCampaignCreate, data, function(rspData, errorCode)
    if 0 < errorCode then
      return
    end
    if callback then
      callback()
    end
  end)
end

return this
