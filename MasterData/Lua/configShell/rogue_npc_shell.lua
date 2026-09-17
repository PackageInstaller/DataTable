local this = class("rogue_npc_shell", G_BaseConfig)
local core = G_Tables.TDRogueNpcTable.GetInstance()

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
  Id = 0,
  unitId = 1,
  npctype = 2,
  eventGroup = 3,
  eventGroupNew = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getUnitid(offset)
  return core:GetInt(offset, this.indexMap.unitId)
end

function this:_getNpctype(offset)
  return core:GetInt(offset, this.indexMap.npctype)
end

function this:_getEventgroup(offset)
  local str = core:GetVString(offset, this.indexMap.eventGroup).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getEventgroupnew(offset)
  local str = core:GetVString(offset, this.indexMap.eventGroupNew).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  Id = this._getId,
  unitId = this._getUnitid,
  npctype = this._getNpctype,
  eventGroup = this._getEventgroup,
  eventGroupNew = this._getEventgroupnew
}
return this
