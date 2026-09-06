-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/copy/answer/CORoadAnswerResultViewPresentor.lua

module("logic.extensions.cantonoperaroad.view.copy.answer.CORoadAnswerResultViewPresentor", package.seeall)

local CORoadAnswerResultViewPresentor = class("CORoadAnswerResultViewPresentor", ViewPresentor)

function CORoadAnswerResultViewPresentor:ctor()
	CORoadAnswerResultViewPresentor.super.ctor(self)
end

function CORoadAnswerResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CORoadAnswerResultViewPresentor:dependWhatResources()
	return {
		"ui/views/cantoneseoperaroad/answer/coroadanswerresultview.prefab"
	}
end

function CORoadAnswerResultViewPresentor:buildViews()
	return {
		CORoadAnswerResultView.New()
	}
end

return CORoadAnswerResultViewPresentor
