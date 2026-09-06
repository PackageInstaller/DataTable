-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastrichmanmainViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastrichmanmainViewPresentor", package.seeall)

local BeastrichmanmainViewPresentor = class("BeastrichmanmainViewPresentor", ViewPresentor)

function BeastrichmanmainViewPresentor:ctor()
	BeastrichmanmainViewPresentor.super.ctor(self)
end

function BeastrichmanmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastrichmanmainViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmanmainview.prefab"
	}
end

function BeastrichmanmainViewPresentor:buildViews()
	return {
		BeastrichmanmainView.New()
	}
end

return BeastrichmanmainViewPresentor
