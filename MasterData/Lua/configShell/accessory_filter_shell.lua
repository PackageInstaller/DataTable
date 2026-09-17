local this = class("accessory_filter_shell", G_BaseConfig)
local core = G_Tables.TDAccessoryFilterTable.GetInstance()

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
  type = 2,
  battleinfoID = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("accessory_filter", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getBattleinfoid(offset)
  return core:GetInt(offset, this.indexMap.battleinfoID)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  type = this._getType,
  battleinfoID = this._getBattleinfoid
}
return this
