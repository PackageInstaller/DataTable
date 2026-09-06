-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/BoonSignViewPresentor.lua

module("logic.extensions.bonus.view.xiaonuobirthday.BoonSignViewPresentor", package.seeall)

local BoonSignViewPresentor = class("BoonSignViewPresentor", ViewPresentor)

function BoonSignViewPresentor:ctor()
	BoonSignViewPresentor.super.ctor(self)
end

function BoonSignViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoonSignViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/boonsignview.prefab"
	}
end

function BoonSignViewPresentor:buildViews()
	return {
		BoonSignView.New()
	}
end

return BoonSignViewPresentor
