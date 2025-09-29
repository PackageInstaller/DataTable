-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/thinking/ThinkingActiveSuccessPresentor.lua

module("logic.extensions.charactersystem.view.thinking.ThinkingActiveSuccessPresentor", package.seeall)

local M = class("ThinkingActiveSuccessPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Thought_thought_active_success_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ThinkingActiveSuccessView.New())

	return views
end

return M
