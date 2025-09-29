-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/control/ContainmentController.lua

module("logic.extensions.containmentzone.control.ContainmentController", package.seeall)

local M = class("ContainmentController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:setEvent(true)
end

function M:onReset()
	return
end

function M:setEvent(add)
	if add then
		HouseDispatcher:addEventListener(HouseEventType.LIVE_ZONE_ACTIVE, self._handleLiveZoneActive, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_UNLOCK_INFO_REFRESH, self._handleLiveUnlockInfoRefresh, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_ZONE_ACTIVE, self._handleLiveZoneActive, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_UNLOCK_INFO_REFRESH, self._handleLiveUnlockInfoRefresh, self)
	end
end

function M:_handleLiveZoneActive(e, zoneId)
	local isHoldRoomActive = zoneId < 1200

	if isHoldRoomActive then
		ContainmentZoneAgent.instance:sendGetSingleHoldRoomInfoRequest(zoneId)
	end
end

function M:_handleLiveUnlockInfoRefresh(e, unlockZones)
	HouseMainRoomModel.instance:onLiveUnlockZonesRefresh(unlockZones)
end

function M:receiveSingleReportReward(report, showGainItemView)
	if report then
		local reportMo = ContainmentReportModel.instance:reciveReport(report)

		if showGainItemView then
			local dataLst = reportMo and reportMo:getRewardsItemDataLst() or {}

			table.sort(dataLst, ItemUtil.sortItemsCompare)

			if #dataLst > 0 then
				GainItemController.instance:openView(dataLst)
			end
		end
	end
end

function M:receiveReportLstReward(reportDataLst)
	ContainmentReportModel.instance:reciveReportLst(reportDataLst)
end

M.instance = M.New()

return M
