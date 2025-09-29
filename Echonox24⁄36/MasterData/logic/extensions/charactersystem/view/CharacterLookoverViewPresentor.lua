-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/CharacterLookoverViewPresentor.lua

module("logic.extensions.charactersystem.view.CharacterLookoverViewPresentor", package.seeall)

local M = class("CharacterLookoverViewPresentor", CharacterMainSystemViewPresentor)

function M:buildViews()
	local views = {}

	table.insert(views, CharacterLookoverView.New())

	return views
end

return M
