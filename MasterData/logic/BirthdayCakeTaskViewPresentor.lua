-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaycake/view/BirthdayCakeTaskViewPresentor.lua

module("logic.extensions.birthdaycake.view.BirthdayCakeTaskViewPresentor", package.seeall)

local BirthdayCakeTaskViewPresentor = class("BirthdayCakeTaskViewPresentor", ViewPresentor)

function BirthdayCakeTaskViewPresentor:ctor()
	BirthdayCakeTaskViewPresentor.super.ctor(self)
end

function BirthdayCakeTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BirthdayCakeTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/birthdaycake/birthdaycaketaskview.prefab"
	}
end

function BirthdayCakeTaskViewPresentor:buildViews()
	return {
		BirthdayCakeTaskView.New()
	}
end

return BirthdayCakeTaskViewPresentor
