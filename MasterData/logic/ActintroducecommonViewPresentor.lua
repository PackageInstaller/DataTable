-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/actintroduce/view/ActintroducecommonViewPresentor.lua

module("logic.extensions.actintroduce.view.ActintroducecommonViewPresentor", package.seeall)

local ActintroducecommonViewPresentor = class("ActintroducecommonViewPresentor", ViewPresentor)

function ActintroducecommonViewPresentor:ctor()
	ActintroducecommonViewPresentor.super.ctor(self)
end

function ActintroducecommonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActintroducecommonViewPresentor:dependWhatResources()
	return {
		"ui/views/actintroduce/actintroducecommonview.prefab"
	}
end

function ActintroducecommonViewPresentor:buildViews()
	return {
		ActIntroduceCommonView.New()
	}
end

return ActintroducecommonViewPresentor
