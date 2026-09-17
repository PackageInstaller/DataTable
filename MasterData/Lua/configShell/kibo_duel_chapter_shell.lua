local this = class("kibo_duel_chapter_shell", G_BaseConfig)
local core = G_Tables.TDKiboDuelChapterTable.GetInstance()

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
  mode = 2,
  index = 3,
  condition = 4,
  kiboDuelGroupId = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  local langStr = G_TableMgrIns:GetLangStr("kibo_duel_chapter", core:GetVString(offset, this.indexMap.type))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "type")
end

function this:_getMode(offset)
  return core:GetInt(offset, this.indexMap.mode)
end

function this:_getIndex(offset)
  return core:GetInt(offset, this.indexMap.index)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getKiboduelgroupid(offset)
  local str = core:GetVString(offset, this.indexMap.kiboDuelGroupId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  mode = this._getMode,
  index = this._getIndex,
  condition = this._getCondition,
  kiboDuelGroupId = this._getKiboduelgroupid
}
return this
