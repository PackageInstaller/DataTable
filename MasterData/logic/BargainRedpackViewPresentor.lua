-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bargain/view/BargainRedpackViewPresentor.lua

module("logic.extensions.bargain.view.BargainRedpackViewPresentor", package.seeall)

local BargainRedpackViewPresentor = class("BargainRedpackViewPresentor", ViewPresentor)

function BargainRedpackViewPresentor:ctor()
	BargainRedpackViewPresentor.super.ctor(self)
end

function BargainRedpackViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BargainRedpackViewPresentor:dependWhatResources()
	return {
		"ui/views/bargain/bargainredpackview.prefab"
	}
end

function BargainRedpackViewPresentor:buildViews()
	return {
		BargainRedpackView.New()
	}
end

return BargainRedpackViewPresentor
