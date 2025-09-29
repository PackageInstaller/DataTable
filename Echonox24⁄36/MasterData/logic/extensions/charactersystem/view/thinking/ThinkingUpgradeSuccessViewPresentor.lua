-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/thinking/ThinkingUpgradeSuccessViewPresentor.lua

module("logic.extensions.charactersystem.view.thinking.ThinkingUpgradeSuccessViewPresentor", package.seeall)

local M = class("ThinkingUpgradeSuccessViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Thought_thought_upgrade_success_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ThinkingUpgradeSuccessView.New())

	return views
end

return M
