-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echocardpack/view/EchoCardPackViewPresentor.lua

module("logic.extensions.echocardpack.view.EchoCardPackViewPresentor", package.seeall)

local M = class("EchoCardPackViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.EchoCardPackView,
		ResName.EchoCardPackViewItem,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.DefaultHideType))
	table.insert(views, EchoCardPackView.New())
	table.insert(views, EchoCardPackBuyView.New())
	table.insert(views, EchoCardPackUseView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
