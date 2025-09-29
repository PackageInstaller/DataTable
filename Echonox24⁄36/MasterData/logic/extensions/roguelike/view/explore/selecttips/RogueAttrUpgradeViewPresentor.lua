-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/selecttips/RogueAttrUpgradeViewPresentor.lua

module("logic.extensions.roguelike.view.explore.selecttips.RogueAttrUpgradeViewPresentor", package.seeall)

local M = class("RogueAttrUpgradeViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupexplore_attr_upgrade_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueAttrUpgradeView.New())

	local blurView = BlurBgView.New()

	blurView:OnlyBlurScene()
	table.insert(views, blurView)

	return views
end

return M
