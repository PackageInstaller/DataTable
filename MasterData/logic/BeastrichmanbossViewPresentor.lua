-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastrichmanbossViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastrichmanbossViewPresentor", package.seeall)

local BeastrichmanbossViewPresentor = class("BeastrichmanbossViewPresentor", ViewPresentor)

function BeastrichmanbossViewPresentor:ctor()
	BeastrichmanbossViewPresentor.super.ctor(self)
end

function BeastrichmanbossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastrichmanbossViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmanbossview.prefab"
	}
end

function BeastrichmanbossViewPresentor:buildViews()
	return {
		BeastrichmanbossView.New()
	}
end

return BeastrichmanbossViewPresentor
