-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewvs/BattleSkillHintViewPresentor.lua

module("logic.extensions.battle.viewvs.BattleSkillHintViewPresentor", package.seeall)

local BattleSkillHintViewPresentor = class("BattleSkillHintViewPresentor", ViewPresentor)

BattleSkillHintViewPresentor.MainUrl = BattleResourceName.UISkillHint

function BattleSkillHintViewPresentor:dependWhatResources()
	return {
		BattleSkillHintViewPresentor.MainUrl
	}
end

function BattleSkillHintViewPresentor:attachToWhichRoot()
	return ViewRootType.Hud
end

function BattleSkillHintViewPresentor:buildViews()
	local views = {}

	table.insert(views, BattleSkillHintView.New())

	return views
end

return BattleSkillHintViewPresentor
