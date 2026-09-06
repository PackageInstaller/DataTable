-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/actintroduce/view/ActintroducedateinfoViewPresentor.lua

module("logic.extensions.actintroduce.view.ActintroducedateinfoViewPresentor", package.seeall)

local ActintroducedateinfoViewPresentor = class("ActintroducedateinfoViewPresentor", ViewPresentor)

function ActintroducedateinfoViewPresentor:ctor()
	ActintroducedateinfoViewPresentor.super.ctor(self)
end

function ActintroducedateinfoViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ActintroducedateinfoViewPresentor:dependWhatResources()
	return {
		"ui/views/actintroduce/actintroducedateinfoview.prefab"
	}
end

function ActintroducedateinfoViewPresentor:buildViews()
	return {
		ActIntroduceDateInfoView.New()
	}
end

return ActintroducedateinfoViewPresentor
