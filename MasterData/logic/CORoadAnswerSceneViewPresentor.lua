-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/copy/answer/CORoadAnswerSceneViewPresentor.lua

module("logic.extensions.cantonoperaroad.view.copy.answer.CORoadAnswerSceneViewPresentor", package.seeall)

local CORoadAnswerSceneViewPresentor = class("CORoadAnswerSceneViewPresentor", AnswerSceneViewPresentor)

function CORoadAnswerSceneViewPresentor:buildViews()
	return {
		CORoadAnswerSceneView.New(),
		MainChatView.New()
	}
end

return CORoadAnswerSceneViewPresentor
