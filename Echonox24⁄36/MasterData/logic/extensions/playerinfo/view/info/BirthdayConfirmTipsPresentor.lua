-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/BirthdayConfirmTipsPresentor.lua

module("logic.extensions.playerinfo.view.info.BirthdayConfirmTipsPresentor", package.seeall)

local M = class("BirthdayConfirmTipsPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Dialog_message_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, BirthdayConfirmTips.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
