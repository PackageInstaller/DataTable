local this = class("abbys_buff_group_shell", G_BaseConfig)
local core = G_Tables.TDAbbysBuffGroupTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, buffList = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getBufflist(offset)
  local str = core:GetVString(offset, this.indexMap.buffList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  buffList = this._getBufflist
}
return this
