-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/BirthdaywelfarefestivalsignViewPresentor.lua

module("logic.extensions.bonus.view.xiaonuobirthday.BirthdaywelfarefestivalsignViewPresentor", package.seeall)

local BirthdaywelfarefestivalsignViewPresentor = class("BirthdaywelfarefestivalsignViewPresentor", ViewPresentor)

function BirthdaywelfarefestivalsignViewPresentor:ctor()
	BirthdaywelfarefestivalsignViewPresentor.super.ctor(self)
end

function BirthdaywelfarefestivalsignViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BirthdaywelfarefestivalsignViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/birthdaywelfarefestivalsignview.prefab"
	}
end

function BirthdaywelfarefestivalsignViewPresentor:buildViews()
	return {
		BirthdaywelfarefestivalsignView.New()
	}
end

return BirthdaywelfarefestivalsignViewPresentor
