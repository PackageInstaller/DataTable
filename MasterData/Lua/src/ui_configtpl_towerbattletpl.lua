local this = class("towerBattleTpl")

function this:init(config)
  self.data = config
  self.towerBattles = {}
  for _, tpl in pairs(config) do
    if not math.isEmpty(tpl.towerId) then
      if not self.towerBattles[tpl.towerId] then
        self.towerBattles[tpl.towerId] = {}
      end
      table.insert(self.towerBattles[tpl.towerId], tpl)
    end
  end
end

function this:getTowerBattlesByTowerId(towerId)
  return self.towerBattles[towerId]
end

function this:getTplById(id)
  local res = self.data[id]
  if table.isEmpty(res) then
    errorf(string.format("tower_battle %s 系统没有配置", id))
  end
  return res
end

function this:getId(tpl)
  return tpl.id
end

function this:getTowerId(tpl)
  return tpl.towerId
end

function this:getOrder(tpl)
  return tpl.order
end

function this:getBattleId(tpl)
  return tpl.battleId
end

function this:getLevelName(tpl)
  return L_Config:provider(tpl.levelName)
end

function this:getEnemyId(tpl)
  return tpl.enemyId
end

function this:getReward(tpl)
  return tpl.reward
end

function this:getScoreReward(tpl)
  return tpl.scoreReward
end

return this
