local this = class("abbys_level_shell", G_BaseConfig)
local core = G_Tables.TDAbbysLevelTable.GetInstance()

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
  condition = 2,
  uiperform = 3,
  mode = 4,
  team = 5,
  dungeonId = 6,
  star = 7,
  levelReward = 8,
  boss = 9,
  bossArtResource = 10,
  offset = 11,
  recommandAttr = 12,
  buffId = 13,
  buffGroupid = 14,
  challenge = 15,
  challengeDes = 16
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("abbys_level", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getUiperform(offset)
  local str = core:GetVString(offset, this.indexMap.uiperform).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getMode(offset)
  return core:GetInt(offset, this.indexMap.mode)
end

function this:_getTeam(offset)
  return core:GetInt(offset, this.indexMap.team)
end

function this:_getDungeonid(offset)
  local str = core:GetVString(offset, this.indexMap.dungeonId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getStar(offset)
  return core:GetInt(offset, this.indexMap.star)
end

function this:_getLevelreward(offset)
  local str = core:GetVString(offset, this.indexMap.levelReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getBoss(offset)
  local str = core:GetVString(offset, this.indexMap.boss).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBossartresource(offset)
  local str = core:GetVString(offset, this.indexMap.bossArtResource).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getOffset(offset)
  local str = core:GetVString(offset, this.indexMap.offset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRecommandattr(offset)
  local str = core:GetVString(offset, this.indexMap.recommandAttr).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getBuffid(offset)
  return core:GetInt(offset, this.indexMap.buffId)
end

function this:_getBuffgroupid(offset)
  local str = core:GetVString(offset, this.indexMap.buffGroupid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getChallenge(offset)
  return core:GetVString(offset, this.indexMap.challenge).value
end

function this:_getChallengedes(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("abbys_level", core:GetVString(offset, this.indexMap.challengeDes))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "abbys_level")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  condition = this._getCondition,
  uiperform = this._getUiperform,
  mode = this._getMode,
  team = this._getTeam,
  dungeonId = this._getDungeonid,
  star = this._getStar,
  levelReward = this._getLevelreward,
  boss = this._getBoss,
  bossArtResource = this._getBossartresource,
  offset = this._getOffset,
  recommandAttr = this._getRecommandattr,
  buffId = this._getBuffid,
  buffGroupid = this._getBuffgroupid,
  challenge = this._getChallenge,
  challengeDes = this._getChallengedes
}
return this
