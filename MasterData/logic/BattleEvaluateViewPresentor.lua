-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/BattleEvaluateViewPresentor.lua

module("logic.extensions.materialchallenge.view.BattleEvaluateViewPresentor", package.seeall)

local BattleEvaluateViewPresentor = class("BattleEvaluateViewPresentor", ViewPresentor)

function BattleEvaluateViewPresentor:ctor()
	BattleEvaluateViewPresentor.super.ctor(self)
end

function BattleEvaluateViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BattleEvaluateViewPresentor:dependWhatResources()
	return {
		"ui/views/materialchallenge/battleevaluateview.prefab"
	}
end

function BattleEvaluateViewPresentor:buildViews()
	return {
		BattleEvaluateView.New()
	}
end

return BattleEvaluateViewPresentor
