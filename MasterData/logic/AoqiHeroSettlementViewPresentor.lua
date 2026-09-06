-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroSettlementViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroSettlementViewPresentor", package.seeall)

local AoqiHeroSettlementViewPresentor = class("AoqiHeroSettlementViewPresentor", ViewPresentor)

function AoqiHeroSettlementViewPresentor:ctor()
	AoqiHeroSettlementViewPresentor.super.ctor(self)
end

function AoqiHeroSettlementViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiHeroSettlementViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiherosettlementview.prefab"
	}
end

function AoqiHeroSettlementViewPresentor:buildViews()
	return {
		AoqiHeroSettlementView.New()
	}
end

return AoqiHeroSettlementViewPresentor
