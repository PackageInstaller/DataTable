-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activityshop/model/ActivityshopModel.lua

module("logic.extensions.activityshop.view.ActivityshopModel", package.seeall)

local ActivityshopModel = class("ActivityshopModel", BaseModel)

function ActivityshopModel:ctor()
	return
end

function ActivityshopModel:onInit()
	self:onReset()
	self:_calResetTime()
end

function ActivityshopModel:onReset()
	self._activeShopBuyItemsInfo = {}
end

function ActivityshopModel:isShopPageOpen(activityType, activityId, page)
	local isOpen = true
	local ocfg = ActivityshopConfig.instance:getActivityShopPageCfg(activityType, activityId, page)

	if ocfg.optime > 0 then
		local starTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, activityId)

		isOpen = ServerTime.now() >= starTime + (ocfg.optime - 1) * 86400
	end

	return isOpen
end

function ActivityshopModel:setAllActiveShopBuyInfos(msg)
	self._activeShopBuyItemsInfo[msg.type] = self._activeShopBuyItemsInfo[msg.type] or {}

	local data = {}

	for i, v in ipairs(msg.infos) do
		data[v.itemId] = v
	end

	self._activeShopBuyItemsInfo[msg.type][msg.activityId] = data
end

function ActivityshopModel:setOneActiveShopBuyInfo(msg)
	self._activeShopBuyItemsInfo[msg.type] = self._activeShopBuyItemsInfo[msg.type] or {}
	self._activeShopBuyItemsInfo[msg.type][msg.activityId] = self._activeShopBuyItemsInfo[msg.type][msg.activityId] or {}

	local data = self._activeShopBuyItemsInfo[msg.type][msg.activityId]

	data[msg.itemId] = data[msg.itemId] or {}
	data[msg.itemId].itemId = msg.itemId
	data[msg.itemId].buyTimes = msg.buyTimes
	data[msg.itemId].buyTimesInActivity = msg.buyTimesInActivity
end

function ActivityshopModel:getActiveShopBuyInfos(activityType, activityId)
	return self._activeShopBuyItemsInfo[activityType] and self._activeShopBuyItemsInfo[activityType][activityId]
end

function ActivityshopModel:getActiveShopBuyInfoByItemId(activityType, activityId, itemId)
	local data = self._activeShopBuyItemsInfo[activityType]
	local var_8_0

	if data then
		::label_8_0::

		var_8_0 = data[activityId] and data[activityId][itemId]
	end

	return var_8_0
end

function ActivityshopModel:getActiveShopBuyTimes(activityType, activityId, itemId)
	local data = self._activeShopBuyItemsInfo[activityType]

	return (data and data[activityId] and data[activityId][itemId] or nil) and (data[activityId][itemId].buyTimes or 0)
end

function ActivityshopModel:getActiveShopBuyTimesInActivity(activityType, activityId, itemId)
	local data = self._activeShopBuyItemsInfo[activityType]

	return (data and data[activityId] and data[activityId][itemId] or nil) and (data[activityId][itemId].buyTimesInActivity or 0)
end

function ActivityshopModel:checkItemsCanExchangeByActivityType(activityType)
	local cfg = ActivityDefineController.instance:getActivityCfgByType(activityType)

	if cfg then
		return self:checkAllItemCanExchange(activityType, cfg.activityId)
	end
end

function ActivityshopModel:checkAllItemCanExchange(activityType, activityId)
	local dot = false
	local isInTime = ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)

	if isInTime then
		local list = ActivityshopConfig.instance:getActivityShopCfg(activityType, activityId)

		if list then
			for i, v in ipairs(list) do
				dot = self:checkItemCanExchange(activityType, activityId, v.shopItemId)

				if dot then
					break
				end
			end
		end
	end

	return dot
end

