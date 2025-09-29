-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/specialtraining/view/SpecialtrainingViewPresentor.lua

module("logic.extensions.specialtraining.view.SpecialtrainingViewPresentor", package.seeall)

local M = class("SpecialtrainingViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Specialtraining_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_Com)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, SpecialtrainingView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
