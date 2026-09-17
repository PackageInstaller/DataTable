local this = class("tutorial_activity_shell", G_BaseConfig)
local core = G_Tables.TDTutorialActivityTable.GetInstance()

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
  tutorialTypeId = 1,
  isDefault = 2,
  tutorialName = 3,
  guidePicId = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTutorialtypeid(offset)
  return core:GetInt(offset, this.indexMap.tutorialTypeId)
end

function this:_getIsdefault(offset)
  return core:GetBool(offset, this.indexMap.isDefault)
end

function this:_getTutorialname(offset)
  local langStr = G_TableMgrIns:GetLangStr("tutorial_activity", core:GetVString(offset, this.indexMap.tutorialName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "tutorialName")
end

function this:_getGuidepicid(offset)
  local str = core:GetVString(offset, this.indexMap.guidePicId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  tutorialTypeId = this._getTutorialtypeid,
  isDefault = this._getIsdefault,
  tutorialName = this._getTutorialname,
  guidePicId = this._getGuidepicid
}
return this
