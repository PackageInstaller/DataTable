local this = class("task_block_shell", G_BaseConfig)
local core = G_Tables.TDTaskBlockTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, block_system = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getBlock_system(offset)
  local str = core:GetVString(offset, this.indexMap.block_system).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  block_system = this._getBlock_system
}
return this
