-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/judgesystem/RogueMonsterSettlementViewPresentor.lua

module("logic.extensions.roguelike.view.judgesystem.RogueMonsterSettlementViewPresentor", package.seeall)

local M = class("RogueMonsterSettlementViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupjudgement_run_group_battle_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueMonsterSettlementView.New())

	local blurView = BlurBgView.New()

	blurView:OnlyBlurScene()
	table.insert(views, blurView)

	return views
end

function M:attachToWhichRoot()
	return ViewRootType.PopupTop
end

return M
