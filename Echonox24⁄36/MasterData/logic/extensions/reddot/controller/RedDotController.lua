-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reddot/controller/RedDotController.lua

module("logic.extensions.reddot.controller.RedDotController", package.seeall)

local M = class("RedDotController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	GlobalDispatcher:addEventListener(EventType.RED_DOT_UPDATE_EVENT, self._updateRedDot, self)
	GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKDAY, self._handleClockTickDay, self)
	GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKWEEK, self._handleClockTickWeek, self)
	GlobalDispatcher:addEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self._handleClockTickDailyRefresh, self)
end

function M:onReset()
	RedDotModel.instance:clear()
	GlobalDispatcher:dispatchEvent(EventType.RED_DOT_RESET)
end

function M:_updateRedDot(e, redDotData)
	if redDotData then
		local isActive = RedDotModel.instance:getDotIsActive(redDotData.key)
		local isChange = redDotData.isActive ~= isActive

		if isChange then
			RedDotModel.instance:setDotIsActivite(redDotData)

			local isParentActive = RedDotModel.instance:getDotIsActiveByParentKey(redDotData.parentKey, true)

			GlobalDispatcher:dispatchEvent(EventType.RED_DOT_VIEW_EVENT, redDotData)

			if redDotData.parentKey ~= nil and RedDotModel.instance:getCurKeyParentKey(redDotData.parentKey) ~= nil and isParentActive ~= RedDotModel.instance:getDotIsActive(redDotData.parentKey) then
				GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
					isParentChange = true,
					key = redDotData.parentKey,
					isActive = isParentActive,
					parentKey = RedDotModel.instance:getCurKeyParentKey(redDotData.parentKey)
				})
			end
		end
	end
end

function M:_handleClockTickDay(e)
	RedDotAgent.instance:sendLoadAllRedPointRequest()
end

function M:_handleClockTickWeek(e)
	RedDotAgent.instance:sendLoadAllRedPointRequest()
end

function M:_handleClockTickDailyRefresh(e, enum)
	RedDotAgent.instance:sendLoadAllRedPointRequest()
end

M.instance = M.New()

return M
