local this = class("photo_template_shell", G_BaseConfig)
local core = G_Tables.TDPhotoTemplateTable.GetInstance()

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
  show = 2,
  fullStr = 3,
  icon = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("photo_template", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getShow(offset)
  return core:GetInt(offset, this.indexMap.show)
end

function this:_getFullstr(offset)
  return core:GetVString(offset, this.indexMap.fullStr).value
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  show = this._getShow,
  fullStr = this._getFullstr,
  icon = this._getIcon
}
return this
