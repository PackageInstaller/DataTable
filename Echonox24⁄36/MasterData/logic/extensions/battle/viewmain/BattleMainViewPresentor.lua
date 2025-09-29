-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/BattleMainViewPresentor.lua

module("logic.extensions.battle.viewmain.BattleMainViewPresentor", package.seeall)

local BattleMainViewPresentor = class("BattleMainViewPresentor", ViewPresentor)

BattleMainViewPresentor.MainUrl = BattleResourceName.UIMain

function BattleMainViewPresentor:dependWhatResources()
	return {
		BattleMainViewPresentor.MainUrl,
		BattleResourceName.HeroUI3dLight,
		ViewlibResPath.BattleUseSkillItem,
		ViewlibResPath.BuffDetailItem1
	}
end

function BattleMainViewPresentor:attachToWhichRoot()
	return ViewRootType.Hud
end

function BattleMainViewPresentor:buildViews()
	local views = {}

	table.insert(views, BattleMainView.New())
	table.insert(views, BattlePropertyCompareView.New())
	table.insert(views, BattleOperatorUnitInfoView.New())
	table.insert(views, BattleOperatorSkillView.New())
	table.insert(views, BattleLeftTopView.New())
	table.insert(views, BattleCenterTopView.New())
	table.insert(views, BattleLeftDownView.New())
	table.insert(views, BattleRightTopView.New())
	table.insert(views, BattleRightDownView.New())
	table.insert(views, BattleAdditionalTerrainInfoView.New())
	table.insert(views, BattleUIElementsView.New())
	table.insert(views, BattleProxyView.New())
	table.insert(views, BattleExtensionView.New())
	table.insert(views, BattleLeftRoleView.New())

	return views
end

return BattleMainViewPresentor
