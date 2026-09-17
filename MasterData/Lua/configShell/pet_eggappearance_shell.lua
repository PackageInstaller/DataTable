local this = class("pet_eggappearance_shell", G_BaseConfig)
local core = G_Tables.TDPetEggappearanceTable.GetInstance()

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
  anotherId = 1,
  appearance = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getAnotherid(offset)
  return core:GetInt(offset, this.indexMap.anotherId)
end

function this:_getAppearance(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_eggappearance", core:GetVString(offset, this.indexMap.appearance))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "appearance")
end

this.keyToMethodsMap = {
  id = this._getId,
  anotherId = this._getAnotherid,
  appearance = this._getAppearance
}
return this
