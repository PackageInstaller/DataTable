local base = require("Game.ActivityHistoryTinyGame.HTGPlayer.Base.HTGPlayerBase")
local DamieTinyGameData = class("DamieTinyGameData", base)
local eDynConfigData = require("Game.ConfigData.eDynConfigData")

function DamieTinyGameData:ctor()
end

function DamieTinyGameData:EnterTinyGame()
  local actFrameId
  local instanceId = self.__tinyGameInstanceId
  local maxScore = self.__selfHighScore
  ConfigData:LoadDynCfg(eDynConfigData.activity_refresh_dungeon_hero)
  UIManager:ShowWindowAsync(UIWindowTypeID.AprilGameDamie, function(window)
    window:InitDamieWithData(actFrameId, instanceId, maxScore, true, self)
    window:InjectExitAction(function()
      ConfigData:ReleaseDynCfg(eDynConfigData.activity_refresh_dungeon_hero)
    end)
  end)
end

return DamieTinyGameData
