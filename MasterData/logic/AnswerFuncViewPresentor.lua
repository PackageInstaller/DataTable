-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerfunc/view/AnswerFuncViewPresentor.lua

module("logic.extensions.partysummary.view.AnswerFuncViewPresentor", package.seeall)

local AnswerFuncViewPresentor = class("AnswerFuncViewPresentor", ViewWithGuidePresentor)

function AnswerFuncViewPresentor:ctor()
	AnswerFuncViewPresentor.super.ctor(self)
end

function AnswerFuncViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnswerFuncViewPresentor:dependWhatResources()
	return {
		"ui/views/answerfunc/answerfuncview.prefab"
	}
end

function AnswerFuncViewPresentor:buildViews()
	return {
		AnswerFuncView.New()
	}
end

return AnswerFuncViewPresentor
