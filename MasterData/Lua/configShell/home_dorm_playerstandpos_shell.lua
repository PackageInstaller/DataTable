local this = class("home_dorm_playerstandpos_shell", G_BaseConfig)
local core = G_Tables.TDHomeDormPlayerStandPosTable.GetInstance()

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
  playerPosOffset = 1,
  playerEulerOffset = 2,
  cameraVerticalPov = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPlayerposoffset(offset)
  local str = core:GetVString(offset, this.indexMap.playerPosOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPlayereuleroffset(offset)
  local str = core:GetVString(offset, this.indexMap.playerEulerOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCameraverticalpov(offset)
  return core:GetFloat(offset, this.indexMap.cameraVerticalPov)
end

this.keyToMethodsMap = {
  id = this._getId,
  playerPosOffset = this._getPlayerposoffset,
  playerEulerOffset = this._getPlayereuleroffset,
  cameraVerticalPov = this._getCameraverticalpov
}
return this
