local this = class("skill_shell", G_BaseConfig)
local core = G_Tables.TDSkillTable.GetInstance()

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
  skillType = 1,
  skillDisplayType = 2,
  name = 3,
  icon = 4,
  battleSkillIcon = 5,
  skillElement = 6,
  parentSkill = 7,
  skillShowResponse = 8,
  skillModuleTag = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSkilltype(offset)
  return core:GetInt(offset, this.indexMap.skillType)
end

function this:_getSkilldisplaytype(offset)
  return core:GetInt(offset, this.indexMap.skillDisplayType)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("skill", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getBattleskillicon(offset)
  local str = core:GetVString(offset, this.indexMap.battleSkillIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getSkillelement(offset)
  local str = core:GetVString(offset, this.indexMap.skillElement).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getParentskill(offset)
  return core:GetInt(offset, this.indexMap.parentSkill)
end

function this:_getSkillshowresponse(offset)
  return core:GetInt(offset, this.indexMap.skillShowResponse)
end

function this:_getSkillmoduletag(offset)
  return core:GetInt(offset, this.indexMap.skillModuleTag)
end

this.keyToMethodsMap = {
  id = this._getId,
  skillType = this._getSkilltype,
  skillDisplayType = this._getSkilldisplaytype,
  name = this._getName,
  icon = this._getIcon,
  battleSkillIcon = this._getBattleskillicon,
  skillElement = this._getSkillelement,
  parentSkill = this._getParentskill,
  skillShowResponse = this._getSkillshowresponse,
  skillModuleTag = this._getSkillmoduletag
}
return this
