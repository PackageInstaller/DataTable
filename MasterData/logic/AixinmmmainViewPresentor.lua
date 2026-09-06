-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmm/view/AixinmmmainViewPresentor.lua

module("logic.extensions.aixinmm.view.AixinmmmainViewPresentor", package.seeall)

local AixinmmmainViewPresentor = class("AixinmmmainViewPresentor", ViewPresentor)

function AixinmmmainViewPresentor:ctor()
	AixinmmmainViewPresentor.super.ctor(self)
end

function AixinmmmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AixinmmmainViewPresentor:dependWhatResources()
	return {
		"ui/views/aixinmm/aixinmmmainview.prefab"
	}
end

function AixinmmmainViewPresentor:buildViews()
	return {
		AixinmmmainView.New()
	}
end

return AixinmmmainViewPresentor
