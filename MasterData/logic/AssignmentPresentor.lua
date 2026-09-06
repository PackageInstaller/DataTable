-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assignment/view/AssignmentPresentor.lua

module("logic.extensions.assignment.view.AssignmentPresentor", package.seeall)

local AssignmentPresentor = class("AssignmentPresentor", ViewWithGuidePresentor)

function AssignmentPresentor:ctor()
	AssignmentPresentor.super.ctor(self)
end

function AssignmentPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AssignmentPresentor:dependWhatResources()
	return {
		"ui/views/assignment/assignmentview.prefab"
	}
end

function AssignmentPresentor:buildViews()
	return {
		AssignmentView.New()
	}
end

return AssignmentPresentor
