-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/tips/BattleDangerTipsViewPresentor.lua

module("logic.extensions.dungeon.view.tips.BattleDangerTipsViewPresentor", package.seeall)

local BattleDangerTipsViewPresentor = class("BattleDangerTipsViewPresentor", ViewPresentor)

function BattleDangerTipsViewPresentor:dependWhatResources()
	return {
		ResName.Instance_danger_degree_tips
	}
end

function BattleDangerTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BattleDangerTipsViewPresentor:buildViews()
	local views = {}

	table.insert(views, BattleDangerTipsView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return BattleDangerTipsViewPresentor
