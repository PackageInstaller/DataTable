-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcondition/BattleConditionsViewPresentor.lua

module("logic.extensions.battle.viewcondition.BattleConditionsViewPresentor", package.seeall)

local BattleConditionsViewPresentor = class("BattleConditionsViewPresentor", ViewPresentor)

BattleConditionsViewPresentor.MainUrl = BattleResourceName.UIConditions

function BattleConditionsViewPresentor:dependWhatResources()
	return {
		BattleConditionsViewPresentor.MainUrl
	}
end

function BattleConditionsViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function BattleConditionsViewPresentor:buildViews()
	local views = {}

	table.insert(views, BattleConditionsView.New())

	return views
end

return BattleConditionsViewPresentor
