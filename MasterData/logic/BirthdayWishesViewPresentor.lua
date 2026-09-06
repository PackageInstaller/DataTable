-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/BirthdayWishesViewPresentor.lua

module("logic.extensions.birthdaywishes.view.BirthdayWishesViewPresentor", package.seeall)

local BirthdayWishesViewPresentor = class("BirthdayWishesViewPresentor", ViewWithGuidePresentor)

function BirthdayWishesViewPresentor:ctor()
	BirthdayWishesViewPresentor.super.ctor(self)
end

function BirthdayWishesViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BirthdayWishesViewPresentor:dependWhatResources()
	return {
		"ui/views/birthdaywishes/birthdaywishesview.prefab"
	}
end

function BirthdayWishesViewPresentor:buildViews()
	return {
		BirthdayWishesView.New()
	}
end

return BirthdayWishesViewPresentor
