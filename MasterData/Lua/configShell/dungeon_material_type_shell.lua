local this = class("dungeon_material_type_shell", G_BaseConfig)
local core = G_Tables.TDDungeonMaterialTypeTable.GetInstance()

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
  tagId = 1,
  unlock = 2,
  showCondition = 3,
  sortId = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTagid(offset)
  return core:GetInt(offset, this.indexMap.tagId)
end

function this:_getUnlock(offset)
  local str = core:GetVString(offset, this.indexMap.unlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getShowcondition(offset)
  local str = core:GetVString(offset, this.indexMap.showCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSortid(offset)
  return core:GetInt(offset, this.indexMap.sortId)
end

this.keyToMethodsMap = {
  id = this._getId,
  tagId = this._getTagid,
  unlock = this._getUnlock,
  showCondition = this._getShowcondition,
  sortId = this._getSortid
}
return this
