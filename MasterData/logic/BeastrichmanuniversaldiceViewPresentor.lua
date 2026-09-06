-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastrichmanuniversaldiceViewPresentor.lua

module("logic.extensions.beastrichman.view.BeastrichmanuniversaldiceViewPresentor", package.seeall)

local BeastrichmanuniversaldiceViewPresentor = class("BeastrichmanuniversaldiceViewPresentor", ViewPresentor)

function BeastrichmanuniversaldiceViewPresentor:ctor()
	BeastrichmanuniversaldiceViewPresentor.super.ctor(self)
end

function BeastrichmanuniversaldiceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BeastrichmanuniversaldiceViewPresentor:dependWhatResources()
	return {
		"ui/views/beastrichman/beastrichmanuniversaldiceview.prefab"
	}
end

function BeastrichmanuniversaldiceViewPresentor:buildViews()
	return {
		BeastrichmanuniversaldiceView.New()
	}
end

return BeastrichmanuniversaldiceViewPresentor
