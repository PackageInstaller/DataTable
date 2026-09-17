local this = class("gameClientTpl")
local table = G_Tables.TDGameClientTable

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getHash(tpl)
  return tpl.hash
end

function this:getGroup(tpl)
  return tpl.group
end

function this:getValue(key)
  local data = self.data[key]
  return self.data[key]
end

function this:getData(key, typeId, default)
  typeId = typeId or L_Const.int
  local val = table.GetData(key)
  if val == nil then
    return default
  end
  local data = L_GameUtil.convertValue(val, typeId)
  return data
end

function this:getFormationFlashOpen()
  return self:getData("FORMATION_SELECTED_EFFECT", L_Const.GameTplType.int) == 1
end

function this:getFormationFlashMax()
  local val = self:getData("FORMATION_FLASHING_STRENGTH", L_Const.GameTplType.list_float)
  return val and val[2] or nil
end

function this:getFormationFlashMin()
  local val = self:getData("FORMATION_FLASHING_STRENGTH", L_Const.GameTplType.list_float)
  return val and val[1] or nil
end

function this:getFormationFlashTime()
  return self:getData("FORMATION_FLASHING_TIME", L_Const.GameTplType.float)
end

return this
