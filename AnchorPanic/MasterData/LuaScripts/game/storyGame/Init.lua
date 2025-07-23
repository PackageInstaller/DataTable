storyGame = {}

storyGame.StoryGameSelectView = "game/storyGame/view/StoryGameSelectView"
storyGame.WaterpipeGameItem = require("game/storyGame/view/item/WaterpipeGameItem")
storyGame.PuzzleGameView = "game/storyGame/view/PuzzleGameView"
storyGame.WaterpipeGameView = "game/storyGame/view/WaterpipeGameView"
storyGame.ValveGameView = "game/storyGame/view/ValveGameView"
storyGame.PasswordGameView = "game/storyGame/view/PasswordGameView"
storyGame.ReadGameView = "game/storyGame/view/ReadGameView"

storyGame.WaterpipeBaseVo = require("game/storyGame/manager/vo/WaterpipeBaseVo")
storyGame.WaterpipeGameVo = require("game/storyGame/manager/vo/WaterpipeGameVo")
storyGame.WaterpipeGameManager = require("game/storyGame/manager/WaterpipeGameManager")

local _plgc = require('game/storyGame/controller/PuzzleGameController').new()
local _vlgc = require('game/storyGame/controller/ValveGameController').new()
local _pwgc = require('game/storyGame/controller/PasswordGameController').new()
local _pwgc = require('game/storyGame/controller/ReadGameController').new()
local _wpgc = require('game/storyGame/controller/WaterpipeGameController').new(storyGame.WaterpipeGameManager)

local module = { _plgc, _vlgc, _pwgc, _wpgc }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
