-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annuityprivilege/controller/AnnuityPrivilegeController.lua

module("logic.extensions.annuityprivilege.controller.AnnuityPrivilegeController", package.seeall)

local AnnuityPrivilegeController = class("AnnuityPrivilegeController", BaseController)

function AnnuityPrivilegeController:onInit()
	return
end

function AnnuityPrivilegeController:onReset()
	return
end

function AnnuityPrivilegeController:isCanSweep(activityId)
	local ids = self:getCanSweepAnnuityActivityIds(activityId)

	for _, annuityActivityId in ipairs(ids) do
		if YearCardModel.instance:isActiveAnnuity(annuityActivityId) then
			return true
		end
	end

	return false
end

function AnnuityPrivilegeController:isBelongSweep(activityId)
	local ids = self:getCanSweepAnnuityActivityIds(activityId)

	return #ids > 0
end

function AnnuityPrivilegeController:getCanSweepAnnuityActivityIds(activityId)
	local ids = {}
	local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)
	local annuityActivityIds = self:getFitAnnuityActivityIdsByTime(ServerTime.now())

	for _, annuityActivityId in ipairs(annuityActivityIds) do
		local sweepData = AnnuityPrivilegeConfig.instance:getSweepData(annuityActivityId, activityType)

		if sweepData then
			if sweepData.refuseSweepActivityIds then
				if table.indexof(sweepData.refuseSweepActivityIds, activityId) == false then
					table.insert(ids, annuityActivityId)
				end
			else
				table.insert(ids, annuityActivityId)

				break
			end
		end
	end

	return ids
end

function AnnuityPrivilegeController:getFitAnnuityActivityIdsByTime(timeStamp)
	local activityIds = {}
	local activityTimes = AnnuityPrivilegeConfig.instance:getAnnuityActivityIdsByTime()

	for annuityActivityId, v in pairs(activityTimes) do
		if GameUtil.getTimePeriodBySecWithOther(timeStamp, v[1], v[2]) == GameUtil.inTimePeriod then
			table.insert(activityIds, annuityActivityId)
		end
	end

	return activityIds
end

function AnnuityPrivilegeController:addAnnuityPrivilegeSweepTipsView(parentGo, parentPresentor, activityId)
	local viewName = ViewName.AnnuityPrivilegeTipsView

	if ViewMgr.instance:isOpen(viewName) then
		ViewMgr.instance:close(viewName)
	end

	ViewMgr.instance:openAt(parentGo, viewName, parentPresentor, activityId)
end

function AnnuityPrivilegeController:closeAnnuityPrivilegeSweepTipsView()
	local viewName = ViewName.AnnuityPrivilegeTipsView

	if ViewMgr.instance:isOpen(viewName) then
		ViewMgr.instance:close(viewName)
	end

	GlobalDispatcher:dispatch(GlobalNotify.AnnuityPrivilegeTipsViewClose)
end

AnnuityPrivilegeController.instance = AnnuityPrivilegeController.New()

return AnnuityPrivilegeController
