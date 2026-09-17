local this = class("battle_pass_shell", G_BaseConfig)
local core = G_Tables.TDBattlePassTable.GetInstance()

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
  commonName = 1,
  advancedName = 2,
  advancedRewardShow = 3,
  luxuryName = 4,
  luxuryDesc = 5,
  advancedReward = 6,
  luxuryReward = 7,
  importantReward = 8,
  luxuryLevelReward = 9,
  startTime = 10,
  endTime = 11,
  rewardId = 12,
  taskIdDay = 13,
  taskIdWeek = 14,
  taskIdForever = 15,
  resourceId = 16,
  shorttermTip = 17,
  video = 18,
  upgradeName = 19
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCommonname(offset)
  local langStr = G_TableMgrIns:GetLangStr("battle_pass", core:GetVString(offset, this.indexMap.commonName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "commonName")
end

function this:_getAdvancedname(offset)
  local langStr = G_TableMgrIns:GetLangStr("battle_pass", core:GetVString(offset, this.indexMap.advancedName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "advancedName")
end

function this:_getAdvancedrewardshow(offset)
  local str = core:GetVString(offset, this.indexMap.advancedRewardShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getLuxuryname(offset)
  local langStr = G_TableMgrIns:GetLangStr("battle_pass", core:GetVString(offset, this.indexMap.luxuryName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "luxuryName")
end

function this:_getLuxurydesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("battle_pass", core:GetVString(offset, this.indexMap.luxuryDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "luxuryDesc")
end

function this:_getAdvancedreward(offset)
  local str = core:GetVString(offset, this.indexMap.advancedReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getLuxuryreward(offset)
  local str = core:GetVString(offset, this.indexMap.luxuryReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getImportantreward(offset)
  local str = core:GetVString(offset, this.indexMap.importantReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getLuxurylevelreward(offset)
  return core:GetInt(offset, this.indexMap.luxuryLevelReward)
end

function this:_getStarttime(offset)
  return core:GetVString(offset, this.indexMap.startTime).value
end

function this:_getEndtime(offset)
  return core:GetVString(offset, this.indexMap.endTime).value
end

function this:_getRewardid(offset)
  return core:GetInt(offset, this.indexMap.rewardId)
end

function this:_getTaskidday(offset)
  return core:GetInt(offset, this.indexMap.taskIdDay)
end

function this:_getTaskidweek(offset)
  return core:GetInt(offset, this.indexMap.taskIdWeek)
end

function this:_getTaskidforever(offset)
  return core:GetInt(offset, this.indexMap.taskIdForever)
end

function this:_getResourceid(offset)
  return core:GetInt(offset, this.indexMap.resourceId)
end

function this:_getShorttermtip(offset)
  return core:GetInt(offset, this.indexMap.shorttermTip)
end

function this:_getVideo(offset)
  local str = core:GetVString(offset, this.indexMap.video).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getUpgradename(offset)
  local langStr = G_TableMgrIns:GetLangStr("battle_pass", core:GetVString(offset, this.indexMap.upgradeName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "upgradeName")
end

this.keyToMethodsMap = {
  id = this._getId,
  commonName = this._getCommonname,
  advancedName = this._getAdvancedname,
  advancedRewardShow = this._getAdvancedrewardshow,
  luxuryName = this._getLuxuryname,
  luxuryDesc = this._getLuxurydesc,
  advancedReward = this._getAdvancedreward,
  luxuryReward = this._getLuxuryreward,
  importantReward = this._getImportantreward,
  luxuryLevelReward = this._getLuxurylevelreward,
  startTime = this._getStarttime,
  endTime = this._getEndtime,
  rewardId = this._getRewardid,
  taskIdDay = this._getTaskidday,
  taskIdWeek = this._getTaskidweek,
  taskIdForever = this._getTaskidforever,
  resourceId = this._getResourceid,
  shorttermTip = this._getShorttermtip,
  video = this._getVideo,
  upgradeName = this._getUpgradename
}
return this
