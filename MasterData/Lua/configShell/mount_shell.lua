local this = class("mount_shell", G_BaseConfig)
local core = G_Tables.TDMountTable.GetInstance()

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
  moveType = 2,
  defaultMoveType = 3,
  defaultMoveTypeWater = 4,
  defaultMoveTypeAir = 5,
  moveDesc = 6,
  desc = 7,
  rarity = 8,
  controlConfig = 9,
  icon = 10,
  defaultSaddle = 11,
  unlock = 12,
  unlockCondition = 13,
  homelevelshow = 14,
  fast_move_speed = 15,
  deceleration = 16,
  max_fly_distance = 17,
  landing_distance = 18,
  sprint_cd = 19,
  collisionType = 20,
  consume = 21,
  dashCost = 22,
  jumpCost = 23,
  skillCost = 24,
  min_water_depth = 25,
  collider_info = 26,
  skillAbility = 27,
  skillCastType = 28,
  changeFlyOffset = 29,
  rideonAirOffset = 30,
  ParagliderMaxStamina = 31,
  ParagliderStaminaCost = 32,
  ParagliderStaminaRecover = 33,
  ParagliderStaminaGiveOut = 34,
  isFixedspeed = 35
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("mount", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getMovetype(offset)
  local str = core:GetVString(offset, this.indexMap.moveType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDefaultmovetype(offset)
  return core:GetInt(offset, this.indexMap.defaultMoveType)
end

function this:_getDefaultmovetypewater(offset)
  return core:GetInt(offset, this.indexMap.defaultMoveTypeWater)
end

function this:_getDefaultmovetypeair(offset)
  return core:GetInt(offset, this.indexMap.defaultMoveTypeAir)
end

function this:_getMovedesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("mount", core:GetVString(offset, this.indexMap.moveDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "moveDesc")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("mount", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getControlconfig(offset)
  local str = core:GetVString(offset, this.indexMap.controlConfig).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIcon(offset)
  return core:GetVString(offset, this.indexMap.icon).value
end

function this:_getDefaultsaddle(offset)
  local str = core:GetVString(offset, this.indexMap.defaultSaddle).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getUnlock(offset)
  return core:GetInt(offset, this.indexMap.unlock)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHomelevelshow(offset)
  return core:GetInt(offset, this.indexMap.homelevelshow)
end

function this:_getFast_move_speed(offset)
  return core:GetInt(offset, this.indexMap.fast_move_speed)
end

function this:_getDeceleration(offset)
  return core:GetFloat(offset, this.indexMap.deceleration)
end

function this:_getMax_fly_distance(offset)
  return core:GetFloat(offset, this.indexMap.max_fly_distance)
end

function this:_getLanding_distance(offset)
  return core:GetFloat(offset, this.indexMap.landing_distance)
end

function this:_getSprint_cd(offset)
  local str = core:GetVString(offset, this.indexMap.sprint_cd).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCollisiontype(offset)
  return core:GetInt(offset, this.indexMap.collisionType)
end

function this:_getConsume(offset)
  local str = core:GetVString(offset, this.indexMap.consume).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDashcost(offset)
  return core:GetFloat(offset, this.indexMap.dashCost)
end

function this:_getJumpcost(offset)
  return core:GetFloat(offset, this.indexMap.jumpCost)
end

function this:_getSkillcost(offset)
  return core:GetFloat(offset, this.indexMap.skillCost)
end

function this:_getMin_water_depth(offset)
  return core:GetFloat(offset, this.indexMap.min_water_depth)
end

function this:_getCollider_info(offset)
  local str = core:GetVString(offset, this.indexMap.collider_info).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSkillability(offset)
  return core:GetInt(offset, this.indexMap.skillAbility)
end

function this:_getSkillcasttype(offset)
  local str = core:GetVString(offset, this.indexMap.skillCastType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getChangeflyoffset(offset)
  return core:GetFloat(offset, this.indexMap.changeFlyOffset)
end

function this:_getRideonairoffset(offset)
  return core:GetFloat(offset, this.indexMap.rideonAirOffset)
end

function this:_getParaglidermaxstamina(offset)
  return core:GetFloat(offset, this.indexMap.ParagliderMaxStamina)
end

function this:_getParagliderstaminacost(offset)
  return core:GetFloat(offset, this.indexMap.ParagliderStaminaCost)
end

function this:_getParagliderstaminarecover(offset)
  return core:GetFloat(offset, this.indexMap.ParagliderStaminaRecover)
end

function this:_getParagliderstaminagiveout(offset)
  return core:GetFloat(offset, this.indexMap.ParagliderStaminaGiveOut)
end

function this:_getIsfixedspeed(offset)
  return core:GetInt(offset, this.indexMap.isFixedspeed)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  moveType = this._getMovetype,
  defaultMoveType = this._getDefaultmovetype,
  defaultMoveTypeWater = this._getDefaultmovetypewater,
  defaultMoveTypeAir = this._getDefaultmovetypeair,
  moveDesc = this._getMovedesc,
  desc = this._getDesc,
  rarity = this._getRarity,
  controlConfig = this._getControlconfig,
  icon = this._getIcon,
  defaultSaddle = this._getDefaultsaddle,
  unlock = this._getUnlock,
  unlockCondition = this._getUnlockcondition,
  homelevelshow = this._getHomelevelshow,
  fast_move_speed = this._getFast_move_speed,
  deceleration = this._getDeceleration,
  max_fly_distance = this._getMax_fly_distance,
  landing_distance = this._getLanding_distance,
  sprint_cd = this._getSprint_cd,
  collisionType = this._getCollisiontype,
  consume = this._getConsume,
  dashCost = this._getDashcost,
  jumpCost = this._getJumpcost,
  skillCost = this._getSkillcost,
  min_water_depth = this._getMin_water_depth,
  collider_info = this._getCollider_info,
  skillAbility = this._getSkillability,
  skillCastType = this._getSkillcasttype,
  changeFlyOffset = this._getChangeflyoffset,
  rideonAirOffset = this._getRideonairoffset,
  ParagliderMaxStamina = this._getParaglidermaxstamina,
  ParagliderStaminaCost = this._getParagliderstaminacost,
  ParagliderStaminaRecover = this._getParagliderstaminarecover,
  ParagliderStaminaGiveOut = this._getParagliderstaminagiveout,
  isFixedspeed = this._getIsfixedspeed
}
return this
