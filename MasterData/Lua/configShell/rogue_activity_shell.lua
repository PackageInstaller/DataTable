local this = class("rogue_activity_shell", G_BaseConfig)
local core = G_Tables.TDRogueActivityTable.GetInstance()

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
  mode = 1,
  turnId = 2,
  difficulty = 3,
  prelevel = 4,
  unlockCondition = 5,
  lockTips = 6,
  name = 7,
  difficultDec = 8,
  initialEffectDetails = 9,
  buffDec = 10,
  buffId = 11,
  rogueMapLeft = 12,
  linerender = 13,
  enemy = 14,
  levelPath = 15
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getMode(offset)
  return core:GetInt(offset, this.indexMap.mode)
end

function this:_getTurnid(offset)
  return core:GetInt(offset, this.indexMap.turnId)
end

function this:_getDifficulty(offset)
  return core:GetInt(offset, this.indexMap.difficulty)
end

function this:_getPrelevel(offset)
  return core:GetInt(offset, this.indexMap.prelevel)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getLocktips(offset)
  local langStr = G_TableMgrIns:GetLangStr("rogue_activity", core:GetVString(offset, this.indexMap.lockTips))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "lockTips")
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("rogue_activity", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDifficultdec(offset)
  local langStr = G_TableMgrIns:GetLangStr("rogue_activity", core:GetVString(offset, this.indexMap.difficultDec))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "difficultDec")
end

function this:_getInitialeffectdetails(offset)
  local str = core:GetVString(offset, this.indexMap.initialEffectDetails).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBuffdec(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("rogue_activity", core:GetVString(offset, this.indexMap.buffDec))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "rogue_activity")
end

function this:_getBuffid(offset)
  local str = core:GetVString(offset, this.indexMap.buffId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRoguemapleft(offset)
  local str = core:GetVString(offset, this.indexMap.rogueMapLeft).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getLinerender(offset)
  return core:GetInt(offset, this.indexMap.linerender)
end

function this:_getEnemy(offset)
  local str = core:GetVString(offset, this.indexMap.enemy).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getLevelpath(offset)
  return core:GetInt(offset, this.indexMap.levelPath)
end

this.keyToMethodsMap = {
  id = this._getId,
  mode = this._getMode,
  turnId = this._getTurnid,
  difficulty = this._getDifficulty,
  prelevel = this._getPrelevel,
  unlockCondition = this._getUnlockcondition,
  lockTips = this._getLocktips,
  name = this._getName,
  difficultDec = this._getDifficultdec,
  initialEffectDetails = this._getInitialeffectdetails,
  buffDec = this._getBuffdec,
  buffId = this._getBuffid,
  rogueMapLeft = this._getRoguemapleft,
  linerender = this._getLinerender,
  enemy = this._getEnemy,
  levelPath = this._getLevelpath
}
return this
