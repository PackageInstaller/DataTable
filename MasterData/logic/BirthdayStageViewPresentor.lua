-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/birthday/BirthdayStageViewPresentor.lua

module("logic.extensions.scenariocopy.view.birthday.BirthdayStageViewPresentor", package.seeall)

local BirthdayStageViewPresentor = class("BirthdayStageViewPresentor", ViewPresentor)

function BirthdayStageViewPresentor:ctor()
	BirthdayStageViewPresentor.super.ctor(self)
end

function BirthdayStageViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BirthdayStageViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/brithday/brithdaystageview.prefab"
	}
end

function BirthdayStageViewPresentor:buildViews()
	return {
		BirthdayStageView.New()
	}
end

return BirthdayStageViewPresentor
