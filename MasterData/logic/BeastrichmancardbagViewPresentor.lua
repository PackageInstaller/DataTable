-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastrichmancardbagViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastrichmancardbagViewPresentor", package.seeall)

local BeastrichmancardbagViewPresentor = class("BeastrichmancardbagViewPresentor", ViewPresentor)

function BeastrichmancardbagViewPresentor:ctor()
	BeastrichmancardbagViewPresentor.super.ctor(self)
end

function BeastrichmancardbagViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastrichmancardbagViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmancardbagview.prefab"
	}
end

function BeastrichmancardbagViewPresentor:buildViews()
	return {
		BeastrichmancardbagView.New()
	}
end

return BeastrichmancardbagViewPresentor
