-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/mainline/MainlineDungeonViewPresentor.lua

module("logic.extensions.dungeon.view.mainline.MainlineDungeonViewPresentor", package.seeall)

local M = class("MainlineDungeonViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Instance_instance_view_copy,
		ResName.Common_enemy_head,
		ResName.Common_hero_item,
		ResName.Common_Backpack_Item,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Dungeon),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Language)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, MainlineDungeonView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.DungeonShowType))

	return views
end

return M
