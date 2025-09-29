-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/util/StoreUtil.lua

module("logic.extensions.store.util.StoreUtil", package.seeall)

function StoreUtil.formatText(text)
	local firstStr = string.sub(text, 1, 1)
	local endStr = string.sub(text, -1)
	local tempList = {}

	if firstStr == "{" and endStr == "}" then
		local allItems = string.gsub(text, "{(.-)}", "%1")
		local itemlistStr = string.split(allItems, ",")

		for index, itemStr in ipairs(itemlistStr) do
			local itemStr = string.split(itemStr, ":")
			local len = #itemStr

			if len == 2 then
				table.insert(tempList, {
					itemId = tonumber(itemStr[1]),
					num = tonumber(itemStr[2]),
					base = tonumber(itemStr[2])
				})
			end
		end
	else
		local rewardId = tonumber(text)
		local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardId)

		if rewardCO then
			for i, v in ipairs(rewardCO.reward and rewardCO.reward or {}) do
				table.insert(tempList, {
					itemId = v.code,
					num = v.num,
					base = v.num
				})
			end
		end
	end

	return tempList
end

function StoreUtil.getStoreShowType(storeId)
	local type = math.floor(storeId / 10000)

	return type
end

function StoreUtil.getStoreType(storeId)
	local storeType = StoreEnum.MallType.MonthyCard
	local storeCO = StoreConfig.instance:getStoreCO(storeId)

	if storeCO then
		storeType = storeCO.mallType
	end

	return storeType
end

function StoreUtil.isGoodsInDiscountTime(goodsCo)
	return StoreUtil.isInDiscountTime(goodsCo.discountStartTime, goodsCo.discountEndTime)
end

function StoreUtil.isInDiscountTime(startTime, endTime)
	local startTimeStamp = not string.nilorempty(startTime) and TimeUtil.instance:dateStr2TimeStamp(startTime) or 0
	local endTimeStamp = not string.nilorempty(endTime) and TimeUtil.instance:dateStr2TimeStamp(endTime) or 1e+63

	return startTimeStamp < ServerTime.now() and endTimeStamp > ServerTime.now()
end

function StoreUtil.getRemainedTime(startTime, endTime)
	local beginT = false
	local endT = false
	local offset = 0

	if not string.nilorempty(startTime) then
		beginT = TimeUtil.instance:dateStr2TimeStamp(startTime)
	end

	if not string.nilorempty(endTime) then
		endT = TimeUtil.instance:dateStr2TimeStamp(endTime)
	end

	if beginT then
		if endT then
			if endT > ServerTime.now() and beginT <= ServerTime.now() then
				offset = endT - ServerTime.now()
			end
		elseif beginT > ServerTime.now() then
			offset = beginT - ServerTime.now()
		end
	elseif endT and endT > ServerTime.now() then
		offset = endT - ServerTime.now()
	end

	return offset
end

function StoreUtil.getMoneyMark(price)
	return langF("tip_money_mark", string.format("%.2f", price))
end

function StoreUtil.getDiscount(discount, withTips)
	if withTips then
		return langF("tip_store_discount", discount / 10)
	end

	return discount / 10
end

function StoreUtil._checkDiscountEnable(goodsCo)
	if not goodsCo then
		return false
	end

	if goodsCo.discountCost ~= "" then
		local isEnable, needTick = StoreUtil._getIsCanDiscount(goodsCo.discountStartTime, goodsCo.discountEndTime)

		if isEnable then
			return isEnable, needTick
		end
	end

	return false
end

function StoreUtil._getIsCanDiscount(startTime, endTime)
	local beginT = false
	local endT = false
	local canOnLine = false
	local needTick = false

	if not string.nilorempty(startTime) then
		beginT = TimeUtil.instance:dateStr2TimeStamp(startTime)
	end

	if not string.nilorempty(endTime) then
		endT = TimeUtil.instance:dateStr2TimeStamp(endTime)
	end

	if beginT then
		if endT then
			if endT > ServerTime.now() and beginT <= ServerTime.now() then
				canOnLine = true
				needTick = true
			end
		elseif beginT <= ServerTime.now() then
			canOnLine = true
		else
			needTick = true
		end
	elseif endT then
		if endT > ServerTime.now() then
			canOnLine = true
			needTick = true
		end
	else
		canOnLine = true
	end

	return canOnLine, needTick
end

function StoreUtil.getCostPrice(cost)
	local costItems = StoreUtil.formatText(cost)
	local len = #costItems

	if len ~= 1 then
		if enableErrorLog then
			printError("Discounted Cost Item Length More then 1?", len)
		end

		return false, false
	end

	local itemId = costItems[1].itemId
	local num = costItems[1].num

	return itemId, num
