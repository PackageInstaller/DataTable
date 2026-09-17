local this = class("world_reborn_group_shell", G_BaseConfig)
local core = G_Tables.TDWorldRebornGroupTable.GetInstance()

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
  rebornCycle = 1,
  rebornQuantity = 2,
  appearCond = 3,
  rebornNow = 4,
  type = 5,
  useNonRepeat = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getReborncycle(offset)
  local str = core:GetVString(offset, this.indexMap.rebornCycle).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRebornquantity(offset)
  return core:GetInt(offset, this.indexMap.rebornQuantity)
end

function this:_getAppearcond(offset)
  local str = core:GetVString(offset, this.indexMap.appearCond).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getRebornnow(offset)
  return core:GetInt(offset, this.indexMap.rebornNow)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getUsenonrepeat(offset)
  return core:GetInt(offset, this.indexMap.useNonRepeat)
end

this.keyToMethodsMap = {
  id = this._getId,
  rebornCycle = this._getReborncycle,
  rebornQuantity = this._getRebornquantity,
  appearCond = this._getAppearcond,
  rebornNow = this._getRebornnow,
  type = this._getType,
  useNonRepeat = this._getUsenonrepeat
}
return this
