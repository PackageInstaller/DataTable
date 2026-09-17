local this = class("world_enemy_group_shell", G_BaseConfig)
local core = G_Tables.TDWorldEnemyGroupTable.GetInstance()

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
  enemyList = 1,
  enemyAI = 2,
  worldFsm = 3,
  enemyGroupAI = 4,
  appearCondition = 5,
  displayCount = 6,
  fillDisplayType = 7,
  settleType = 8,
  noEscape = 9,
  canRiding = 10,
  changeableBattleRadius = 11,
  enterBattleRange = 12,
  battleRadius = 13,
  battleStartTimeline = 14,
  battleEndTimeline = 15,
  battleFsmType = 16,
  timeLimit = 17,
  worldPropertyList = 18,
  canForceKill = 19,
  defaultMoveTypeList = 20,
  groupType = 21,
  domainRange = 22,
  campType = 23,
  deathBorthpos = 24,
  enemyGroupType = 25,
  maxInstanceLimit = 26,
  battleInOutBgmEvent = 27,
  slotTemplateGuid = 28,
  slotNum = 29,
  disableAutoHeal = 30
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getEnemylist(offset)
  local str = core:GetVString(offset, this.indexMap.enemyList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getEnemyai(offset)
  local str = core:GetVString(offset, this.indexMap.enemyAI).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWorldfsm(offset)
  local str = core:GetVString(offset, this.indexMap.worldFsm).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getEnemygroupai(offset)
  return core:GetInt(offset, this.indexMap.enemyGroupAI)
end

function this:_getAppearcondition(offset)
  return core:GetInt(offset, this.indexMap.appearCondition)
end

function this:_getDisplaycount(offset)
  return core:GetInt(offset, this.indexMap.displayCount)
end

function this:_getFilldisplaytype(offset)
  return core:GetInt(offset, this.indexMap.fillDisplayType)
end

function this:_getSettletype(offset)
  return core:GetInt(offset, this.indexMap.settleType)
end

function this:_getNoescape(offset)
  return core:GetInt(offset, this.indexMap.noEscape)
end

function this:_getCanriding(offset)
  return core:GetInt(offset, this.indexMap.canRiding)
end

function this:_getChangeablebattleradius(offset)
  return core:GetInt(offset, this.indexMap.changeableBattleRadius)
end

function this:_getEnterbattlerange(offset)
  return core:GetInt(offset, this.indexMap.enterBattleRange)
end

function this:_getBattleradius(offset)
  return core:GetInt(offset, this.indexMap.battleRadius)
end

function this:_getBattlestarttimeline(offset)
  return core:GetInt(offset, this.indexMap.battleStartTimeline)
end

function this:_getBattleendtimeline(offset)
  return core:GetVString(offset, this.indexMap.battleEndTimeline).value
end

function this:_getBattlefsmtype(offset)
  return core:GetInt(offset, this.indexMap.battleFsmType)
end

function this:_getTimelimit(offset)
  return core:GetInt(offset, this.indexMap.timeLimit)
end

function this:_getWorldpropertylist(offset)
  local str = core:GetVString(offset, this.indexMap.worldPropertyList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCanforcekill(offset)
  return core:GetBool(offset, this.indexMap.canForceKill)
end

function this:_getDefaultmovetypelist(offset)
  local str = core:GetVString(offset, this.indexMap.defaultMoveTypeList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getGrouptype(offset)
  return core:GetInt(offset, this.indexMap.groupType)
end

function this:_getDomainrange(offset)
  return core:GetInt(offset, this.indexMap.domainRange)
end

function this:_getCamptype(offset)
  return core:GetInt(offset, this.indexMap.campType)
end

function this:_getDeathborthpos(offset)
  return core:GetInt(offset, this.indexMap.deathBorthpos)
end

function this:_getEnemygrouptype(offset)
  return core:GetInt(offset, this.indexMap.enemyGroupType)
end

function this:_getMaxinstancelimit(offset)
  return core:GetInt(offset, this.indexMap.maxInstanceLimit)
end

function this:_getBattleinoutbgmevent(offset)
  return core:GetVString(offset, this.indexMap.battleInOutBgmEvent).value
end

function this:_getSlottemplateguid(offset)
  return core:GetBool(offset, this.indexMap.slotTemplateGuid)
end

function this:_getSlotnum(offset)
  return core:GetInt(offset, this.indexMap.slotNum)
end

function this:_getDisableautoheal(offset)
  return core:GetInt(offset, this.indexMap.disableAutoHeal)
end

this.keyToMethodsMap = {
  id = this._getId,
  enemyList = this._getEnemylist,
  enemyAI = this._getEnemyai,
  worldFsm = this._getWorldfsm,
  enemyGroupAI = this._getEnemygroupai,
  appearCondition = this._getAppearcondition,
  displayCount = this._getDisplaycount,
  fillDisplayType = this._getFilldisplaytype,
  settleType = this._getSettletype,
  noEscape = this._getNoescape,
  canRiding = this._getCanriding,
  changeableBattleRadius = this._getChangeablebattleradius,
  enterBattleRange = this._getEnterbattlerange,
  battleRadius = this._getBattleradius,
  battleStartTimeline = this._getBattlestarttimeline,
  battleEndTimeline = this._getBattleendtimeline,
  battleFsmType = this._getBattlefsmtype,
  timeLimit = this._getTimelimit,
  worldPropertyList = this._getWorldpropertylist,
  canForceKill = this._getCanforcekill,
  defaultMoveTypeList = this._getDefaultmovetypelist,
  groupType = this._getGrouptype,
  domainRange = this._getDomainrange,
  campType = this._getCamptype,
  deathBorthpos = this._getDeathborthpos,
  enemyGroupType = this._getEnemygrouptype,
  maxInstanceLimit = this._getMaxinstancelimit,
  battleInOutBgmEvent = this._getBattleinoutbgmevent,
  slotTemplateGuid = this._getSlottemplateguid,
  slotNum = this._getSlotnum,
  disableAutoHeal = this._getDisableautoheal
}
return this
