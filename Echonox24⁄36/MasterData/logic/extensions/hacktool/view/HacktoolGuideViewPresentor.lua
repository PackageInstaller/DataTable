-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/HacktoolGuideViewPresentor.lua

module("logic.extensions.hacktool.view.HacktoolGuideViewPresentor", package.seeall)

local M = class("HacktoolGuideViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Hacktool_guide_hacktool_panel
	}
end

function M:buildViews()
	local views = {}
	local mainView = HacktoolGuideView.New()

	table.insert(views, mainView)

	return views
end

return M
