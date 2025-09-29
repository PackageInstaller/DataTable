-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/AirWorkShopDynMsgViewPresentor.lua

module("logic.extensions.airworkshop.view.AirWorkShopDynMsgViewPresentor", package.seeall)

local M = class("AirWorkShopDynMsgViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_dynamics_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Battle)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopDynMsgView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
