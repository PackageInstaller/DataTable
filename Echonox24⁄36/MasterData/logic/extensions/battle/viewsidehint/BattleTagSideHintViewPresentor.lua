-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsidehint/BattleTagSideHintViewPresentor.lua

module("logic.extensions.battle.viewsidehint.BattleTagSideHintViewPresentor", package.seeall)

local M = class("BattleTagSideHintViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Battle_tag_side_hint_tips
	}
end

function M:attachToWhichRoot()
	return ViewRootType.NotifyTop
end

function M:buildViews()
	local views = {}

	table.insert(views, BattleTagSideHintView.New())

	return views
end

return M
