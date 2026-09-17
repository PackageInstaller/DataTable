local this = class("char_kibo_shell", G_BaseConfig)
local core = G_Tables.TDCharKiboTable.GetInstance()

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
  characterName = 1,
  getType = 2,
  unlockCondition = 3,
  unlockDesc = 4,
  unlockReward = 5,
  systemJump = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCharactername(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_kibo", core:GetVString(offset, this.indexMap.characterName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "characterName")
end

function this:_getGettype(offset)
  return core:GetInt(offset, this.indexMap.getType)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getUnlockdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_kibo", core:GetVString(offset, this.indexMap.unlockDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "unlockDesc")
end

function this:_getUnlockreward(offset)
  local str = core:GetVString(offset, this.indexMap.unlockReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSystemjump(offset)
  return core:GetInt(offset, this.indexMap.systemJump)
end

this.keyToMethodsMap = {
  id = this._getId,
  characterName = this._getCharactername,
  getType = this._getGettype,
  unlockCondition = this._getUnlockcondition,
  unlockDesc = this._getUnlockdesc,
  unlockReward = this._getUnlockreward,
  systemJump = this._getSystemjump
}
return this
