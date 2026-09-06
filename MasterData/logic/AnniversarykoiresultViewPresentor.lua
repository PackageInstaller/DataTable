-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarykoi/view/AnniversarykoiresultViewPresentor.lua

module("logic.extensions.anniversarykoi.view.AnniversarykoiresultViewPresentor", package.seeall)

local AnniversarykoiresultViewPresentor = class("AnniversarykoiresultViewPresentor", ViewPresentor)

function AnniversarykoiresultViewPresentor:ctor()
	AnniversarykoiresultViewPresentor.super.ctor(self)
end

function AnniversarykoiresultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AnniversarykoiresultViewPresentor:dependWhatResources()
	return {
		"ui/views/anniversarykoi/anniversarykoiresultview.prefab"
	}
end

function AnniversarykoiresultViewPresentor:buildViews()
	return {
		AnniversaryKoiresultView.New()
	}
end

return AnniversarykoiresultViewPresentor
