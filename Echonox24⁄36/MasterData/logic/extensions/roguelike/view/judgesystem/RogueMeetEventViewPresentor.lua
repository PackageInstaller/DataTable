-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/judgesystem/RogueMeetEventViewPresentor.lua

module("logic.extensions.roguelike.view.judgesystem.RogueMeetEventViewPresentor", package.seeall)

local M = class("RogueMeetEventViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupjudgement_run_group_event_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueMeetEventView.New())

	local blurView = BlurBgView.New()

	blurView:OnlyBlurScene()
	table.insert(views, blurView)

	return views
end

function M:attachToWhichRoot()
	return ViewRootType.PopupTop
end

return M
