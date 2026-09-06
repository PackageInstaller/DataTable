-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petassist/view/AssistUpgradeViewPresentor.lua

module("logic.extensions.petassist.view.AssistUpgradeViewPresentor", package.seeall)

local AssistUpgradeViewPresentor = class("AssistUpgradeViewPresentor", ViewWithGuidePresentor)

function AssistUpgradeViewPresentor:ctor()
	AssistUpgradeViewPresentor.super.ctor(self)
end

function AssistUpgradeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AssistUpgradeViewPresentor:dependWhatResources()
	return {
		"ui/views/petassist/assistupgradeview.prefab"
	}
end

function AssistUpgradeViewPresentor:buildViews()
	return {
		AssistUpgradeView.New()
	}
end

return AssistUpgradeViewPresentor
