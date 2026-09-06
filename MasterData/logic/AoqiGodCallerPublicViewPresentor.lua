-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodCallerPublicViewPresentor.lua

module("logic.extensions.aoqigod.view.AoqiGodCallerPublicViewPresentor", package.seeall)

local AoqiGodCallerPublicViewPresentor = class("AoqiGodCallerPublicViewPresentor", ViewPresentor)

function AoqiGodCallerPublicViewPresentor:ctor()
	AoqiGodCallerPublicViewPresentor.super.ctor(self)
end

function AoqiGodCallerPublicViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AoqiGodCallerPublicViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqigod/aoqigodcallerpublicview.prefab"
	}
end

function AoqiGodCallerPublicViewPresentor:buildViews()
	return {
		AoqiGodCallerPublicView.New()
	}
end

return AoqiGodCallerPublicViewPresentor
