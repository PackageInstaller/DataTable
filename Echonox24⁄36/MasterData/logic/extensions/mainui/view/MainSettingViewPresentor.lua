-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainSettingViewPresentor.lua

module("logic.extensions.mainui.view.MainSettingViewPresentor", package.seeall)

local M = class("MainSettingViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Main_main_setting_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, MainSettingView.New())
	table.insert(views, AccountSettingView.New())
	table.insert(views, SoundSettingView.New())
	table.insert(views, FrameSettingView.New())
	table.insert(views, BattleOptionSettingView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

function M:onClickOutside()
	ViewMgr.instance:close(ViewName.MainSettingViewPresentor)
end

return M
