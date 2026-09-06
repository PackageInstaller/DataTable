-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/athenabless/view/AthenaBlessViewPresentor.lua

module("logic.extensions.athenabless.view.AthenaBlessViewPresentor", package.seeall)

local AthenaBlessViewPresentor = class("AthenaBlessViewPresentor", ViewPresentor)

function AthenaBlessViewPresentor:ctor()
	AthenaBlessViewPresentor.super.ctor(self)
end

function AthenaBlessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AthenaBlessViewPresentor:dependWhatResources()
	return {
		"ui/views/athenabless/athenablessview.prefab"
	}
end

function AthenaBlessViewPresentor:buildViews()
	return {
		AthenaBlessView.New()
	}
end

return AthenaBlessViewPresentor
