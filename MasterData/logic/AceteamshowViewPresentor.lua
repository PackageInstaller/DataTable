-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/petshow/AceteamshowViewPresentor.lua

module("logic.extensions.aceteam.view.petshow.AceteamshowViewPresentor", package.seeall)

local AceteamshowViewPresentor = class("AceteamshowViewPresentor", ViewPresentor)

function AceteamshowViewPresentor:ctor()
	AceteamshowViewPresentor.super.ctor(self)
end

function AceteamshowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AceteamshowViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/aceteamshowview.prefab"
	}
end

function AceteamshowViewPresentor:buildViews()
	return {
		AceteamshowView.New()
	}
end

return AceteamshowViewPresentor
