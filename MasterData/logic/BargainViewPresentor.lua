-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bargain/view/BargainViewPresentor.lua

module("logic.extensions.bargain.view.BargainViewPresentor", package.seeall)

local BargainViewPresentor = class("BargainViewPresentor", ViewPresentor)

function BargainViewPresentor:ctor()
	BargainViewPresentor.super.ctor(self)
end

function BargainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BargainViewPresentor:dependWhatResources()
	return {
		"ui/views/bargain/bargainview.prefab"
	}
end

function BargainViewPresentor:buildViews()
	return {
		BargainView.New()
	}
end

return BargainViewPresentor
