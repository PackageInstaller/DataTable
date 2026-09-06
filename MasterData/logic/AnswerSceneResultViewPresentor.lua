-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerscene/view/AnswerSceneResultViewPresentor.lua

module("logic.extensions.answerscene.view.AnswerSceneResultViewPresentor", package.seeall)

local AnswerSceneResultViewPresentor = class("AnswerSceneResultViewPresentor", ViewPresentor)

function AnswerSceneResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AnswerSceneResultViewPresentor:dependWhatResources()
	return {
		"ui/views/answerscene/answersceneresultview.prefab"
	}
end

function AnswerSceneResultViewPresentor:buildViews()
	return {
		AnswerSceneResultView.New()
	}
end

function AnswerSceneResultViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AnswerSceneResultViewPresentor
