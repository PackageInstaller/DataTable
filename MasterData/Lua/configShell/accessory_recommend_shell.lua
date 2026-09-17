local this = class("accessory_recommend_shell", G_BaseConfig)
local core = G_Tables.TDAccessoryRecommendTable.GetInstance()

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
  recommend = 1,
  recommendSet1 = 2,
  recommendSet2 = 3,
  recommendSet3 = 4,
  recommendSkill = 5,
  recommend1 = 6,
  recommend2 = 7,
  recommend3 = 8,
  recommend4 = 9,
  recommend5 = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getRecommend(offset)
  return core:GetInt(offset, this.indexMap.recommend)
end

function this:_getRecommendset1(offset)
  local str = core:GetVString(offset, this.indexMap.recommendSet1).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRecommendset2(offset)
  local str = core:GetVString(offset, this.indexMap.recommendSet2).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRecommendset3(offset)
  local str = core:GetVString(offset, this.indexMap.recommendSet3).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRecommendskill(offset)
  local str = core:GetVString(offset, this.indexMap.recommendSkill).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRecommend1(offset)
  local str = core:GetVString(offset, this.indexMap.recommend1).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRecommend2(offset)
  local str = core:GetVString(offset, this.indexMap.recommend2).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRecommend3(offset)
  local str = core:GetVString(offset, this.indexMap.recommend3).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRecommend4(offset)
  local str = core:GetVString(offset, this.indexMap.recommend4).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRecommend5(offset)
  local str = core:GetVString(offset, this.indexMap.recommend5).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  recommend = this._getRecommend,
  recommendSet1 = this._getRecommendset1,
  recommendSet2 = this._getRecommendset2,
  recommendSet3 = this._getRecommendset3,
  recommendSkill = this._getRecommendskill,
  recommend1 = this._getRecommend1,
  recommend2 = this._getRecommend2,
  recommend3 = this._getRecommend3,
  recommend4 = this._getRecommend4,
  recommend5 = this._getRecommend5
}
return this
