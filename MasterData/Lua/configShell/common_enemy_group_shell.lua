local this = class("common_enemy_group_shell", G_BaseConfig)
local core = G_Tables.TDCommonEnemyGroupTable.GetInstance()

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
  teamId = 1,
  desc = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTeamid(offset)
  local str = core:GetVString(offset, this.indexMap.teamId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("common_enemy_group", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

this.keyToMethodsMap = {
  id = this._getId,
  teamId = this._getTeamid,
  desc = this._getDesc
}
return this
