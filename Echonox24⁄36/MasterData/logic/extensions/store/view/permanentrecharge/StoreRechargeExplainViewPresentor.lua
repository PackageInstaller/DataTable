-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/permanentrecharge/StoreRechargeExplainViewPresentor.lua

module("logic.extensions.store.view.permanentrecharge.StoreRechargeExplainViewPresentor", package.seeall)

local M = class("StoreRechargeExplainViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Store_permanent_recharge_explain_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, StoreRechargeExplainView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
