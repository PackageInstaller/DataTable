-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doloresclg/view/atlasclg/AtlasclgmainViewPresentor.lua

module("logic.extensions.doloresclg.view.atlasclg.AtlasclgmainViewPresentor", package.seeall)

local AtlasclgmainViewPresentor = class("AtlasclgmainViewPresentor", ViewPresentor)

function AtlasclgmainViewPresentor:ctor()
	AtlasclgmainViewPresentor.super.ctor(self)
end

function AtlasclgmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AtlasclgmainViewPresentor:dependWhatResources()
	return {
		"ui/views/doloresclg/atlasclg/atlasclgmainview.prefab"
	}
end

function AtlasclgmainViewPresentor:buildViews()
	return {
		AtlasclgmainView.New()
	}
end

return AtlasclgmainViewPresentor
