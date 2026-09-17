local this = class("petStarSoulTpl")

function this:init(config)
  self.data = {}
  for _, v in pairs(config) do
    local templateId = v.templateId
    local stage = v.group
    local node = v.node
    self.data[templateId] = self.data[templateId] or {}
    self.data[templateId][stage] = self.data[templateId][stage] or {}
    self.data[templateId][stage][node] = v
  end
end

function this:getTplByStageNode(templateId, stage, node)
  local stageData = self.data[templateId]
  return stageData and stageData[stage] and stageData[stage][node] or nil
end

function this:getMaxStage(templateId)
  local stageData = self.data[templateId]
  if not stageData then
    return 0
  end
  return #stageData
end

function this:getNodeCnt(templateId, stage)
  local stageData = self.data[templateId]
  return stageData and stageData[stage] and #stageData[stage] or 0
end

function this:getTemplateId(tpl)
  return tpl and tpl.templateId or nil
end

function this:getType(tpl)
  return tpl and tpl.type or nil
end

function this:getCost(tpl)
  return tpl and tpl.item or nil
end

function this:getCostKiBoNum(tpl)
  return tpl and tpl.kiboItemNum or nil
end

function this:getUpgradeAttr(tpl)
  return tpl and tpl.attrParam or nil
end

function this:getUpgradeSkillLv(tpl)
  return tpl and tpl.skillParam or 0
end

function this:getNextTpl(tpl)
  if not tpl then
    return
  end
  local templateId = tpl.templateId
  local stageData = self.data[templateId]
  if not stageData then
    return
  end
  local stage = tpl.group
  if not stageData[stage] then
    return
  end
  local node = tpl.node
  if stageData[stage][node + 1] then
    return stageData[stage][node + 1]
  end
  return stageData[stage + 1][1]
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getItemReturn(tpl)
  return tpl.itemReturn
end

function this:getKiboItemReturn(tpl)
  return tpl.kiboItemReturn
end

function this:getUpgradeCumulativeAttr(templateId, stage, node)
  local stageData = self.data[templateId]
  local tpl = stageData and stageData[stage] and stageData[stage][node] or nil
  if not tpl then
    return
  end
  return tpl.attrSumParam
end

return this
