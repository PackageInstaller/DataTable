local this = class("accessory_customed_shell", G_BaseConfig)
local core = G_Tables.TDAccessoryCustomedTable.GetInstance()

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
  accessoryId = 1,
  extra = 2,
  kiboScore = 3,
  score = 4,
  scoreLimit = 5,
  grade = 6,
  quality = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getAccessoryid(offset)
  return core:GetInt(offset, this.indexMap.accessoryId)
end

function this:_getExtra(offset)
  return core:GetInt(offset, this.indexMap.extra)
end

function this:_getKiboscore(offset)
  return core:GetInt(offset, this.indexMap.kiboScore)
end

function this:_getScore(offset)
  return core:GetInt(offset, this.indexMap.score)
end

function this:_getScorelimit(offset)
  return core:GetInt(offset, this.indexMap.scoreLimit)
end

function this:_getGrade(offset)
  return core:GetInt(offset, this.indexMap.grade)
end

function this:_getQuality(offset)
  local str = core:GetVString(offset, this.indexMap.quality).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  accessoryId = this._getAccessoryid,
  extra = this._getExtra,
  kiboScore = this._getKiboscore,
  score = this._getScore,
  scoreLimit = this._getScorelimit,
  grade = this._getGrade,
  quality = this._getQuality
}
return this