end

function StoreUtil.getGiftBagIconPath(icon)
	icon = icon and icon or ""

	return "git_bag/" .. icon
end

function StoreUtil.getEchoCarIconPath(icon)
	icon = icon and icon or ""

	return "exchange/echo_card_bag/" .. icon
end

function StoreUtil.getQualityIconPath(icon)
	icon = icon and icon or ""

	return "quality2/" .. icon
end

function StoreUtil.getMinLimit(curent, target)
	if curent == 0 then
		return target
	end

	if target == 0 then
		return curent
	end

	return Mathf.Min(curent, target)
end

function StoreUtil.getBuyConfirmTitleNme(goodsType)
	local name = lang(StoreEnum.BuyConfirmTitleNme[goodsType])

	return name or ""
end

function StoreUtil.isOddNumber(num)
	local num1, num2 = math.modf(num / 2)

	if num2 == 0 then
		return true
	else
		return false
	end
end

function StoreUtil.createCostItems(costId, costCount)
	local costItems = {}
	local costItem = {
		costId = costId,
		costCount = costCount
	}

	table.insert(costItems, costItem)

	return costItems
end

function StoreUtil.getLimitName(goodsMo)
	if not goodsMo or goodsMo:getHisBuyLimit() > 0 then
		return lang("tip_store_buy_limit")
	end

	if goodsMo:getGoodsType() == StoreEnum.GoodsType.GiftBag then
		local name = StoreEnum.StoreLimitNames[goodsMo:getAutoRefreshType()]

		return name and lang(name) or lang("tip_store_buy_limit")
	end

	local storeCO = StoreConfig.instance:getStoreCO(goodsMo:getStoreId())

	if not storeCO then
		return lang("tip_store_buy_limit")
	end

	local name = StoreEnum.StoreLimitNames[storeCO.autoRefreshType]

	return name and lang(name) or lang("tip_store_buy_limit")
end

function StoreUtil.getNormalBuyMaxNum(goodsMo, costItemId, price)
	local buyLimit = goodsMo:getBuyLimit()
	local hisBuyLimit = goodsMo:getHisBuyLimit()
	local dailyBuyLimit = goodsMo:getDailyBuyMaxNum()
	local limit = StoreUtil.getMinLimit(0, buyLimit or 0)

	limit = StoreUtil.getMinLimit(limit, hisBuyLimit or 0)
	limit = StoreUtil.getMinLimit(limit, dailyBuyLimit or 0)

	local remainedNum = goodsMo:getRemainedNum()
	local onceMaxNum = goodsMo:getOnceMaxNum()
	local dailyBuyNum = goodsMo:getDailyBuyNum()
	local dailyBuyMaxNum = goodsMo:getDailyBuyMaxNum()
	local canBuyMax = 0

	if limit > 0 then
		canBuyMax = remainedNum ~= -1 and remainedNum or limit

		local isBuyLimit = canBuyMax > 0

		if onceMaxNum > 0 and dailyBuyMaxNum > 0 then
			local dailyRemainedNum = dailyBuyMaxNum - dailyBuyNum > 0 and dailyBuyMaxNum - dailyBuyNum or 0
			local onceRemainedNum = onceMaxNum

			if isBuyLimit then
				if dailyRemainedNum <= onceRemainedNum and dailyRemainedNum <= remainedNum then
					canBuyMax = dailyRemainedNum
				elseif onceRemainedNum <= dailyRemainedNum and onceRemainedNum <= remainedNum then
					canBuyMax = onceRemainedNum
				elseif remainedNum > 0 and remainedNum <= dailyRemainedNum and remainedNum <= onceRemainedNum then
					canBuyMax = remainedNum
				end
			end
		elseif onceMaxNum > 0 then
			if onceMaxNum < canBuyMax then
				canBuyMax = onceMaxNum
			end
		elseif dailyBuyMaxNum > 0 then
			canBuyMax = dailyBuyMaxNum - dailyBuyNum > 0 and dailyBuyMaxNum - dailyBuyNum or 0
		end
	elseif dailyBuyMaxNum > 0 then
		canBuyMax = dailyBuyMaxNum - dailyBuyNum > 0 and dailyBuyMaxNum - dailyBuyNum or 0

		if onceMaxNum > 0 and onceMaxNum < canBuyMax then
			canBuyMax = onceMaxNum
		end
	elseif onceMaxNum > 0 then
		canBuyMax = onceMaxNum
	else
		canBuyMax = 100
	end

	return canBuyMax
end

return StoreUtil
