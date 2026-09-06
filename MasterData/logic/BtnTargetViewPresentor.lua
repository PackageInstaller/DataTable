-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/BtnTargetViewPresentor.lua

module("logic.extensions.powerland.view.BtnTargetViewPresentor", package.seeall)

local BtnTargetViewPresentor = class("BtnTargetViewPresentor", ViewPresentor)

function BtnTargetViewPresentor:ctor()
	BtnTargetViewPresentor.super.ctor(self)
end

function BtnTargetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BtnTargetViewPresentor:dependWhatResources()
	return {
		"ui/views/powerland/btntargetview.prefab"
	}
end

function BtnTargetViewPresentor:buildViews()
	return {
		BtnTargetView.New()
	}
end

return BtnTargetViewPresentor
