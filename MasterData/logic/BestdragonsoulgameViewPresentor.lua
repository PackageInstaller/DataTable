-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bestdragonsoul/view/BestdragonsoulgameViewPresentor.lua

module("logic.extensions.bestdragonsoul.view.BestdragonsoulgameViewPresentor", package.seeall)

local BestdragonsoulgameViewPresentor = class("BestdragonsoulgameViewPresentor", ViewPresentor)

function BestdragonsoulgameViewPresentor:ctor()
	BestdragonsoulgameViewPresentor.super.ctor(self)
end

function BestdragonsoulgameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BestdragonsoulgameViewPresentor:dependWhatResources()
	return {
		"ui/views/bestdragonsoul/bestdragonsoulgameview.prefab"
	}
end

function BestdragonsoulgameViewPresentor:buildViews()
	return {
		BestdragonsoulgameView.New()
	}
end

return BestdragonsoulgameViewPresentor
