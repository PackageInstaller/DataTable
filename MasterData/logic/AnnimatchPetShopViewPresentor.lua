-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchPetShopViewPresentor.lua

module("logic.extensions.annimatch.view.AnnimatchPetShopViewPresentor", package.seeall)

local AnnimatchPetShopViewPresentor = class("AnnimatchPetShopViewPresentor", ViewPresentor)

function AnnimatchPetShopViewPresentor:ctor()
	AnnimatchPetShopViewPresentor.super.ctor(self)
end

function AnnimatchPetShopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnimatchPetShopViewPresentor:dependWhatResources()
	return {
		"ui/views/annimatch/annimatchpetshopview.prefab"
	}
end

function AnnimatchPetShopViewPresentor:buildViews()
	return {
		AnnimatchPetShopView.New()
	}
end

return AnnimatchPetShopViewPresentor
