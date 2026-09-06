-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoQiHeroDefenceViewPresentor.lua

module("logic.extensions.aoqihero.view.AoQiHeroDefenceViewPresentor", package.seeall)

local AoQiHeroDefenceViewPresentor = class("AoQiHeroDefenceViewPresentor", ViewPresentor)

function AoQiHeroDefenceViewPresentor:ctor()
	AoQiHeroDefenceViewPresentor.super.ctor(self)
end

function AoQiHeroDefenceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoQiHeroDefenceViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiherodefenceview.prefab"
	}
end

function AoQiHeroDefenceViewPresentor:buildViews()
	return {
		AoQiHeroDefenceView.New()
	}
end

return AoQiHeroDefenceViewPresentor
