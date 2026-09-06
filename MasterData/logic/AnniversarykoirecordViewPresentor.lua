-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarykoi/view/AnniversarykoirecordViewPresentor.lua

module("logic.extensions.anniversarykoi.view.AnniversarykoirecordViewPresentor", package.seeall)

local AnniversarykoirecordViewPresentor = class("AnniversarykoirecordViewPresentor", ViewPresentor)

function AnniversarykoirecordViewPresentor:ctor()
	AnniversarykoirecordViewPresentor.super.ctor(self)
end

function AnniversarykoirecordViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AnniversarykoirecordViewPresentor:dependWhatResources()
	return {
		"ui/views/anniversarykoi/anniversarykoirecordview.prefab"
	}
end

function AnniversarykoirecordViewPresentor:buildViews()
	return {
		AnniversaryKoirecordView.New()
	}
end

return AnniversarykoirecordViewPresentor
