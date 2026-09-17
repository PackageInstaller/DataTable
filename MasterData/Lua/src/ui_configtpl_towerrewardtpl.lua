local this = class("towerRewardTpl")

function this:init(config)
  self.data = config
end

function this:getConfig()
  return self.data
end

function this:getTplById(id)
  local res = self.data[id]
  if table.isEmpty(res) then
    errorf(string.format("tower_reward %s 系统没有配置", id))
  end
  return res
end

function this:getScore(tpl)
  return tpl.score
end

function this:getReward(tpl)
  return tpl.reward
end

function this:getId(tpl)
  return tpl.id
end

return this
