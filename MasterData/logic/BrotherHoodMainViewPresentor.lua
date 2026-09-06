-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brotherhood/view/BrotherHoodMainViewPresentor.lua

module("logic.extensions.brotherhood.view.BrotherHoodMainViewPresentor", package.seeall)

local BrotherHoodMainViewPresentor = class("BrotherHoodMainViewPresentor", ViewPresentor)

function BrotherHoodMainViewPresentor:ctor()
	BrotherHoodMainViewPresentor.super.ctor(self)
end

function BrotherHoodMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BrotherHoodMainViewPresentor:dependWhatResources()
	return {
		"ui/views/brotherhood/brotherhoodmainview.prefab"
	}
end

function BrotherHoodMainViewPresentor:buildViews()
	return {
		BrotherHoodMainView.New()
	}
end

return BrotherHoodMainViewPresentor
