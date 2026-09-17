local this = class("goods_group_shell", G_BaseConfig)
local core = G_Tables.TDGoodsGroupTable.GetInstance()

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
