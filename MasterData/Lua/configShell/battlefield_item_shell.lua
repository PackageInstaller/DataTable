local this = class("battlefield_item_shell", G_BaseConfig)
local core = G_Tables.TDBattlefieldItemTable.GetInstance()

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
  itemType = 1,
  path = 2,
  displayName = 3,
  param = 4,
  stringParam = 5,
  skillList = 6,
  skillBytesPath = 7,
  modelParam = 8,
  FxParam = 9,
  lockCheck = 10,
  aiLockCheck = 11,
  risingDamageText = 12,
  independenceRisingDamageText = 13,
  barrier = 14,
  CanBeAttacked = 15,
  collisionType = 16,
  element = 17
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getItemtype(offset)
  return core:GetInt(offset, this.indexMap.itemType)
end

function this:_getPath(offset)
  local str = core:GetVString(offset, this.indexMap.path).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDisplayname(offset)
  local langStr = G_TableMgrIns:GetLangStr("battlefield_item", core:GetVString(offset, this.indexMap.displayName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "displayName")
end

function this:_getParam(offset)
  local str = core:GetVString(offset, this.indexMap.param).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "number")
end

function this:_getStringparam(offset)
  local str = core:GetVString(offset, this.indexMap.stringParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "string")
end

function this:_getSkilllist(offset)
  local str = core:GetVString(offset, this.indexMap.skillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getSkillbytespath(offset)
  local str = core:GetVString(offset, this.indexMap.skillBytesPath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getModelparam(offset)
  local str = core:GetVString(offset, this.indexMap.modelParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string")
end

function this:_getFxparam(offset)
  local str = core:GetVString(offset, this.indexMap.FxParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string")
end

function this:_getLockcheck(offset)
  return core:GetBool(offset, this.indexMap.lockCheck)
end

function this:_getAilockcheck(offset)
  return core:GetBool(offset, this.indexMap.aiLockCheck)
end

function this:_getRisingdamagetext(offset)
  return core:GetBool(offset, this.indexMap.risingDamageText)
end

function this:_getIndependencerisingdamagetext(offset)
  return core:GetBool(offset, this.indexMap.independenceRisingDamageText)
end

function this:_getBarrier(offset)
  return core:GetBool(offset, this.indexMap.barrier)
end

function this:_getCanbeattacked(offset)
  return core:GetBool(offset, this.indexMap.CanBeAttacked)
end

function this:_getCollisiontype(offset)
  return core:GetInt(offset, this.indexMap.collisionType)
end

function this:_getElement(offset)
  return core:GetInt(offset, this.indexMap.element)
end

this.keyToMethodsMap = {
  id = this._getId,
  itemType = this._getItemtype,
  path = this._getPath,
  displayName = this._getDisplayname,
  param = this._getParam,
  stringParam = this._getStringparam,
  skillList = this._getSkilllist,
  skillBytesPath = this._getSkillbytespath,
  modelParam = this._getModelparam,
  FxParam = this._getFxparam,
  lockCheck = this._getLockcheck,
  aiLockCheck = this._getAilockcheck,
  risingDamageText = this._getRisingdamagetext,
  independenceRisingDamageText = this._getIndependencerisingdamagetext,
  barrier = this._getBarrier,
  CanBeAttacked = this._getCanbeattacked,
  collisionType = this._getCollisiontype,
  element = this._getElement
}
return this
