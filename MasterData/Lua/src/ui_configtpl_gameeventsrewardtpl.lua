local this = class("gameEventsRewardTpl")

function this:init(config)
  self.data = config
end

function this:getData()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getId(tpl)
  return tpl.id
end

function this:getShowType(tpl)
  return tpl.showType
end

function this:getPara(tpl)
  return tpl.para
end

function this:getFinishCondition(tpl)
  return tpl.finishCondition
end

function this:getRewardShow(tpl)
  return L_DataUtil.parseRewardConfig(tpl.rewardShow)
end

function this:getDescription(tpl)
  return L_Config:provider(tpl.description)
end

function this:getCommonJump(tpl)
  return tpl.commonJump
end

function this:getReward(tpl)
  return tpl.reward
end

function this:getGroupIdGather(tpl)
  return tpl.groupIdGather
end

return this
