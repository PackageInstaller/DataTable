-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/monitor/MonitorUseItemViewPresentor.lua

module("logic.extensions.controlaction.view.monitor.MonitorUseItemViewPresentor", package.seeall)

local M = class("MonitorUseItemViewPresentor", ViewPresentor)

M.Url_View = ResName.Regulatory_manual_useitem

function M:dependWhatResources()
	return {
		M.Url_View
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, MonitorUseItemView.New())

	return views
end

return M
