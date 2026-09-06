-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assignment/view/AssignmentDetailsPresentor.lua

module("logic.extensions.AssignmentDetails.view.AssignmentDetailsPresentor", package.seeall)

local AssignmentDetailsPresentor = class("AssignmentDetailsPresentor", ViewWithGuidePresentor)

function AssignmentDetailsPresentor:ctor()
	AssignmentDetailsPresentor.super.ctor(self)
end

function AssignmentDetailsPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AssignmentDetailsPresentor:dependWhatResources()
	return {
		"ui/views/assignment/assignmentdetailsview.prefab"
	}
end

function AssignmentDetailsPresentor:buildViews()
	return {
		AssignmentDetailsRightView.New(),
		AssignmentDetailsView.New()
	}
end

return AssignmentDetailsPresentor
