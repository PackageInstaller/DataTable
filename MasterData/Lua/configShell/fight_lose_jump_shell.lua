local this = class("fight_lose_jump_shell", G_BaseConfig)
local core = G_Tables.TDFightLoseJumpTable.GetInstance()

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
  common_jump = 2,
  resource = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("fight_lose_jump", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getCommon_jump(offset)
  return core:GetInt(offset, this.indexMap.common_jump)
end

function this:_getResource(offset)
  local str = core:GetVString(offset, this.indexMap.resource).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  common_jump = this._getCommon_jump,
  resource = this._getResource
}
return this
