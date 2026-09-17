local this = class("ui_top_bar_shell", G_BaseConfig)
local core = G_Tables.TDUiTopBarTable.GetInstance()

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
  viewName = 1,
  backButton = 2,
  backTxt = 3,
  param = 4,
  resourceBar = 5,
  navigationButton = 6,
  helpButton = 7,
  introductionGroupId = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getViewname(offset)
  return core:GetVString(offset, this.indexMap.viewName).value
end

function this:_getBackbutton(offset)
  return core:GetBool(offset, this.indexMap.backButton)
end

function this:_getBacktxt(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("ui_top_bar", core:GetVString(offset, this.indexMap.backTxt))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "ui_top_bar")
end

function this:_getParam(offset)
  return core:GetInt(offset, this.indexMap.param)
end

function this:_getResourcebar(offset)
  local str = core:GetVString(offset, this.indexMap.resourceBar).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getNavigationbutton(offset)
  return core:GetBool(offset, this.indexMap.navigationButton)
end

function this:_getHelpbutton(offset)
  return core:GetBool(offset, this.indexMap.helpButton)
end

function this:_getIntroductiongroupid(offset)
  return core:GetInt(offset, this.indexMap.introductionGroupId)
end

this.keyToMethodsMap = {
  id = this._getId,
  viewName = this._getViewname,
  backButton = this._getBackbutton,
  backTxt = this._getBacktxt,
  param = this._getParam,
  resourceBar = this._getResourcebar,
  navigationButton = this._getNavigationbutton,
  helpButton = this._getHelpbutton,
  introductionGroupId = this._getIntroductiongroupid
}
return this
