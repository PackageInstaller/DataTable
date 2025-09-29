-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewhacker/BattleAttrModifyHackViewPresentor.lua

module("logic.extensions.battle.viewhacker.BattleAttrModifyHackViewPresentor", package.seeall)

local M = class("BattleAttrModifyHackViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Hacktool_skill_modify_view
	}
end

function M:attachToWhichRoot()
	return ViewRootType.Top
end

function M:buildViews()
	local views = {}

	table.insert(views, BattleAttrModifyHackView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
