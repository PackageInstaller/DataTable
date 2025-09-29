-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/currencyexchange/controller/CurrencyExchangeController.lua

module("logic.extensions.currencyexchange.controller.CurrencyExchangeController", package.seeall)

local M = class("CurrencyExchangeController", BaseController)

function M:onInit()
	return
end

function M:onReset()
	return
end

function M:showTipsNormal(id, minMulti, alwaysShow, forceShowWhenJumpOpen, titleStr)
	return self:showTips(id, minMulti, false, 1, alwaysShow, forceShowWhenJumpOpen, titleStr)
end

function M:showTipsMulti(id, minMulti, multiStep, alwaysShow, forceShowWhenJumpOpen, titleStr)
	return self:showTips(id, minMulti, true, multiStep, alwaysShow, forceShowWhenJumpOpen, titleStr)
end

function M:showTips(id, minMulti, isMulti, multiStep, alwaysShow, forceShowWhenJumpOpen, titleStr)
	local cfgCO = CurrencyExchangeConfig.instance:getCurrencyExchange(id)

	if cfgCO == nil then
		printError("无法从[%s]找到[%s]的数据", ConfigName.CurrencyExchange, id)

		return false
	end

	if alwaysShow then
		ToolTipsMgr.showCurrencyExchangeTips(id, minMulti, isMulti, multiStep, titleStr)

		return true
	end

	minMulti = not minMulti and 1 or minMulti
	minMulti = minMulti < 1 and 1 or minMulti
	multiStep = not multiStep and 1 or multiStep
	multiStep = multiStep < 1 and 1 or multiStep

	local sourceOwenNum = ItemModel.instance:getItemCountByItemId(cfgCO:getSourceId())
	local sourceReqNum = cfgCO:getSourceNum()

	if sourceOwenNum >= sourceReqNum * minMulti then
		ToolTipsMgr.showCurrencyExchangeTips(id, minMulti, isMulti, multiStep, titleStr)

		return true
	else
		if forceShowWhenJumpOpen then
			local jumpId = cfgCO:getJumpId()
			local systemOpen = true

			if jumpId > 0 then
				systemOpen = SystemOpenFacade.instance:isOpen(jumpId)
			else
				systemOpen = false
			end

			if systemOpen then
				ToolTipsMgr.showCurrencyExchangeTips(id, minMulti, isMulti, multiStep, titleStr)

				return true
			end
		end

		printWarn(string.format("[%s] 源道具%s[%s] 数量[%d] 不足 [%d]，无法打开通用兑换界面", id, cfgCO:getItemNameSource(), cfgCO:getSourceId(), sourceOwenNum, sourceReqNum))

		return false
	end
end

function M:checkBackpackItemEnough(itemId, reqNum)
	local owenNum = ItemModel.instance:getItemCountByItemId(itemId)

	return reqNum <= owenNum
end

function M:onExchangeCurrencyReply(msg)
	local id = msg.id
	local remainedTimes = msg.remainedTimes

	printWarn("id[%s] remainedTimes[%s]", id, remainedTimes)

	if remainedTimes then
		local mo = CurrencyExchangeModel.instance:getExchangeMo(id)

		mo:setRemainedTimes(remainedTimes)
		GlobalDispatcher:dispatchEvent(EventType.CURRENCY_EXCHANGE_TIME_CHANGE, id, false)
	end
end

function M:onExchangeRemainedTimesReply(remainedTimes)
	local len = remainedTimes and #remainedTimes or 0

	if len > 0 then
		for _, EntryNO in ipairs(remainedTimes) do
			local ruleId = EntryNO.key
			local times = EntryNO.value
			local mo = CurrencyExchangeModel.instance:getExchangeMo(ruleId)

			mo:setRemainedTimes(times)
			GlobalDispatcher:dispatchEvent(EventType.CURRENCY_EXCHANGE_TIME_CHANGE, ruleId, true)
		end
	end
end

M.instance = M.New()

return M
