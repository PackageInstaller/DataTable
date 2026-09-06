-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaysportswish/view/BirthdaysportswishesmainViewPresentor.lua

module("logic.extensions.birthdaysportswish.view.BirthdaysportswishesmainViewPresentor", package.seeall)

local BirthdaysportswishesmainViewPresentor = class("BirthdaysportswishesmainViewPresentor", ViewPresentor)

function BirthdaysportswishesmainViewPresentor:ctor()
	BirthdaysportswishesmainViewPresentor.super.ctor(self)
end

function BirthdaysportswishesmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BirthdaysportswishesmainViewPresentor:dependWhatResources()
	return {
		"ui/views/birthdaysportswish/birthdaysportswishesmainview.prefab"
	}
end

function BirthdaysportswishesmainViewPresentor:buildViews()
	return {
		BirthdaySportsWishesMainView.New()
	}
end

return BirthdaysportswishesmainViewPresentor
