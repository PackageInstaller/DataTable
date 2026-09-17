local this = class("pet_builder_rule_shell", G_BaseConfig)
local core = G_Tables.TDPetBuilderRuleTable.GetInstance()

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
  petBuilderId = 1,
  petDnaPoolId = 2,
  petDnaElitePoolId = 3,
  petDnaMutation = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPetbuilderid(offset)
  return core:GetInt(offset, this.indexMap.petBuilderId)
end

function this:_getPetdnapoolid(offset)
  return core:GetInt(offset, this.indexMap.petDnaPoolId)
end

function this:_getPetdnaelitepoolid(offset)
  return core:GetInt(offset, this.indexMap.petDnaElitePoolId)
end

function this:_getPetdnamutation(offset)
  return core:GetInt(offset, this.indexMap.petDnaMutation)
end

this.keyToMethodsMap = {
  id = this._getId,
  petBuilderId = this._getPetbuilderid,
  petDnaPoolId = this._getPetdnapoolid,
  petDnaElitePoolId = this._getPetdnaelitepoolid,
  petDnaMutation = this._getPetdnamutation
}
return this
