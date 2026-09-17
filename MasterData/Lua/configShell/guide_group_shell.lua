local this = class("guide_group_shell", G_BaseConfig)
local core = G_Tables.TDGuideGroupTable.GetInstance()

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
  bavTreePath = 1,
  isWorking = 2,
  guideType = 3,
  guidePriority = 4,
  isBreak = 5,
  triggerSource = 6,
  guideAndCondition = 7,
  guideOrCondition = 8,
  triggerScene = 9,
  isRepeat = 10,
  guideAndDisableCondition = 11,
  guideOrDisableCondition = 12,
  isBattle = 13,
  isNoBattle = 14,
  tutorialId = 15,
  mutualExclusion = 16,
  playableId = 17,
  isHome = 18,
  isBattleGuide = 19
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getBavtreepath(offset)
  local str = core:GetVString(offset, this.indexMap.bavTreePath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIsworking(offset)
  return core:GetBool(offset, this.indexMap.isWorking)
end

function this:_getGuidetype(offset)
  return core:GetInt(offset, this.indexMap.guideType)
end

function this:_getGuidepriority(offset)
  return core:GetInt(offset, this.indexMap.guidePriority)
end

function this:_getIsbreak(offset)
  return core:GetBool(offset, this.indexMap.isBreak)
end

function this:_getTriggersource(offset)
  return core:GetInt(offset, this.indexMap.triggerSource)
end

function this:_getGuideandcondition(offset)
  local str = core:GetVString(offset, this.indexMap.guideAndCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getGuideorcondition(offset)
  local str = core:GetVString(offset, this.indexMap.guideOrCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTriggerscene(offset)
  local str = core:GetVString(offset, this.indexMap.triggerScene).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIsrepeat(offset)
  return core:GetBool(offset, this.indexMap.isRepeat)
end

function this:_getGuideanddisablecondition(offset)
  local str = core:GetVString(offset, this.indexMap.guideAndDisableCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getGuideordisablecondition(offset)
  local str = core:GetVString(offset, this.indexMap.guideOrDisableCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIsbattle(offset)
  return core:GetBool(offset, this.indexMap.isBattle)
end

function this:_getIsnobattle(offset)
  return core:GetBool(offset, this.indexMap.isNoBattle)
end

function this:_getTutorialid(offset)
  local str = core:GetVString(offset, this.indexMap.tutorialId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMutualexclusion(offset)
  local str = core:GetVString(offset, this.indexMap.mutualExclusion).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPlayableid(offset)
  local str = core:GetVString(offset, this.indexMap.playableId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIshome(offset)
  return core:GetBool(offset, this.indexMap.isHome)
end

function this:_getIsbattleguide(offset)
  return core:GetInt(offset, this.indexMap.isBattleGuide)
end

this.keyToMethodsMap = {
  id = this._getId,
  bavTreePath = this._getBavtreepath,
  isWorking = this._getIsworking,
  guideType = this._getGuidetype,
  guidePriority = this._getGuidepriority,
  isBreak = this._getIsbreak,
  triggerSource = this._getTriggersource,
  guideAndCondition = this._getGuideandcondition,
  guideOrCondition = this._getGuideorcondition,
  triggerScene = this._getTriggerscene,
  isRepeat = this._getIsrepeat,
  guideAndDisableCondition = this._getGuideanddisablecondition,
  guideOrDisableCondition = this._getGuideordisablecondition,
  isBattle = this._getIsbattle,
  isNoBattle = this._getIsnobattle,
  tutorialId = this._getTutorialid,
  mutualExclusion = this._getMutualexclusion,
  playableId = this._getPlayableid,
  isHome = this._getIshome,
  isBattleGuide = this._getIsbattleguide
}
return this
