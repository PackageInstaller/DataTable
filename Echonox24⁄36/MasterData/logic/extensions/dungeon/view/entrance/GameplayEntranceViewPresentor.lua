-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/entrance/GameplayEntranceViewPresentor.lua

module("logic.extensions.dungeon.view.entrance.GameplayEntranceViewPresentor", package.seeall)

local M = class("GameplayEntranceViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Fight_fight_entry_new_view,
		ResName.Fight_fight_entry_homepage_panel,
		ResName.Fight_fight_entry_mainline_panel,
		ResName.Fight_fight_entry_regulatory_panel,
		ResName.Fight_fight_entry_resources_panel,
		ResName.Fight_fight_challenge_panel,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Fight),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Dungeon),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_AirWorkShop)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, GameplayEntranceView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.OnlyEnergyShowType))
	table.insert(views, TitleView.New())

	return views
end

return M
