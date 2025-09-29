-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/thinking/ThinkingInfoViewPresentor.lua

module("logic.extensions.charactersystem.view.thinking.ThinkingInfoViewPresentor", package.seeall)

local M = class("ThinkingInfoViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Thought_thought_info_view,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ThinkingInfoView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