function ActivityshopModel:checkAllItemCanExchangeByPage(activityType, activityId, page)
	local dot = false
	local isInTime = ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)

	if isInTime then
		local list = ActivityshopConfig.instance:getActivityShopCfgWithPage(activityType, activityId)

		if list and list[page] then
			for i, v in ipairs(list[page]) do
				dot = self:checkItemCanExchange(activityType, activityId, v.shopItemId)

				if dot then
					break
				end
			end
		end
	end

	return dot
end

function ActivityshopModel:checkItemCanExchange(activityType, activityId, itemId)
	local dot = false
	local cfg = ActivityshopConfig.instance:getActivityShopCfgByItemId(activityType, activityId, itemId)
	local costNum = MaterialFacade.instance:getGoodCostByStr(cfg.sellPrice)
	local has_num = MaterialFacade.instance:getMatNumber(matType, matId)

	if cfg.sellPeriodLimit ~= "none" then
		local buyTimes = ActivityshopModel.instance:getActiveShopBuyTimes(activityType, activityId, itemId)

		if buyTimes < cfg.sellLimitCount then
			dot = MaterialFacade.instance:isMatsEnough(cfg.sellPrice)
		end
	else
		dot = MaterialFacade.instance:isMatsEnough(cfg.sellPrice)
	end

	return dot
end

function ActivityshopModel:checkDailyRedDot(activityType, activityId)
	if not activityId then
		local acfg = ActivityDefineController.instance:getActivityCfgByType(activityType)

		if acfg then
			activityId = acfg.activityId
		end
	end

	if not activityId then
		return false
	end

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)

	if not isInTime then
		return false
	end

	return self:_hasDailyRedDot(activityType, activityId)
end

function ActivityshopModel:_hasDailyRedDot(activityType, activityId)
	local key = self:_getRedDotKey(activityType, activityId)
	local cacheStr = Framework.LocalStorage.Instance:GetString(key)

	if cacheStr == "" then
		return true
	else
		local nowTime = ServerTime.nowServerLook()
		local resetTime = Framework.LocalStorage.Instance:GetString("ActivityshopModel_Time")
		local lastClickTIme = checknumber(cacheStr)

		resetTime = checknumber(resetTime)

		if lastClickTIme < resetTime and resetTime < nowTime then
			return true
		end
	end

	return false
end

function ActivityshopModel:clearDailyRed(activityType, activityId)
	local key = self:_getRedDotKey(activityType, activityId)
	local nowTime = ServerTime.nowServerLook()

	Framework.LocalStorage.Instance:SetString(key, tostring(nowTime))
end

function ActivityshopModel:_getRedDotKey(activityType, activityId)
	return string.format("ActivityshopModel_%s_%s_%s_%s", LoginModel.instance.platformId, LoginModel.instance.userId, activityType, activityId)
end

function ActivityshopModel:refreshDailyDot()
	self:_calResetTime()
end

function ActivityshopModel:_calResetTime()
	local nowTime = ServerTime.nowServerLook()
	local date = os.date("*t", nowTime)
	local resetTime = os.time({
		hour = 5,
		min = 0,
		sce = 0,
		year = date.year,
		month = date.month,
		day = date.day
	})

	Framework.LocalStorage.Instance:SetString("ActivityshopModel_Time", tostring(resetTime))
end

function ActivityshopModel:isActivityInDiscountTime(activityId)
	local timeStr = ActivityshopConfig.instance:getActDiscountTimeStr(activityId)

	if not string.nilorempty(timeStr) then
		return GameUtil.checkTimeStr(timeStr)
	end

	return false
end

function ActivityshopModel:getDiscountEndTime(str)
	if string.nilorempty(str) then
		return
	end

	if str == "全天" then
		return
	else
		local arr = string.split(str, "|")
		local type = arr[1]
		local timeStr = arr[2]

		if type == "时段" then
			local tem = string.split(timeStr, ",")

			if string.nilorempty(tem[2]) then
				printError("折扣时间段定义错误")
			end

			return GameUtil.string2time(tem[2])
		else
			printError("未定义该折扣时间的结束时间")
		end
	end
end

ActivityshopModel.instance = ActivityshopModel.New()

return ActivityshopModel
