-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroStrengthenViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroStrengthenViewPresentor", package.seeall)

local AoqiHeroStrengthenViewPresentor = class("AoqiHeroStrengthenViewPresentor", ViewPresentor)

function AoqiHeroStrengthenViewPresentor:ctor()
	AoqiHeroStrengthenViewPresentor.super.ctor(self)
end

function AoqiHeroStrengthenViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiHeroStrengthenViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiherostrengthenview.prefab"
	}
end

function AoqiHeroStrengthenViewPresentor:buildViews()
	return {
		AoqiHeroStrengthenView.New()
	}
end

return AoqiHeroStrengthenViewPresentor
