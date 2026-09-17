local this = class("accessory_score_shell", G_BaseConfig)
local core = G_Tables.TDAccessoryScoreTable.GetInstance()

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
  ID = 0,
  score = 1,
  icon = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.ID)
end

function this:_getScore(offset)
  local str = core:GetVString(offset, this.indexMap.score).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  ID = this._getId,
  score = this._getScore,
  icon = this._getIcon
}
return this
