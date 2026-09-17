local this = class("battle_info_default_shell", G_BaseConfig)
local core = G_Tables.TDBattleInfoDefaultTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, attrDefault = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getAttrdefault(offset)
  return core:GetInt(offset, this.indexMap.attrDefault)
end

this.keyToMethodsMap = {
  id = this._getId,
  attrDefault = this._getAttrdefault
}
return this
