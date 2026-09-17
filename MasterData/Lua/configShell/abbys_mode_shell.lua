local this = class("abbys_mode_shell", G_BaseConfig)
local core = G_Tables.TDAbbysModeTable.GetInstance()

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
  name = 2,
  condition = 3,
  level = 4,
  reward = 5,
  enterPerform = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("abbys_mode", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getLevel(offset)
  local str = core:GetVString(offset, this.indexMap.level).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getReward(offset)
  return core:GetInt(offset, this.indexMap.reward)
end

function this:_getEnterperform(offset)
  local str = core:GetVString(offset, this.indexMap.enterPerform).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  name = this._getName,
  condition = this._getCondition,
  level = this._getLevel,
  reward = this._getReward,
  enterPerform = this._getEnterperform
}
return this
