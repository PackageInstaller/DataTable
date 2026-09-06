-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/birthday/BirthdayDungeonViewPresentor.lua

module("logic.extensions.scenariocopy.view.birthday.BirthdayDungeonViewPresentor", package.seeall)

local BirthdayDungeonViewPresentor = class("BirthdayDungeonViewPresentor", ViewPresentor)

BirthdayDungeonViewPresentor.bgPicturePaths = {
	"ui/bigbg/yyfb/bg_xnsrh_01.png",
	"ui/bigbg/yyfb/bg_xnsrh_02.png",
	"ui/bigbg/yyfb/bg_xnsrh_03.png"
}

function BirthdayDungeonViewPresentor:ctor()
	BirthdayDungeonViewPresentor.super.ctor(self)
end

function BirthdayDungeonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BirthdayDungeonViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/brithday/brithdaycopyview.prefab"
	}
end

function BirthdayDungeonViewPresentor:getTempResources()
	return {
		BirthdayDungeonViewPresentor.bgPicturePaths[1],
		BirthdayDungeonViewPresentor.bgPicturePaths[2],
		BirthdayDungeonViewPresentor.bgPicturePaths[3]
	}
end

function BirthdayDungeonViewPresentor:buildViews()
	return {
		BirthdayDungeonView.New()
	}
end

return BirthdayDungeonViewPresentor
