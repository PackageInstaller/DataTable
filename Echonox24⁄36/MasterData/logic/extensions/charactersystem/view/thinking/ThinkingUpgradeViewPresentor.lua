-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/thinking/ThinkingUpgradeViewPresentor.lua

module("logic.extensions.charactersystem.view.thinking.ThinkingUpgradeViewPresentor", package.seeall)

local M = class("ThinkingUpgradeViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Thought_thought_upgrade_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ThinkingUpgradeView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
