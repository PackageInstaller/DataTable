local this = class("egg_poolitem_shell", G_BaseConfig)
local core = G_Tables.TDEggPoolitemTable.GetInstance()

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
  guaranteegroup5 = 1,
  guaranteegroup4 = 2,
  kipopool1 = 3,
  guaranteegrouprule = 4,
  kipopool2 = 5,
  kipopool3 = 6,
  kipopool4 = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGuaranteegroup5(offset)
  return core:GetInt(offset, this.indexMap.guaranteegroup5)
end

function this:_getGuaranteegroup4(offset)
  local str = core:GetVString(offset, this.indexMap.guaranteegroup4).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getKipopool1(offset)
  return core:GetInt(offset, this.indexMap.kipopool1)
end

function this:_getGuaranteegrouprule(offset)
  local str = core:GetVString(offset, this.indexMap.guaranteegrouprule).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getKipopool2(offset)
  return core:GetInt(offset, this.indexMap.kipopool2)
end

function this:_getKipopool3(offset)
  return core:GetInt(offset, this.indexMap.kipopool3)
end

function this:_getKipopool4(offset)
  return core:GetInt(offset, this.indexMap.kipopool4)
end

this.keyToMethodsMap = {
  id = this._getId,
  guaranteegroup5 = this._getGuaranteegroup5,
  guaranteegroup4 = this._getGuaranteegroup4,
  kipopool1 = this._getKipopool1,
  guaranteegrouprule = this._getGuaranteegrouprule,
  kipopool2 = this._getKipopool2,
  kipopool3 = this._getKipopool3,
  kipopool4 = this._getKipopool4
}
return this
