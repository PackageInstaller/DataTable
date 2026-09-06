-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/babybus/view/BabybuswishtreelistViewPresentor.lua

module("logic.extensions.babybus.view.BabybuswishtreelistViewPresentor", package.seeall)

local BabybuswishtreelistViewPresentor = class("BabybuswishtreelistViewPresentor", ViewPresentor)

function BabybuswishtreelistViewPresentor:ctor()
	BabybuswishtreelistViewPresentor.super.ctor(self)
end

function BabybuswishtreelistViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BabybuswishtreelistViewPresentor:dependWhatResources()
	return {
		"ui/views/babybus/babybuswishtreelistview.prefab"
	}
end

function BabybuswishtreelistViewPresentor:buildViews()
	return {
		BabybuswishtreelistView.New()
	}
end

return BabybuswishtreelistViewPresentor
