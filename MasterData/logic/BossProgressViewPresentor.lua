-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/BossProgressViewPresentor.lua

module("logic.extensions.sharetask.view.BossProgressViewPresentor", package.seeall)

local BossProgressViewPresentor = class("BossProgressViewPresentor", ViewPresentor)

function BossProgressViewPresentor:ctor()
	BossProgressViewPresentor.super.ctor(self)
end

function BossProgressViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BossProgressViewPresentor:dependWhatResources()
	return {
		"ui/views/sharetask/bossprogressview.prefab"
	}
end

function BossProgressViewPresentor:buildViews()
	return {
		BossProgressView.New()
	}
end

return BossProgressViewPresentor
