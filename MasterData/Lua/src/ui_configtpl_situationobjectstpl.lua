local this = class("situationObjectsTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getObjectsName(tpl)
  return L_Config.provider(tpl.objectsName)
end

function this:getObjResource(tpl)
  return tpl.objResource
end

function this:getObjIcon(tpl)
  return tpl.objIcon
end

function this:getUnlock(tpl)
  return tpl.unlock
end

return this
