local this = class("common_unlock_shell", G_BaseConfig)
local core = G_Tables.TDCommonUnlockTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {}
this.keyToMethodsMap = {}
return this
