local this = class("pet_skill_shell", G_BaseConfig)
local core = G_Tables.TDPetSkillTable.GetInstance()

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
  petId = 1,
  petLevel = 2,
  skillLevel = 3,
  skillAdd = 4,
  skillReduce = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPetid(offset)
  return core:GetInt(offset, this.indexMap.petId)
end

function this:_getPetlevel(offset)
  return core:GetInt(offset, this.indexMap.petLevel)
end

function this:_getSkilllevel(offset)
  return core:GetInt(offset, this.indexMap.skillLevel)
end

function this:_getSkilladd(offset)
  local str = core:GetVString(offset, this.indexMap.skillAdd).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSkillreduce(offset)
  local str = core:GetVString(offset, this.indexMap.skillReduce).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  petId = this._getPetid,
  petLevel = this._getPetlevel,
  skillLevel = this._getSkilllevel,
  skillAdd = this._getSkilladd,
  skillReduce = this._getSkillreduce
}
return this
