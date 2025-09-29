-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/facade/ContainmentFacade.lua

module("logic.extensions.containmentzone.facade.ContainmentFacade", package.seeall)

local M = class("ContainmentFacade", BaseFacade)

function M:ctor()
	return
end

function M:openHoldingMainView(roomId)
	local info = {}

	info.roomId = roomId

	ViewMgr.instance:open(ViewName.FacilityHoldingMainView, info)
end

function M:openHoldingManageView(protomerId)
	local info = {}

	info.protomerId = protomerId

	ViewMgr.instance:open(ViewName.FacilityHoldingManageView, info)
end

function M:openHoldingChangeView(selectTab)
	local info = {}

	info.selectTab = selectTab

	ViewMgr.instance:open(ViewName.FacilityHoldingChangeView, info)
end

function M:openProtomerUpgradeView(protomerId)
	local info = {}

	info.protomerId = protomerId

	ViewMgr.instance:open(ViewName.FacilityHoldingUpgradeView, info)
end

function M:openPrototypeInfoView(protomerId)
	local info = {}

	info.protomerId = protomerId

	ViewMgr.instance:open(ViewName.FacilityHoldingPrototypeInfoView, info)
end

function M:openReportSettlementView(roomId)
	local info = {}

	info.roomId = roomId

	ViewMgr.instance:open(ViewName.FacilityHoldingReportSettlementView, info)
end

function M:openReportView(roomId)
	local info = {}

	info.roomId = roomId

	ViewMgr.instance:open(ViewName.FacilityHoldingReportView, info)
end

function M:openReprotDetailView(roomId, reportLst)
	local info = {}

	info.roomId = roomId
	info.reportLst = reportLst
	info.readFailMode = false

	ViewMgr.instance:open(ViewName.FacilityHoldingReportDetailsView, info)
end

function M:openReportDetailViewForUnReadFailReport()
	local reportLst = ContainmentReportModel.instance:getAllUnReadFailReportInfoLst()

	if #reportLst > 0 then
		printWarn(string.format("未读报告筛选结果为[%d]", #reportLst))

		reportLst = ContainmentUtil.sortHoldRoomReport(reportLst)

		printWarn(string.format("未读报告筛选结果为[%d]", #reportLst))

		local info = {}

		info.roomId = 0
		info.reportLst = reportLst
		info.readFailMode = true

		ContainmentReportModel.instance:removeAllUnReadFailReport()
		ViewMgr.instance:open(ViewName.FacilityHoldingReportDetailsView, info)
	else
		printWarn(string.format("未读报告筛选结果为[%d]，无需打开界面", #reportLst))
	end
end

M.instance = M.New()

return M
