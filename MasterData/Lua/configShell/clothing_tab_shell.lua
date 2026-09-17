local this = class("clothing_tab_shell", G_BaseConfig)
local core = G_Tables.TDClothingTabTable.GetInstance()

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
  typeId = 1,
  name = 2,
  icon = 3,
  iconSelected = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTypeid(offset)
  return core:GetInt(offset, this.indexMap.typeId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("clothing_tab", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  return core:GetVString(offset, this.indexMap.icon).value
end

function this:_getIconselected(offset)
  return core:GetVString(offset, this.indexMap.iconSelected).value
end

this.keyToMethodsMap = {
  id = this._getId,
  typeId = this._getTypeid,
  name = this._getName,
  icon = this._getIcon,
  iconSelected = this._getIconselected
}
return this
