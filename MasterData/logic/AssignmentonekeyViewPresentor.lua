-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assignment/view/AssignmentonekeyViewPresentor.lua

module("logic.extensions.assignment.view.AssignmentonekeyViewPresentor", package.seeall)

local AssignmentonekeyViewPresentor = class("AssignmentonekeyViewPresentor", ViewPresentor)

function AssignmentonekeyViewPresentor:ctor()
	AssignmentonekeyViewPresentor.super.ctor(self)
end

function AssignmentonekeyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AssignmentonekeyViewPresentor:dependWhatResources()
	return {
		"ui/views/assignment/assignmentonekeyview.prefab"
	}
end

function AssignmentonekeyViewPresentor:buildViews()
	return {
		AssignmentonekeyView.New()
	}
end

return AssignmentonekeyViewPresentor
