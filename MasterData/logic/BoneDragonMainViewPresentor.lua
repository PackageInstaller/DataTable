-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragon/view/BoneDragonMainViewPresentor.lua

module("logic.extensions.bonedragon.view.BoneDragonMainViewPresentor", package.seeall)

local BoneDragonMainViewPresentor = class("BoneDragonMainViewPresentor", ViewPresentor)

function BoneDragonMainViewPresentor:ctor()
	BoneDragonMainViewPresentor.super.ctor(self)
end

function BoneDragonMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoneDragonMainViewPresentor:dependWhatResources()
	return {
		"ui/views/bonedragon/bonedragonmainview.prefab"
	}
end

function BoneDragonMainViewPresentor:buildViews()
	return {
		BoneDragonMainView.New()
	}
end

return BoneDragonMainViewPresentor
