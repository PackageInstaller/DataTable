local base = require("Game.ActivityHistoryTinyGame.HTGPlayer.Base.HTGPlayerBase")
local FlappyBirdTinyGameData = class("FlappyBirdTinyGameData", base)

function FlappyBirdTinyGameData:ctor(tinyGameType, tinyGameInstanceId)
end

function FlappyBirdTinyGameData:InitTinyGameData()
  base.InitTinyGameData(self)
end

function FlappyBirdTinyGameData:EnterTinyGame()
  local activityFwId
  local birdConfigId = self.__tinyGameInstanceId
  local maxScore = self.__selfHighScore
  local joinRewards = true
  local ctrl = require("Game.TinyGames.FlappyBird.Ctrl.FlappyBirdController").New(activityFwId, birdConfigId, joinRewards, maxScore, true, self)
  ctrl:InjectExitAction(function()
    UIUtil.ReShowTopStatus()
    AudioManager:PlayAudioById(3002)
  end)
  ctrl:InjectModifyBirdMsgAction(nil, nil)
  ctrl:ShowFlappyBirdUI(true)
  AudioManager:PlayAudioById(1139)
end

return FlappyBirdTinyGameData
