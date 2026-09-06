-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/view/BrotherGroupPrizeViewPresentor.lua

module("logic.extensions.brothergroup.view.BrotherGroupPrizeViewPresentor", package.seeall)

local BrotherGroupPrizeViewPresentor = class("BrotherGroupPrizeViewPresentor", ViewPresentor)

function BrotherGroupPrizeViewPresentor:ctor()
	BrotherGroupPrizeViewPresentor.super.ctor(self)
end

function BrotherGroupPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BrotherGroupPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/brothergroup/brothergroupprizeview.prefab"
	}
end

function BrotherGroupPrizeViewPresentor:buildViews()
	return {
		BrotherGroupPrizeView.New()
	}
end

return BrotherGroupPrizeViewPresentor
