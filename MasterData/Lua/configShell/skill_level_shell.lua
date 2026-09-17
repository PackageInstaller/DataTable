local this = class("skill_level_shell", G_BaseConfig)
local core = G_Tables.TDSkillLevelTable.GetInstance()

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
  skillId = 1,
  level = 2,
  canUp = 3,
  gold = 4,
  item = 5,
  heroLevel = 6,
  heroRank = 7,
  subSkillId = 8,
  coolDown = 9,
  spCost = 10,
  skillDescribe = 11,
  skillDescribeDetail = 12,
  name = 13,
  skillPowerName = 14,
  skillPower = 15,
  value = 16,
  skillSpecialDesc = 17
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSkillid(offset)
  return core:GetInt(offset, this.indexMap.skillId)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getCanup(offset)
  return core:GetInt(offset, this.indexMap.canUp)
end

function this:_getGold(offset)
  return core:GetInt(offset, this.indexMap.gold)
end

function this:_getItem(offset)
  local str = core:GetVString(offset, this.indexMap.item).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getHerolevel(offset)
  return core:GetInt(offset, this.indexMap.heroLevel)
end

function this:_getHerorank(offset)
  return core:GetInt(offset, this.indexMap.heroRank)
end

function this:_getSubskillid(offset)
  return core:GetInt(offset, this.indexMap.subSkillId)
end

function this:_getCooldown(offset)
  return core:GetInt(offset, this.indexMap.coolDown)
end

function this:_getSpcost(offset)
  return core:GetInt(offset, this.indexMap.spCost)
end

function this:_getSkilldescribe(offset)
  local langStr = G_TableMgrIns:GetLangStr("skill_level", core:GetVString(offset, this.indexMap.skillDescribe))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "skillDescribe")
end

function this:_getSkilldescribedetail(offset)
  local langStr = G_TableMgrIns:GetLangStr("skill_level", core:GetVString(offset, this.indexMap.skillDescribeDetail))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "skillDescribeDetail")
end

function this:_getName(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("skill_level", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "skill_level")
end

function this:_getSkillpowername(offset)
  return core:GetInt(offset, this.indexMap.skillPowerName)
end

function this:_getSkillpower(offset)
  return core:GetInt(offset, this.indexMap.skillPower)
end

function this:_getValue(offset)
  local str = core:GetVString(offset, this.indexMap.value).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getSkillspecialdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("skill_level", core:GetVString(offset, this.indexMap.skillSpecialDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "skillSpecialDesc")
end

this.keyToMethodsMap = {
  id = this._getId,
  skillId = this._getSkillid,
  level = this._getLevel,
  canUp = this._getCanup,
  gold = this._getGold,
  item = this._getItem,
  heroLevel = this._getHerolevel,
  heroRank = this._getHerorank,
  subSkillId = this._getSubskillid,
  coolDown = this._getCooldown,
  spCost = this._getSpcost,
  skillDescribe = this._getSkilldescribe,
  skillDescribeDetail = this._getSkilldescribedetail,
  name = this._getName,
  skillPowerName = this._getSkillpowername,
  skillPower = this._getSkillpower,
  value = this._getValue,
  skillSpecialDesc = this._getSkillspecialdesc
}
return this
