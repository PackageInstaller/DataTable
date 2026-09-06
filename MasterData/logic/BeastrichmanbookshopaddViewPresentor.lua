-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastrichmanbookshopaddViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastrichmanbookshopaddViewPresentor", package.seeall)

local BeastrichmanbookshopaddViewPresentor = class("BeastrichmanbookshopaddViewPresentor", ViewPresentor)

function BeastrichmanbookshopaddViewPresentor:ctor()
	BeastrichmanbookshopaddViewPresentor.super.ctor(self)
end

function BeastrichmanbookshopaddViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastrichmanbookshopaddViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmanbookshopaddview.prefab"
	}
end

function BeastrichmanbookshopaddViewPresentor:buildViews()
	return {
		BeastrichmanbookshopaddView.New()
	}
end

return BeastrichmanbookshopaddViewPresentor
