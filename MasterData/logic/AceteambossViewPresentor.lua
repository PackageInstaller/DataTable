-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteambossViewPresentor.lua

module("logic.extensions.aceteam.view.AceteambossViewPresentor", package.seeall)

local AceteambossViewPresentor = class("AceteambossViewPresentor", ViewPresentor)

function AceteambossViewPresentor:ctor()
	AceteambossViewPresentor.super.ctor(self)
end

function AceteambossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AceteambossViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/aceteambossview.prefab"
	}
end

function AceteambossViewPresentor:buildViews()
	return {
		AceteambossView.New()
	}
end

return AceteambossViewPresentor
