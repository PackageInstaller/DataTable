-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerfunc/view/AnswerShowViewPresentor.lua

module("logic.extensions.partysummary.view.AnswerShowViewPresentor", package.seeall)

local AnswerShowViewPresentor = class("AnswerShowViewPresentor", ViewWithGuidePresentor)

function AnswerShowViewPresentor:ctor()
	AnswerShowViewPresentor.super.ctor(self)
end

function AnswerShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnswerShowViewPresentor:dependWhatResources()
	return {
		"ui/views/answerfunc/answershowview.prefab"
	}
end

function AnswerShowViewPresentor:buildViews()
	return {
		AnswerShowView.New()
	}
end

return AnswerShowViewPresentor
