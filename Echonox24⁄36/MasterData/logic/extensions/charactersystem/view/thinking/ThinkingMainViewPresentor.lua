-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/thinking/ThinkingMainViewPresentor.lua

module("logic.extensions.charactersystem.view.thinking.ThinkingMainViewPresentor", package.seeall)

local M = class("ThinkingMainViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Thought_thought_main_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ThinkingMainView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
