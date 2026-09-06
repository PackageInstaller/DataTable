-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/view/ASheBuffSelectViewPresentor.lua

module("logic.extensions.ashechallenge.view.ASheBuffSelectViewPresentor", package.seeall)

local ASheBuffSelectViewPresentor = class("ASheBuffSelectViewPresentor", ViewPresentor)

function ASheBuffSelectViewPresentor:ctor()
	ASheBuffSelectViewPresentor.super.ctor(self)
end

function ASheBuffSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ASheBuffSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/ashechallenge/ashebuffselectview.prefab"
	}
end

function ASheBuffSelectViewPresentor:buildViews()
	return {
		ASheBuffSelectView.New()
	}
end

return ASheBuffSelectViewPresentor
