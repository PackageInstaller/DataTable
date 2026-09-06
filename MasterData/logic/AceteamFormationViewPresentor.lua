-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/mission/AceteamFormationViewPresentor.lua

module("logic.extensions.formation.view.AceteamFormationViewPresentor", package.seeall)

local AceteamFormationViewPresentor = class("AceteamFormationViewPresentor", ViewPresentor)

function AceteamFormationViewPresentor:ctor()
	AceteamFormationViewPresentor.super.ctor(self)
end

function AceteamFormationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AceteamFormationViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/formationview.prefab"
	}
end

function AceteamFormationViewPresentor:buildViews()
	return {
		AceteamBuzhenLeftView.New(),
		AceteamFormationRightView.New(),
		AceteamFormationView.New()
	}
end

return AceteamFormationViewPresentor
