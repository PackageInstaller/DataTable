-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activityshop/controller/ActivityshopController.lua

module("logic.extensions.activityshop.controller.ActivityshopController", package.seeall)

local ActivityshopController = class("ActivityshopController", BaseController)

function ActivityshopController:ctor()
	return
end

function ActivityshopController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("open_exchange_view", self.onOpenExchangeView, self)
	ActivityShopAgent.instance:addHandler(ActivityShopAgent.PM_GetAllShopItemInfoRes, self._receivedAllShopItemInfo, self)
	ActivityShopAgent.instance:addHandler(ActivityShopAgent.PM_BuyShopItemRes, self._receivedBuyShopItem, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._checkRefreshTime, self)
end

function ActivityshopController:onReset()
	return
end

function ActivityshopController:onOpenExchangeView(params)
	ActivityshopController.instance:openExchangeView(checknumber(params[1]), checknumber(params[2]))
end

function ActivityshopController:_receivedAllShopItemInfo(msg)
	if msg == nil then
		return
	end

	if msg.type == SevenDaysModel.instance.trboxActivityType then
		SevenDaysModel.instance:SetExchangeGoodsBuyCount(true, msg.activityId, msg.infos)

		return
	end

	ActivityshopModel.instance:setAllActiveShopBuyInfos(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdateActiveShopInfo, msg.type, msg.activityId)
end

function ActivityshopController:_receivedBuyShopItem(msg)
	if msg == nil then
		return
	end

	if msg.type == SevenDaysModel.instance.trboxActivityType then
		SevenDaysModel.instance:SetExchangeGoodsBuyCount(false, msg.activityId, {
			itemId = msg.itemId,
			buyTimes = msg.buyTimes,
			buyTimesInActivity = msg.buyTimesInActivity
		})

		return
	end

	ActivityshopModel.instance:setOneActiveShopBuyInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdateActiveShopInfo, msg.type, msg.activityId)
end

function ActivityshopController:getAllShopItemInfo(activityType, activityId)
	if not ActivityDefineController.instance:isInActivityTimeById(activityType, activityId) then
		FloatWordMgr.instance:show("不在活动时间内")

		return
	end

	ActivityShopAgent.instance:sendPM_GetAllShopItemInfoReq(activityType, activityId)
end

function ActivityshopController:buyShopItem(activityType, activityId, id, count, couponUseInfo)
	count = count or 1

	ActivityShopAgent.instance:sendPM_BuyShopItemReq(activityType, activityId, id, count, couponUseInfo)
end

function ActivityshopController:openExchangeView(...)
	local params = {
		...
	}
	local activityType = checknumber(params[1])
	local activityId = checknumber(params[2])

	if activityType > 0 then
		local cfg

		if activityId > 0 then
			local isIn = ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)

			if not isIn then
				printWarn("通用商店传入活动id不在活动开放时间内，自动换成在时间内的活动id")

				activityId = ActivityDefineController.instance:getActivityIdByType(activityType)
			end

			cfg = ActivityDefineConfig.instance:getCfgById(activityType, activityId)
		else
			cfg = ActivityDefineController.instance:getActivityCfgByType(activityType)
		end

		if cfg then
			UIStateManager.instance:push(ViewName.ActivityshopexchangeView, GameUtil.unpack10(params))
		else
			FloatWordMgr.instance:show("不在活动开放时间内")
		end
	else
		printError("ActivityshopController:openExchangeView 要带参数的")
	end
end

function ActivityshopController:_checkRefreshTime()
	ActivityshopModel.instance:refreshDailyDot()
end

ActivityshopController.instance = ActivityshopController.New()

return ActivityshopController
