-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/monitor/QuickTakeViewPresentor.lua

module("logic.extensions.controlaction.view.monitor.QuickTakeViewPresentor", package.seeall)

local M = class("QuickTakeViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Equip_explore_multiplicity_fight_tips,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, QuickTakeView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.OnlyEnergyShowType))
	table.insert(views, BlurBgView.New())

	return views
end

return M
