-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragon/view/BoneDragonChallengeViewPresentor.lua

module("logic.extensions.bonedragon.view.BoneDragonChallengeViewPresentor", package.seeall)

local BoneDragonChallengeViewPresentor = class("BoneDragonChallengeViewPresentor", ViewPresentor)

function BoneDragonChallengeViewPresentor:ctor()
	BoneDragonChallengeViewPresentor.super.ctor(self)
end

function BoneDragonChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoneDragonChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/bonedragon/bonedragonchallengeview.prefab"
	}
end

function BoneDragonChallengeViewPresentor:buildViews()
	return {
		BoneDragonChallengeView.New()
	}
end

return BoneDragonChallengeViewPresentor
