-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/challenge/AirWorkShopRodeoMainViewPresentor.lua

module("logic.extensions.airworkshop.view.challenge.AirWorkShopRodeoMainViewPresentor", package.seeall)

local M = class("AirWorkShopRodeoMainViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_sports_mode_view,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_AirWorkShop)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopRodeoMainView.New())

	local titleView = TitleView.New(CommEnum.GuideID.AirWorkShopRodeo)

	titleView:setTitle(lang("tip_air_entry_rodeo_mode"))
	table.insert(views, titleView)
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.AirStudioChallengeShowType))

	return views
end

return M
