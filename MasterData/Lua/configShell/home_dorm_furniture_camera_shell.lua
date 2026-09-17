local this = class("home_dorm_furniture_camera_shell", G_BaseConfig)
local core = G_Tables.TDHomeDormFurnitureCameraTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {
  id = 0,
  doubleInteractIdleAnimateName = 1,
  doubleFurnitureMontageName = 2,
  IdleCameraName = 3,
  pose = 4,
  interactPoint = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDoubleinteractidleanimatename(offset)
  return core:GetVString(offset, this.indexMap.doubleInteractIdleAnimateName).value
end

function this:_getDoublefurnituremontagename(offset)
  return core:GetVString(offset, this.indexMap.doubleFurnitureMontageName).value
end

function this:_getIdlecameraname(offset)
  local str = core:GetVString(offset, this.indexMap.IdleCameraName).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPose(offset)
  local str = core:GetVString(offset, this.indexMap.pose).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getInteractpoint(offset)
  local str = core:GetVString(offset, this.indexMap.interactPoint).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  doubleInteractIdleAnimateName = this._getDoubleinteractidleanimatename,
  doubleFurnitureMontageName = this._getDoublefurnituremontagename,
  IdleCameraName = this._getIdlecameraname,
  pose = this._getPose,
  interactPoint = this._getInteractpoint
}
return this
