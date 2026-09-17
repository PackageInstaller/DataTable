local this = class("journey_tab_shell", G_BaseConfig)
local core = G_Tables.TDJourneyTabTable.GetInstance()

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
  isRequired = 2,
  sort = 3,
  unlockCondition = 4,
  unlockDesc = 5,
  unlockIcon = 6,
  tabIconSelect = 7,
  tabIconNotSelect = 8,
  color = 9,
  stageUnlockIcon = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("journey_tab", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIsrequired(offset)
  return core:GetInt(offset, this.indexMap.isRequired)
end

function this:_getSort(offset)
  return core:GetInt(offset, this.indexMap.sort)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getUnlockdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("journey_tab", core:GetVString(offset, this.indexMap.unlockDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "unlockDesc")
end

function this:_getUnlockicon(offset)
  local str = core:GetVString(offset, this.indexMap.unlockIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTabiconselect(offset)
  local str = core:GetVString(offset, this.indexMap.tabIconSelect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTabiconnotselect(offset)
  local str = core:GetVString(offset, this.indexMap.tabIconNotSelect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getColor(offset)
  return core:GetVString(offset, this.indexMap.color).value
end

function this:_getStageunlockicon(offset)
  local str = core:GetVString(offset, this.indexMap.stageUnlockIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  isRequired = this._getIsrequired,
  sort = this._getSort,
  unlockCondition = this._getUnlockcondition,
  unlockDesc = this._getUnlockdesc,
  unlockIcon = this._getUnlockicon,
  tabIconSelect = this._getTabiconselect,
  tabIconNotSelect = this._getTabiconnotselect,
  color = this._getColor,
  stageUnlockIcon = this._getStageunlockicon
}
return this
