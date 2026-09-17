local this = class("rogue_activity_difficulty_shell", G_BaseConfig)
local core = G_Tables.TDRogueActivityDifficultyTable.GetInstance()

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
  difficultygather = 1,
  levelnum = 2,
  enemylevel = 3,
  difficultIndex = 4,
  difficultIndexAlly = 5,
  integral = 6,
  commoncarpweight = 7,
  rarecarpweight = 8,
  epiccarpweight = 9,
  skillPoint = 10,
  levelDrop = 11
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDifficultygather(offset)
  return core:GetInt(offset, this.indexMap.difficultygather)
end

function this:_getLevelnum(offset)
  return core:GetInt(offset, this.indexMap.levelnum)
end

function this:_getEnemylevel(offset)
  return core:GetInt(offset, this.indexMap.enemylevel)
end

function this:_getDifficultindex(offset)
  local str = core:GetVString(offset, this.indexMap.difficultIndex).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDifficultindexally(offset)
  local str = core:GetVString(offset, this.indexMap.difficultIndexAlly).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getIntegral(offset)
  return core:GetInt(offset, this.indexMap.integral)
end

function this:_getCommoncarpweight(offset)
  return core:GetInt(offset, this.indexMap.commoncarpweight)
end

function this:_getRarecarpweight(offset)
  return core:GetInt(offset, this.indexMap.rarecarpweight)
end

function this:_getEpiccarpweight(offset)
  return core:GetInt(offset, this.indexMap.epiccarpweight)
end

function this:_getSkillpoint(offset)
  return core:GetInt(offset, this.indexMap.skillPoint)
end

function this:_getLeveldrop(offset)
  local str = core:GetVString(offset, this.indexMap.levelDrop).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  difficultygather = this._getDifficultygather,
  levelnum = this._getLevelnum,
  enemylevel = this._getEnemylevel,
  difficultIndex = this._getDifficultindex,
  difficultIndexAlly = this._getDifficultindexally,
  integral = this._getIntegral,
  commoncarpweight = this._getCommoncarpweight,
  rarecarpweight = this._getRarecarpweight,
  epiccarpweight = this._getEpiccarpweight,
  skillPoint = this._getSkillpoint,
  levelDrop = this._getLeveldrop
}
return this
