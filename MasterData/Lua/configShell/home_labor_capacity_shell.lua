local this = class("home_labor_capacity_shell", G_BaseConfig)
local core = G_Tables.TDHomeLaborCapacityTable.GetInstance()

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
  laborCapacityId = 0,
  laborCapacityName = 1,
  laborType = 2,
  subBehaviourTree = 3,
  icon = 4,
  backgroundIcon = 5,
  bevTree = 6,
  satietyScore = 7
}

function this:_getLaborcapacityid(offset)
  return core:GetInt(offset, this.indexMap.laborCapacityId)
end

function this:_getLaborcapacityname(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_labor_capacity", core:GetVString(offset, this.indexMap.laborCapacityName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "laborCapacityName")
end

function this:_getLabortype(offset)
  return core:GetInt(offset, this.indexMap.laborType)
end

function this:_getSubbehaviourtree(offset)
  return core:GetInt(offset, this.indexMap.subBehaviourTree)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getBackgroundicon(offset)
  local str = core:GetVString(offset, this.indexMap.backgroundIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getBevtree(offset)
  return core:GetVString(offset, this.indexMap.bevTree).value
end

function this:_getSatietyscore(offset)
  local str = core:GetVString(offset, this.indexMap.satietyScore).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  laborCapacityId = this._getLaborcapacityid,
  laborCapacityName = this._getLaborcapacityname,
  laborType = this._getLabortype,
  subBehaviourTree = this._getSubbehaviourtree,
  icon = this._getIcon,
  backgroundIcon = this._getBackgroundicon,
  bevTree = this._getBevtree,
  satietyScore = this._getSatietyscore
}
return this
