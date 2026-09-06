-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/BattleSettlementSuccessViewPresentor.lua

module("logic.extensions.battlesettlement.view.BattleSettlementSuccessViewPresentor", package.seeall)

local BattleSettlementSuccessViewPresentor = class("BattleSettlementSuccessViewPresentor", ViewPresentor)

function BattleSettlementSuccessViewPresentor:ctor()
	BattleSettlementSuccessViewPresentor.super.ctor(self)
end

function BattleSettlementSuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BattleSettlementSuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/battlesettlement/battlesettlementsuccess.prefab"
	}
end

function BattleSettlementSuccessViewPresentor:buildViews()
	return {
		BattleSettlementSuccessView.New()
	}
end

return BattleSettlementSuccessViewPresentor
