local this = class("main_bottom_buttons_shell", G_BaseConfig)
local core = G_Tables.TDMainBottomButtonsTable.GetInstance()

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
  icon = 1,
  text = 2,
  decorateText = 3,
  exitText = 4,
  exitDecorateText = 5,
  bottomOrder = 6,
  extendOrder = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getText(offset)
  local langStr = G_TableMgrIns:GetLangStr("main_bottom_buttons", core:GetVString(offset, this.indexMap.text))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "text")
end

function this:_getDecoratetext(offset)
  return core:GetVString(offset, this.indexMap.decorateText).value
end

function this:_getExittext(offset)
  local langStr = G_TableMgrIns:GetLangStr("main_bottom_buttons", core:GetVString(offset, this.indexMap.exitText))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "exitText")
end

function this:_getExitdecoratetext(offset)
  return core:GetVString(offset, this.indexMap.exitDecorateText).value
end

function this:_getBottomorder(offset)
  return core:GetInt(offset, this.indexMap.bottomOrder)
end

function this:_getExtendorder(offset)
  return core:GetInt(offset, this.indexMap.extendOrder)
end

this.keyToMethodsMap = {
  id = this._getId,
  icon = this._getIcon,
  text = this._getText,
  decorateText = this._getDecoratetext,
  exitText = this._getExittext,
  exitDecorateText = this._getExitdecoratetext,
  bottomOrder = this._getBottomorder,
  extendOrder = this._getExtendorder
}
return this
