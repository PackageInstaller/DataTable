-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/HeroSelectedViewPresentor.lua

module("logic.extensions.common.view.HeroSelectedViewPresentor", package.seeall)

local M = class("HeroSelectedViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Dialog_role_select_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HeroSelectedView.New())

	return views
end

return M
