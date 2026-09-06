-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragondungeon/view/BoneDragonDungeonShopViewPresentor.lua

module("logic.extensions.bonedragondungeon.view.BoneDragonDungeonShopViewPresentor", package.seeall)

local BoneDragonDungeonShopViewPresentor = class("BoneDragonDungeonShopViewPresentor", ViewPresentor)

function BoneDragonDungeonShopViewPresentor:ctor()
	BoneDragonDungeonShopViewPresentor.super.ctor(self)
end

function BoneDragonDungeonShopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BoneDragonDungeonShopViewPresentor:dependWhatResources()
	return {
		"ui/views/bonedragondungeon/bonedragondungeonshopview.prefab"
	}
end

function BoneDragonDungeonShopViewPresentor:buildViews()
	return {
		BoneDragonDungeonShopView.New()
	}
end

return BoneDragonDungeonShopViewPresentor
