-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccaccioclg/view/BoccaccioclgextViewPresentor.lua

module("logic.extensions.boccaccioclg.view.BoccaccioclgextViewPresentor", package.seeall)

local BoccaccioclgextViewPresentor = class("BoccaccioclgextViewPresentor", ViewPresentor)

function BoccaccioclgextViewPresentor:ctor()
	BoccaccioclgextViewPresentor.super.ctor(self)
end

function BoccaccioclgextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoccaccioclgextViewPresentor:dependWhatResources()
	return {
		"ui/views/boccaccioclg/boccaccioclgextview.prefab"
	}
end

function BoccaccioclgextViewPresentor:buildViews()
	return {
		BoccaccioclgextView.New()
	}
end

return BoccaccioclgextViewPresentor
