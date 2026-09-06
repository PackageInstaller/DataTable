-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastrichmanrankViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastrichmanrankViewPresentor", package.seeall)

local BeastrichmanrankViewPresentor = class("BeastrichmanrankViewPresentor", ViewPresentor)

function BeastrichmanrankViewPresentor:ctor()
	BeastrichmanrankViewPresentor.super.ctor(self)
end

function BeastrichmanrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastrichmanrankViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmanrankview.prefab"
	}
end

function BeastrichmanrankViewPresentor:buildViews()
	return {
		BeastrichmanrankView.New()
	}
end

return BeastrichmanrankViewPresentor
