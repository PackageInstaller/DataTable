local this = class("dungeon_entrust_difficulty_shell", G_BaseConfig)
local core = G_Tables.TDDungeonEntrustDifficultyTable.GetInstance()

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
  unlock = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_entrust_difficulty", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getUnlock(offset)
  local str = core:GetVString(offset, this.indexMap.unlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  unlock = this._getUnlock
}
return this
