-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cakesign/view/CakesignpreshowViewPresentor.lua

module("logic.extensions.cakesign.view.CakesignpreshowViewPresentor", package.seeall)

local CakesignpreshowViewPresentor = class("CakesignpreshowViewPresentor", ViewPresentor)

function CakesignpreshowViewPresentor:ctor()
	CakesignpreshowViewPresentor.super.ctor(self)
end

function CakesignpreshowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CakesignpreshowViewPresentor:dependWhatResources()
	return {
		"ui/views/cakesign/cakesignpreshowview.prefab"
	}
end

function CakesignpreshowViewPresentor:buildViews()
	return {
		CakesignpreshowView.New()
	}
end

return CakesignpreshowViewPresentor
