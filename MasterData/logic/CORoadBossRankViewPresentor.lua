-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/boss/CORoadBossRankViewPresentor.lua

module("logic.extensions.cantonoperaroad.view.boss.CORoadBossRankViewPresentor", package.seeall)

local CORoadBossRankViewPresentor = class("CORoadBossRankViewPresentor", ViewPresentor)

function CORoadBossRankViewPresentor:ctor()
	CORoadBossRankViewPresentor.super.ctor(self)
end

function CORoadBossRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CORoadBossRankViewPresentor:dependWhatResources()
	return {
		"ui/views/cantoneseoperaroad/boss/coroadbossrankview.prefab"
	}
end

function CORoadBossRankViewPresentor:buildViews()
	return {
		CORoadBossRankView.New()
	}
end

return CORoadBossRankViewPresentor
