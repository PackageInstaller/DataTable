local this = class("battle_hit_anim_shell", G_BaseConfig)
local core = G_Tables.TDBattleHitAnimTable.GetInstance()

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
  hitStartFrame = 1,
  hitHStartFrame = 2,
  hitAirStartFrame = 3,
  hitHAirStartFrame = 4,
  hitWaterStartFrame = 5,
  hitHWaterStartFrame = 6,
  breakStartFrame = 7,
  breakAirStartFrame = 8,
  breakWaterStartFrame = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getHitstartframe(offset)
  return core:GetInt(offset, this.indexMap.hitStartFrame)
end

function this:_getHithstartframe(offset)
  return core:GetInt(offset, this.indexMap.hitHStartFrame)
end

function this:_getHitairstartframe(offset)
  return core:GetInt(offset, this.indexMap.hitAirStartFrame)
end

function this:_getHithairstartframe(offset)
  return core:GetInt(offset, this.indexMap.hitHAirStartFrame)
end

function this:_getHitwaterstartframe(offset)
  return core:GetInt(offset, this.indexMap.hitWaterStartFrame)
end

function this:_getHithwaterstartframe(offset)
  return core:GetInt(offset, this.indexMap.hitHWaterStartFrame)
end

function this:_getBreakstartframe(offset)
  return core:GetInt(offset, this.indexMap.breakStartFrame)
end

function this:_getBreakairstartframe(offset)
  return core:GetInt(offset, this.indexMap.breakAirStartFrame)
end

function this:_getBreakwaterstartframe(offset)
  return core:GetInt(offset, this.indexMap.breakWaterStartFrame)
end

this.keyToMethodsMap = {
  id = this._getId,
  hitStartFrame = this._getHitstartframe,
  hitHStartFrame = this._getHithstartframe,
  hitAirStartFrame = this._getHitairstartframe,
  hitHAirStartFrame = this._getHithairstartframe,
  hitWaterStartFrame = this._getHitwaterstartframe,
  hitHWaterStartFrame = this._getHithwaterstartframe,
  breakStartFrame = this._getBreakstartframe,
  breakAirStartFrame = this._getBreakairstartframe,
  breakWaterStartFrame = this._getBreakwaterstartframe
}
return this
