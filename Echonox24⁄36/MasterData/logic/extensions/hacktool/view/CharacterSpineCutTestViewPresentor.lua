-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/CharacterSpineCutTestViewPresentor.lua

module("logic.extensions.hacktool.view.CharacterSpineCutTestViewPresentor", package.seeall)

local M = class("CharacterSpineCutTestViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Hacktool_characterspinecuttest
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterSpineCutTestView.New())

	return views
end

return M
