local this = class("game_activity_levelgroup_shell", G_BaseConfig)
local core = G_Tables.TDGameActivityLevelgroupTable.GetInstance()

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
  showpet = 2,
  xmove = 3,
  yturn = 4,
  difficultybadge = 5,
  sortId = 6,
  introduce = 7,
  rewardshow = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_activity_levelgroup", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getShowpet(offset)
  return core:GetInt(offset, this.indexMap.showpet)
end

function this:_getXmove(offset)
  return core:GetFloat(offset, this.indexMap.xmove)
end

function this:_getYturn(offset)
  return core:GetFloat(offset, this.indexMap.yturn)
end

function this:_getDifficultybadge(offset)
  local str = core:GetVString(offset, this.indexMap.difficultybadge).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getSortid(offset)
  return core:GetInt(offset, this.indexMap.sortId)
end

function this:_getIntroduce(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_activity_levelgroup", core:GetVString(offset, this.indexMap.introduce))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "introduce")
end

function this:_getRewardshow(offset)
  local str = core:GetVString(offset, this.indexMap.rewardshow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  showpet = this._getShowpet,
  xmove = this._getXmove,
  yturn = this._getYturn,
  difficultybadge = this._getDifficultybadge,
  sortId = this._getSortid,
  introduce = this._getIntroduce,
  rewardshow = this._getRewardshow
}
return this
