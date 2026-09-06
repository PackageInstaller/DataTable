-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/boss/CORoadBossMainViewPresentor.lua

module("logic.extensions.cantonoperaroad.view.boss.CORoadBossMainViewPresentor", package.seeall)

local CORoadBossMainViewPresentor = class("CORoadBossMainViewPresentor", ViewPresentor)

function CORoadBossMainViewPresentor:ctor()
	CORoadBossMainViewPresentor.super.ctor(self)
end

function CORoadBossMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CORoadBossMainViewPresentor:dependWhatResources()
	return {
		"ui/views/cantoneseoperaroad/boss/coroadbossmainview.prefab"
	}
end

function CORoadBossMainViewPresentor:buildViews()
	return {
		CORoadBossMainView.New()
	}
end

return CORoadBossMainViewPresentor
