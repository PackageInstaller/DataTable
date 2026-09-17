local this = class("robot_battle_shell", G_BaseConfig)
local core = G_Tables.TDRobotBattleTable.GetInstance()

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
  herolv = 1,
  rank = 2,
  star = 3,
  weaponid = 4,
  weaponlv = 5,
  weaponad = 6,
  soldierid = 7,
  soldierlv = 8,
  device = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getHerolv(offset)
  local str = core:GetVString(offset, this.indexMap.herolv).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRank(offset)
  return core:GetInt(offset, this.indexMap.rank)
end

function this:_getStar(offset)
  return core:GetInt(offset, this.indexMap.star)
end

function this:_getWeaponid(offset)
  return core:GetInt(offset, this.indexMap.weaponid)
end

function this:_getWeaponlv(offset)
  return core:GetInt(offset, this.indexMap.weaponlv)
end

function this:_getWeaponad(offset)
  return core:GetInt(offset, this.indexMap.weaponad)
end

function this:_getSoldierid(offset)
  return core:GetInt(offset, this.indexMap.soldierid)
end

function this:_getSoldierlv(offset)
  local str = core:GetVString(offset, this.indexMap.soldierlv).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDevice(offset)
  local str = core:GetVString(offset, this.indexMap.device).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  herolv = this._getHerolv,
  rank = this._getRank,
  star = this._getStar,
  weaponid = this._getWeaponid,
  weaponlv = this._getWeaponlv,
  weaponad = this._getWeaponad,
  soldierid = this._getSoldierid,
  soldierlv = this._getSoldierlv,
  device = this._getDevice
}
return this
