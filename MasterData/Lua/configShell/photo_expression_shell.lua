local this = class("photo_expression_shell", G_BaseConfig)
local core = G_Tables.TDPhotoExpressionTable.GetInstance()

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
  exprnName = 2,
  texture = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("photo_expression", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getExprnname(offset)
  return core:GetVString(offset, this.indexMap.exprnName).value
end

function this:_getTexture(offset)
  local str = core:GetVString(offset, this.indexMap.texture).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  exprnName = this._getExprnname,
  texture = this._getTexture
}
return this
