local base = require("Game.ActivityHistoryTinyGame.HTGPlayer.Base.HTGPlayerBase")
local _2048TinyGameData = class("_2048TinyGameData", base)

function _2048TinyGameData:ctor(tinyGameType, tinyGameInstanceId)
end

function _2048TinyGameData:EnterTinyGame()
  local Game2048Controller = require("Game.TinyGames.2048.Game2048Controller")
  local gameCtrl = Game2048Controller.New()
  local actFrameId = self.actFrameId
  local instanceId = self.__tinyGameInstanceId
  gameCtrl:InitGame2048(actFrameId, instanceId, nil, true, self)
end

return _2048TinyGameData
