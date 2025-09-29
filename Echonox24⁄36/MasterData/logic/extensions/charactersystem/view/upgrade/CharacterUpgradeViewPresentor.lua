-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/upgrade/CharacterUpgradeViewPresentor.lua

module("logic.extensions.charactersystem.view.upgrade.CharacterUpgradeViewPresentor", package.seeall)

local M = class("CharacterUpgradeViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Charactersystem_level_up_common_tips_copy,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterUpgradeView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.OnlyMoneyShowType))
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
