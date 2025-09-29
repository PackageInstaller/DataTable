-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/DungeonStarRewardViewPresentor.lua

module("logic.extensions.dungeon.view.DungeonStarRewardViewPresentor", package.seeall)

local M = class("DungeonStarRewardViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Branchline_bounty_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, DungeonStarRewardView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
