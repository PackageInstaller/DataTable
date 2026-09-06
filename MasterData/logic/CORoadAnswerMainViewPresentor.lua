-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/copy/answer/CORoadAnswerMainViewPresentor.lua

module("logic.extensions.cantonoperaroad.view.copy.answer.CORoadAnswerMainViewPresentor", package.seeall)

local CORoadAnswerMainViewPresentor = class("CORoadAnswerMainViewPresentor", ViewPresentor)

function CORoadAnswerMainViewPresentor:ctor()
	CORoadAnswerMainViewPresentor.super.ctor(self)
end

function CORoadAnswerMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CORoadAnswerMainViewPresentor:dependWhatResources()
	return {
		"ui/views/cantoneseoperaroad/answer/coroadanswermainview.prefab"
	}
end

function CORoadAnswerMainViewPresentor:buildViews()
	return {
		CORoadAnswerMainView.New()
	}
end

return CORoadAnswerMainViewPresentor
