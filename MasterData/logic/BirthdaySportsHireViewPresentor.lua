-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaysportswish/view/BirthdaySportsHireViewPresentor.lua

module("logic.extensions.birthdaysportswish.view.BirthdaySportsHireViewPresentor", package.seeall)

local BirthdaySportsHireViewPresentor = class("BirthdaySportsHireViewPresentor", ViewPresentor)

function BirthdaySportsHireViewPresentor:ctor()
	BirthdaySportsHireViewPresentor.super.ctor(self)
end

function BirthdaySportsHireViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BirthdaySportsHireViewPresentor:dependWhatResources()
	return {
		"ui/views/birthdaysportswish/birthdaysportshireview.prefab"
	}
end

function BirthdaySportsHireViewPresentor:buildViews()
	return {
		BirthdaySportsHireView.New()
	}
end

return BirthdaySportsHireViewPresentor
