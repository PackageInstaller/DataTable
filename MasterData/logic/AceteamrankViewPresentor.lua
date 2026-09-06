-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteamrankViewPresentor.lua

module("logic.extensions.aceteam.view.AceteamrankViewPresentor", package.seeall)

local AceteamrankViewPresentor = class("AceteamrankViewPresentor", ViewPresentor)

function AceteamrankViewPresentor:ctor()
	AceteamrankViewPresentor.super.ctor(self)
end

function AceteamrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AceteamrankViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/aceteamrankview.prefab"
	}
end

function AceteamrankViewPresentor:buildViews()
	return {
		AceteamrankView.New()
	}
end

return AceteamrankViewPresentor
