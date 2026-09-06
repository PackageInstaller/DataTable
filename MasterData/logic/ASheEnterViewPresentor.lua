-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/view/ASheEnterViewPresentor.lua

module("logic.extensions.ashechallenge.view.ASheEnterViewPresentor", package.seeall)

local ASheEnterViewPresentor = class("ASheEnterViewPresentor", ViewPresentor)

function ASheEnterViewPresentor:ctor()
	ASheEnterViewPresentor.super.ctor(self)
end

function ASheEnterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ASheEnterViewPresentor:dependWhatResources()
	return {
		"ui/views/ashechallenge/asheenterview.prefab"
	}
end

function ASheEnterViewPresentor:buildViews()
	return {
		ASheEnterView.New()
	}
end

return ASheEnterViewPresentor
