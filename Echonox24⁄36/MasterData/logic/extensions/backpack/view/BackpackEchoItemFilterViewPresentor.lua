-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackEchoItemFilterViewPresentor.lua

module("logic.extensions.backpack.view.BackpackEchoItemFilterViewPresentor", package.seeall)

local M = class("BackpackEchoItemFilterViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Backpack_backpack_filter_tips_1
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, BackpackEchoItemFilterView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
