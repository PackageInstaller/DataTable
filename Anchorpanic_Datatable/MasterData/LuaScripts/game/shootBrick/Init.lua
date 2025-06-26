shootBrick = {}

--vo
shootBrick.ShootBrickDupConfigVo = require("game/shootBrick/manager/vo/ShootBrickDupConfigVo")
shootBrick.ShootBrickStarConfigVo = require("game/shootBrick/manager/vo/ShootBrickStarConfigVo")
shootBrick.ShootBrickPropConfigVo = require("game/shootBrick/manager/vo/ShootBrickPropConfigVo")
shootBrick.ShootBrickBallConfigVo = require("game/shootBrick/manager/vo/ShootBrickBallConfigVo")
shootBrick.ShootBrickBrickConfigVo = require("game/shootBrick/manager/vo/ShootBrickBrickConfigVo")
shootBrick.ShootBrickRewardConfigVo = require("game/shootBrick/manager/vo/ShootBrickRewardConfigVo")

shootBrick.ShootBrickBall = require("game/shootBrick/manager/ShootBrickBall")
shootBrick.ShootBrickBrick = require("game/shootBrick/manager/ShootBrickBrick")
shootBrick.ShootBrickDrop = require("game/shootBrick/manager/ShootBrickDrop")
shootBrick.ShootBrickTower = require("game/shootBrick/manager/ShootBrickTower")
shootBrick.ShootBrickTowerBullet = require("game/shootBrick/manager/ShootBrickTowerBullet")

----UI
shootBrick.ShootBrickStagePanel = "game/shootBrick/view/ShootBrickStagePanel"
shootBrick.ShootBrickSceneUI = "game/shootBrick/view/ShootBrickSceneUI"
shootBrick.ShootBrickPausePanel = "game/shootBrick/view/ShootBrickPausePanel"
shootBrick.ShootBrickRewardView = "game/shootBrick/view/ShootBrickRewardView"
shootBrick.ShootBrickSettlementPanel = "game/shootBrick/view/ShootBrickSettlementPanel"
shootBrick.ShootBrickTeachingView = "game/shootBrick/view/ShootBrickTeachingView"

shootBrick.ShootBrickStageItem = require("game/shootBrick/view/item/ShootBrickStageItem")
shootBrick.ShootBrickRewardItem = require("game/shootBrick/view/item/ShootBrickRewardItem")

--管理器
shootBrick.ShootBrickConst = require("game/shootBrick/manager/ShootBrickConst")
shootBrick.ShootBrickManager = require("game/shootBrick/manager/ShootBrickManager").new()
shootBrick.ShootBrickController = require("game/shootBrick/controller/ShootBrickController").new(shootBrick.ShootBrickManager)

local module = {shootBrick.ShootBrickController}
return module

--[[ 替换语言包自动生成，请勿修改！
]]
