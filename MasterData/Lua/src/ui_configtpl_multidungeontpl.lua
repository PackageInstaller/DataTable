local this = class("multiDungeonTpl")

function this:init(config)
  self.data = config
  self.groupData = {}
  for i, v in pairs(self.data) do
    self.groupData[v.dungeonGroupId] = self.groupData[v.dungeonGroupId] or {}
    self.groupData[v.dungeonGroupId][v.difficultyId] = v
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getBossDes(tpl)
  return L_Config:provider(tpl.bossDes)
end

function this:getDifficultyId(tpl)
  return tpl.difficultyId
end

function this:getDungeonTag(tpl)
  local res = {}
  for i, v in ipairs(tpl.dungeonTag) do
    table.insert(res, L_Config:provider(v))
  end
  return res
end

function this:getSceneId(tpl)
  return tpl.dungeonId
end

function this:getChallengeDes(tpl)
  local res = {}
  for i, v in ipairs(tpl.challengeDes) do
    table.insert(res, L_Config:provider(v))
  end
  return res
end

function this:getDungeonGroupId(tpl)
  return tpl.dungeonGroupId
end

function this:getBossBg(tpl)
  return tpl.bossBg
end

function this:getFirstLoot(tpl)
  return tpl.firstLoot
end

function this:getChallenge(tpl)
  return tpl.challenge
end

function this:getId(tpl)
  return tpl.id
end

function this:getBossId(tpl)
  return tpl.bossId
end

function this:getBossPic(tpl)
  return tpl.bossPic
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getBossPos(tpl)
  return L_Config:provider(tpl.bossPos)
end

function this:getTplByGroupAndDifficult(groupId, difficult)
  return self.groupData[groupId][difficult]
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

return this
