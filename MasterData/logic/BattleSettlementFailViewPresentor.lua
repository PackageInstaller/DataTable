-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/BattleSettlementFailViewPresentor.lua

module("logic.extensions.battlesettlement.view.BattleSettlementFailViewPresentor", package.seeall)

local BattleSettlementFailViewPresentor = class("BattleSettlementFailViewPresentor", ViewPresentor)

function BattleSettlementFailViewPresentor:ctor()
	BattleSettlementFailViewPresentor.super.ctor(self)
end

function BattleSettlementFailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BattleSettlementFailViewPresentor:dependWhatResources()
	return {
		"ui/views/battlesettlement/battlesettlementfail.prefab"
	}
end

function BattleSettlementFailViewPresentor:buildViews()
	return {
		BattleSettlementFailView.New()
	}
end

return BattleSettlementFailViewPresentor
