-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/CustomCharacterViewPresentor.lua

module("logic.extensions.hacktool.view.CustomCharacterViewPresentor", package.seeall)

local M = class("CustomCharacterViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Custom_Character,
		IconLoader.getSpriteAtlasUrl(IconType.Skinlib)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CustomCharacterView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
