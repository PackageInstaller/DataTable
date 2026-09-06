-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/BirthdaywelfaresignViewPresentor.lua

module("logic.extensions.bonus.view.xiaonuobirthday.BirthdaywelfaresignViewPresentor", package.seeall)

local BirthdaywelfaresignViewPresentor = class("BirthdaywelfaresignViewPresentor", ViewPresentor)

function BirthdaywelfaresignViewPresentor:ctor()
	BirthdaywelfaresignViewPresentor.super.ctor(self)
end

function BirthdaywelfaresignViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BirthdaywelfaresignViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/birthdaywelfaresignview.prefab"
	}
end

function BirthdaywelfaresignViewPresentor:buildViews()
	return {
		BirthdaywelfaresignView.New()
	}
end

return BirthdaywelfaresignViewPresentor
