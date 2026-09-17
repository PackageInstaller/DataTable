local this = class("battle_tag_shell", G_BaseConfig)
local core = G_Tables.TDBattleTagTable.GetInstance()

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
  type = 1,
  title = 2,
  desc = 3,
  color = 4,
  battle = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getTitle(offset)
  local langStr = G_TableMgrIns:GetLangStr("battle_tag", core:GetVString(offset, this.indexMap.title))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "title")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("battle_tag", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getColor(offset)
  return core:GetVString(offset, this.indexMap.color).value
end

function this:_getBattle(offset)
  local str = core:GetVString(offset, this.indexMap.battle).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  title = this._getTitle,
  desc = this._getDesc,
  color = this._getColor,
  battle = this._getBattle
}
return this
