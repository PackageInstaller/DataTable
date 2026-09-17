local this = class("clothing_occupy_shell", G_BaseConfig)
local core = G_Tables.TDClothingOccupyTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

this.keyToMethodsMap = {
  id = this._getId
}
return this
