-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/copy/making/CORoadMakingMainViewPresentor.lua

module("logic.extensions.cantonoperaroad.view.copy.making.CORoadMakingMainViewPresentor", package.seeall)

local CORoadMakingMainViewPresentor = class("CORoadMakingMainViewPresentor", ViewPresentor)

function CORoadMakingMainViewPresentor:ctor()
	CORoadMakingMainViewPresentor.super.ctor(self)
end

function CORoadMakingMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CORoadMakingMainViewPresentor:dependWhatResources()
	return {
		"ui/views/cantoneseoperaroad/making/coroadmakingmainview.prefab"
	}
end

function CORoadMakingMainViewPresentor:buildViews()
	return {
		CORoadMakingMainView.New()
	}
end

return CORoadMakingMainViewPresentor
