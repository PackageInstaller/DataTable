-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preview/CharacterDetailPreviewPresentor.lua

module("logic.extensions.charactersystem.view.preview.CharacterDetailPreviewPresentor", package.seeall)

local M = class("CharacterDetailPreviewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Character_preview_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_Com)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterDetailPreviewView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
