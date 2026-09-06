-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/BirthdaywelfaresignViewExtPresentor.lua

module("logic.extensions.bonus.view.xiaonuobirthday.BirthdaywelfaresignViewExtPresentor", package.seeall)

local BirthdaywelfaresignViewExtPresentor = class("BirthdaywelfaresignViewExtPresentor", ViewPresentor)

function BirthdaywelfaresignViewExtPresentor:ctor()
	BirthdaywelfaresignViewExtPresentor.super.ctor(self)
end

function BirthdaywelfaresignViewExtPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BirthdaywelfaresignViewExtPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/birthdaywelfaresignextview.prefab"
	}
end

function BirthdaywelfaresignViewExtPresentor:buildViews()
	return {
		BirthdaywelfaresignViewExt.New()
	}
end

return BirthdaywelfaresignViewExtPresentor
