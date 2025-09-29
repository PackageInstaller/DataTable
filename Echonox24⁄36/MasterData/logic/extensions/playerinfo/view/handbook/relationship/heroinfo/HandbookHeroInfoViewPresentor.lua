-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/relationship/heroinfo/HandbookHeroInfoViewPresentor.lua

module("logic.extensions.playerinfo.view.handbook.relationship.heroinfo.HandbookHeroInfoViewPresentor", package.seeall)

local M = class("HandbookHeroInfoViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Charactersystem_character_system_main_view,
		ResName.Charactersystem_role_information_panel,
		ResName.Information_role_other_item,
		ResName.Information_role_voice_item,
		ResName.Information_role_special_voice_item,
		ResName.Authority_character_mask_eliminate_quad,
		ResName.Character_character_mask_ui_blur,
		ResName.Character_character_mask,
		ResName.Information_role_file_tips,
		ResName.Information_role_voice_tips,
		ResName.Information_role_expression_tips,
		ViewlibResPath.SkillItem1,
		CommonResPath.Url_Currency_Item,
		CommonResPath.UICommonBg,
		IconLoader.getSpriteAtlasUrl(IconType.Skinlib),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Language)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HandbookHeroInfoView.New())

	return views
end

return M
