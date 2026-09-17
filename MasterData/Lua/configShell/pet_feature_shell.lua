local this = class("pet_feature_shell", G_BaseConfig)
local core = G_Tables.TDPetFeatureTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, feature = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getFeature(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_feature", core:GetVString(offset, this.indexMap.feature))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "feature")
end

this.keyToMethodsMap = {
  id = this._getId,
  feature = this._getFeature
}
return this
