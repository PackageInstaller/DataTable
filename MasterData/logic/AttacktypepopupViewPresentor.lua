-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guidepopup/view/AttacktypepopupViewPresentor.lua

module("logic.extensions.guidepopup.view.AttacktypepopupViewPresentor", package.seeall)

local AttacktypepopupViewPresentor = class("AttacktypepopupViewPresentor", ViewPresentor)

function AttacktypepopupViewPresentor:ctor()
	AttacktypepopupViewPresentor.super.ctor(self)
end

function AttacktypepopupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AttacktypepopupViewPresentor:dependWhatResources()
	return {
		"ui/views/guidepopup/attacktypepopup.prefab"
	}
end

function AttacktypepopupViewPresentor:buildViews()
	return {
		AttacktypepopupView.New()
	}
end

return AttacktypepopupViewPresentor
