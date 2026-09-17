local this = class("pet_learningenum_shell", G_BaseConfig)
local core = G_Tables.TDPetLearningenumTable.GetInstance()

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
  attributeEnum = 2,
  order = 3,
  color = 4,
  newIcon = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_learningenum", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getAttributeenum(offset)
  return core:GetInt(offset, this.indexMap.attributeEnum)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getColor(offset)
  return core:GetVString(offset, this.indexMap.color).value
end

function this:_getNewicon(offset)
  local str = core:GetVString(offset, this.indexMap.newIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  attributeEnum = this._getAttributeenum,
  order = this._getOrder,
  color = this._getColor,
  newIcon = this._getNewicon
}
return this
