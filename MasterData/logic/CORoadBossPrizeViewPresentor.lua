-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/boss/CORoadBossPrizeViewPresentor.lua

module("logic.extensions.cantonoperaroad.view.boss.CORoadBossPrizeViewPresentor", package.seeall)

local CORoadBossPrizeViewPresentor = class("CORoadBossPrizeViewPresentor", ViewPresentor)

function CORoadBossPrizeViewPresentor:ctor()
	CORoadBossPrizeViewPresentor.super.ctor(self)
end

function CORoadBossPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CORoadBossPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/cantoneseoperaroad/boss/coroadbossprizeview.prefab"
	}
end

function CORoadBossPrizeViewPresentor:buildViews()
	return {
		CORoadBossPrizeView.New()
	}
end

return CORoadBossPrizeViewPresentor
