-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroPvPResultViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroPvPResultViewPresentor", package.seeall)

local AoqiHeroPvPResultViewPresentor = class("AoqiHeroPvPResultViewPresentor", ViewPresentor)

function AoqiHeroPvPResultViewPresentor:ctor()
	AoqiHeroPvPResultViewPresentor.super.ctor(self)
end

function AoqiHeroPvPResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiHeroPvPResultViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiheropvpresultview.prefab"
	}
end

function AoqiHeroPvPResultViewPresentor:buildViews()
	return {
		AoqiHeroPvPResultView.New()
	}
end

return AoqiHeroPvPResultViewPresentor
