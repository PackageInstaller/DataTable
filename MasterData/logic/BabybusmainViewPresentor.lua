-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/babybus/view/BabybusmainViewPresentor.lua

module("logic.extensions.babybus.view.BabybusmainViewPresentor", package.seeall)

local BabybusmainViewPresentor = class("BabybusmainViewPresentor", ViewPresentor)

function BabybusmainViewPresentor:ctor()
	BabybusmainViewPresentor.super.ctor(self)
end

function BabybusmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BabybusmainViewPresentor:dependWhatResources()
	return {
		"ui/views/babybus/babybusmainview.prefab"
	}
end

function BabybusmainViewPresentor:buildViews()
	return {
		BabybusmainView.New()
	}
end

return BabybusmainViewPresentor
