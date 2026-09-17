local this = class("home_crop_type_shell", G_BaseConfig)
local core = G_Tables.TDHomeCropTypeTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, cropType = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCroptype(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_crop_type", core:GetVString(offset, this.indexMap.cropType))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "cropType")
end

this.keyToMethodsMap = {
  id = this._getId,
  cropType = this._getCroptype
}
return this
