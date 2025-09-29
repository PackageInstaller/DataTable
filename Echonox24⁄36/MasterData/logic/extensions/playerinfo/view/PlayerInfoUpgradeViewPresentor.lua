-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/PlayerInfoUpgradeViewPresentor.lua

module("logic.extensions.playerinfo.view.PlayerInfoUpgradeViewPresentor", package.seeall)

local M = class("PlayerInfoUpgradeViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Info_player_info_attribute_use_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, PlayerInfoUpgradeView.New())
	table.insert(views, TitleView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
