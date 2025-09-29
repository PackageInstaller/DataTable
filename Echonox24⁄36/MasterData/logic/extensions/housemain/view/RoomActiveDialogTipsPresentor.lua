-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/view/RoomActiveDialogTipsPresentor.lua

module("logic.extensions.housemain.view.RoomActiveDialogTipsPresentor", package.seeall)

local M = class("RoomActiveDialogTipsPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Dialog_message_tips,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RoomActiveDialogTipsView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.HouseShowType))
	table.insert(views, BlurBgView.New())

	return views
end

return M
