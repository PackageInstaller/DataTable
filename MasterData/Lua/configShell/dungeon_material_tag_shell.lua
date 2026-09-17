local this = class("dungeon_material_tag_shell", G_BaseConfig)
local core = G_Tables.TDDungeonMaterialTagTable.GetInstance()

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
  unlock = 2,
  showCondition = 3,
  sort = 4,
  bg = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_material_tag", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getUnlock(offset)
  local str = core:GetVString(offset, this.indexMap.unlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getShowcondition(offset)
  local str = core:GetVString(offset, this.indexMap.showCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSort(offset)
  return core:GetInt(offset, this.indexMap.sort)
end

function this:_getBg(offset)
  local str = core:GetVString(offset, this.indexMap.bg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  unlock = this._getUnlock,
  showCondition = this._getShowcondition,
  sort = this._getSort,
  bg = this._getBg
}
return this
