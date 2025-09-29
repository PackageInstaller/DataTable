-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/tip/view/HintFloatTipsViewPresentor.lua

module("logic.extensions.common.tip.view.HintFloatTipsViewPresentor", package.seeall)

local M = class("HintFloatTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Dialog_hint_float_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HintFloatTipsView.New())

	return views
end

return M
