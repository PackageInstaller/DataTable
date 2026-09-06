-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoQiHeroBattleViewPresentor.lua

module("logic.extensions.aoqihero.view.AoQiHeroBattleViewPresentor", package.seeall)

local AoQiHeroBattleViewPresentor = class("AoQiHeroBattleViewPresentor", ViewPresentor)

function AoQiHeroBattleViewPresentor:ctor()
	AoQiHeroBattleViewPresentor.super.ctor(self)
end

function AoQiHeroBattleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoQiHeroBattleViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiherobattleview.prefab"
	}
end

function AoQiHeroBattleViewPresentor:buildViews()
	return {
		AoQiHeroBattleView.New()
	}
end

return AoQiHeroBattleViewPresentor
