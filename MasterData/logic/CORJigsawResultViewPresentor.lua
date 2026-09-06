-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/copy/jigsaw/CORJigsawResultViewPresentor.lua

module("logic.extensions.cantonoperaroad.view.copy.jigsaw.CORJigsawResultViewPresentor", package.seeall)

local CORJigsawResultViewPresentor = class("CORJigsawResultViewPresentor", ViewPresentor)

function CORJigsawResultViewPresentor:ctor()
	CORJigsawResultViewPresentor.super.ctor(self)
end

function CORJigsawResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CORJigsawResultViewPresentor:dependWhatResources()
	return {
		"ui/views/cantoneseoperaroad/jigsaw/corjigsawresultview.prefab"
	}
end

function CORJigsawResultViewPresentor:buildViews()
	return {
		CORJigsawResultView.New()
	}
end

return CORJigsawResultViewPresentor
