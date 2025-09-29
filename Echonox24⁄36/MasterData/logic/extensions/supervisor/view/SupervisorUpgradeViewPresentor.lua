-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/supervisor/view/SupervisorUpgradeViewPresentor.lua

module("logic.extensions.supervisor.view.SupervisorUpgradeViewPresentor", package.seeall)

local M = class("SupervisorUpgradeViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_yield_facility_yield_upgrade_tips,
		ResName.Room_facility_yield_unlock_cell,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, SupervisorUpgradeView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.RoomUpgradeShowType))

	return views
end

return M
