local this = class("enemy_debug_formation_shell", G_BaseConfig)
local core = G_Tables.TDEnemyDebugFormationTable.GetInstance()

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
  monster_list = 1,
  formation_list = 2,
  wave = 3,
  sub_wave = 4,
  wave_time = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getMonster_list(offset)
  local str = core:GetVString(offset, this.indexMap.monster_list).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getFormation_list(offset)
  local str = core:GetVString(offset, this.indexMap.formation_list).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getWave(offset)
  return core:GetInt(offset, this.indexMap.wave)
end

function this:_getSub_wave(offset)
  return core:GetInt(offset, this.indexMap.sub_wave)
end

function this:_getWave_time(offset)
  return core:GetInt(offset, this.indexMap.wave_time)
end

this.keyToMethodsMap = {
  id = this._getId,
  monster_list = this._getMonster_list,
  formation_list = this._getFormation_list,
  wave = this._getWave,
  sub_wave = this._getSub_wave,
  wave_time = this._getWave_time
}
return this
