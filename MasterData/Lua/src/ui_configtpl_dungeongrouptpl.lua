local this = class("dungeonGroupTpl")

function this:init(config)
  self.data = config
end

function this:getValue()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getOpenTypeParam(tpl)
  return tpl.openTypeParam
end

function this:getDungeonGroupOrder(tpl)
  return tpl.dungeonGroupOrder
end

function this:getNeedPower(tpl)
  return tpl.needPower
end

function this:getDungeonGroupName(tpl)
  return L_Config:provider(tpl.dungeonGroupName)
end

function this:getOpenType(tpl)
  return tpl.openType
end

function this:getDungeonGroupTag(tpl)
  return L_Config:provider(tpl.dungeonGroupTag)
end

function this:getDoorId(tpl)
  return tpl.doorId
end

function this:getDungeonSystemType(tpl)
  return tpl.dungeonSystemType
end

function this:getCameraVerticalAngle(tpl)
  return tpl.cameraVerticalAngle
end

function this:getUserExp(tpl)
  return tpl.userExp
end

function this:getCameraDistance(tpl)
  return tpl.cameraDistance
end

function this:getDiffType(tpl)
  return tpl.diffType
end

function this:getCameraHorizontalAngle(tpl)
  return tpl.cameraHorizontalAngle
end

function this:getDescription(tpl)
  return tpl.description
end

function this:getFirstLoot(tpl)
  return L_DataUtil.parseRewardConfig(tpl.firstLoot)
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getId(tpl)
  return tpl.id
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getShowLevel(tpl)
  return tpl.showLevel
end

return this
