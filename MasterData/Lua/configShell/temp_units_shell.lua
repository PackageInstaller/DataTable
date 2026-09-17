local this = class("temp_units_shell", G_BaseConfig)
local core = G_Tables.TDTempUnitsTable.GetInstance()

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
  model_id = 1,
  unit_type = 2,
  max_hp = 3,
  move_speed = 4,
  acceleration = 5,
  weight = 6,
  formation = 7,
  knock_up_chance = 8,
  block_knock_up_chance = 9,
  default_rows = 10,
  default_columns = 11,
  default_cooldown = 12,
  skill_id = 13,
  vision = 14,
  weapon_id = 15,
  groups = 16,
  status = 17
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getModel_id(offset)
  return core:GetInt(offset, this.indexMap.model_id)
end

function this:_getUnit_type(offset)
  return core:GetVString(offset, this.indexMap.unit_type).value
end

function this:_getMax_hp(offset)
  return core:GetInt(offset, this.indexMap.max_hp)
end

function this:_getMove_speed(offset)
  return core:GetFloat(offset, this.indexMap.move_speed)
end

function this:_getAcceleration(offset)
  return core:GetFloat(offset, this.indexMap.acceleration)
end

function this:_getWeight(offset)
  return core:GetFloat(offset, this.indexMap.weight)
end

function this:_getFormation(offset)
  return core:GetVString(offset, this.indexMap.formation).value
end

function this:_getKnock_up_chance(offset)
  return core:GetInt(offset, this.indexMap.knock_up_chance)
end

function this:_getBlock_knock_up_chance(offset)
  return core:GetInt(offset, this.indexMap.block_knock_up_chance)
end

function this:_getDefault_rows(offset)
  return core:GetInt(offset, this.indexMap.default_rows)
end

function this:_getDefault_columns(offset)
  return core:GetInt(offset, this.indexMap.default_columns)
end

function this:_getDefault_cooldown(offset)
  return core:GetFloat(offset, this.indexMap.default_cooldown)
end

function this:_getSkill_id(offset)
  return core:GetInt(offset, this.indexMap.skill_id)
end

function this:_getVision(offset)
  return core:GetInt(offset, this.indexMap.vision)
end

function this:_getWeapon_id(offset)
  return core:GetInt(offset, this.indexMap.weapon_id)
end

function this:_getGroups(offset)
  return core:GetInt(offset, this.indexMap.groups)
end

function this:_getStatus(offset)
  local str = core:GetVString(offset, this.indexMap.status).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  model_id = this._getModel_id,
  unit_type = this._getUnit_type,
  max_hp = this._getMax_hp,
  move_speed = this._getMove_speed,
  acceleration = this._getAcceleration,
  weight = this._getWeight,
  formation = this._getFormation,
  knock_up_chance = this._getKnock_up_chance,
  block_knock_up_chance = this._getBlock_knock_up_chance,
  default_rows = this._getDefault_rows,
  default_columns = this._getDefault_columns,
  default_cooldown = this._getDefault_cooldown,
  skill_id = this._getSkill_id,
  vision = this._getVision,
  weapon_id = this._getWeapon_id,
  groups = this._getGroups,
  status = this._getStatus
}
return this
