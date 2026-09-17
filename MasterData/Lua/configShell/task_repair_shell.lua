local this = class("task_repair_shell", G_BaseConfig)
local core = G_Tables.TDTaskRepairTable.GetInstance()

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
  borthposid = 1,
  returnnewmark = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getBorthposid(offset)
  return core:GetInt(offset, this.indexMap.borthposid)
end

function this:_getReturnnewmark(offset)
  return core:GetInt(offset, this.indexMap.returnnewmark)
end

this.keyToMethodsMap = {
  id = this._getId,
  borthposid = this._getBorthposid,
  returnnewmark = this._getReturnnewmark
}
return this
