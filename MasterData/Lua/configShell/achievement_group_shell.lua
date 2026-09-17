local this = class("achievement_group_shell", G_BaseConfig)
local core = G_Tables.TDAchievementGroupTable.GetInstance()

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
  achiName = 1,
  achiType = 2,
  achiOrder = 3,
  achiRes = 4,
  achiGroupId = 5,
  achiPage = 6,
  reward = 7,
  achiPageWord = 8,
  achiText = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getAchiname(offset)
  local langStr = G_TableMgrIns:GetLangStr("achievement_group", core:GetVString(offset, this.indexMap.achiName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "achiName")
end

function this:_getAchitype(offset)
  return core:GetInt(offset, this.indexMap.achiType)
end

function this:_getAchiorder(offset)
  return core:GetInt(offset, this.indexMap.achiOrder)
end

function this:_getAchires(offset)
  local str = core:GetVString(offset, this.indexMap.achiRes).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getAchigroupid(offset)
  return core:GetInt(offset, this.indexMap.achiGroupId)
end

function this:_getAchipage(offset)
  local str = core:GetVString(offset, this.indexMap.achiPage).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getAchipageword(offset)
  local str = core:GetVString(offset, this.indexMap.achiPageWord).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getAchitext(offset)
  return core:GetVString(offset, this.indexMap.achiText).value
end

this.keyToMethodsMap = {
  id = this._getId,
  achiName = this._getAchiname,
  achiType = this._getAchitype,
  achiOrder = this._getAchiorder,
  achiRes = this._getAchires,
  achiGroupId = this._getAchigroupid,
  achiPage = this._getAchipage,
  reward = this._getReward,
  achiPageWord = this._getAchipageword,
  achiText = this._getAchitext
}
return this
