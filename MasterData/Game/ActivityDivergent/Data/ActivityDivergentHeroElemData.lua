local ActivityDivergentHeroElemData = class("ActivityDivergentHeroElemData")

function ActivityDivergentHeroElemData.CreateDivergentHeroElem(heroElemMsg)
  local heroElemData = ActivityDivergentHeroElemData.New()
  heroElemData._heroId = heroElemMsg.heroId
  heroElemData._fragGetDic = heroElemMsg.chipGet
  heroElemData._rewardStage = heroElemMsg.rewardStage
  heroElemData._rewardExp = heroElemMsg.rewardExp
  return heroElemData
end

function ActivityDivergentHeroElemData:GetDivergentHeroId()
  return self._heroId
end

function ActivityDivergentHeroElemData:GetDivergentHeroFragGetDic()
  return self._fragGetDic
end

function ActivityDivergentHeroElemData:GetDivergentHeroRewardStage()
  return self._rewardStage
end

function ActivityDivergentHeroElemData:GetDivergentHeroRewardExp()
  return self._rewardExp
end

return ActivityDivergentHeroElemData
