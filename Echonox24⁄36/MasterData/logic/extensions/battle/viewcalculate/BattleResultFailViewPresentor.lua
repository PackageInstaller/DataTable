-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcalculate/BattleResultFailViewPresentor.lua

module("logic.extensions.battle.viewcalculate.BattleResultFailViewPresentor", package.seeall)

local M = class("BattleResultFailViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		BattleResourceName.UIBattleResultView
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, BattleResultFailView.New())
	table.insert(views, BattleResultFailJumpView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
