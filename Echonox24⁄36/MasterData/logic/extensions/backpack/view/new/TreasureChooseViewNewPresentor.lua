-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/new/TreasureChooseViewNewPresentor.lua

module("logic.extensions.backpack.view.new.TreasureChooseViewNewPresentor", package.seeall)

local M = class("TreasureChooseViewNewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Common_common_multiple_choice_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, TreasureChooseViewNew.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
