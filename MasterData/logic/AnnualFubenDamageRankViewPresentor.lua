-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenDamageRankViewPresentor.lua

module("logic.extensions.annualfuben.view.AnnualFubenDamageRankViewPresentor", package.seeall)

local AnnualFubenDamageRankViewPresentor = class("AnnualFubenDamageRankViewPresentor", ViewPresentor)

function AnnualFubenDamageRankViewPresentor:ctor()
	AnnualFubenDamageRankViewPresentor.super.ctor(self)
end

function AnnualFubenDamageRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AnnualFubenDamageRankViewPresentor:dependWhatResources()
	return {
		"ui/views/annualfuben/annualfubendamagerankview.prefab"
	}
end

function AnnualFubenDamageRankViewPresentor:buildViews()
	return {
		AnnualFubenDamageRankView.New()
	}
end

return AnnualFubenDamageRankViewPresentor
