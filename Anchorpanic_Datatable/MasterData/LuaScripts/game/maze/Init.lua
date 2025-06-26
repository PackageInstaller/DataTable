maze = {}

maze.MazePlayerMoveAi = require('game/maze/ai/MazePlayerMoveAi')

require('game/maze/utils/MazeMapUtil')
maze.MazeAstarGrid = require('game/maze/utils/MazeAstarGrid')
maze.MazeAStar = require('game/maze/utils/MazeAStar').new()

maze.MazeCamera = require('game/maze/manager/MazeCamera').new()

require('game/maze/manager/MazeConst')
maze.MazeVo = require('game/maze/manager/vo/msgVo/MazeVo')
maze.MazeTileVo = require('game/maze/manager/vo/msgVo/MazeTileVo')
maze.MazeEventVo = require('game/maze/manager/vo/msgVo/MazeEventVo')
maze.MazeHeroVo = require('game/maze/manager/vo/msgVo/MazeHeroVo')
maze.MazeRankVo = require('game/maze/manager/vo/msgVo/MazeRankVo')
maze.MazeManager = require('game/maze/manager/MazeManager').new()
maze.MazeController = require('game/maze/controller/MazeController').new(maze.MazeManager)

maze.MazeSceneManager = require('game/maze/manager/MazeSceneManager').new()
maze.MazeSceneThingManager = require('game/maze/manager/MazeSceneThingManager').new()
local mgrList = {}
table.insert(mgrList, maze.MazeSceneManager)
table.insert(mgrList, maze.MazeSceneThingManager)
maze.MazeSceneController = require('game/maze/controller/MazeSceneController').new(mgrList)

maze.MazeItem = require('game/maze/view/item/MazeItem')
maze.MazeGoodsItem = require('game/maze/view/item/MazeGoodsItem')
maze.MazeGoodsSelectItem = require('game/maze/view/item/MazeGoodsSelectItem')
maze.MazePanel = require('game/maze/view/MazePanel')
maze.MazeScenePanel = require('game/maze/view/MazeScenePanel')
maze.MazeProgressPanel = require('game/maze/view/MazeProgressPanel')
maze.MazeGoodsPanel = require('game/maze/view/MazeGoodsPanel')
maze.MazeGoodsSelectPanel = require('game/maze/view/MazeGoodsSelectPanel')
maze.MazeRankHallPanel = require('game/maze/view/MazeRankHallPanel')
maze.MazeRankAwardItem = require('game/maze/view/item/MazeRankAwardItem')
maze.MazeRankAwardPanel = require('game/maze/view/MazeRankAwardPanel')
maze.MazeRankItem = require('game/maze/view/item/MazeRankItem')
maze.MazeRankPanel = require('game/maze/view/MazeRankPanel')
maze.MazeAbnormalShowPanel = require('game/maze/view/MazeAbnormalShowPanel')
maze.MazeAbnormalShowItem = require('game/maze/view/item/MazeAbnormalShowItem')

maze.MazeScene = require('game/maze/view/MazeScene')
maze.MazePlayerModel = require('game/maze/view/thing/MazePlayerModel')
maze.MazeEventModel = require('game/maze/view/thing/MazeEventModel')

maze.MazeEventInfoPanel = require('game/maze/view/MazeEventInfoPanel')
maze.MazeGoodsInfoItem = require('game/maze/view/item/MazeGoodsInfoItem')
maze.MazeGoodsInfoPanel = require('game/maze/view/MazeGoodsInfoPanel')
maze.MazeAwardInfoPanel = require('game/maze/view/MazeAwardInfoPanel')
maze.MazeAwardPreviewPanel = require('game/maze/view/MazeAwardPreviewPanel')
maze.MazeDupInfoPanel = require('game/maze/view/MazeDupInfoPanel')
maze.MazeMercenaryInfoPanel = require('game/maze/view/MazeMercenaryInfoPanel')
maze.MazeTriggerInfoPanel = require('game/maze/view/MazeTriggerInfoPanel')
maze.MazeCannonInfoPanel = require('game/maze/view/MazeCannonInfoPanel')
maze.MazeRotarySwitchInfoPanel = require('game/maze/view/MazeRotarySwitchInfoPanel')

maze.MazeConfigVo = require('game/maze/manager/vo/configVo/MazeConfigVo')
maze.MazeTileConfigVo = require('game/maze/manager/vo/configVo/MazeTileConfigVo')
maze.MazeEventConfigVo = require('game/maze/manager/vo/configVo/MazeEventConfigVo')
maze.MazeGoodsConfigVo = require('game/maze/manager/vo/configVo/MazeGoodsConfigVo')
maze.MazeDupConfigVo = require('game/maze/manager/vo/configVo/MazeDupConfigVo')
maze.MazeAbnormalConfigVo = require('game/maze/manager/vo/configVo/MazeAbnormalConfigVo')

maze.MazeEventExecutor = require('game/maze/executor/event/MazeEventExecutor')
maze.MazeEventExecutor:initRequireList()

maze.MazeEffectExecutor = require('game/maze/executor/effect/MazeEffectExecutor')
maze.MazeEffectExecutor:initRequireList()


local module = {maze.MazeController, maze.MazeSceneController}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
