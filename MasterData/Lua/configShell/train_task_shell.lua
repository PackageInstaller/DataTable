local this = class("train_task_shell", G_BaseConfig)
local core = G_Tables.TDTrainTaskTable.GetInstance()

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
  taskid = 0,
  dungeonId = 1,
  taskType = 2,
  passReward = 3,
  unlockCondition = 4,
  taskName = 5,
  sortId = 6,
  dec = 7,
  groupType = 8,
  showTeamInterim = 9,
  heroId = 10,
  UnlockDefault = 11,
  heroBigPic = 12,
  heroBigbg = 13,
  heroTittlePic = 14,
  heroTittleColor = 15,
  bg = 16,
  pic1 = 17,
  pic2 = 18,
  pic3 = 19,
  pic2Param = 20,
  subname = 21,
  sex = 22
}

function this:_getTaskid(offset)
  return core:GetInt(offset, this.indexMap.taskid)
end

function this:_getDungeonid(offset)
  return core:GetInt(offset, this.indexMap.dungeonId)
end

function this:_getTasktype(offset)
  return core:GetInt(offset, this.indexMap.taskType)
end

function this:_getPassreward(offset)
  local str = core:GetVString(offset, this.indexMap.passReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getTaskname(offset)
  local langStr = G_TableMgrIns:GetLangStr("train_task", core:GetVString(offset, this.indexMap.taskName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "taskName")
end

function this:_getSortid(offset)
  return core:GetInt(offset, this.indexMap.sortId)
end

function this:_getDec(offset)
  local langStr = G_TableMgrIns:GetLangStr("train_task", core:GetVString(offset, this.indexMap.dec))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "dec")
end

function this:_getGrouptype(offset)
  return core:GetInt(offset, this.indexMap.groupType)
end

function this:_getShowteaminterim(offset)
  local str = core:GetVString(offset, this.indexMap.showTeamInterim).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroId)
end

function this:_getUnlockdefault(offset)
  return core:GetInt(offset, this.indexMap.UnlockDefault)
end

function this:_getHerobigpic(offset)
  local str = core:GetVString(offset, this.indexMap.heroBigPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getHerobigbg(offset)
  local str = core:GetVString(offset, this.indexMap.heroBigbg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getHerotittlepic(offset)
  local str = core:GetVString(offset, this.indexMap.heroTittlePic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getHerotittlecolor(offset)
  return core:GetVString(offset, this.indexMap.heroTittleColor).value
end

function this:_getBg(offset)
  local str = core:GetVString(offset, this.indexMap.bg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPic1(offset)
  local str = core:GetVString(offset, this.indexMap.pic1).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPic2(offset)
  local str = core:GetVString(offset, this.indexMap.pic2).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPic3(offset)
  local str = core:GetVString(offset, this.indexMap.pic3).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPic2param(offset)
  local str = core:GetVString(offset, this.indexMap.pic2Param).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSubname(offset)
  return core:GetVString(offset, this.indexMap.subname).value
end

function this:_getSex(offset)
  return core:GetInt(offset, this.indexMap.sex)
end

this.keyToMethodsMap = {
  taskid = this._getTaskid,
  dungeonId = this._getDungeonid,
  taskType = this._getTasktype,
  passReward = this._getPassreward,
  unlockCondition = this._getUnlockcondition,
  taskName = this._getTaskname,
  sortId = this._getSortid,
  dec = this._getDec,
  groupType = this._getGrouptype,
  showTeamInterim = this._getShowteaminterim,
  heroId = this._getHeroid,
  UnlockDefault = this._getUnlockdefault,
  heroBigPic = this._getHerobigpic,
  heroBigbg = this._getHerobigbg,
  heroTittlePic = this._getHerotittlepic,
  heroTittleColor = this._getHerotittlecolor,
  bg = this._getBg,
  pic1 = this._getPic1,
  pic2 = this._getPic2,
  pic3 = this._getPic3,
  pic2Param = this._getPic2param,
  subname = this._getSubname,
  sex = this._getSex
}
return this
