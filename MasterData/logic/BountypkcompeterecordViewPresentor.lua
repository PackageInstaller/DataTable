-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountypkcompeterecordViewPresentor.lua

module("logic.extensions.bountypkcompete.view.BountypkcompeterecordViewPresentor", package.seeall)

local BountypkcompeterecordViewPresentor = class("BountypkcompeterecordViewPresentor", ViewPresentor)

function BountypkcompeterecordViewPresentor:ctor()
	BountypkcompeterecordViewPresentor.super.ctor(self)
end

function BountypkcompeterecordViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BountypkcompeterecordViewPresentor:dependWhatResources()
	return {
		"ui/views/bountypkcompete/bountypkcompeterecordview.prefab"
	}
end

function BountypkcompeterecordViewPresentor:buildViews()
	return {
		BountyPKCompeteRecordView.New()
	}
end

return BountypkcompeterecordViewPresentor
