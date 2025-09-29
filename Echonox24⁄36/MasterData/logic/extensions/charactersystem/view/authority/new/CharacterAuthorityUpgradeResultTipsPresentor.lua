-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/authority/new/CharacterAuthorityUpgradeResultTipsPresentor.lua

module("logic.extensions.charactersystem.view.authority.new.CharacterAuthorityUpgradeResultTipsPresentor", package.seeall)

local M = class("CharacterAuthorityUpgradeResultTipsPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Authority_authority_upgrade_show_pane_copy,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_Authority)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterAuthorityUpgradeResultTips.New())

	return views
end

return M
