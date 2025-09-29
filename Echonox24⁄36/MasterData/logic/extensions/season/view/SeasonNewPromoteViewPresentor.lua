-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonNewPromoteViewPresentor.lua

module("logic.extensions.season.view.SeasonNewPromoteViewPresentor", package.seeall)

local M = class("SeasonNewPromoteViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Common_common_multiple_choice_tips,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, SeasonNewPromoteView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.OnlySkinShowType))
	table.insert(views, BlurBgView.New())

	return views
end

return M
