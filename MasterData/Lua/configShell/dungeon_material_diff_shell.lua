local this = class("dungeon_material_diff_shell", G_BaseConfig)
local core = G_Tables.TDDungeonMaterialDiffTable.GetInstance()

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
  diff = 1,
  name = 2,
  pic = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDiff(offset)
  return core:GetInt(offset, this.indexMap.diff)
end

function this:_getName(offset)
  return core:GetVString(offset, this.indexMap.name).value
end

function this:_getPic(offset)
  local str = core:GetVString(offset, this.indexMap.pic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  diff = this._getDiff,
  name = this._getName,
  pic = this._getPic
}
return this
