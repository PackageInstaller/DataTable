-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/ConfidentialityTipViewPresentor.lua

module("logic.extensions.login.view.ConfidentialityTipViewPresentor", package.seeall)

local M = class("ConfidentialityTipViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Agreement_confidentiality_agreement_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ConfidentialityTipView.New())

	return views
end

return M
