-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonNewMainViewPresentor.lua

module("logic.extensions.season.view.SeasonNewMainViewPresentor", package.seeall)

local M = class("SeasonNewMainViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.season_main_view,
		ResName.Secret_secret_time_achievements_panel,
		ResName.Secret_secret_time_judge_panel,
		ResName.Secret_secret_time_common_effect,
		ResName.Secret_secret_time_judge_cell,
		ResName.Common_Backpack_Item,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, SeasonNewMainView.New())

	local titleView = TitleView.New()

	titleView:setHideHomeBtn(true)
	table.insert(views, titleView)

	return views
end

return M
