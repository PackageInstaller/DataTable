local this = class("pet_special_boss_prob_shell", G_BaseConfig)
local core = G_Tables.TDPetSpecialBossProbTable.GetInstance()

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
  petid = 1,
  name = 2,
  petProb = 3,
  petOnceRefreshProb = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPetid(offset)
  return core:GetInt(offset, this.indexMap.petid)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_special_boss_prob", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getPetprob(offset)
  local str = core:GetVString(offset, this.indexMap.petProb).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getPetoncerefreshprob(offset)
  local str = core:GetVString(offset, this.indexMap.petOnceRefreshProb).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  petid = this._getPetid,
  name = this._getName,
  petProb = this._getPetprob,
  petOnceRefreshProb = this._getPetoncerefreshprob
}
return this
