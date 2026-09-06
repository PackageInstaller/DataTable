-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerscene/view/AnswerSceneViewPresentor.lua

module("logic.extensions.answerscene.view.AnswerSceneViewPresentor", package.seeall)

local AnswerSceneViewPresentor = class("AnswerSceneViewPresentor", ViewPresentor)

function AnswerSceneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnswerSceneViewPresentor:dependWhatResources()
	return {
		"ui/views/answerscene/answersceneview.prefab"
	}
end

function AnswerSceneViewPresentor:buildViews()
	return {
		AnswerSceneView.New(),
		MainChatView.New()
	}
end

function AnswerSceneViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AnswerSceneViewPresentor
