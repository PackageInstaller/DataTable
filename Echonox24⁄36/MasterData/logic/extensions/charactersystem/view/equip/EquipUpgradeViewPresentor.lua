-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipUpgradeViewPresentor.lua

module("logic.extensions.charactersystem.view.equip.EquipUpgradeViewPresentor", package.seeall)

local M = class("EquipUpgradeViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Charactersystem_level_up_common_tips,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, EquipUpgradeView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.EquipIntensify))
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
