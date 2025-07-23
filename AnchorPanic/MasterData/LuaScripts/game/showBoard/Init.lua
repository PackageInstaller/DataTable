showBoard = {}

require("game/showBoard/manager/ShowBoardConst")
showBoard.ShowBoardManager = require("game/showBoard/manager/ShowBoardManager").new()
showBoard.ShowBoardController = require('game/showBoard/controller/ShowBoardController').new(showBoard.ShowBoardManager)

showBoard.ShowBoardHeroItem2 = require('game/showBoard/view/item/ShowBoardHeroItem2')
showBoard.ShowBoardHeroPanel2 = require('game/showBoard/view/ShowBoardHeroPanel2')

local module = {showBoard.ShowBoardController}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
