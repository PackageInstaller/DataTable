mainExplore = {}

require('game/mainExplore/manager/MainExploreConst')

-- 相机
mainExplore.MainExploreCamera = require('game/mainExplore/manager/MainExploreCamera').new()
-- 摇杆
mainExplore.MainExploreJoystickView = require('game/mainExplore/view/MainExploreJoystickView')
-- 玩家代理
mainExplore.MainExplorePlayerProxy = require('game/mainExplore/controller/MainExplorePlayerProxy').new()

-- AI
mainExplore.MainExploreBaseAiCtrl = require('game/mainExplore/ai/MainExploreBaseAiCtrl')
mainExplore.MainExplorePlayerAiCtrl = require('game/mainExplore/ai/MainExplorePlayerAiCtrl')
mainExplore.MainExploreMonsterAiCtrl = require('game/mainExplore/ai/MainExploreMonsterAiCtrl')

-- 实体对象
mainExplore.MainExploreBaseThing = require('game/mainExplore/view/thing/MainExploreBaseThing')
mainExplore.MainExploreNormalThing = require('game/mainExplore/view/thing/MainExploreNormalThing')
mainExplore.MainExplorePlayerThing = require('game/mainExplore/view/thing/MainExplorePlayerThing')
mainExplore.MainExploreMonsterThing = require('game/mainExplore/view/thing/MainExploreMonsterThing')

-- 实体数据vo
mainExplore.MainExploreBaseThingVo = require('game/mainExplore/manager/vo/MainExploreBaseThingVo')
mainExplore.MainExplorePlayerThingVo = require('game/mainExplore/manager/vo/MainExplorePlayerThingVo')
mainExplore.MainExploreMonsterThingVo = require('game/mainExplore/manager/vo/MainExploreMonsterThingVo')

-- 数据vo
mainExplore.MainExploreEventVo = require('game/mainExplore/manager/vo/MainExploreEventVo')
mainExplore.MainExploreHeroVo = require('game/mainExplore/manager/vo/MainExploreHeroVo')
mainExplore.MainExploreWaitEffectVo = require('game/mainExplore/manager/vo/MainExploreWaitEffectVo')

-- 配置数据vo
mainExplore.MainExploreClientMapConfigVo = require('game/mainExplore/manager/vo/MainExploreClientMapConfigVo')
mainExplore.MainExploreClientMapGridConfigVo = require('game/mainExplore/manager/vo/MainExploreClientMapGridConfigVo')
mainExplore.MainExploreMapConfigVo = require('game/mainExplore/manager/vo/MainExploreMapConfigVo')
mainExplore.MainExploreItemConfigVo = require('game/mainExplore/manager/vo/MainExploreItemConfigVo')
mainExplore.MainExploreEventConfigVo = require('game/mainExplore/manager/vo/MainExploreEventConfigVo')
mainExplore.MainExploreDupConfigVo = require('game/mainExplore/manager/vo/MainExploreDupConfigVo')
mainExplore.MainExplorePlayerConfigVo = require('game/mainExplore/manager/vo/MainExplorePlayerConfigVo')
mainExplore.MainExploreGoodsConfigVo = require('game/mainExplore/manager/vo/MainExploreGoodsConfigVo')
mainExplore.MainExplorePlayConfigVo = require('game/mainExplore/manager/vo/MainExplorePlayConfigVo')
mainExplore.MainExploreIntroduceConfigVo = require('game/mainExplore/manager/vo/MainExploreIntroduceConfigVo')

mainExplore.MainExploreManager = require('game/mainExplore/manager/MainExploreManager').new()
mainExplore.MainExploreController = require('game/mainExplore/controller/MainExploreController').new(mainExplore.MainExploreManager)

mainExplore.MainExploreSceneManager = require('game/mainExplore/manager/MainExploreSceneManager').new()
mainExplore.MainExploreSceneThingManager = require('game/mainExplore/manager/MainExploreSceneThingManager').new()
local mgrList = {}
table.insert(mgrList, mainExplore.MainExploreSceneManager)
table.insert(mgrList, mainExplore.MainExploreSceneThingManager)
mainExplore.MainExploreSceneController = require('game/mainExplore/controller/MainExploreSceneController').new(mgrList)

mainExplore.MainExploreScene = require('game/mainExplore/view/MainExploreScene')
mainExplore.MainExploreScenePanel = require('game/mainExplore/view/MainExploreScenePanel')
mainExplore.MainExploreGoodsSelectPanel = require('game/mainExplore/view/MainExploreGoodsSelectPanel')
mainExplore.MainExploreGoodsSelectItem = require('game/mainExplore/view/item/MainExploreGoodsSelectItem')
mainExplore.MainExploreGoodsPanel = require('game/mainExplore/view/MainExploreGoodsPanel')
mainExplore.MainExploreGoodsItem = require('game/mainExplore/view/item/MainExploreGoodsItem')
mainExplore.MainExploreGoodsInfoPanel = require('game/mainExplore/view/MainExploreGoodsInfoPanel')
mainExplore.MainExploreGoodsInfoItem = require('game/mainExplore/view/item/MainExploreGoodsInfoItem')
mainExplore.MainExploreFirstIntroducePanel = require('game/mainExplore/view/MainExploreFirstIntroducePanel')
mainExplore.MainExploreMapView = require('game/mainExplore/view/MainExploreMapView')
mainExplore.MainExploreMapPanel = require('game/mainExplore/view/MainExploreMapPanel')

-- 事件执行器
mainExplore.MainExploreEventExecutor = require('game/mainExplore/executor/event/MainExploreEventExecutor').new()
-- 效果执行器
mainExplore.MainExploreEffectExecutor = require('game/mainExplore/executor/effect/MainExploreEffectExecutor').new()

local module = {mainExplore.MainExploreController, mainExplore.MainExploreSceneController}
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
