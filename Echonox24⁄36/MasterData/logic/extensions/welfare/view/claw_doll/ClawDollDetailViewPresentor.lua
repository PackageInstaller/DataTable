-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/claw_doll/ClawDollDetailViewPresentor.lua

module("logic.extensions.welfare.view.claw_doll.ClawDollDetailViewPresentor", package.seeall)

local M = class("ClawDollDetailViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.ClawDoll_detail_view,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ClawDollDetailView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.ClawDollCoin))
	table.insert(views, TitleView.New())

	return views
end

return M
