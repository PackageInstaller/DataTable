-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/view/two/AresMomChallengeTwoViewPresentor.lua

module("logic.extensions.aresmom.view.two.AresMomChallengeTwoViewPresentor", package.seeall)

local AresMomChallengeTwoViewPresentor = class("AresMomChallengeTwoViewPresentor", AresMomChallengeViewPresentor)

function AresMomChallengeTwoViewPresentor:dependWhatResources()
	return {
		"ui/views/aresmom/two/aresmomchallengetwoview.prefab"
	}
end

function AresMomChallengeTwoViewPresentor:buildViews()
	return {
		AresMomChallengeTwoView.New()
	}
end

return AresMomChallengeTwoViewPresentor
