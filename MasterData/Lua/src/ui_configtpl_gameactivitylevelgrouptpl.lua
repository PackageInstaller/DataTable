local this = class("gameActivityLevelGroupTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getShowpet(tpl)
  return tpl.showpet
end

function this:getXmove(tpl)
  return tpl.xmove
end

function this:getYturn(tpl)
  return tpl.yturn
end

function this:getDifficultyBadge(tpl)
  return tpl.difficultybadge
end

function this:getSortId(tpl)
  return tpl.sortId
end

function this:getIntroduce(tpl)
  return L_Config:provider(tpl.introduce)
end

function this:getRewardShow(tpl)
  return tpl.rewardshow
end

function this:getAllData()
  return self.data
end

return this
