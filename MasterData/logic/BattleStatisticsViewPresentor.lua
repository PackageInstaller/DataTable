-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/BattleStatisticsViewPresentor.lua

module("logic.extensions.battlesettlement.view.BattleStatisticsViewPresentor", package.seeall)

local BattleStatisticsViewPresentor = class("BattleStatisticsViewPresentor", ViewPresentor)

function BattleStatisticsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BattleStatisticsViewPresentor:dependWhatResources()
	return {
		"ui/views/battlesettlement/battlestatisticsview.prefab"
	}
end

function BattleStatisticsViewPresentor:buildViews()
	return {
		BattleStatisticsView.New()
	}
end

return BattleStatisticsViewPresentor
