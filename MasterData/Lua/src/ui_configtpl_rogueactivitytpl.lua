local this = class("rogueActivityTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getInitialEffectDetails(tpl)
  return tpl.initialEffectDetails
end

function this:getDifficulty(tpl)
  return tpl.difficulty
end

function this:getRewardDisplay(tpl)
  return tpl.rewardDisplay
end

function this:getLevelPath(tpl)
  return tpl.levelPath
end

function this:getName(tpl)
  return tpl.name
end

function this:getId(tpl)
  return tpl.id
end

function this:getBegintime(tpl)
  return tpl.begintime
end

function this:getFirstPassReward(tpl)
  return tpl.firstPassReward
end

function this:getInitialEffect(tpl)
  return tpl.initialEffect
end

function this:getMode(tpl)
  return tpl.mode
end

function this:getPrelevel(tpl)
  return tpl.prelevel
end

function this:getGetCurrencyText(tpl)
  return tpl.getCurrencyText
end

function this:getEndtime(tpl)
  return tpl.endtime
end

function this:getEnemy(tpl)
  return tpl.enemy
end

return this
