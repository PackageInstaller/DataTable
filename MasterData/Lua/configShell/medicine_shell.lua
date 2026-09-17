local this = class("medicine_shell", G_BaseConfig)
local core = G_Tables.TDMedicineTable.GetInstance()

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
  desc = 2,
  medicineIcon = 3,
  medicineTarget = 4,
  medicinType = 5,
  buffType = 6,
  buffId = 7,
  coolDown = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("medicine", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("medicine", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getMedicineicon(offset)
  return core:GetInt(offset, this.indexMap.medicineIcon)
end

function this:_getMedicinetarget(offset)
  return core:GetInt(offset, this.indexMap.medicineTarget)
end

function this:_getMedicintype(offset)
  return core:GetInt(offset, this.indexMap.medicinType)
end

function this:_getBufftype(offset)
  return core:GetInt(offset, this.indexMap.buffType)
end

function this:_getBuffid(offset)
  return core:GetInt(offset, this.indexMap.buffId)
end

function this:_getCooldown(offset)
  return core:GetInt(offset, this.indexMap.coolDown)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  desc = this._getDesc,
  medicineIcon = this._getMedicineicon,
  medicineTarget = this._getMedicinetarget,
  medicinType = this._getMedicintype,
  buffType = this._getBufftype,
  buffId = this._getBuffid,
  coolDown = this._getCooldown
}
return this
