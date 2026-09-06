-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/copy/making/CORoadMakingResultViewPresentor.lua

module("logic.extensions.cantonoperaroad.view.copy.making.CORoadMakingResultViewPresentor", package.seeall)

local CORoadMakingResultViewPresentor = class("CORoadMakingResultViewPresentor", ViewPresentor)

function CORoadMakingResultViewPresentor:ctor()
	CORoadMakingResultViewPresentor.super.ctor(self)
end

function CORoadMakingResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CORoadMakingResultViewPresentor:dependWhatResources()
	return {
		"ui/views/cantoneseoperaroad/making/coroadmakingresultview.prefab"
	}
end

function CORoadMakingResultViewPresentor:buildViews()
	return {
		CORoadMakingResultView.New()
	}
end

return CORoadMakingResultViewPresentor
