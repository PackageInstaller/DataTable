-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragondungeon/view/BoneDragonDungeonGameViewPresentor.lua

module("logic.extensions.bonedragondungeon.view.BoneDragonDungeonGameViewPresentor", package.seeall)

local BoneDragonDungeonGameViewPresentor = class("BoneDragonDungeonGameViewPresentor", ViewPresentor)

function BoneDragonDungeonGameViewPresentor:ctor()
	BoneDragonDungeonGameViewPresentor.super.ctor(self)
end

function BoneDragonDungeonGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoneDragonDungeonGameViewPresentor:dependWhatResources()
	return {
		"ui/views/bonedragondungeon/bonedragondungeongameview.prefab"
	}
end

function BoneDragonDungeonGameViewPresentor:buildViews()
	return {
		BoneDragonDungeonGameView.New()
	}
end

return BoneDragonDungeonGameViewPresentor
