local this = class("dungeonEntrustRewardTpl")

function this:init(config)
  self.data = config
  self.modeInfo = {}
  for _, v in pairs(config) do
    if not self.modeInfo[v.dungeonEntrustType] then
      self.modeInfo[v.dungeonEntrustType] = {}
    end
    if not self.modeInfo[v.dungeonEntrustType][v.difficultyId] then
      self.modeInfo[v.dungeonEntrustType][v.difficultyId] = {}
    end
    table.insert(self.modeInfo[v.dungeonEntrustType][v.difficultyId], v)
  end
  for _, v in pairs(self.modeInfo) do
    for _, v1 in pairs(v) do
      table.sort(v1, function(a, b)
        return a.starNum < b.starNum
      end)
    end
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getDifficulty(tpl)
  return tpl.difficultyId
end

function this:getStarNum(tpl)
  return tpl.starNum
end

function this:getReward(tpl)
  return L_DataUtil.parseRewardConfig(tpl.reward)
end

function this:getInfoByDifficulty(entrustType, difficulty)
  return self.modeInfo[entrustType][difficulty]
end

return this
