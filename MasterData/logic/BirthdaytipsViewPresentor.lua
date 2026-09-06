-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/BirthdaytipsViewPresentor.lua

module("logic.extensions.bonus.view.xiaonuobirthday.BirthdaytipsViewPresentor", package.seeall)

local BirthdaytipsViewPresentor = class("BirthdaytipsViewPresentor", ViewPresentor)

function BirthdaytipsViewPresentor:ctor()
	BirthdaytipsViewPresentor.super.ctor(self)
end

function BirthdaytipsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BirthdaytipsViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/birthdaytipsview.prefab"
	}
end

function BirthdaytipsViewPresentor:buildViews()
	return {
		BirthdaytipsView.New()
	}
end

return BirthdaytipsViewPresentor
