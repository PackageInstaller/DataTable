-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/view/ASheMainViewPresentor.lua

module("logic.extensions.ashechallenge.view.ASheMainViewPresentor", package.seeall)

local ASheMainViewPresentor = class("ASheMainViewPresentor", ViewPresentor)

function ASheMainViewPresentor:ctor()
	ASheMainViewPresentor.super.ctor(self)
end

function ASheMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ASheMainViewPresentor:dependWhatResources()
	return {
		"ui/views/ashechallenge/ashemainview.prefab"
	}
end

function ASheMainViewPresentor:buildViews()
	return {
		ASheMainView.New()
	}
end

return ASheMainViewPresentor
