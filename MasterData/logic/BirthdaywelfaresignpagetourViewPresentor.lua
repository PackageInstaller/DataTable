-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/BirthdaywelfaresignpagetourViewPresentor.lua

module("logic.extensions.bonus.view.xiaonuobirthday.BirthdaywelfaresignpagetourViewPresentor", package.seeall)

local BirthdaywelfaresignpagetourViewPresentor = class("BirthdaywelfaresignpagetourViewPresentor", ViewPresentor)

function BirthdaywelfaresignpagetourViewPresentor:ctor()
	BirthdaywelfaresignpagetourViewPresentor.super.ctor(self)
end

function BirthdaywelfaresignpagetourViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BirthdaywelfaresignpagetourViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/birthdaywelfaresignpagetourview.prefab"
	}
end

function BirthdaywelfaresignpagetourViewPresentor:buildViews()
	return {
		BirthdaywelfaresignpagetourView.New()
	}
end

return BirthdaywelfaresignpagetourViewPresentor
