local this = class("kibo_duel_group_shell", G_BaseConfig)
local core = G_Tables.TDKiboDuelGroupTable.GetInstance()

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
  chapterID = 1,
  levelName = 2,
  levelNpc = 3,
  dec = 4,
  levelNum = 5,
  offset = 6,
  nextLevel = 7,
  stamina = 8,
  unlockCondition = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getChapterid(offset)
  return core:GetInt(offset, this.indexMap.chapterID)
end

function this:_getLevelname(offset)
  local langStr = G_TableMgrIns:GetLangStr("kibo_duel_group", core:GetVString(offset, this.indexMap.levelName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "levelName")
end

function this:_getLevelnpc(offset)
  local langStr = G_TableMgrIns:GetLangStr("kibo_duel_group", core:GetVString(offset, this.indexMap.levelNpc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "levelNpc")
end

function this:_getDec(offset)
  local langStr = G_TableMgrIns:GetLangStr("kibo_duel_group", core:GetVString(offset, this.indexMap.dec))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "dec")
end

function this:_getLevelnum(offset)
  local langStr = G_TableMgrIns:GetLangStr("kibo_duel_group", core:GetVString(offset, this.indexMap.levelNum))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "levelNum")
end

function this:_getOffset(offset)
  local str = core:GetVString(offset, this.indexMap.offset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNextlevel(offset)
  local str = core:GetVString(offset, this.indexMap.nextLevel).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getStamina(offset)
  return core:GetInt(offset, this.indexMap.stamina)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

this.keyToMethodsMap = {
  id = this._getId,
  chapterID = this._getChapterid,
  levelName = this._getLevelname,
  levelNpc = this._getLevelnpc,
  dec = this._getDec,
  levelNum = this._getLevelnum,
  offset = this._getOffset,
  nextLevel = this._getNextlevel,
  stamina = this._getStamina,
  unlockCondition = this._getUnlockcondition
}
return this
