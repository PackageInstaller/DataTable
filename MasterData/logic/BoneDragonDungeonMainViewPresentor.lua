-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragondungeon/view/BoneDragonDungeonMainViewPresentor.lua

module("logic.extensions.bonedragondungeon.view.BoneDragonDungeonMainViewPresentor", package.seeall)

local BoneDragonDungeonMainViewPresentor = class("BoneDragonDungeonMainViewPresentor", ViewPresentor)

function BoneDragonDungeonMainViewPresentor:ctor()
	BoneDragonDungeonMainViewPresentor.super.ctor(self)
end

function BoneDragonDungeonMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoneDragonDungeonMainViewPresentor:dependWhatResources()
	return {
		"ui/views/bonedragondungeon/bonedragondungeonmainview.prefab"
	}
end

function BoneDragonDungeonMainViewPresentor:buildViews()
	return {
		BoneDragonDungeonMainView.New()
	}
end

return BoneDragonDungeonMainViewPresentor
