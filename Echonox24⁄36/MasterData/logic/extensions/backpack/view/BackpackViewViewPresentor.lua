-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackViewViewPresentor.lua

module("logic.extensions.backpack.view.BackpackViewViewPresentor", package.seeall)

local M = class("BackpackViewViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Backpack_Backpack_View,
		ResName.Common_Backpack_Item,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Backpack)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, BackpackView.New())
	table.insert(views, BackpackPropOperateView.New())
	table.insert(views, BackpackEquipOperateView.New())
	table.insert(views, BackpackEchoOperateView.New())

	local titleView = TitleView.New()

	titleView:setHideHomeBtn(true)
	table.insert(views, titleView)
	table.insert(views, BackpackMoneyView.New())

	return views
end

return M
