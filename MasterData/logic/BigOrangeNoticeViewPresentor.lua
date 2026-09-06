-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bigorange/view/BigOrangeNoticeViewPresentor.lua

module("logic.extensions.bigorange.view.BigOrangeNoticeViewPresentor", package.seeall)

local BigOrangeNoticeViewPresentor = class("BigOrangeNoticeViewPresentor", ViewPresentor)

function BigOrangeNoticeViewPresentor:ctor()
	BigOrangeNoticeViewPresentor.super.ctor(self)
end

function BigOrangeNoticeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BigOrangeNoticeViewPresentor:dependWhatResources()
	return {
		"ui/views/bigorange/bigorangenoticeview.prefab"
	}
end

function BigOrangeNoticeViewPresentor:buildViews()
	return {
		BigOrangeNoticeView.New()
	}
end

return BigOrangeNoticeViewPresentor
