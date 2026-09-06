-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaysportswish/view/BattlewishesViewPresentor.lua

module("logic.extensions.birthdaysportswish.view.BattlewishesViewPresentor", package.seeall)

local BattlewishesViewPresentor = class("BattlewishesViewPresentor", ViewPresentor)

function BattlewishesViewPresentor:ctor()
	BattlewishesViewPresentor.super.ctor(self)
end

function BattlewishesViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BattlewishesViewPresentor:dependWhatResources()
	return {
		"ui/views/birthdaysportswish/battlewishesview.prefab"
	}
end

function BattlewishesViewPresentor:buildViews()
	return {
		BattleWishesView.New()
	}
end

return BattlewishesViewPresentor
