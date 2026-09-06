-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteamsourcetracemultinodeViewPresentor.lua

module("logic.extensions.aceteam.view.AceteamsourcetracemultinodeViewPresentor", package.seeall)

local AceteamsourcetracemultinodeViewPresentor = class("AceteamsourcetracemultinodeViewPresentor", ViewPresentor)

function AceteamsourcetracemultinodeViewPresentor:ctor()
	AceteamsourcetracemultinodeViewPresentor.super.ctor(self)
end

function AceteamsourcetracemultinodeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AceteamsourcetracemultinodeViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/aceteamsourcetracemultinodeview.prefab"
	}
end

function AceteamsourcetracemultinodeViewPresentor:buildViews()
	return {
		AceteamsourcetracemultinodeView.New()
	}
end

return AceteamsourcetracemultinodeViewPresentor
