-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/view/BrotherGroupBuyViewPresentor.lua

module("logic.extensions.brothergroup.view.BrotherGroupBuyViewPresentor", package.seeall)

local BrotherGroupBuyViewPresentor = class("BrotherGroupBuyViewPresentor", ViewPresentor)

function BrotherGroupBuyViewPresentor:ctor()
	BrotherGroupBuyViewPresentor.super.ctor(self)
end

function BrotherGroupBuyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BrotherGroupBuyViewPresentor:dependWhatResources()
	return {
		"ui/views/brothergroup/brothergroupbuyview.prefab"
	}
end

function BrotherGroupBuyViewPresentor:buildViews()
	return {
		BrotherGroupBuyView.New()
	}
end

return BrotherGroupBuyViewPresentor
