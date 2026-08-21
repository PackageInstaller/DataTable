lottery = {}

lottery.LotteryDataVo = require("game/lottery/manager/vo/LotteryDataVo")

lottery.LotteryGamePanel = require("game/lottery/view/LotteryGamePanel")


lottery.LotteryParentItem = require("game/lottery/view/item/LotteryParentItem")
lottery.LotteryRulePanel = require("game/lottery/view/LotteryRulePanel")



lottery.LotteryManager = require("game/lottery/manager/LotteryManager").new()
lottery.LotteryController = require("game/lottery/controller/LotteryController").new(lottery.LotteryManager)
local module = {lottery.LotteryController}
return module