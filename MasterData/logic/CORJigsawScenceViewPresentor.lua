-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/copy/jigsaw/CORJigsawScenceViewPresentor.lua

module("logic.extensions.cantonoperaroad.view.copy.jigsaw.CORJigsawScenceViewPresentor", package.seeall)

local CORJigsawScenceViewPresentor = class("CORJigsawScenceViewPresentor", ViewPresentor)

function CORJigsawScenceViewPresentor:ctor()
	CORJigsawScenceViewPresentor.super.ctor(self)
end

function CORJigsawScenceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CORJigsawScenceViewPresentor:dependWhatResources()
	return {
		"ui/views/cantoneseoperaroad/jigsaw/corjigsawscenceview.prefab"
	}
end

function CORJigsawScenceViewPresentor:buildViews()
	return {
		CORJigsawScenceView.New()
	}
end

return CORJigsawScenceViewPresentor
