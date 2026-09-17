local this = class("game_events_cul_assistlevel_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulAssistlevelTable.GetInstance()

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
  Id = 0,
  assisId = 1,
  bondLevel = 2,
  needPoints = 3,
  effect = 4,
  name = 5,
  unlockdesc = 6,
  traindesc = 7,
  icon = 8,
  assistoriginid = 9,
  isflash = 10,
  desc = 11,
  storyId = 12,
  lvlupeffect = 13,
  assistTrainWeight = 14,
  assistTrainModifier = 15,
  bondTrainProbability = 16,
  bondTrainModifier = 17,
  assistTrainAdd = 18,
  assistmoodModifieradd = 19,
  assistStaminacost = 20,
  finalscore = 21
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getAssisid(offset)
  return core:GetInt(offset, this.indexMap.assisId)
end

function this:_getBondlevel(offset)
  return core:GetInt(offset, this.indexMap.bondLevel)
end

function this:_getNeedpoints(offset)
  return core:GetInt(offset, this.indexMap.needPoints)
end

function this:_getEffect(offset)
  local str = core:GetVString(offset, this.indexMap.effect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_assistlevel", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getUnlockdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_assistlevel", core:GetVString(offset, this.indexMap.unlockdesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "unlockdesc")
end

function this:_getTraindesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_assistlevel", core:GetVString(offset, this.indexMap.traindesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "traindesc")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getAssistoriginid(offset)
  return core:GetInt(offset, this.indexMap.assistoriginid)
end

function this:_getIsflash(offset)
  return core:GetBool(offset, this.indexMap.isflash)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_assistlevel", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getStoryid(offset)
  return core:GetInt(offset, this.indexMap.storyId)
end

function this:_getLvlupeffect(offset)
  local str = core:GetVString(offset, this.indexMap.lvlupeffect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getAssisttrainweight(offset)
  local str = core:GetVString(offset, this.indexMap.assistTrainWeight).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getAssisttrainmodifier(offset)
  return core:GetInt(offset, this.indexMap.assistTrainModifier)
end

function this:_getBondtrainprobability(offset)
  return core:GetInt(offset, this.indexMap.bondTrainProbability)
end

function this:_getBondtrainmodifier(offset)
  return core:GetInt(offset, this.indexMap.bondTrainModifier)
end

function this:_getAssisttrainadd(offset)
  local str = core:GetVString(offset, this.indexMap.assistTrainAdd).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getAssistmoodmodifieradd(offset)
  return core:GetInt(offset, this.indexMap.assistmoodModifieradd)
end

function this:_getAssiststaminacost(offset)
  return core:GetInt(offset, this.indexMap.assistStaminacost)
end

function this:_getFinalscore(offset)
  return core:GetInt(offset, this.indexMap.finalscore)
end

this.keyToMethodsMap = {
  Id = this._getId,
  assisId = this._getAssisid,
  bondLevel = this._getBondlevel,
  needPoints = this._getNeedpoints,
  effect = this._getEffect,
  name = this._getName,
  unlockdesc = this._getUnlockdesc,
  traindesc = this._getTraindesc,
  icon = this._getIcon,
  assistoriginid = this._getAssistoriginid,
  isflash = this._getIsflash,
  desc = this._getDesc,
  storyId = this._getStoryid,
  lvlupeffect = this._getLvlupeffect,
  assistTrainWeight = this._getAssisttrainweight,
  assistTrainModifier = this._getAssisttrainmodifier,
  bondTrainProbability = this._getBondtrainprobability,
  bondTrainModifier = this._getBondtrainmodifier,
  assistTrainAdd = this._getAssisttrainadd,
  assistmoodModifieradd = this._getAssistmoodmodifieradd,
  assistStaminacost = this._getAssiststaminacost,
  finalscore = this._getFinalscore
}
return this
