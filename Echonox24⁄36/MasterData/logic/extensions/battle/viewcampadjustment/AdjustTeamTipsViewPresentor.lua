-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcampadjustment/AdjustTeamTipsViewPresentor.lua

module("logic.extensions.battle.viewcampadjustment.AdjustTeamTipsViewPresentor", package.seeall)

local M = class("AdjustTeamTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Battle_adjust_team_tips,
		ViewlibResPath.BattleTeamCellItem,
		ViewlibResPath.HeroHeadItem
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AdjustTeamTipsView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
