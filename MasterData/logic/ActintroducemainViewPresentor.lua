-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/actintroduce/view/ActintroducemainViewPresentor.lua

module("logic.extensions.actintroduce.view.ActintroducemainViewPresentor", package.seeall)

local ActintroducemainViewPresentor = class("ActintroducemainViewPresentor", ViewPresentor)

function ActintroducemainViewPresentor:ctor()
	ActintroducemainViewPresentor.super.ctor(self)
end

function ActintroducemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActintroducemainViewPresentor:dependWhatResources()
	return {
		"ui/views/actintroduce/actintroducemainview.prefab"
	}
end

function ActintroducemainViewPresentor:buildViews()
	return {
		ActIntroduceMainView.New()
	}
end

return ActintroducemainViewPresentor
