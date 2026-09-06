-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/actintroduce/view/ActintroducelevelViewPresentor.lua

module("logic.extensions.actintroduce.view.ActintroducelevelViewPresentor", package.seeall)

local ActintroducelevelViewPresentor = class("ActintroducelevelViewPresentor", ViewPresentor)

function ActintroducelevelViewPresentor:ctor()
	ActintroducelevelViewPresentor.super.ctor(self)
end

function ActintroducelevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActintroducelevelViewPresentor:dependWhatResources()
	return {
		"ui/views/actintroduce/actintroducelevelview.prefab"
	}
end

function ActintroducelevelViewPresentor:buildViews()
	return {
		ActIntroduceLevelView.New()
	}
end

return ActintroducelevelViewPresentor
