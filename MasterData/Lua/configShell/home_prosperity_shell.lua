local this = class("home_prosperity_shell", G_BaseConfig)
local core = G_Tables.TDHomeProsperityTable.GetInstance()

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
  prosperity = 1,
  reward = 2,
  icon = 3,
  unlockDesc = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getProsperity(offset)
  return core:GetInt(offset, this.indexMap.prosperity)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getIcon(offset)
  return core:GetVString(offset, this.indexMap.icon).value
end

function this:_getUnlockdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_prosperity", core:GetVString(offset, this.indexMap.unlockDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "unlockDesc")
end

this.keyToMethodsMap = {
  id = this._getId,
  prosperity = this._getProsperity,
  reward = this._getReward,
  icon = this._getIcon,
  unlockDesc = this._getUnlockdesc
}
return this
