-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/MainUIDetectViewPresentor.lua

module("logic.extensions.mainui.view.performeditor.MainUIDetectViewPresentor", package.seeall)

local M = class("MainUIDetectViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Main_main_ui_detect
	}
end

function M:attachToWhichRoot()
	return ViewRootType.Top
end

function M:buildViews()
	local views = {}

	table.insert(views, MainUIDetectView.New())

	return views
end

return M
