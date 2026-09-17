local this = class("robot_shell", G_BaseConfig)
local core = G_Tables.TDRobotTable.GetInstance()

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
  type = 1,
  lv = 2,
  combat = 3,
  robotlv = 4,
  heroid = 5,
  stageid = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getLv(offset)
  local str = core:GetVString(offset, this.indexMap.lv).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCombat(offset)
  return core:GetInt(offset, this.indexMap.combat)
end

function this:_getRobotlv(offset)
  return core:GetInt(offset, this.indexMap.robotlv)
end

function this:_getHeroid(offset)
  local str = core:GetVString(offset, this.indexMap.heroid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getStageid(offset)
  return core:GetInt(offset, this.indexMap.stageid)
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  lv = this._getLv,
  combat = this._getCombat,
  robotlv = this._getRobotlv,
  heroid = this._getHeroid,
  stageid = this._getStageid
}
return this
