-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterportrait/view/CharacterPotraitViewPresentor.lua

module("logic.extensions.characterportrait.view.CharacterPotraitViewPresentor", package.seeall)

local M = class("CharacterPotraitViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Background_character_check_view,
		ResName.Background_background_item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterPotraitView.New())

	return views
end

return M
