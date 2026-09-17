local this = class("common_pet_satiety_shell", G_BaseConfig)
local core = G_Tables.TDCommonPetSatietyTable.GetInstance()

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
  satiety = 1,
  move_speed_sp = 2,
  fast_move_speed_mp = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSatiety(offset)
  local str = core:GetVString(offset, this.indexMap.satiety).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getMove_speed_sp(offset)
  return core:GetInt(offset, this.indexMap.move_speed_sp)
end

function this:_getFast_move_speed_mp(offset)
  return core:GetInt(offset, this.indexMap.fast_move_speed_mp)
end

this.keyToMethodsMap = {
  id = this._getId,
  satiety = this._getSatiety,
  move_speed_sp = this._getMove_speed_sp,
  fast_move_speed_mp = this._getFast_move_speed_mp
}
return this
