-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/BirthdaywelfaresignprogressViewPresentor.lua

module("logic.extensions.bonus.view.xiaonuobirthday.BirthdaywelfaresignprogressViewPresentor", package.seeall)

local BirthdaywelfaresignprogressViewPresentor = class("BirthdaywelfaresignprogressViewPresentor", ViewPresentor)

function BirthdaywelfaresignprogressViewPresentor:ctor()
	BirthdaywelfaresignprogressViewPresentor.super.ctor(self)
end

function BirthdaywelfaresignprogressViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BirthdaywelfaresignprogressViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/birthdaywelfaresignprogressview.prefab"
	}
end

function BirthdaywelfaresignprogressViewPresentor:buildViews()
	return {
		BirthdaywelfaresignprogressView.New()
	}
end

return BirthdaywelfaresignprogressViewPresentor
