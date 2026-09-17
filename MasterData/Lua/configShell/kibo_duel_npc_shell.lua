local this = class("kibo_duel_npc_shell", G_BaseConfig)
local core = G_Tables.TDKiboDuelNpcTable.GetInstance()

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
  heroId = 1,
  npcInfo = 2,
  npcPos = 3,
  lv1enemy = 4,
  lv2enemy = 5,
  lv3enemy = 6,
  skillList = 7,
  passiveSkillList = 8,
  behaviortree = 9,
  param = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroId)
end

function this:_getNpcinfo(offset)
  local str = core:GetVString(offset, this.indexMap.npcInfo).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getNpcpos(offset)
  local str = core:GetVString(offset, this.indexMap.npcPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getLv1enemy(offset)
  local str = core:GetVString(offset, this.indexMap.lv1enemy).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getLv2enemy(offset)
  local str = core:GetVString(offset, this.indexMap.lv2enemy).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getLv3enemy(offset)
  local str = core:GetVString(offset, this.indexMap.lv3enemy).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getSkilllist(offset)
  local str = core:GetVString(offset, this.indexMap.skillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPassiveskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.passiveSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBehaviortree(offset)
  return core:GetInt(offset, this.indexMap.behaviortree)
end

function this:_getParam(offset)
  local str = core:GetVString(offset, this.indexMap.param).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  heroId = this._getHeroid,
  npcInfo = this._getNpcinfo,
  npcPos = this._getNpcpos,
  lv1enemy = this._getLv1enemy,
  lv2enemy = this._getLv2enemy,
  lv3enemy = this._getLv3enemy,
  skillList = this._getSkilllist,
  passiveSkillList = this._getPassiveskilllist,
  behaviortree = this._getBehaviortree,
  param = this._getParam
}
return this
