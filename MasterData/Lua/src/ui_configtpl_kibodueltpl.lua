local this = class("kiboDuelTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getCostTime(tpl)
  return tpl.costTime
end

function this:getBehaviortree(tpl)
  return tpl.behaviortree
end

function this:getSkillBytesPath(tpl)
  return tpl.skillBytesPath
end

function this:getMasterState(tpl)
  return tpl.masterState
end

function this:getParam(tpl)
  local param = {}
  for i, v in ipairs(tpl.param) do
    param[i] = {
      v[1],
      v[2],
      v[3],
      v[4],
      v[5] > 0 and v[5] or tpl.recommendLevel
    }
  end
  return param
end

function this:getKiboList(tpl)
  return tpl.kiboList or {}
end

function this:getPassiveSkillList(tpl)
  return tpl.passiveSkillList
end

function this:getSkillNumber(tpl)
  return tpl.skillNumber
end

function this:getMinimumKibo(tpl)
  return tpl.minimumKibo
end

function this:getEnemy(tpl)
  local enemy = {}
  for _, v in ipairs(tpl.enemy) do
    enemy[v] = tpl.recommendLevel
  end
  return enemy
end

function this:getAnimName(tpl)
  return tpl.aniName
end

function this:getPassiveSkillListNumber(tpl)
  return tpl.passiveSkillListNumber
end

function this:getCost(tpl)
  return tpl.cost
end

function this:getFsm(tpl)
  return tpl.fsm
end

function this:getTime(tpl)
  return tpl.time
end

function this:getSkillList(tpl)
  return tpl.skillList
end

function this:getArt(tpl)
  return tpl.art
end

function this:getId(tpl)
  return tpl.id
end

function this:getSummoningArea(tpl)
  return tpl.summoningArea
end

function this:getNpcSpawnerID(tpl)
  return tpl.worldSpawnerId
end

function this:getIsRechallenge(tpl)
  return tpl.isRechallenge
end

function this:getRecommendLevel(tpl)
  return tpl.recommendLevel
end

function this:getWorldMapId(tpl)
  return tpl.worldMapId
end

function this:getNpcName(tpl)
  return L_Config:provider(tpl.npcName)
end

function this:getNpcTransOffset(tpl)
  if not tpl.npcInfo or not tpl.npcInfo[1] then
    return C_Vector3(0, 0, 0)
  end
  return C_Vector3(tpl.npcInfo[1][1] or 0, tpl.npcInfo[1][2] or 0, tpl.npcInfo[1][3] or 0)
end

function this:getNpcTransEuler(tpl)
  if not tpl.npcInfo or not tpl.npcInfo[2] then
    return C_Vector3(0, 0, 0)
  end
  return C_Vector3(tpl.npcInfo[2][1] or 0, tpl.npcInfo[2][2] or 0, tpl.npcInfo[2][3] or 0)
end

function this:getNpcTransScale(tpl)
  if not tpl.npcInfo or not tpl.npcInfo[3] then
    return C_Vector3(0, 0, 0)
  end
  return C_Vector3(tpl.npcInfo[3][1] or 0, tpl.npcInfo[3][2] or 0, tpl.npcInfo[3][3] or 0)
end

function this:getWorldAreaId(tpl)
  return tpl.worldAreaId
end

function this:getWorldBorthPos(tpl)
  return tpl.worldBorthPos
end

function this:getFirstLoot(tpl)
  return L_DataUtil.parseRewardConfig(tpl.firstLoot)
end

function this:getChallengeRewardShow(tpl)
  return L_DataUtil.parseRewardConfig(tpl.challengeRewardShow)
end

function this:getCommonReward(tpl)
  return L_DataUtil.parseRewardConfig(tpl.commonReward)
end

function this:getChallenge(tpl)
  return tpl.challenge
end

function this:getLevelType(tpl)
  return tpl.levelType
end

function this:getTrialRole(tpl)
  return tpl.trialRole
end

function this:getTask(tpl)
  return tpl.task
end

function this:getHandList(tpl)
  return tpl.handList
end

function this:getKiBoLock(tpl)
  return tpl.kiboLock
end

function this:getMapId(tpl)
  return tpl.mapId
end

function this:isKiboLock(levelId)
  local tpl = self:getTplById(levelId)
  if tpl == nil then
    return false
  end
  return not math.isEmpty(tpl.kiboLock)
end

function this:getKiBoLockList(tpl)
  return tpl.kiboLockList
end

function this:getAreaType(tpl)
  return tpl.areaType
end

function this:getAreaLevel(tpl)
  return tpl.areaLevel
end

function this:getLevelTalk(tpl)
  return L_Config:provider(tpl.levelTalk)
end

function this:getDuelMode(tpl)
  return tpl.duelMode
end

function this:getDuelModeShow(tpl)
  return tpl.duelModeShow
end

function this:getDungeonId(tpl)
  return tpl.dungeonId
end

function this:getAreaIcon(tpl)
  return tpl.areaIcon
end

function this:getAreaRankLevel(tpl)
  return tpl.areaRankLevel
end

return this
