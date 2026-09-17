local this = class("kibo_duel_pvp_shell", G_BaseConfig)
local core = G_Tables.TDKiboDuelPvpTable.GetInstance()

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
  dungeonId = 1,
  isLevel = 2,
  level = 3,
  soulLinkLevel = 4,
  KiboNumber = 5,
  art = 6,
  blueprintId = 7,
  minimumKibo = 8,
  skillList = 9,
  skillNumber = 10,
  passiveSkillList = 11,
  cost = 12,
  costTime = 13,
  buffTime = 14,
  time = 15,
  masterState = 16,
  summonType = 17,
  fsm = 18,
  defaultTime = 19,
  timePassAvailable = 20,
  npc = 21,
  matching_rules = 22
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDungeonid(offset)
  return core:GetInt(offset, this.indexMap.dungeonId)
end

function this:_getIslevel(offset)
  return core:GetInt(offset, this.indexMap.isLevel)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getSoullinklevel(offset)
  return core:GetInt(offset, this.indexMap.soulLinkLevel)
end

function this:_getKibonumber(offset)
  return core:GetInt(offset, this.indexMap.KiboNumber)
end

function this:_getArt(offset)
  return core:GetInt(offset, this.indexMap.art)
end

function this:_getBlueprintid(offset)
  return core:GetInt(offset, this.indexMap.blueprintId)
end

function this:_getMinimumkibo(offset)
  return core:GetInt(offset, this.indexMap.minimumKibo)
end

function this:_getSkilllist(offset)
  local str = core:GetVString(offset, this.indexMap.skillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSkillnumber(offset)
  return core:GetInt(offset, this.indexMap.skillNumber)
end

function this:_getPassiveskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.passiveSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCost(offset)
  local str = core:GetVString(offset, this.indexMap.cost).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getCosttime(offset)
  local str = core:GetVString(offset, this.indexMap.costTime).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getBufftime(offset)
  local str = core:GetVString(offset, this.indexMap.buffTime).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getTime(offset)
  return core:GetInt(offset, this.indexMap.time)
end

function this:_getMasterstate(offset)
  return core:GetInt(offset, this.indexMap.masterState)
end

function this:_getSummontype(offset)
  local str = core:GetVString(offset, this.indexMap.summonType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getFsm(offset)
  local str = core:GetVString(offset, this.indexMap.fsm).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDefaulttime(offset)
  return core:GetInt(offset, this.indexMap.defaultTime)
end

function this:_getTimepassavailable(offset)
  return core:GetInt(offset, this.indexMap.timePassAvailable)
end

function this:_getNpc(offset)
  local str = core:GetVString(offset, this.indexMap.npc).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMatching_rules(offset)
  return core:GetInt(offset, this.indexMap.matching_rules)
end

this.keyToMethodsMap = {
  id = this._getId,
  dungeonId = this._getDungeonid,
  isLevel = this._getIslevel,
  level = this._getLevel,
  soulLinkLevel = this._getSoullinklevel,
  KiboNumber = this._getKibonumber,
  art = this._getArt,
  blueprintId = this._getBlueprintid,
  minimumKibo = this._getMinimumkibo,
  skillList = this._getSkilllist,
  skillNumber = this._getSkillnumber,
  passiveSkillList = this._getPassiveskilllist,
  cost = this._getCost,
  costTime = this._getCosttime,
  buffTime = this._getBufftime,
  time = this._getTime,
  masterState = this._getMasterstate,
  summonType = this._getSummontype,
  fsm = this._getFsm,
  defaultTime = this._getDefaulttime,
  timePassAvailable = this._getTimepassavailable,
  npc = this._getNpc,
  matching_rules = this._getMatching_rules
}
return this
