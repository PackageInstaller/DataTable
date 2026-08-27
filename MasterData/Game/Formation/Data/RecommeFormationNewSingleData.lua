local RecommeFormationSingleData = class("RecommeFormationSingleData")

function RecommeFormationSingleData:ctor()
end

function RecommeFormationSingleData:SetRecommeSinglePara(isDungeon, stageId)
  self._isDungeon = isDungeon
  self._stageId = stageId
end

function RecommeFormationSingleData:InitRecommeSingleData(data, rank)
  self.winCount = data.winCount
  self.power = data.data.power
  self.rank = rank
  self.recommanHeroList = {}
  self:GenHeroList(data.data.heroIds)
  self._rankFairyElem = data.data and data.data.fairy
end

function RecommeFormationSingleData:GenHeroList(heroIds)
  local heroList = CommonUtil.SplitStrToNumber(heroIds, "_")
  for i = 1, #heroList do
    table.insert(self.recommanHeroList, {
      basicId = heroList[i]
    })
  end
end

function RecommeFormationSingleData:GetRecomSingleFairyElem()
  return self._rankFairyElem
end

function RecommeFormationSingleData:IsAllowCopy()
  local indexMax = ConfigData:GetFormationHeroCount()
  for index, data in pairs(self.recommanHeroList) do
    if index <= indexMax and PlayerDataCenter.heroDic[data.basicId] ~= nil then
      return true
    end
  end
  return false
end

function RecommeFormationSingleData:GetHaveCount()
  local indexMax = ConfigData:GetFormationHeroCount()
  local count = 0
  for index, data in pairs(self.recommanHeroList) do
    if index <= indexMax and PlayerDataCenter.heroDic[data.basicId] ~= nil then
      count = count + 1
    end
  end
  return count
end

function RecommeFormationSingleData:CopyFormation()
  local indexMax = ConfigData:GetFormationHeroCount()
  local res = {}
  for index, data in pairs(self.recommanHeroList) do
    if index <= indexMax and PlayerDataCenter.heroDic[data.basicId] ~= nil then
      res[index] = data.basicId
    end
  end
  return res
end

return RecommeFormationSingleData
