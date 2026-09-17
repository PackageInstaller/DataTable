local this = class("accessory_set_shell", G_BaseConfig)
local core = G_Tables.TDAccessorySetTable.GetInstance()

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
  skill = 1,
  name = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSkill(offset)
  local str = core:GetVString(offset, this.indexMap.skill).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("accessory_set", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

this.keyToMethodsMap = {
  id = this._getId,
  skill = this._getSkill,
  name = this._getName
}
return this
