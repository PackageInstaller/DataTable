-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cakesign/view/CakesignViewPresentor.lua

module("logic.extensions.cakesign.view.CakesignViewPresentor", package.seeall)

local CakesignViewPresentor = class("CakesignViewPresentor", ViewPresentor)

function CakesignViewPresentor:ctor()
	CakesignViewPresentor.super.ctor(self)
end

function CakesignViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CakesignViewPresentor:dependWhatResources()
	return {
		"ui/views/cakesign/cakesignview.prefab"
	}
end

function CakesignViewPresentor:buildViews()
	return {
		CakesignView.New()
	}
end

return CakesignViewPresentor
