-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroPetTipsViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroPetTipsViewPresentor", package.seeall)

local AoqiHeroPetTipsViewPresentor = class("AoqiHeroPetTipsViewPresentor", ViewPresentor)

function AoqiHeroPetTipsViewPresentor:ctor()
	AoqiHeroPetTipsViewPresentor.super.ctor(self)
end

function AoqiHeroPetTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AoqiHeroPetTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiheropettipsview.prefab"
	}
end

function AoqiHeroPetTipsViewPresentor:buildViews()
	return {
		AoqiHeroPetTipsView.New()
	}
end

return AoqiHeroPetTipsViewPresentor
