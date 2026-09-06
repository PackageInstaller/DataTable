-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleVerifyViewPresentor.lua

module("logic.extensions.battle.view.BattleVerifyViewPresentor", package.seeall)

local BattleVerifyViewPresentor = class("BattleVerifyViewPresentor", ViewPresentor)

function BattleVerifyViewPresentor:ctor()
	BattleVerifyViewPresentor.super.ctor(self)
end

function BattleVerifyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BattleVerifyViewPresentor:dependWhatResources()
	return {
		"ui/views/battle/battleverifyview.prefab"
	}
end

function BattleVerifyViewPresentor:buildViews()
	return {
		BattleVerifyView.New()
	}
end

return BattleVerifyViewPresentor
