-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccaccioclg/view/BoccaccioclgstageViewPresentor.lua

module("logic.extensions.boccaccioclg.view.BoccaccioclgstageViewPresentor", package.seeall)

local BoccaccioclgstageViewPresentor = class("BoccaccioclgstageViewPresentor", ViewPresentor)

function BoccaccioclgstageViewPresentor:ctor()
	BoccaccioclgstageViewPresentor.super.ctor(self)
end

function BoccaccioclgstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoccaccioclgstageViewPresentor:dependWhatResources()
	return {
		"ui/views/boccaccioclg/boccaccioclgstageview.prefab"
	}
end

function BoccaccioclgstageViewPresentor:buildViews()
	return {
		BoccaccioclgstageView.New()
	}
end

return BoccaccioclgstageViewPresentor
