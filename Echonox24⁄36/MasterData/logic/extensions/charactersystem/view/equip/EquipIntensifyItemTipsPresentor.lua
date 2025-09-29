-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipIntensifyItemTipsPresentor.lua

module("logic.extensions.charactersystem.view.equip.EquipIntensifyItemTipsPresentor", package.seeall)

local M = class("EquipIntensifyItemTipsPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Tips_equip_detail_tips,
		IconLoader.getSpriteAtlasUrl(IconType.Skinlib),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, EquipIntensifyItemTipsView.New())

	return views
end

return M
