local this = class("accessory_sub_parameter_num_shell", G_BaseConfig)
local core = G_Tables.TDAccessorySubParameterNumTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, rarity = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

this.keyToMethodsMap = {
  id = this._getId,
  rarity = this._getRarity
}
return this
