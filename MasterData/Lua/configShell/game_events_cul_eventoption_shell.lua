local this = class("game_events_cul_eventoption_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulEventoptionTable.GetInstance()

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
  optionId = 0,
  unlockCondition = 1,
  weight = 2,
  invisibleUnlock = 3,
  unlockDesc = 4,
  buttonType = 5,
  optionIcon = 6,
  optionName = 7,
  optionDesc = 8,
  costPoints = 9,
  effect = 10,
  nextStep = 11,
  checkType = 12,
  checkDifficulty = 13,
  checklevel = 14,
  effectFail = 15,
  nextStepFail = 16
}

function this:_getOptionid(offset)
  return core:GetInt(offset, this.indexMap.optionId)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getWeight(offset)
  return core:GetInt(offset, this.indexMap.weight)
end

function this:_getInvisibleunlock(offset)
  return core:GetInt(offset, this.indexMap.invisibleUnlock)
end

function this:_getUnlockdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_eventoption", core:GetVString(offset, this.indexMap.unlockDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "unlockDesc")
end

function this:_getButtontype(offset)
  return core:GetInt(offset, this.indexMap.buttonType)
end

function this:_getOptionicon(offset)
  local str = core:GetVString(offset, this.indexMap.optionIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getOptionname(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_eventoption", core:GetVString(offset, this.indexMap.optionName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "optionName")
end

function this:_getOptiondesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_eventoption", core:GetVString(offset, this.indexMap.optionDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "optionDesc")
end

function this:_getCostpoints(offset)
  return core:GetInt(offset, this.indexMap.costPoints)
end

function this:_getEffect(offset)
  local str = core:GetVString(offset, this.indexMap.effect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNextstep(offset)
  return core:GetInt(offset, this.indexMap.nextStep)
end

function this:_getChecktype(offset)
  return core:GetInt(offset, this.indexMap.checkType)
end

function this:_getCheckdifficulty(offset)
  return core:GetInt(offset, this.indexMap.checkDifficulty)
end

function this:_getChecklevel(offset)
  return core:GetInt(offset, this.indexMap.checklevel)
end

function this:_getEffectfail(offset)
  local str = core:GetVString(offset, this.indexMap.effectFail).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNextstepfail(offset)
  return core:GetInt(offset, this.indexMap.nextStepFail)
end

this.keyToMethodsMap = {
  optionId = this._getOptionid,
  unlockCondition = this._getUnlockcondition,
  weight = this._getWeight,
  invisibleUnlock = this._getInvisibleunlock,
  unlockDesc = this._getUnlockdesc,
  buttonType = this._getButtontype,
  optionIcon = this._getOptionicon,
  optionName = this._getOptionname,
  optionDesc = this._getOptiondesc,
  costPoints = this._getCostpoints,
  effect = this._getEffect,
  nextStep = this._getNextstep,
  checkType = this._getChecktype,
  checkDifficulty = this._getCheckdifficulty,
  checklevel = this._getChecklevel,
  effectFail = this._getEffectfail,
  nextStepFail = this._getNextstepfail
}
return this
