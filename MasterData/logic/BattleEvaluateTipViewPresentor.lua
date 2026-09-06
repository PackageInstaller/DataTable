-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/BattleEvaluateTipViewPresentor.lua

module("logic.extensions.materialchallenge.view.BattleEvaluateTipViewPresentor", package.seeall)

local BattleEvaluateTipViewPresentor = class("BattleEvaluateTipViewPresentor", ViewPresentor)

function BattleEvaluateTipViewPresentor:ctor()
	BattleEvaluateTipViewPresentor.super.ctor(self)
end

function BattleEvaluateTipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BattleEvaluateTipViewPresentor:dependWhatResources()
	return {
		"ui/views/materialchallenge/battleevaluatetipview.prefab"
	}
end

function BattleEvaluateTipViewPresentor:buildViews()
	return {
		BattleEvaluateTipView.New()
	}
end

return BattleEvaluateTipViewPresentor
