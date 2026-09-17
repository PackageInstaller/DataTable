local this = class("world_interact_shell", G_BaseConfig)
local core = G_Tables.TDWorldInteractTable.GetInstance()

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
  desc = 1,
  icon = 2,
  interactRange = 3,
  interactLeaveRange = 4,
  interactAngle = 5,
  interactHeroAngle = 6,
  interactCond = 7,
  interactAction = 8,
  interactSE = 9,
  relatedHuds = 10,
  leaveInteract = 11,
  abilityPath = 12,
  battleInteract = 13,
  interactEffectType = 14,
  priority = 15,
  stroke = 16,
  interactCD = 17
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("world_interact", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getInteractrange(offset)
  return core:GetFloat(offset, this.indexMap.interactRange)
end

function this:_getInteractleaverange(offset)
  return core:GetFloat(offset, this.indexMap.interactLeaveRange)
end

function this:_getInteractangle(offset)
  local str = core:GetVString(offset, this.indexMap.interactAngle).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getInteractheroangle(offset)
  local str = core:GetVString(offset, this.indexMap.interactHeroAngle).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getInteractcond(offset)
  local str = core:GetVString(offset, this.indexMap.interactCond).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getInteractaction(offset)
  return core:GetInt(offset, this.indexMap.interactAction)
end

function this:_getInteractse(offset)
  return core:GetVString(offset, this.indexMap.interactSE).value
end

function this:_getRelatedhuds(offset)
  local str = core:GetVString(offset, this.indexMap.relatedHuds).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getLeaveinteract(offset)
  return core:GetInt(offset, this.indexMap.leaveInteract)
end

function this:_getAbilitypath(offset)
  return core:GetVString(offset, this.indexMap.abilityPath).value
end

function this:_getBattleinteract(offset)
  return core:GetInt(offset, this.indexMap.battleInteract)
end

function this:_getInteracteffecttype(offset)
  return core:GetInt(offset, this.indexMap.interactEffectType)
end

function this:_getPriority(offset)
  return core:GetInt(offset, this.indexMap.priority)
end

function this:_getStroke(offset)
  return core:GetBool(offset, this.indexMap.stroke)
end

function this:_getInteractcd(offset)
  return core:GetInt(offset, this.indexMap.interactCD)
end

this.keyToMethodsMap = {
  id = this._getId,
  desc = this._getDesc,
  icon = this._getIcon,
  interactRange = this._getInteractrange,
  interactLeaveRange = this._getInteractleaverange,
  interactAngle = this._getInteractangle,
  interactHeroAngle = this._getInteractheroangle,
  interactCond = this._getInteractcond,
  interactAction = this._getInteractaction,
  interactSE = this._getInteractse,
  relatedHuds = this._getRelatedhuds,
  leaveInteract = this._getLeaveinteract,
  abilityPath = this._getAbilitypath,
  battleInteract = this._getBattleinteract,
  interactEffectType = this._getInteracteffecttype,
  priority = this._getPriority,
  stroke = this._getStroke,
  interactCD = this._getInteractcd
}
return this
