-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteamrewardViewPresentor.lua

module("logic.extensions.aceteam.view.AceteamrewardViewPresentor", package.seeall)

local AceteamrewardViewPresentor = class("AceteamrewardViewPresentor", ViewPresentor)

function AceteamrewardViewPresentor:ctor()
	AceteamrewardViewPresentor.super.ctor(self)
end

function AceteamrewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AceteamrewardViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/aceteamrewardview.prefab"
	}
end

function AceteamrewardViewPresentor:buildViews()
	return {
		AceteamrewardView.New()
	}
end

return AceteamrewardViewPresentor
