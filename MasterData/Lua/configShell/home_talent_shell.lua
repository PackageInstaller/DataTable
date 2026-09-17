local this = class("home_talent_shell", G_BaseConfig)
local core = G_Tables.TDHomeTalentTable.GetInstance()

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
  talentId = 0,
  laborCapacityId = 1,
  laborTypeId = 2,
  typeIcon = 3,
  icon = 4,
  tagIcon = 5,
  talentGroupId = 6,
  talentLevel = 7,
  talentName = 8,
  talentNameShort = 9,
  buffCondition = 10,
  buffConditionLogic = 11,
  buffParams = 12,
  buffId = 13,
  talentDescription = 14
}

function this:_getTalentid(offset)
  return core:GetInt(offset, this.indexMap.talentId)
end

function this:_getLaborcapacityid(offset)
  return core:GetInt(offset, this.indexMap.laborCapacityId)
end

function this:_getLabortypeid(offset)
  return core:GetInt(offset, this.indexMap.laborTypeId)
end

function this:_getTypeicon(offset)
  local str = core:GetVString(offset, this.indexMap.typeIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTagicon(offset)
  local str = core:GetVString(offset, this.indexMap.tagIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTalentgroupid(offset)
  return core:GetInt(offset, this.indexMap.talentGroupId)
end

function this:_getTalentlevel(offset)
  return core:GetInt(offset, this.indexMap.talentLevel)
end

function this:_getTalentname(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_talent", core:GetVString(offset, this.indexMap.talentName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "talentName")
end

function this:_getTalentnameshort(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_talent", core:GetVString(offset, this.indexMap.talentNameShort))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "talentNameShort")
end

function this:_getBuffcondition(offset)
  local str = core:GetVString(offset, this.indexMap.buffCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getBuffconditionlogic(offset)
  return core:GetInt(offset, this.indexMap.buffConditionLogic)
end

function this:_getBuffparams(offset)
  local str = core:GetVString(offset, this.indexMap.buffParams).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getBuffid(offset)
  local str = core:GetVString(offset, this.indexMap.buffId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTalentdescription(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_talent", core:GetVString(offset, this.indexMap.talentDescription))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "talentDescription")
end

this.keyToMethodsMap = {
  talentId = this._getTalentid,
  laborCapacityId = this._getLaborcapacityid,
  laborTypeId = this._getLabortypeid,
  typeIcon = this._getTypeicon,
  icon = this._getIcon,
  tagIcon = this._getTagicon,
  talentGroupId = this._getTalentgroupid,
  talentLevel = this._getTalentlevel,
  talentName = this._getTalentname,
  talentNameShort = this._getTalentnameshort,
  buffCondition = this._getBuffcondition,
  buffConditionLogic = this._getBuffconditionlogic,
  buffParams = this._getBuffparams,
  buffId = this._getBuffid,
  talentDescription = this._getTalentdescription
}
return this
