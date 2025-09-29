-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/betgame/RogueMoonyDiceGameViewPresentor.lua

module("logic.extensions.roguelike.view.betgame.RogueMoonyDiceGameViewPresentor", package.seeall)

local M = class("RogueMoonyDiceGameViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupgame_magnet_dice_game_view,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueMoonyDiceGameView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.RogueVendingMachineShowType))

	local blurView = BlurBgView.New()

	blurView:OnlyBlurScene()
	table.insert(views, blurView)
	table.insert(views, TitleView.New(CommEnum.ManualKey.RogueMoony))

	return views
end

return M
