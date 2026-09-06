-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bestdragonsoul/view/BestdragonsoulmainViewPresentor.lua

module("logic.extensions.bestdragonsoul.view.BestdragonsoulmainViewPresentor", package.seeall)

local BestdragonsoulmainViewPresentor = class("BestdragonsoulmainViewPresentor", ViewPresentor)

function BestdragonsoulmainViewPresentor:ctor()
	BestdragonsoulmainViewPresentor.super.ctor(self)
end

function BestdragonsoulmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BestdragonsoulmainViewPresentor:dependWhatResources()
	return {
		"ui/views/bestdragonsoul/bestdragonsoulmainview.prefab"
	}
end

function BestdragonsoulmainViewPresentor:buildViews()
	return {
		BestdragonsoulmainView.New()
	}
end

return BestdragonsoulmainViewPresentor
