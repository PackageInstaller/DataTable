-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doloresclg/view/atlasclg/AtlasclglevelViewPresentor.lua

module("logic.extensions.doloresclg.view.atlasclg.AtlasclglevelViewPresentor", package.seeall)

local AtlasclglevelViewPresentor = class("AtlasclglevelViewPresentor", ViewPresentor)

function AtlasclglevelViewPresentor:ctor()
	AtlasclglevelViewPresentor.super.ctor(self)
end

function AtlasclglevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AtlasclglevelViewPresentor:dependWhatResources()
	return {
		"ui/views/doloresclg/atlasclg/atlasclglevelview.prefab"
	}
end

function AtlasclglevelViewPresentor:buildViews()
	return {
		AtlasclglevelView.New()
	}
end

return AtlasclglevelViewPresentor
