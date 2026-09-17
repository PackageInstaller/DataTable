local this = class("monthly_card_shell", G_BaseConfig)
local core = G_Tables.TDMonthlyCardTable.GetInstance()

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
  name = 1,
  charge = 2,
  purchaseSdkID = 3,
  reward = 4,
  buff = 5,
  dailyReward = 6,
  day = 7,
  remindMail = 8,
  expireMail = 9,
  maxDay = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("monthly_card", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getCharge(offset)
  return core:GetInt(offset, this.indexMap.charge)
end

function this:_getPurchasesdkid(offset)
  return core:GetInt(offset, this.indexMap.purchaseSdkID)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getBuff(offset)
  return core:GetVString(offset, this.indexMap.buff).value
end

function this:_getDailyreward(offset)
  local str = core:GetVString(offset, this.indexMap.dailyReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDay(offset)
  return core:GetInt(offset, this.indexMap.day)
end

function this:_getRemindmail(offset)
  return core:GetInt(offset, this.indexMap.remindMail)
end

function this:_getExpiremail(offset)
  return core:GetInt(offset, this.indexMap.expireMail)
end

function this:_getMaxday(offset)
  return core:GetInt(offset, this.indexMap.maxDay)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  charge = this._getCharge,
  purchaseSdkID = this._getPurchasesdkid,
  reward = this._getReward,
  buff = this._getBuff,
  dailyReward = this._getDailyreward,
  day = this._getDay,
  remindMail = this._getRemindmail,
  expireMail = this._getExpiremail,
  maxDay = this._getMaxday
}
return this
