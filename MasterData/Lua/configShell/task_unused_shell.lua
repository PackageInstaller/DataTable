local this = class("task_unused_shell", G_BaseConfig)
local core = G_Tables.TDTaskUnusedTable.GetInstance()

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
  type = 1,
  tabType = 2,
  unlockcondition = 3,
  filter = 4,
  autoAccept = 5,
  newShow = 6,
  canRepeat = 7,
  name = 8,
  desc = 9,
  taskReward = 10,
  pic = 11,
  worldShow = 12,
  mapShow = 13,
  levelParameter = 14,
  difficultIndex = 15
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getTabtype(offset)
  return core:GetInt(offset, this.indexMap.tabType)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockcondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getFilter(offset)
  return core:GetInt(offset, this.indexMap.filter)
end

function this:_getAutoaccept(offset)
  return core:GetInt(offset, this.indexMap.autoAccept)
end

function this:_getNewshow(offset)
  return core:GetInt(offset, this.indexMap.newShow)
end

function this:_getCanrepeat(offset)
  return core:GetInt(offset, this.indexMap.canRepeat)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("task_unused", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("task_unused", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getTaskreward(offset)
  local str = core:GetVString(offset, this.indexMap.taskReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPic(offset)
  local str = core:GetVString(offset, this.indexMap.pic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getWorldshow(offset)
  return core:GetInt(offset, this.indexMap.worldShow)
end

function this:_getMapshow(offset)
  return core:GetInt(offset, this.indexMap.mapShow)
end

function this:_getLevelparameter(offset)
  return core:GetInt(offset, this.indexMap.levelParameter)
end

function this:_getDifficultindex(offset)
  local str = core:GetVString(offset, this.indexMap.difficultIndex).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  tabType = this._getTabtype,
  unlockcondition = this._getUnlockcondition,
  filter = this._getFilter,
  autoAccept = this._getAutoaccept,
  newShow = this._getNewshow,
  canRepeat = this._getCanrepeat,
  name = this._getName,
  desc = this._getDesc,
  taskReward = this._getTaskreward,
  pic = this._getPic,
  worldShow = this._getWorldshow,
  mapShow = this._getMapshow,
  levelParameter = this._getLevelparameter,
  difficultIndex = this._getDifficultindex
}
return this
