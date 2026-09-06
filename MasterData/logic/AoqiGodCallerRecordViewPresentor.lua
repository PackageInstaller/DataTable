-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodCallerRecordViewPresentor.lua

module("logic.extensions.aoqigod.view.AoqiGodCallerRecordViewPresentor", package.seeall)

local AoqiGodCallerRecordViewPresentor = class("AoqiGodCallerRecordViewPresentor", ViewPresentor)

function AoqiGodCallerRecordViewPresentor:ctor()
	AoqiGodCallerRecordViewPresentor.super.ctor(self)
end

function AoqiGodCallerRecordViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AoqiGodCallerRecordViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqigod/aoqigodcallerrecordview.prefab"
	}
end

function AoqiGodCallerRecordViewPresentor:buildViews()
	return {
		AoqiGodCallerRecordView.New()
	}
end

return AoqiGodCallerRecordViewPresentor
