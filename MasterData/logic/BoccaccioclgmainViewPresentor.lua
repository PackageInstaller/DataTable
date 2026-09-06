-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccaccioclg/view/BoccaccioclgmainViewPresentor.lua

module("logic.extensions.boccaccioclg.view.BoccaccioclgmainViewPresentor", package.seeall)

local BoccaccioclgmainViewPresentor = class("BoccaccioclgmainViewPresentor", ViewPresentor)

function BoccaccioclgmainViewPresentor:ctor()
	BoccaccioclgmainViewPresentor.super.ctor(self)
end

function BoccaccioclgmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoccaccioclgmainViewPresentor:dependWhatResources()
	return {
		"ui/views/boccaccioclg/boccaccioclgmainview.prefab"
	}
end

function BoccaccioclgmainViewPresentor:buildViews()
	return {
		BoccaccioclgmainView.New()
	}
end

return BoccaccioclgmainViewPresentor
