-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/copy/jigsaw/CORJigsawMainViewPresentor.lua

module("logic.extensions.cantonoperaroad.view.copy.jigsaw.CORJigsawMainViewPresentor", package.seeall)

local CORJigsawMainViewPresentor = class("CORJigsawMainViewPresentor", ViewPresentor)

function CORJigsawMainViewPresentor:ctor()
	CORJigsawMainViewPresentor.super.ctor(self)
end

function CORJigsawMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CORJigsawMainViewPresentor:dependWhatResources()
	return {
		"ui/views/cantoneseoperaroad/jigsaw/corjigsawmainview.prefab"
	}
end

function CORJigsawMainViewPresentor:buildViews()
	return {
		CORJigsawMainView.New()
	}
end

return CORJigsawMainViewPresentor
