local this = class("game_events_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsTable.GetInstance()

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
  show = 1,
  name = 2,
  type = 3,
  tabBg = 4,
  tabImg = 5,
  typeIcon = 6,
  condition = 7,
  lockText = 8,
  lockJump = 9,
  dropList = 10,
  guideTaskId = 11,
  endTaskId = 12,
  filterMarkId = 13,
  commonJump = 14,
  timelimit = 15,
  fakeTime = 16,
  endShowType = 17,
  autoWindow = 18,
  loopType = 19,
  loopInterval = 20,
  loopTime = 21,
  param = 22,
  sort = 23,
  desc = 24,
  rewardShow = 25,
  systemId = 26,
  unlockShow = 27,
  help = 28,
  preShowCondition = 29,
  currencyid = 30,
  ptShopId = 31,
  ptCurrencyId = 32,
  ptCurrencyMax = 33
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getShow(offset)
  return core:GetInt(offset, this.indexMap.show)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getTabbg(offset)
  local str = core:GetVString(offset, this.indexMap.tabBg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTabimg(offset)
  local str = core:GetVString(offset, this.indexMap.tabImg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTypeicon(offset)
  local str = core:GetVString(offset, this.indexMap.typeIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getLocktext(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("game_events", core:GetVString(offset, this.indexMap.lockText))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "game_events")
end

function this:_getLockjump(offset)
  local str = core:GetVString(offset, this.indexMap.lockJump).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDroplist(offset)
  local str = core:GetVString(offset, this.indexMap.dropList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getGuidetaskid(offset)
  return core:GetInt(offset, this.indexMap.guideTaskId)
end

function this:_getEndtaskid(offset)
  return core:GetInt(offset, this.indexMap.endTaskId)
end

function this:_getFiltermarkid(offset)
  return core:GetInt(offset, this.indexMap.filterMarkId)
end

function this:_getCommonjump(offset)
  return core:GetInt(offset, this.indexMap.commonJump)
end

function this:_getTimelimit(offset)
  return core:GetInt(offset, this.indexMap.timelimit)
end

function this:_getFaketime(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events", core:GetVString(offset, this.indexMap.fakeTime))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "fakeTime")
end

function this:_getEndshowtype(offset)
  return core:GetInt(offset, this.indexMap.endShowType)
end

function this:_getAutowindow(offset)
  return core:GetInt(offset, this.indexMap.autoWindow)
end

function this:_getLooptype(offset)
  return core:GetInt(offset, this.indexMap.loopType)
end

function this:_getLoopinterval(offset)
  return core:GetInt(offset, this.indexMap.loopInterval)
end

function this:_getLooptime(offset)
  return core:GetInt(offset, this.indexMap.loopTime)
end

function this:_getParam(offset)
  local str = core:GetVString(offset, this.indexMap.param).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSort(offset)
  return core:GetInt(offset, this.indexMap.sort)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getRewardshow(offset)
  local str = core:GetVString(offset, this.indexMap.rewardShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

function this:_getUnlockshow(offset)
  return core:GetInt(offset, this.indexMap.unlockShow)
end

function this:_getHelp(offset)
  return core:GetInt(offset, this.indexMap.help)
end

function this:_getPreshowcondition(offset)
  local str = core:GetVString(offset, this.indexMap.preShowCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getCurrencyid(offset)
  return core:GetInt(offset, this.indexMap.currencyid)
end

function this:_getPtshopid(offset)
  return core:GetInt(offset, this.indexMap.ptShopId)
end

function this:_getPtcurrencyid(offset)
  return core:GetInt(offset, this.indexMap.ptCurrencyId)
end

function this:_getPtcurrencymax(offset)
  return core:GetInt(offset, this.indexMap.ptCurrencyMax)
end

this.keyToMethodsMap = {
  id = this._getId,
  show = this._getShow,
  name = this._getName,
  type = this._getType,
  tabBg = this._getTabbg,
  tabImg = this._getTabimg,
  typeIcon = this._getTypeicon,
  condition = this._getCondition,
  lockText = this._getLocktext,
  lockJump = this._getLockjump,
  dropList = this._getDroplist,
  guideTaskId = this._getGuidetaskid,
  endTaskId = this._getEndtaskid,
  filterMarkId = this._getFiltermarkid,
  commonJump = this._getCommonjump,
  timelimit = this._getTimelimit,
  fakeTime = this._getFaketime,
  endShowType = this._getEndshowtype,
  autoWindow = this._getAutowindow,
  loopType = this._getLooptype,
  loopInterval = this._getLoopinterval,
  loopTime = this._getLooptime,
  param = this._getParam,
  sort = this._getSort,
  desc = this._getDesc,
  rewardShow = this._getRewardshow,
  systemId = this._getSystemid,
  unlockShow = this._getUnlockshow,
  help = this._getHelp,
  preShowCondition = this._getPreshowcondition,
  currencyid = this._getCurrencyid,
  ptShopId = this._getPtshopid,
  ptCurrencyId = this._getPtcurrencyid,
  ptCurrencyMax = this._getPtcurrencymax
}
return this
