-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroPvPMainViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroPvPMainViewPresentor", package.seeall)

local AoqiHeroPvPMainViewPresentor = class("AoqiHeroPvPMainViewPresentor", ViewPresentor)

function AoqiHeroPvPMainViewPresentor:ctor()
	AoqiHeroPvPMainViewPresentor.super.ctor(self)
end

function AoqiHeroPvPMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiHeroPvPMainViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiheropvpmainview.prefab"
	}
end

function AoqiHeroPvPMainViewPresentor:buildViews()
	return {
		AoqiHeroPvPMainView.New()
	}
end

return AoqiHeroPvPMainViewPresentor
