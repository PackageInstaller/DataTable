local this = class("trial_pet_shell", G_BaseConfig)
local core = G_Tables.TDTrialPetTable.GetInstance()

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
  trialPet = 2,
  trialPetLevel = 3,
  trialPetDna = 4,
  trialPethobby = 5,
  trialPetLearning = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  return core:GetVString(offset, this.indexMap.name).value
end

function this:_getTrialpet(offset)
  return core:GetInt(offset, this.indexMap.trialPet)
end

function this:_getTrialpetlevel(offset)
  return core:GetInt(offset, this.indexMap.trialPetLevel)
end

function this:_getTrialpetdna(offset)
  local str = core:GetVString(offset, this.indexMap.trialPetDna).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getTrialpethobby(offset)
  return core:GetInt(offset, this.indexMap.trialPethobby)
end

function this:_getTrialpetlearning(offset)
  local str = core:GetVString(offset, this.indexMap.trialPetLearning).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  trialPet = this._getTrialpet,
  trialPetLevel = this._getTrialpetlevel,
  trialPetDna = this._getTrialpetdna,
  trialPethobby = this._getTrialpethobby,
  trialPetLearning = this._getTrialpetlearning
}
return this
