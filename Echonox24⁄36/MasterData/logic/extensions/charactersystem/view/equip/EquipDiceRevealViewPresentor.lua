-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipDiceRevealViewPresentor.lua

module("logic.extensions.charactersystem.view.equip.EquipDiceRevealViewPresentor", package.seeall)

local M = class("EquipDiceRevealViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Equipsystem_dice_reveal_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, EquipDiceRevealView.New())

	return views
end

return M
