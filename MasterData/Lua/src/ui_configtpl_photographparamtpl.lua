local this = class("photographParamTpl")

function this:init(config)
  self.data = config
  self.group = {}
  for _, v in pairs(config) do
    if self:getShow(v) then
      local gId = self:getGroupId(v)
      self.group[gId] = self.group[gId] or {}
      table.insert(self.group[gId], v)
    end
  end
  
  local function _compare(a, b)
    return a.sequence < b.sequence
  end
  
  for _, v in pairs(self.group) do
    table.sort(v, _compare)
  end
end

function this:getConfig()
  return self.data
end

function this:getListByGroupId(gId)
  return self.group[gId]
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getId(tpl)
  return tpl.id
end

function this:getParamType(tpl)
  return tpl.paramType
end

function this:getShow(tpl)
  if tpl.show ~= 1 then
    return false
  end
  if tpl.id == L_Const.photoParam.highResolution and C_AppConfigManager.IsMobilePlatformForUI then
    return false
  end
  return true
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getSystemUnlock(tpl)
  return tpl.systemUnlock
end

function this:getParam(tpl)
  local val = tpl.param
  local pType = self:getParamType(tpl)
  if pType == L_Const.photoParamType.boolean then
    val = val == "1"
  elseif pType == L_Const.photoParamType.int or pType == L_Const.photoParamType.range then
    val = tonumber(val) or 0
  end
  return val
end

function this:getParamMin(tpl)
  return tpl.paramMin
end

function this:getParamMax(tpl)
  return tpl.paramMax
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getSequence(tpl)
  return tpl.sequence
end

function this:getType(tpl)
  return tpl.type
end

return this
