local this = class("kibo_duel_competition_season_shell", G_BaseConfig)
local core = G_Tables.TDKiboDuelCompetitionSeasonTable.GetInstance()

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
  timelimitId = 1,
  rewardGroup = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.ID)
end

function this:_getTimelimitid(offset)
  return core:GetInt(offset, this.indexMap.timelimitId)
end

function this:_getRewardgroup(offset)
  local str = core:GetVString(offset, this.indexMap.rewardGroup).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  ID = this._getId,
  timelimitId = this._getTimelimitid,
  rewardGroup = this._getRewardgroup
}
return this
