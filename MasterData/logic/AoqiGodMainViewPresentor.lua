-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodMainViewPresentor.lua

module("logic.extensions.aoqigod.view.AoqiGodMainViewPresentor", package.seeall)

local AoqiGodMainViewPresentor = class("AoqiGodMainViewPresentor", ViewPresentor)

function AoqiGodMainViewPresentor:ctor()
	AoqiGodMainViewPresentor.super.ctor(self)
end

function AoqiGodMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiGodMainViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqigod/aoqigodmainview.prefab"
	}
end

function AoqiGodMainViewPresentor:buildViews()
	return {
		AoqiGodMainView.New()
	}
end

return AoqiGodMainViewPresentor
