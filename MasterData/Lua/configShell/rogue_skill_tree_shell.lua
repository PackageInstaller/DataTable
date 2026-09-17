local this = class("rogue_skill_tree_shell", G_BaseConfig)
local core = G_Tables.TDRogueSkillTreeTable.GetInstance()

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
  name = 1,
  description = 2,
  icon = 3,
  locationx = 4,
  locationy = 5,
  type = 6,
  linkid = 7,
  isinitial = 8,
  cost = 9,
  battleinfo = 10,
  buffid = 11,
  effectid = 12
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("rogue_skill_tree", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDescription(offset)
  local langStr = G_TableMgrIns:GetLangStr("rogue_skill_tree", core:GetVString(offset, this.indexMap.description))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "description")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getLocationx(offset)
  return core:GetInt(offset, this.indexMap.locationx)
end

function this:_getLocationy(offset)
  return core:GetInt(offset, this.indexMap.locationy)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getLinkid(offset)
  local str = core:GetVString(offset, this.indexMap.linkid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIsinitial(offset)
  return core:GetBool(offset, this.indexMap.isinitial)
end

function this:_getCost(offset)
  return core:GetInt(offset, this.indexMap.cost)
end

function this:_getBattleinfo(offset)
  local str = core:GetVString(offset, this.indexMap.battleinfo).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getBuffid(offset)
  local str = core:GetVString(offset, this.indexMap.buffid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getEffectid(offset)
  local str = core:GetVString(offset, this.indexMap.effectid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  description = this._getDescription,
  icon = this._getIcon,
  locationx = this._getLocationx,
  locationy = this._getLocationy,
  type = this._getType,
  linkid = this._getLinkid,
  isinitial = this._getIsinitial,
  cost = this._getCost,
  battleinfo = this._getBattleinfo,
  buffid = this._getBuffid,
  effectid = this._getEffectid
}
return this
