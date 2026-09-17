local this = class("homeTalentTpl")

function this:init(config)
  self.data = config
  self.groupData = {}
  for i, v in pairs(self.data) do
    self.groupData[v.talentGroupId] = v
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTplByGroupId(groupId)
  return self.groupData[groupId]
end

function this:getBuffInfo(tpl)
  return tpl.buffId, tpl.buffParams, tpl.buffCondition, tpl.buffConditionLogic == 2
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getTagIcon(tpl)
  return tpl.tagIcon
end

function this:getTalentGroupId(tpl)
  return tpl.talentGroupId
end

function this:getTalentDescription(tpl)
  return L_Config:provider(tpl.talentDescription)
end

function this:getTalentName(tpl)
  return L_Config:provider(tpl.talentName)
end

function this:getTalentNameShort(tpl)
  return L_Config:provider(tpl.talentNameShort)
end

function this:getLaborCapacityId(tpl)
  return tpl.laborCapacityId
end

function this:getTalentId(tpl)
  return tpl.talentId
end

function this:getTalentLevel(tpl)
  return tpl.talentLevel
end

function this:getLaborTypeIdOfTalent(tpl)
  return tpl and tpl.laborTypeId
end

function this:getTypeIcon(tpl)
  return tpl.typeIcon
end

return this
