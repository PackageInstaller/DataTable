local this = class("pet_race_shell", G_BaseConfig)
local core = G_Tables.TDPetRaceTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {ID = 0, raceType = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.ID)
end

function this:_getRacetype(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_race", core:GetVString(offset, this.indexMap.raceType))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "raceType")
end

this.keyToMethodsMap = {
  ID = this._getId,
  raceType = this._getRacetype
}
return this
