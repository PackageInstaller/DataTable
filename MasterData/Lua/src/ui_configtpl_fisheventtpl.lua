local this = class("fishEventTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getLimit(tpl)
  return tpl.limit
end

function this:getParam(tpl)
  return tpl.param
end

function this:getPlot(tpl)
  return tpl.plot
end

function this:getReward(tpl)
  return tpl.reward
end

function this:getType(tpl)
  return tpl.type
end

function this:getPerId(tpl)
  return tpl.perId
end

function this:getIcon(tpl)
  if not string.isEmpty(tpl.icon) then
    return tpl.icon
  end
  local reward = L_DataUtil.parseRewardConfigItem(tpl.reward)
  local item = L_ItemManager:parseItem(reward.itemType, reward.itemId)
  return item.icon
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

return this
