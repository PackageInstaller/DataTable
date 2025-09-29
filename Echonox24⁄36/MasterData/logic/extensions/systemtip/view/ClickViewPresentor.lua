-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemtip/view/ClickViewPresentor.lua

module("logic.extensions.systemtip.view.ClickViewPresentor", package.seeall)

local M = class("ClickViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Common_click_feedback
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ClickView.New())

	return views
end

function M:attachToWhichRoot()
	return ViewRootType.TopMost
end

return M
