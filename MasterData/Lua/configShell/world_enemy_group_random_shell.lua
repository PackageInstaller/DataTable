local this = class("world_enemy_group_random_shell", G_BaseConfig)
local core = G_Tables.TDWorldEnemyGroupRandomTable.GetInstance()

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
  enemyGroupRandom = 1,
  commonCondition = 2,
  conditionCompleteEnemyGroup = 3,
  slotTemplateGuid = 4,
  slotNum = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getEnemygrouprandom(offset)
  local str = core:GetVString(offset, this.indexMap.enemyGroupRandom).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "string")
end

function this:_getCommoncondition(offset)
  local str = core:GetVString(offset, this.indexMap.commonCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getConditioncompleteenemygroup(offset)
  local str = core:GetVString(offset, this.indexMap.conditionCompleteEnemyGroup).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "string")
end

function this:_getSlottemplateguid(offset)
  return core:GetBool(offset, this.indexMap.slotTemplateGuid)
end

function this:_getSlotnum(offset)
  return core:GetInt(offset, this.indexMap.slotNum)
end

this.keyToMethodsMap = {
  id = this._getId,
  enemyGroupRandom = this._getEnemygrouprandom,
  commonCondition = this._getCommoncondition,
  conditionCompleteEnemyGroup = this._getConditioncompleteenemygroup,
  slotTemplateGuid = this._getSlottemplateguid,
  slotNum = this._getSlotnum
}
return this
