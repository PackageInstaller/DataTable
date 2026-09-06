-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/babybus/view/BabybusfragmentViewPresentor.lua

module("logic.extensions.babybus.view.BabybusfragmentViewPresentor", package.seeall)

local BabybusfragmentViewPresentor = class("BabybusfragmentViewPresentor", ViewPresentor)

function BabybusfragmentViewPresentor:ctor()
	BabybusfragmentViewPresentor.super.ctor(self)
end

function BabybusfragmentViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BabybusfragmentViewPresentor:dependWhatResources()
	return {
		"ui/views/babybus/babybusfragmentview.prefab"
	}
end

function BabybusfragmentViewPresentor:buildViews()
	return {
		BabybusfragmentView.New()
	}
end

return BabybusfragmentViewPresentor
