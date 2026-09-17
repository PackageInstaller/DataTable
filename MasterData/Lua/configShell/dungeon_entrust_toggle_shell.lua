local this = class("dungeon_entrust_toggle_shell", G_BaseConfig)
local core = G_Tables.TDDungeonEntrustToggleTable.GetInstance()

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
  name = 1,
  showCondition = 2,
  dungeonEntrustType = 3,
  DungeonEntrustTypeIcon = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_entrust_toggle", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getShowcondition(offset)
  local str = core:GetVString(offset, this.indexMap.showCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDungeonentrusttype(offset)
  local str = core:GetVString(offset, this.indexMap.dungeonEntrustType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDungeonentrusttypeicon(offset)
  local str = core:GetVString(offset, this.indexMap.DungeonEntrustTypeIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  showCondition = this._getShowcondition,
  dungeonEntrustType = this._getDungeonentrusttype,
  DungeonEntrustTypeIcon = this._getDungeonentrusttypeicon
}
return this
