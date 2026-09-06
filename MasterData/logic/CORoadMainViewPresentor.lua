-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/CORoadMainViewPresentor.lua

module("logic.extensions.cantonoperaroad.view.CORoadMainViewPresentor", package.seeall)

local CORoadMainViewPresentor = class("CORoadMainViewPresentor", ViewPresentor)

function CORoadMainViewPresentor:ctor()
	CORoadMainViewPresentor.super.ctor(self)
end

function CORoadMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CORoadMainViewPresentor:dependWhatResources()
	return {
		"ui/views/cantoneseoperaroad/main/coroadmainview.prefab"
	}
end

function CORoadMainViewPresentor:buildViews()
	return {
		CORoadMainView.New()
	}
end

return CORoadMainViewPresentor
