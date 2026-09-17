local this = class("skill_entry_shell", G_BaseConfig)
local core = G_Tables.TDSkillEntryTable.GetInstance()

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
  Id = 0,
  skillEntryId = 1,
  skillId = 2,
  subSkillId = 3,
  skillLv = 4,
  mainAttr = 5,
  icon = 6,
  skillType = 7,
  skillName = 8,
  skillCommonDesc = 9,
  skillDesc = 10,
  skillParam = 11
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getSkillentryid(offset)
  return core:GetInt(offset, this.indexMap.skillEntryId)
end

function this:_getSkillid(offset)
  return core:GetInt(offset, this.indexMap.skillId)
end

function this:_getSubskillid(offset)
  return core:GetInt(offset, this.indexMap.subSkillId)
end

function this:_getSkilllv(offset)
  return core:GetInt(offset, this.indexMap.skillLv)
end

function this:_getMainattr(offset)
  local str = core:GetVString(offset, this.indexMap.mainAttr).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getSkilltype(offset)
  return core:GetInt(offset, this.indexMap.skillType)
end

function this:_getSkillname(offset)
  local langStr = G_TableMgrIns:GetLangStr("skill_entry", core:GetVString(offset, this.indexMap.skillName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "skillName")
end

function this:_getSkillcommondesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("skill_entry", core:GetVString(offset, this.indexMap.skillCommonDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "skillCommonDesc")
end

function this:_getSkilldesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("skill_entry", core:GetVString(offset, this.indexMap.skillDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "skillDesc")
end

function this:_getSkillparam(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("skill_entry", core:GetVString(offset, this.indexMap.skillParam))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "skill_entry")
end

this.keyToMethodsMap = {
  Id = this._getId,
  skillEntryId = this._getSkillentryid,
  skillId = this._getSkillid,
  subSkillId = this._getSubskillid,
  skillLv = this._getSkilllv,
  mainAttr = this._getMainattr,
  icon = this._getIcon,
  skillType = this._getSkilltype,
  skillName = this._getSkillname,
  skillCommonDesc = this._getSkillcommondesc,
  skillDesc = this._getSkilldesc,
  skillParam = this._getSkillparam
}
return this
