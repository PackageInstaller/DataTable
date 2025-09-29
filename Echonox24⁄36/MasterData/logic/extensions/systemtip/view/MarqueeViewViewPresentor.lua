-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemtip/view/MarqueeViewViewPresentor.lua

module("logic.extensions.systemtip.view.MarqueeViewViewPresentor", package.seeall)

local M = class("MarqueeViewViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Systemtip_marquee_view
	}
end

function M:attachToWhichRoot()
	return ViewRootType.TopMost
end

function M:buildViews()
	local views = {}

	table.insert(views, MarqueeView.New())

	return views
end

return M
