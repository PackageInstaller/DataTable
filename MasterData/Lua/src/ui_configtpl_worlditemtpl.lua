local this = class("worldItemTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  return tpl.name
end

function this:getResPath(tpl)
  return tpl.resPath
end

function this:getId(tpl)
  return tpl.id
end

function this:getRewardHeight(tpl)
  return tpl.rewardHeight
end

function this:getOverwriteId(tpl)
  return tpl.overwriteId
end

return this
