-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chamber/view/ChamberExchangeViewPresentor.lua

module("logic.extensions.chamber.view.ChamberExchangeViewPresentor", package.seeall)

local M = class("ChamberExchangeViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Secret_impression_disc_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ChamberExchangeView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
