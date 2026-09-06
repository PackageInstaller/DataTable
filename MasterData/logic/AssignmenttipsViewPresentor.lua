-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assignment/view/AssignmenttipsViewPresentor.lua

module("logic.extensions.assignment.view.AssignmenttipsViewPresentor", package.seeall)

local AssignmenttipsViewPresentor = class("AssignmenttipsViewPresentor", ViewPresentor)

function AssignmenttipsViewPresentor:ctor()
	AssignmenttipsViewPresentor.super.ctor(self)
end

function AssignmenttipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AssignmenttipsViewPresentor:dependWhatResources()
	return {
		"ui/views/assignment/assignmenttips.prefab"
	}
end

function AssignmenttipsViewPresentor:buildViews()
	return {
		AssignmenttipsView.New()
	}
end

return AssignmenttipsViewPresentor
