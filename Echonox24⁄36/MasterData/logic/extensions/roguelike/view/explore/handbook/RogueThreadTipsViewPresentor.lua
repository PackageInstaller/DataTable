-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/handbook/RogueThreadTipsViewPresentor.lua

module("logic.extensions.roguelike.view.explore.handbook.RogueThreadTipsViewPresentor", package.seeall)

local M = class("RogueThreadTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupexplore_run_group_gain_thread_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueThreadTipsView.New())

	local blurView = BlurBgView.New()

	table.insert(views, blurView)

	return views
end

function M:attachToWhichRoot()
	return ViewRootType.PopupTop
end

return M
