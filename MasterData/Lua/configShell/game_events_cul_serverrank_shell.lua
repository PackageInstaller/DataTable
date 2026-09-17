local this = class("game_events_cul_serverrank_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulServerrankTable.GetInstance()

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
  gameeventid = 1,
  needscore = 2,
  predictpercent = 3,
  isrank = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGameeventid(offset)
  return core:GetInt(offset, this.indexMap.gameeventid)
end

function this:_getNeedscore(offset)
  return core:GetInt(offset, this.indexMap.needscore)
end

function this:_getPredictpercent(offset)
  return core:GetInt(offset, this.indexMap.predictpercent)
end

function this:_getIsrank(offset)
  return core:GetInt(offset, this.indexMap.isrank)
end

this.keyToMethodsMap = {
  id = this._getId,
  gameeventid = this._getGameeventid,
  needscore = this._getNeedscore,
  predictpercent = this._getPredictpercent,
  isrank = this._getIsrank
}
return this
