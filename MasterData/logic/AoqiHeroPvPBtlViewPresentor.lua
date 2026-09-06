-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroPvPBtlViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroPvPBtlViewPresentor", package.seeall)

local AoqiHeroPvPBtlViewPresentor = class("AoqiHeroPvPBtlViewPresentor", ViewPresentor)

function AoqiHeroPvPBtlViewPresentor:ctor()
	AoqiHeroPvPBtlViewPresentor.super.ctor(self)
end

function AoqiHeroPvPBtlViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiHeroPvPBtlViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiheropvpbtlview.prefab"
	}
end

function AoqiHeroPvPBtlViewPresentor:buildViews()
	return {
		AoqiHeroPvPBtlView.New()
	}
end

return AoqiHeroPvPBtlViewPresentor
