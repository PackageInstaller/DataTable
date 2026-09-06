-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmm/view/AixinmmchallengeViewPresentor.lua

module("logic.extensions.aixinmm.view.AixinmmchallengeViewPresentor", package.seeall)

local AixinmmchallengeViewPresentor = class("AixinmmchallengeViewPresentor", ViewPresentor)

function AixinmmchallengeViewPresentor:ctor()
	AixinmmchallengeViewPresentor.super.ctor(self)
end

function AixinmmchallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AixinmmchallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/aixinmm/aixinmmchallengeview.prefab"
	}
end

function AixinmmchallengeViewPresentor:buildViews()
	return {
		AixinmmchallengeView.New()
	}
end

return AixinmmchallengeViewPresentor
