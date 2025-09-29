-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueTeamInfoViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RogueTeamInfoViewPresentor", package.seeall)

local M = class("RogueTeamInfoViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupjudgement_run_group_result_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueTeamInfoView.New())

	local blurView = BlurBgView.New()

	blurView:OnlyBlurScene()
	table.insert(views, blurView)

	return views
end

function M:attachToWhichRoot()
	return ViewRootType.PopupTop
end

return M
