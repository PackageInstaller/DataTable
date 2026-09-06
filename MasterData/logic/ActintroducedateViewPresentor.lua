-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/actintroduce/view/ActintroducedateViewPresentor.lua

module("logic.extensions.actintroduce.view.ActintroducedateViewPresentor", package.seeall)

local ActintroducedateViewPresentor = class("ActintroducedateViewPresentor", ViewPresentor)

function ActintroducedateViewPresentor:ctor()
	ActintroducedateViewPresentor.super.ctor(self)
end

function ActintroducedateViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActintroducedateViewPresentor:dependWhatResources()
	return {
		"ui/views/actintroduce/actintroducedateview.prefab"
	}
end

function ActintroducedateViewPresentor:buildViews()
	return {
		ActIntroduceDateView.New()
	}
end

return ActintroducedateViewPresentor
