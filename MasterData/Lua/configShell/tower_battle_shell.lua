local this = class("tower_battle_shell", G_BaseConfig)
local core = G_Tables.TDTowerBattleTable.GetInstance()

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
  towerId = 1,
  order = 2,
  battleId = 3,
  levelName = 4,
  enemyId = 5,
  reward = 6,
  scoreReward = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTowerid(offset)
  return core:GetInt(offset, this.indexMap.towerId)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getBattleid(offset)
  return core:GetInt(offset, this.indexMap.battleId)
end

function this:_getLevelname(offset)
  local langStr = G_TableMgrIns:GetLangStr("tower_battle", core:GetVString(offset, this.indexMap.levelName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "levelName")
end

function this:_getEnemyid(offset)
  local str = core:GetVString(offset, this.indexMap.enemyId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getScorereward(offset)
  return core:GetInt(offset, this.indexMap.scoreReward)
end

this.keyToMethodsMap = {
  id = this._getId,
  towerId = this._getTowerid,
  order = this._getOrder,
  battleId = this._getBattleid,
  levelName = this._getLevelname,
  enemyId = this._getEnemyid,
  reward = this._getReward,
  scoreReward = this._getScorereward
}
return this
