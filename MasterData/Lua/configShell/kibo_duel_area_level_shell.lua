local this = class("kibo_duel_area_level_shell", G_BaseConfig)
local core = G_Tables.TDKiboDuelAreaLevelTable.GetInstance()

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
  areaType = 1,
  name = 2,
  level = 3,
  level_num = 4,
  exp = 5,
  kiboDuelDecs = 6,
  kiboDuelSkill = 7,
  reward = 8,
  taskId = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getAreatype(offset)
  return core:GetInt(offset, this.indexMap.areaType)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("kibo_duel_area_level", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getLevel_num(offset)
  local str = core:GetVString(offset, this.indexMap.level_num).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getExp(offset)
  return core:GetInt(offset, this.indexMap.exp)
end

function this:_getKibodueldecs(offset)
  local langStr = G_TableMgrIns:GetLangStr("kibo_duel_area_level", core:GetVString(offset, this.indexMap.kiboDuelDecs))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "kiboDuelDecs")
end

function this:_getKiboduelskill(offset)
  local str = core:GetVString(offset, this.indexMap.kiboDuelSkill).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getTaskid(offset)
  return core:GetInt(offset, this.indexMap.taskId)
end

this.keyToMethodsMap = {
  Id = this._getId,
  areaType = this._getAreatype,
  name = this._getName,
  level = this._getLevel,
  level_num = this._getLevel_num,
  exp = this._getExp,
  kiboDuelDecs = this._getKibodueldecs,
  kiboDuelSkill = this._getKiboduelskill,
  reward = this._getReward,
  taskId = this._getTaskid
}
return this
