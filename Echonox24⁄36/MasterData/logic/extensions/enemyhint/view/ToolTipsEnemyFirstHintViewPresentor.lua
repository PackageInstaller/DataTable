-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/enemyhint/view/ToolTipsEnemyFirstHintViewPresentor.lua

module("logic.extensions.enemyhint.view.ToolTipsEnemyFirstHintViewPresentor", package.seeall)

local M = class("ToolTipsEnemyFirstHintViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Enemy_first_appearance_tips
	}
end

function M:attachToWhichRoot()
	return ViewRootType.Top
end

function M:buildViews()
	local views = {}

	table.insert(views, ToolTipsEnemyFirstHintView.New())

	return views
end

return M
