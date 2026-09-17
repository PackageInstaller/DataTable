local this = class("guide_icon_shell", G_BaseConfig)
local core = G_Tables.TDGuideIconTable.GetInstance()

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
  keycode = 1,
  disName = 2,
  icon = 3,
  holdIcon = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getKeycode(offset)
  return core:GetVString(offset, this.indexMap.keycode).value
end

function this:_getDisname(offset)
  local langStr = G_TableMgrIns:GetLangStr("guide_icon", core:GetVString(offset, this.indexMap.disName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "disName")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getHoldicon(offset)
  local str = core:GetVString(offset, this.indexMap.holdIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  keycode = this._getKeycode,
  disName = this._getDisname,
  icon = this._getIcon,
  holdIcon = this._getHoldicon
}
return this
