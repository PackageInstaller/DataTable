-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlestartanim/view/BgInfoViewPresentor.lua

module("logic.extensions.battlestartanim.view.BgInfoViewPresentor", package.seeall)

local BgInfoViewPresentor = class("BgInfoViewPresentor", ViewPresentor)

function BgInfoViewPresentor:ctor()
	BgInfoViewPresentor.super.ctor(self)
end

function BgInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BgInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/bginfoview.prefab"
	}
end

function BgInfoViewPresentor:buildViews()
	return {
		BgInfoView.New()
	}
end

return BgInfoViewPresentor
