-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/selecttips/RogueDiceUnlockViewPresentor.lua

module("logic.extensions.roguelike.view.explore.selecttips.RogueDiceUnlockViewPresentor", package.seeall)

local M = class("RogueDiceUnlockViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupexplore_dice_unlock_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueDiceUnlockView.New())

	local blurView = BlurBgView.New()

	blurView:OnlyBlurScene()
	table.insert(views, blurView)

	return views
end

return M
