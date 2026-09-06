-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/CKAnswerQuestionViewPresentor.lua

module("logic.extensions.chuangkongunion.view.CKAnswerQuestionViewPresentor", package.seeall)

local CKAnswerQuestionViewPresentor = class("CKAnswerQuestionViewPresentor", ViewPresentor)

function CKAnswerQuestionViewPresentor:ctor()
	CKAnswerQuestionViewPresentor.super.ctor(self)
end

function CKAnswerQuestionViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CKAnswerQuestionViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangkongunion/ckanswerquestionview.prefab"
	}
end

function CKAnswerQuestionViewPresentor:buildViews()
	return {
		CKAnswerQuestionView.New()
	}
end

return CKAnswerQuestionViewPresentor
