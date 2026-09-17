local this = class("game_events_cul_skill_tree_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulSkillTreeTable.GetInstance()

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
  skillnode = 0,
  preNode = 1,
  systemId = 2,
  isInitial = 3,
  attribute = 4,
  needValue = 5,
  pos = 6,
  condition = 7,
  style = 8,
  icon = 9,
  skillName = 10,
  skillDesc = 11,
  buffid = 12,
  herointerimid = 13,
  petinterimid = 14
}

function this:_getSkillnode(offset)
  return core:GetInt(offset, this.indexMap.skillnode)
end

function this:_getPrenode(offset)
  return core:GetInt(offset, this.indexMap.preNode)
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

function this:_getIsinitial(offset)
  return core:GetInt(offset, this.indexMap.isInitial)
end

function this:_getAttribute(offset)
  return core:GetInt(offset, this.indexMap.attribute)
end

function this:_getNeedvalue(offset)
  return core:GetInt(offset, this.indexMap.needValue)
end

function this:_getPos(offset)
  return core:GetInt(offset, this.indexMap.pos)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getStyle(offset)
  return core:GetInt(offset, this.indexMap.style)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getSkillname(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_skill_tree", core:GetVString(offset, this.indexMap.skillName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "skillName")
end

function this:_getSkilldesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_skill_tree", core:GetVString(offset, this.indexMap.skillDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "skillDesc")
end

function this:_getBuffid(offset)
  return core:GetInt(offset, this.indexMap.buffid)
end

function this:_getHerointerimid(offset)
  local str = core:GetVString(offset, this.indexMap.herointerimid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPetinterimid(offset)
  local str = core:GetVString(offset, this.indexMap.petinterimid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  skillnode = this._getSkillnode,
  preNode = this._getPrenode,
  systemId = this._getSystemid,
  isInitial = this._getIsinitial,
  attribute = this._getAttribute,
  needValue = this._getNeedvalue,
  pos = this._getPos,
  condition = this._getCondition,
  style = this._getStyle,
  icon = this._getIcon,
  skillName = this._getSkillname,
  skillDesc = this._getSkilldesc,
  buffid = this._getBuffid,
  herointerimid = this._getHerointerimid,
  petinterimid = this._getPetinterimid
}
return this
