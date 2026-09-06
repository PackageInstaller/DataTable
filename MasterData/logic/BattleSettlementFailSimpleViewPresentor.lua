-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/BattleSettlementFailSimpleViewPresentor.lua

module("logic.extensions.battlesettlement.view.BattleSettlementFailSimpleViewPresentor", package.seeall)

local BattleSettlementFailSimpleViewPresentor = class("BattleSettlementFailSimpleViewPresentor", ViewWithGuidePresentor)

function BattleSettlementFailSimpleViewPresentor:ctor()
	BattleSettlementFailSimpleViewPresentor.super.ctor(self)
end

function BattleSettlementFailSimpleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BattleSettlementFailSimpleViewPresentor:dependWhatResources()
	return {
		"ui/views/battlesettlement/battlesettlementfailsimple.prefab"
	}
end

function BattleSettlementFailSimpleViewPresentor:buildViews()
	return {
		BattleSettlementFailSimpleView.New()
	}
end

return BattleSettlementFailSimpleViewPresentor
