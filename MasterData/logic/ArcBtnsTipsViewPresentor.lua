-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/arcbtnstips/ArcBtnsTipsViewPresentor.lua

module("logic.extensions.common.instruction.view.arcbtnstips.ArcBtnsTipsViewPresentor", package.seeall)

local ArcBtnsTipsViewPresentor = class("ArcBtnsTipsViewPresentor", ViewPresentor)

function ArcBtnsTipsViewPresentor:ctor()
	ArcBtnsTipsViewPresentor.super.ctor(self)
end

function ArcBtnsTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ArcBtnsTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/common/arcbtnstips/arcbtnstipsview.prefab"
	}
end

function ArcBtnsTipsViewPresentor:buildViews()
	return {
		ArcBtnsTipsView.New()
	}
end

return ArcBtnsTipsViewPresentor
