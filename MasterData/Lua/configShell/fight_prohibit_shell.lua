local this = class("fight_prohibit_shell", G_BaseConfig)
local core = G_Tables.TDFightProhibitTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, words = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getWords(offset)
  local langStr = G_TableMgrIns:GetLangStr("fight_prohibit", core:GetVString(offset, this.indexMap.words))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "words")
end

this.keyToMethodsMap = {
  id = this._getId,
  words = this._getWords
}
return this
