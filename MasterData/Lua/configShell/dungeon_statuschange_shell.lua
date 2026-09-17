local this = class("dungeon_statuschange_shell", G_BaseConfig)
local core = G_Tables.TDDungeonStatuschangeTable.GetInstance()

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
  statusID = 0,
  sceneTypeid = 1,
  dungeonType = 2,
  playerLife = 3,
  playerHP = 4,
  kiboMP = 5,
  ultraEnergy = 6,
  entryEnergy = 7,
  playerCD = 8,
  playerSigil = 9,
  playerBuff = 10
}

function this:_getStatusid(offset)
  return core:GetInt(offset, this.indexMap.statusID)
end

function this:_getScenetypeid(offset)
  return core:GetInt(offset, this.indexMap.sceneTypeid)
end

function this:_getDungeontype(offset)
  return core:GetInt(offset, this.indexMap.dungeonType)
end

function this:_getPlayerlife(offset)
  local str = core:GetVString(offset, this.indexMap.playerLife).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPlayerhp(offset)
  local str = core:GetVString(offset, this.indexMap.playerHP).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getKibomp(offset)
  local str = core:GetVString(offset, this.indexMap.kiboMP).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getUltraenergy(offset)
  local str = core:GetVString(offset, this.indexMap.ultraEnergy).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getEntryenergy(offset)
  local str = core:GetVString(offset, this.indexMap.entryEnergy).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPlayercd(offset)
  local str = core:GetVString(offset, this.indexMap.playerCD).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPlayersigil(offset)
  local str = core:GetVString(offset, this.indexMap.playerSigil).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPlayerbuff(offset)
  local str = core:GetVString(offset, this.indexMap.playerBuff).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  statusID = this._getStatusid,
  sceneTypeid = this._getScenetypeid,
  dungeonType = this._getDungeontype,
  playerLife = this._getPlayerlife,
  playerHP = this._getPlayerhp,
  kiboMP = this._getKibomp,
  ultraEnergy = this._getUltraenergy,
  entryEnergy = this._getEntryenergy,
  playerCD = this._getPlayercd,
  playerSigil = this._getPlayersigil,
  playerBuff = this._getPlayerbuff
}
return this
