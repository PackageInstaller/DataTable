-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragon/view/BoneDragonChooseViewPresentor.lua

module("logic.extensions.bonedragon.view.BoneDragonChooseViewPresentor", package.seeall)

local BoneDragonChooseViewPresentor = class("BoneDragonChooseViewPresentor", ViewPresentor)

function BoneDragonChooseViewPresentor:ctor()
	BoneDragonChooseViewPresentor.super.ctor(self)
end

function BoneDragonChooseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoneDragonChooseViewPresentor:dependWhatResources()
	return {
		"ui/views/bonedragon/bonedragonchooseview.prefab"
	}
end

function BoneDragonChooseViewPresentor:buildViews()
	return {
		BoneDragonChooseView.New()
	}
end

return BoneDragonChooseViewPresentor
