local this = class("world_tools_breakable_property_shell", G_BaseConfig)
local core = G_Tables.TDWorldToolsBreakablePropertyTable.GetInstance()

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
