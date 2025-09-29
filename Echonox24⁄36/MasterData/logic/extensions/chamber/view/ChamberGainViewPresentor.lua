-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chamber/view/ChamberGainViewPresentor.lua

module("logic.extensions.chamber.view.ChamberGainViewPresentor", package.seeall)

local M = class("ChamberGainViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Secret_secret_time_allotment_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ChamberGainView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
