-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccaccioclg/view/BoccaccioclgresultViewPresentor.lua

module("logic.extensions.boccaccioclg.view.BoccaccioclgresultViewPresentor", package.seeall)

local BoccaccioclgresultViewPresentor = class("BoccaccioclgresultViewPresentor", ViewPresentor)

function BoccaccioclgresultViewPresentor:ctor()
	BoccaccioclgresultViewPresentor.super.ctor(self)
end

function BoccaccioclgresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BoccaccioclgresultViewPresentor:dependWhatResources()
	return {
		"ui/views/boccaccioclg/boccaccioclgresultview.prefab"
	}
end

function BoccaccioclgresultViewPresentor:buildViews()
	return {
		BoccaccioclgresultView.New()
	}
end

return BoccaccioclgresultViewPresentor
