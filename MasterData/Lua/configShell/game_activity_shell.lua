local this = class("game_activity_shell", G_BaseConfig)
local core = G_Tables.TDGameActivityTable.GetInstance()

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
  tutorialName = 2,
  tutorialIcon = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_activity", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getTutorialname(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_activity", core:GetVString(offset, this.indexMap.tutorialName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "tutorialName")
end

function this:_getTutorialicon(offset)
  local str = core:GetVString(offset, this.indexMap.tutorialIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  tutorialName = this._getTutorialname,
  tutorialIcon = this._getTutorialicon
}
return this
