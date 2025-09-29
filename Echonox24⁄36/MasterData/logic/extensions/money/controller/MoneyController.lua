-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/money/controller/MoneyController.lua

module("logic.extensions.money.controller.MoneyController", package.seeall)

local M = class("MoneyController", BaseController)

function M:ctor()
	return
end

function M:onInit()
	GlobalDispatcher:addEventListener(MoneyEventType.ENERGY_RECOVER_TIME_SERVER_CHANGE, self._handleEnergyRecoverTimeChangeEvent, self)
end

function M:onReset()
	self:_timerControllerForEnergyRecover(false)
end

function M:getHintTxt(code)
	local hintStr

	if code == CommEnum.CurrencyCodeEnum.TlCode then
		hintStr = EnergyRecoverModel.instance:getHintTxt()
	end

	return hintStr
end

function M:_handleEnergyRecoverTimeChangeEvent(code, leftTime)
	if leftTime < 0 then
		self:_timerControllerForEnergyRecover(false)

		return
	end

	self:_timerControllerForEnergyRecover(true, leftTime)
end

function M:_timerControllerForEnergyRecover(starTimer, leftTime)
	GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKSECOND, self._timerForEnergyRecover, self)

	if starTimer then
		self:_timerForEnergyRecover()
		GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKSECOND, self._timerForEnergyRecover, self)
	end
end

function M:_timerForEnergyRecover()
	local recoverTime = EnergyRecoverModel.instance:getEnergyRecoverTime()

	recoverTime = recoverTime - 1

	if recoverTime < 0 then
		recoverTime = 0
	end

	EnergyRecoverModel.instance:forceSetEnergyRecoverTime(recoverTime)
end

M.instance = M.New()

return M
