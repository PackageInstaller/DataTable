-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueVendingMachineViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RogueVendingMachineViewPresentor", package.seeall)

local M = class("RogueVendingMachineViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupexplore_vending_machine_view,
		ResName.Rungroupexplore_vending_props_item,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueVendingMachineView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.RogueVendingMachineShowType))

	local blurView = BlurBgView.New()

	blurView:OnlyBlurScene()
	table.insert(views, blurView)
	table.insert(views, TitleView.New(CommEnum.ManualKey.RogueStore))

	return views
end

return M
