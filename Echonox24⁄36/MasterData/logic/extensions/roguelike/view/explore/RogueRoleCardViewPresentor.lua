-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueRoleCardViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RogueRoleCardViewPresentor", package.seeall)

local M = class("RogueRoleCardViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupexplore_props_select_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueRoleCardView.New())

	local blurView = BlurBgView.New()

	blurView:OnlyBlurScene()
	table.insert(views, blurView)

	return views
end

function M:attachToWhichRoot()
	return ViewRootType.PopupTop
end

return M
