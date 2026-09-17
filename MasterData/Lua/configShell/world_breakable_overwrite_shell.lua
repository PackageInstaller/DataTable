local this = class("world_breakable_overwrite_shell", G_BaseConfig)
local core = G_Tables.TDWorldBreakableOverwriteTable.GetInstance()

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
  speed = 1,
  duration = 2,
  amount = 3,
  useBlink = 4,
  blinkColor = 5,
  blinkRange = 6,
  mediaPack = 7,
  mediaPackAttack = 8,
  mediaPackOffset = 9,
  Gravity = 10,
  Shrink = 11,
  YForceSpeed = 12,
  MessChaos = 13,
  ForceMin = 14,
  ForceMax = 15,
  RForceMin = 16,
  RForceMax = 17,
  allStep = 18,
  AllBloodList = 19,
  AllWeaponDamage = 20,
  DisWeapon = 21,
  AdvWeapon = 22,
  canAttackCD = 23,
  EffectLoopName = 24,
  EffectHitName = 25,
  breakableType = 26,
  disElemental = 27,
  advElemental = 28,
  rightSkillId = 29,
  wrongSkillId = 30,
  param = 31,
  stringParam = 32,
  intParam = 33,
  boolParam = 34,
  toolTypeID = 35,
  ItemDistance = 36,
  AttackForceScale = 37,
  AttackYDelta = 38,
  mediaPackScale = 39,
  eatHp = 40,
  trackHud = 41,
  aoiType = 42
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSpeed(offset)
  return core:GetFloat(offset, this.indexMap.speed)
end

function this:_getDuration(offset)
  return core:GetFloat(offset, this.indexMap.duration)
end

function this:_getAmount(offset)
  return core:GetFloat(offset, this.indexMap.amount)
end

function this:_getUseblink(offset)
  return core:GetInt(offset, this.indexMap.useBlink)
end

function this:_getBlinkcolor(offset)
  return core:GetVString(offset, this.indexMap.blinkColor).value
end

function this:_getBlinkrange(offset)
  return core:GetFloat(offset, this.indexMap.blinkRange)
end

function this:_getMediapack(offset)
  local str = core:GetVString(offset, this.indexMap.mediaPack).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getMediapackattack(offset)
  return core:GetVString(offset, this.indexMap.mediaPackAttack).value
end

function this:_getMediapackoffset(offset)
  return core:GetFloat(offset, this.indexMap.mediaPackOffset)
end

function this:_getGravity(offset)
  return core:GetFloat(offset, this.indexMap.Gravity)
end

function this:_getShrink(offset)
  return core:GetFloat(offset, this.indexMap.Shrink)
end

function this:_getYforcespeed(offset)
  return core:GetFloat(offset, this.indexMap.YForceSpeed)
end

function this:_getMesschaos(offset)
  return core:GetFloat(offset, this.indexMap.MessChaos)
end

function this:_getForcemin(offset)
  return core:GetFloat(offset, this.indexMap.ForceMin)
end

function this:_getForcemax(offset)
  return core:GetFloat(offset, this.indexMap.ForceMax)
end

function this:_getRforcemin(offset)
  return core:GetFloat(offset, this.indexMap.RForceMin)
end

function this:_getRforcemax(offset)
  return core:GetFloat(offset, this.indexMap.RForceMax)
end

function this:_getAllstep(offset)
  return core:GetFloat(offset, this.indexMap.allStep)
end

function this:_getAllbloodlist(offset)
  return core:GetVString(offset, this.indexMap.AllBloodList).value
end

function this:_getAllweapondamage(offset)
  return core:GetVString(offset, this.indexMap.AllWeaponDamage).value
end

function this:_getDisweapon(offset)
  return core:GetVString(offset, this.indexMap.DisWeapon).value
end

function this:_getAdvweapon(offset)
  return core:GetVString(offset, this.indexMap.AdvWeapon).value
end

function this:_getCanattackcd(offset)
  return core:GetFloat(offset, this.indexMap.canAttackCD)
end

