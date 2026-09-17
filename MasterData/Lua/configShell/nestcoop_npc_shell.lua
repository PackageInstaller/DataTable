local this = class("nestcoop_npc_shell", G_BaseConfig)
local core = G_Tables.TDNestcoopNpcTable.GetInstance()

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
  heroID = 1,
  condition = 2,
  playercard_dress_id = 3,
  starlinkCardParam = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroID)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getPlayercard_dress_id(offset)
  return core:GetInt(offset, this.indexMap.playercard_dress_id)
end

function this:_getStarlinkcardparam(offset)
  local str = core:GetVString(offset, this.indexMap.starlinkCardParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  heroID = this._getHeroid,
  condition = this._getCondition,
  playercard_dress_id = this._getPlayercard_dress_id,
  starlinkCardParam = this._getStarlinkcardparam
}
return this
