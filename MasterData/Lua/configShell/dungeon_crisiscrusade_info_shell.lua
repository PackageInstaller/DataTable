local this = class("dungeon_crisiscrusade_info_shell", G_BaseConfig)
local core = G_Tables.TDDungeonCrisiscrusadeInfoTable.GetInstance()

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
  _name = 1,
  difficulty = 2,
  pic = 3,
  selectpic = 4,
  recommendlv = 5,
  level = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_get_name(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_crisiscrusade_info", core:GetVString(offset, this.indexMap._name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "_name")
end

function this:_getDifficulty(offset)
  return core:GetInt(offset, this.indexMap.difficulty)
end

function this:_getPic(offset)
  local str = core:GetVString(offset, this.indexMap.pic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getSelectpic(offset)
  local str = core:GetVString(offset, this.indexMap.selectpic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getRecommendlv(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_crisiscrusade_info", core:GetVString(offset, this.indexMap.recommendlv))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "recommendlv")
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

this.keyToMethodsMap = {
  id = this._getId,
  _name = this._get_name,
  difficulty = this._getDifficulty,
  pic = this._getPic,
  selectpic = this._getSelectpic,
  recommendlv = this._getRecommendlv,
  level = this._getLevel
}
return this
