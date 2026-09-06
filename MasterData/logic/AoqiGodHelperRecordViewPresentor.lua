-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodHelperRecordViewPresentor.lua

module("logic.extensions.aoqigod.view.AoqiGodHelperRecordViewPresentor", package.seeall)

local AoqiGodHelperRecordViewPresentor = class("AoqiGodHelperRecordViewPresentor", ViewPresentor)

function AoqiGodHelperRecordViewPresentor:ctor()
	AoqiGodHelperRecordViewPresentor.super.ctor(self)
end

function AoqiGodHelperRecordViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AoqiGodHelperRecordViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqigod/aoqigodhelperrecordview.prefab"
	}
end

function AoqiGodHelperRecordViewPresentor:buildViews()
	return {
		AoqiGodHelperRecordView.New()
	}
end

return AoqiGodHelperRecordViewPresentor
