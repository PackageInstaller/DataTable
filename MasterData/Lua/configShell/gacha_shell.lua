local this = class("gacha_shell", G_BaseConfig)
local core = G_Tables.TDGachaTable.GetInstance()

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
  gachaId = 0,
  gachaType = 1,
  gachaName = 2,
  resourcenamekey = 3,
  timelimit = 4,
  tabPic = 5,
  bannerPic = 6,
  trialActivity = 7,
  gachaLimit = 8,
  probList = 9,
  guaranteeId = 10,
  onlyTenPull = 11,
  tenPullDiscount = 12,
  specialRule = 13,
  stepId = 14,
  upReward = 15,
  selfChoose = 16,
  selfChooseuplist = 17,
  selfChooseEntry = 18,
  paygoodsid = 19
}

function this:_getGachaid(offset)
  return core:GetInt(offset, this.indexMap.gachaId)
end

function this:_getGachatype(offset)
  return core:GetInt(offset, this.indexMap.gachaType)
end

function this:_getGachaname(offset)
  local langStr = G_TableMgrIns:GetLangStr("gacha", core:GetVString(offset, this.indexMap.gachaName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "gachaName")
end

function this:_getResourcenamekey(offset)
  return core:GetVString(offset, this.indexMap.resourcenamekey).value
end

function this:_getTimelimit(offset)
  return core:GetInt(offset, this.indexMap.timelimit)
end

function this:_getTabpic(offset)
  local str = core:GetVString(offset, this.indexMap.tabPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 0)
end

function this:_getBannerpic(offset)
  local str = core:GetVString(offset, this.indexMap.bannerPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 0)
end

function this:_getTrialactivity(offset)
  return core:GetInt(offset, this.indexMap.trialActivity)
end

function this:_getGachalimit(offset)
  return core:GetInt(offset, this.indexMap.gachaLimit)
end

function this:_getProblist(offset)
  return core:GetInt(offset, this.indexMap.probList)
end

function this:_getGuaranteeid(offset)
  local str = core:GetVString(offset, this.indexMap.guaranteeId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getOnlytenpull(offset)
  return core:GetInt(offset, this.indexMap.onlyTenPull)
end

function this:_getTenpulldiscount(offset)
  return core:GetInt(offset, this.indexMap.tenPullDiscount)
end

function this:_getSpecialrule(offset)
  local str = core:GetVString(offset, this.indexMap.specialRule).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getStepid(offset)
  return core:GetInt(offset, this.indexMap.stepId)
end

function this:_getUpreward(offset)
  return core:GetInt(offset, this.indexMap.upReward)
end

function this:_getSelfchoose(offset)
  return core:GetInt(offset, this.indexMap.selfChoose)
end

function this:_getSelfchooseuplist(offset)
  local str = core:GetVString(offset, this.indexMap.selfChooseuplist).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSelfchooseentry(offset)
  return core:GetInt(offset, this.indexMap.selfChooseEntry)
end

function this:_getPaygoodsid(offset)
  local str = core:GetVString(offset, this.indexMap.paygoodsid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  gachaId = this._getGachaid,
  gachaType = this._getGachatype,
  gachaName = this._getGachaname,
  resourcenamekey = this._getResourcenamekey,
  timelimit = this._getTimelimit,
  tabPic = this._getTabpic,
  bannerPic = this._getBannerpic,
  trialActivity = this._getTrialactivity,
  gachaLimit = this._getGachalimit,
  probList = this._getProblist,
  guaranteeId = this._getGuaranteeid,
  onlyTenPull = this._getOnlytenpull,
  tenPullDiscount = this._getTenpulldiscount,
  specialRule = this._getSpecialrule,
  stepId = this._getStepid,
  upReward = this._getUpreward,
  selfChoose = this._getSelfchoose,
  selfChooseuplist = this._getSelfchooseuplist,
  selfChooseEntry = this._getSelfchooseentry,
  paygoodsid = this._getPaygoodsid
}
return this
