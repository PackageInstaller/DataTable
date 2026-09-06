-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaysportswish/view/BirthdaySportsTaskViewPresentor.lua

module("logic.extensions.birthdaysportswish.view.BirthdaySportsTaskViewPresentor", package.seeall)

local BirthdaySportsTaskViewPresentor = class("BirthdaySportsTaskViewPresentor", ViewPresentor)

function BirthdaySportsTaskViewPresentor:ctor()
	BirthdaySportsTaskViewPresentor.super.ctor(self)
end

function BirthdaySportsTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BirthdaySportsTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/birthdaysportswish/birthdaysportstaskview.prefab"
	}
end

function BirthdaySportsTaskViewPresentor:buildViews()
	return {
		BirthdaySportsTaskView.New()
	}
end

return BirthdaySportsTaskViewPresentor
