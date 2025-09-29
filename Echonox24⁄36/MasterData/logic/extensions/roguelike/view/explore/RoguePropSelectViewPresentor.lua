-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RoguePropSelectViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RoguePropSelectViewPresentor", package.seeall)

local M = class("RoguePropSelectViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupexplore_prop_attribute_use_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RoguePropSelectView.New())

	local blurView = BlurBgView.New()

	blurView:OnlyBlurScene()
	table.insert(views, blurView)

	return views
end

return M
