-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preview/CharacterPreviewViewPresentor.lua

module("logic.extensions.charactersystem.view.preview.CharacterPreviewViewPresentor", package.seeall)

local M = class("CharacterPreviewViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Character_preview_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_Com)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterPreviewView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
