local this = class("nestcoopLevelTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getRecommendLv(tpl)
  return tpl.recommendLv
end

function this:getStarTier(tpl)
  return tpl.starTier
end

function this:getLevelType(tpl)
  return tpl.levelType
end

function this:getParam(tpl)
  return tpl.param
end

function this:getRewardShow(tpl)
  return tpl.RewardShow
end

function this:getMasterState(tpl)
  return tpl.masterState
end

function this:getPassiveSkillList(tpl)
  return tpl.passiveSkillList
end

function this:getShowSkill(tpl)
  return tpl.show_skill
end

function this:getRewardItem(tpl)
  return tpl.RewardItem
end

function this:getMinimumKibo(tpl)
  return tpl.minimumKibo
end

function this:getStarlinkKiboEmotion(tpl)
  return tpl.starlinkKiboEmotion
end

function this:getMainReward(tpl)
  return tpl.mainReward
end

function this:getStarLinkPowered(tpl)
  return tpl.starLinkPowered
end

function this:getDifficulty(tpl)
  return tpl.difficulty
end

function this:getHostReward(tpl)
  return tpl.hostReward
end

function this:getKiboTower(tpl)
  return tpl.kiboTower
end

function this:getEnemyLv(tpl)
  return tpl.EnemyLv
end

function this:getTrialRole(tpl)
  return tpl.trialRole
end

function this:getMvpReward(tpl)
  return tpl.mvpReward
end

function this:getStarLinkTimeLimit(tpl)
  return tpl.starLinkTimeLimit
end

function this:getShowPetDna(tpl)
  return tpl.show_pet_dna
end

function this:getEnemyID(tpl)
  return tpl.enemyID
end

function this:getHandList(tpl)
  return tpl.handList
end

function this:getFsm(tpl)
  return tpl.fsm
end

function this:getSkillList(tpl)
  return tpl.skillList
end

function this:getTask(tpl)
  return tpl.task
end

function this:getCostTime(tpl)
  return tpl.costTime
end

function this:getEnemyskill(tpl)
  return tpl.Enemyskill
end

function this:getIntroKiboEmotion(tpl)
  return tpl.introKiboEmotion
end

function this:getCost(tpl)
  return tpl.cost
end

function this:getId(tpl)
  return tpl.id
end

function this:getPassiveSkillListNumber(tpl)
  return tpl.passiveSkillListNumber
end

function this:getHpPercentage(tpl)
  return tpl.hpPercentage
end

function this:getChallengeReward(tpl)
  return tpl.challengeReward
end

function this:getSummonType(tpl)
  return tpl.summonType
end

function this:getStarlinkKiboAction(tpl)
  return tpl.starlinkKiboAction
end

function this:getKiboLockList(tpl)
  return tpl.kiboLockList
end

function this:getKiboLock(tpl)
  return tpl.kiboLock
end

function this:getKiboList(tpl)
  return tpl.kiboList
end

function this:getTime(tpl)
  return tpl.time
end

function this:getKiboDuelConfig(tpl)
  return tpl.kiboDuelConfig
end

function this:getEnemyPic(tpl)
  return tpl.enemyPic
end

function this:getSkillNumber(tpl)
  return tpl.skillNumber
end

function this:getTeamReward(tpl)
  return tpl.teamReward
end

return this
