-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/caiqingdraw/view/CaiqingdrawViewPresentor.lua

module("logic.extensions.caiqingdraw.view.CaiqingdrawViewPresentor", package.seeall)

local CaiqingdrawViewPresentor = class("CaiqingdrawViewPresentor", ViewPresentor)

function CaiqingdrawViewPresentor:ctor()
	CaiqingdrawViewPresentor.super.ctor(self)
end

function CaiqingdrawViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CaiqingdrawViewPresentor:dependWhatResources()
	return {
		"ui/views/activity/caiqingdraw/caiqingdrawview.prefab"
	}
end

function CaiqingdrawViewPresentor:buildViews()
	return {
		CaiqingdrawView.New()
	}
end

return CaiqingdrawViewPresentor
