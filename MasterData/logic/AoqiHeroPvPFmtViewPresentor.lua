-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroPvPFmtViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroPvPFmtViewPresentor", package.seeall)

local AoqiHeroPvPFmtViewPresentor = class("AoqiHeroPvPFmtViewPresentor", ViewPresentor)

function AoqiHeroPvPFmtViewPresentor:ctor()
	AoqiHeroPvPFmtViewPresentor.super.ctor(self)
end

function AoqiHeroPvPFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiHeroPvPFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiheropvpfmtview.prefab"
	}
end

function AoqiHeroPvPFmtViewPresentor:buildViews()
	return {
		AoqiHeroPvPFmtView.New()
	}
end

return AoqiHeroPvPFmtViewPresentor
