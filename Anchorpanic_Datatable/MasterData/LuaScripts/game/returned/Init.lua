returned = {}


returned.ReturnedMainPanel = 'game/returned/view/ReturnedMainPanel'

returned.ReturnedSignView = 'game/returned/view/ReturnedSignView'
returned.ReturnedTaskChallengeView = 'game/returned/view/ReturnedTaskChallengeView'
returned.ReturnedTaskDailyView = 'game/returned/view/ReturnedTaskDailyView'
returned.ReturnedShopView = 'game/returned/view/ReturnedShopView'

returned.ReturnedBuyMoneyView = 'game/returned/view/ReturnedBuyMoneyView'

returned.ReturnedSignItem = require('game/returned/view/item/ReturnedSignItem')
returned.ReturnedTaskItem = require('game/returned/view/item/ReturnedTaskItem')
returned.ReturnedShopBuyItem = require('game/returned/view/item/ReturnedShopBuyItem')

returned.ReturnedTaskVo = require('game/returned/manager/vo/ReturnedTaskVo')
returned.ReturnedConst = require('game/returned/manager/ReturnedConst')
returned.ReturnedManager = require('game/returned/manager/ReturnedManager').new()

local _c = require('game/returned/controller/ReturnedController').new(returned.ReturnedManager)

local module = { _c }
return module