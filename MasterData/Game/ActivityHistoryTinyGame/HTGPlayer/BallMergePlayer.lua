local base = require("Game.ActivityHistoryTinyGame.HTGPlayer.Base.HTGPlayerBase")
local BallMergeTinyGameData = class("BallMergeTinyGameData", base)
local GameWatermelonData = require("Game.ActivityCarnival.GameWatermelonData")

function BallMergeTinyGameData:ctor()
end

function BallMergeTinyGameData:InitTinyGameData()
  self.gameWatermelonData = GameWatermelonData.New(self.__tinyGameUID, self.__tinyGameInstanceId)
  
  function self.gameWatermelonData.UploadWatermelonScore(gameWatermelonData, score, callback)
    self:HTGCommonSettle(score, callback)
  end
  
  base.InitTinyGameData(self)
end

function BallMergeTinyGameData:EnterTinyGame()
  UIManager:ShowWindowAsync(UIWindowTypeID.Carnival22MiniGame, function(win)
    if win ~= nil then
      win:InitCarnivalMiniGame(self, true, self)
    end
  end)
end

function BallMergeTinyGameData:GetCarnivalTinyGame()
  return self.gameWatermelonData
end

return BallMergeTinyGameData
