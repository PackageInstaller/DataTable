-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/view/AresMomChallengeViewPresentor.lua

module("logic.extensions.aresmom.view.AresMomChallengeViewPresentor", package.seeall)

local AresMomChallengeViewPresentor = class("AresMomChallengeViewPresentor", ViewPresentor)

function AresMomChallengeViewPresentor:ctor()
	AresMomChallengeViewPresentor.super.ctor(self)
end

function AresMomChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AresMomChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/aresmom/aresmomchallengeview.prefab"
	}
end

function AresMomChallengeViewPresentor:buildViews()
	return {
		AresMomChallengeView.New()
	}
end

return AresMomChallengeViewPresentor