function this:_getEffectloopname(offset)
  return core:GetVString(offset, this.indexMap.EffectLoopName).value
end

function this:_getEffecthitname(offset)
  return core:GetVString(offset, this.indexMap.EffectHitName).value
end

function this:_getBreakabletype(offset)
  return core:GetInt(offset, this.indexMap.breakableType)
end

function this:_getDiselemental(offset)
  return core:GetVString(offset, this.indexMap.disElemental).value
end

function this:_getAdvelemental(offset)
  return core:GetVString(offset, this.indexMap.advElemental).value
end

function this:_getRightskillid(offset)
  return core:GetInt(offset, this.indexMap.rightSkillId)
end

function this:_getWrongskillid(offset)
  return core:GetInt(offset, this.indexMap.wrongSkillId)
end

function this:_getParam(offset)
  local str = core:GetVString(offset, this.indexMap.param).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "number")
end

function this:_getStringparam(offset)
  local str = core:GetVString(offset, this.indexMap.stringParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "string")
end

function this:_getIntparam(offset)
  local str = core:GetVString(offset, this.indexMap.intParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "number")
end

function this:_getBoolparam(offset)
  local str = core:GetVString(offset, this.indexMap.boolParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string")
end

function this:_getTooltypeid(offset)
  return core:GetInt(offset, this.indexMap.toolTypeID)
end

function this:_getItemdistance(offset)
  return core:GetFloat(offset, this.indexMap.ItemDistance)
end

function this:_getAttackforcescale(offset)
  return core:GetFloat(offset, this.indexMap.AttackForceScale)
end

function this:_getAttackydelta(offset)
  return core:GetFloat(offset, this.indexMap.AttackYDelta)
end

function this:_getMediapackscale(offset)
  return core:GetFloat(offset, this.indexMap.mediaPackScale)
end

function this:_getEathp(offset)
  return core:GetInt(offset, this.indexMap.eatHp)
end

function this:_getTrackhud(offset)
  return core:GetFloat(offset, this.indexMap.trackHud)
end

function this:_getAoitype(offset)
  return core:GetFloat(offset, this.indexMap.aoiType)
end

this.keyToMethodsMap = {
  id = this._getId,
  speed = this._getSpeed,
  duration = this._getDuration,
  amount = this._getAmount,
  useBlink = this._getUseblink,
  blinkColor = this._getBlinkcolor,
  blinkRange = this._getBlinkrange,
  mediaPack = this._getMediapack,
  mediaPackAttack = this._getMediapackattack,
  mediaPackOffset = this._getMediapackoffset,
  Gravity = this._getGravity,
  Shrink = this._getShrink,
  YForceSpeed = this._getYforcespeed,
  MessChaos = this._getMesschaos,
  ForceMin = this._getForcemin,
  ForceMax = this._getForcemax,
  RForceMin = this._getRforcemin,
  RForceMax = this._getRforcemax,
  allStep = this._getAllstep,
  AllBloodList = this._getAllbloodlist,
  AllWeaponDamage = this._getAllweapondamage,
  DisWeapon = this._getDisweapon,
  AdvWeapon = this._getAdvweapon,
  canAttackCD = this._getCanattackcd,
  EffectLoopName = this._getEffectloopname,
  EffectHitName = this._getEffecthitname,
  breakableType = this._getBreakabletype,
  disElemental = this._getDiselemental,
  advElemental = this._getAdvelemental,
  rightSkillId = this._getRightskillid,
  wrongSkillId = this._getWrongskillid,
  param = this._getParam,
  stringParam = this._getStringparam,
  intParam = this._getIntparam,
  boolParam = this._getBoolparam,
  toolTypeID = this._getTooltypeid,
  ItemDistance = this._getItemdistance,
  AttackForceScale = this._getAttackforcescale,
  AttackYDelta = this._getAttackydelta,
  mediaPackScale = this._getMediapackscale,
  eatHp = this._getEathp,
  trackHud = this._getTrackhud,
  aoiType = this._getAoitype
}
return this
