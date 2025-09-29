-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characteranchor/view/ComposeItemViewPresentor.lua

module("logic.extensions.characteranchor.view.ComposeItemViewPresentor", package.seeall)

local M = class("ComposeItemViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Contract_complex_contract_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ComposeItemView.New())

	return views
end

return M
