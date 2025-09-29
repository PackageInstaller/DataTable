-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/currencyexchange/model/CurrencyExchangeMo.lua

module("logic.extensions.currencyexchange.model.CurrencyExchangeMo", package.seeall)

local M = class("CurrencyExchangeMo")

function M:ctor(id)
	self._id = id
end

function M:getId()
	return self._id
end

function M:getCo()
	return CurrencyExchangeConfig.instance:getCurrencyExchange(self:getId())
end

function M:setRemainedTimes(remainTimes)
	self._remainedTimes = remainTimes
end

function M:getRemainedTimes()
	return self._remainedTimes
end

function M:getMaxTime()
	local co = self:getCo()

	return co and co:getMaxCount() or 0
end

return M
