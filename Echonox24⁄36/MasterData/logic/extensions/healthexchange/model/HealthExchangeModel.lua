-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/healthexchange/model/HealthExchangeModel.lua

module("logic.extensions.healthexchange.model.HealthExchangeModel", package.seeall)

local M = class("HealthExchangeModel", BaseModel)

function M:ctor()
	return
end

function M:getEnergyBuyRemainedTime()
	return CurrencyExchangeModel.instance:getRemainedTime(self:getEnergyBuyRuleId())
end

function M:getEnergyBuyMaxTime()
	return CurrencyExchangeModel.instance:getMaxTime(self:getEnergyBuyRuleId())
end

function M:getEnergyBuyRuleId()
	if not self._energyBuyRuleId then
		self._energyBuyRuleId = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.EnergyBuyRule)
	end

	return self._energyBuyRuleId
end

function M:getTimeStampBySet(setHour, setMin, setSec, offsetTimeStamp)
	local now = ServerTime.nowDateServerLook()

	setHour = setHour or 0
	setMin = setMin or 0
	setSec = setSec or 0

	local returnTime = os.time({
		year = now.year,
		month = now.month,
		day = now.day,
		hour = setHour,
		min = setMin,
		sec = setSec
	})

	if offsetTimeStamp and offsetTimeStamp ~= 0 then
		returnTime = returnTime + offsetTimeStamp
	end

	return returnTime
end

function M:onReset()
	return
end

function M:prepareUseDrug(itemUseData)
	local curTime = ServerTime.now() * 1000
	local totalUseNum = 0
	local _sendTable = {}

	for k, v in pairs(itemUseData or {}) do
		if v.hasAddCount > 0 and (v.expireTime == 0 or curTime < v.expireTime) then
			if totalUseNum > 0 then
				table.insert(_sendTable, ",")
			else
				table.insert(_sendTable, "{")
			end

			table.insert(_sendTable, v.uuid)
			table.insert(_sendTable, ":")
			table.insert(_sendTable, v.hasAddCount)

			totalUseNum = totalUseNum + 1
		end
	end

	if totalUseNum > 0 then
		table.insert(_sendTable, "}")

		local _sendStr = table.concat(_sendTable)

		HealthExchangeAgent.instance:sendUseEnergyItemsRequest(_sendStr)
	else
		printWarn("使用药剂失败，没有药剂可用,可能已过期")
		GlobalDispatcher:dispatchEvent(EventType.HEALTH_EXCHANGE_DRUG_LST_CHANGE)
	end
end

function M:handleBuyEnergyErrorStatus(status)
	if status and status == 106 then
		FloatWordMgr.instance:show(lang("tip_buy_power_max_day"))
	end
end

function M:getItemCount(code)
	return ItemModel.instance:getItemCountByItemId(code)
end

function M:getCurEnergy()
	return self:getItemCount(CommEnum.CurrencyCodeEnum.TlCode)
end

function M:getExpiredTimeStr(expiredTime)
	expiredTime = expiredTime or 0
	expiredTime = tonumber(expiredTime)

	if expiredTime == 0 then
		return ""
	end

	local curTime = ServerTime.now() * 1000

	if expiredTime < curTime then
		return lang("tip_overdue")
	end

	local offset = expiredTime - curTime

	return TextFormatter.format(FormatterEnum.EXPIRE_TIME, offset / 1000)
end

M.instance = M.New()

return M
