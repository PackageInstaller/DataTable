-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/tips/PlayerAttributeTipsViewPresentor.lua

module("logic.extensions.playerinfo.view.tips.PlayerAttributeTipsViewPresentor", package.seeall)

local M = class("PlayerAttributeTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Open_functions_open_attributive_hint_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, PlayerAttributeTipsView.New())

	return views
end

return M
