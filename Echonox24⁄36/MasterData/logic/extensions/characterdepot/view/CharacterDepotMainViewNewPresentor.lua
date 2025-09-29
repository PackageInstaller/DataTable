-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterdepot/view/CharacterDepotMainViewNewPresentor.lua

module("logic.extensions.characterdepot.view.CharacterDepotMainViewNewPresentor", package.seeall)

local M = class("CharacterDepotMainViewNewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Characterdepot_character_depot_main_view_copy,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterDepot),
		IconLoader.getSpriteAtlasUrl(IconType.Skinlib)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterDepotMainViewNew.New())

	local titleView = TitleView.New()

	titleView:setHideHomeBtn(true)
	table.insert(views, titleView)

	return views
end

return M
