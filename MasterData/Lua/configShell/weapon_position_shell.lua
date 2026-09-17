local this = class("weapon_position_shell", G_BaseConfig)
local core = G_Tables.TDWeaponPositionTable.GetInstance()

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
  stateParameter = 1,
  stateParameterWorld = 2,
  stateParameterBattle = 3,
  stateParameterWorlds = 4,
  slot = 5,
  slot_pos = 6,
  slot_rotate = 7,
  slot_follow = 8,
  scale = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getStateparameter(offset)
  local str = core:GetVString(offset, this.indexMap.stateParameter).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getStateparameterworld(offset)
  local str = core:GetVString(offset, this.indexMap.stateParameterWorld).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getStateparameterbattle(offset)
  local str = core:GetVString(offset, this.indexMap.stateParameterBattle).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "number")
end

function this:_getStateparameterworlds(offset)
  local str = core:GetVString(offset, this.indexMap.stateParameterWorlds).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "number")
end

function this:_getSlot(offset)
  local str = core:GetVString(offset, this.indexMap.slot).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getSlot_pos(offset)
  local str = core:GetVString(offset, this.indexMap.slot_pos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSlot_rotate(offset)
  local str = core:GetVString(offset, this.indexMap.slot_rotate).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSlot_follow(offset)
  local str = core:GetVString(offset, this.indexMap.slot_follow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getScale(offset)
  return core:GetFloat(offset, this.indexMap.scale)
end

this.keyToMethodsMap = {
  id = this._getId,
  stateParameter = this._getStateparameter,
  stateParameterWorld = this._getStateparameterworld,
  stateParameterBattle = this._getStateparameterbattle,
  stateParameterWorlds = this._getStateparameterworlds,
  slot = this._getSlot,
  slot_pos = this._getSlot_pos,
  slot_rotate = this._getSlot_rotate,
  slot_follow = this._getSlot_follow,
  scale = this._getScale
}
return this
