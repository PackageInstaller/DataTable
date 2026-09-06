-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteamgroupViewPresentor.lua

module("logic.extensions.aceteam.view.AceteamgroupViewPresentor", package.seeall)

local AceteamgroupViewPresentor = class("AceteamgroupViewPresentor", ViewPresentor)

function AceteamgroupViewPresentor:ctor()
	AceteamgroupViewPresentor.super.ctor(self)
end

function AceteamgroupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AceteamgroupViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/aceteamgroupview.prefab"
	}
end

function AceteamgroupViewPresentor:buildViews()
	return {
		AceteamgroupView.New()
	}
end

function AceteamgroupViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AceteamgroupViewPresentor
