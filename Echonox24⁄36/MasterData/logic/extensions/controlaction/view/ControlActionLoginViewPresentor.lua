-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/ControlActionLoginViewPresentor.lua

module("logic.extensions.controlaction.view.ControlActionLoginViewPresentor", package.seeall)

local M = class("ControlActionLoginViewPresentor", ViewPresentor)

M.Url_View = ResName.Regulatory_action_login_view

function M:dependWhatResources()
	return {
		M.Url_View
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ControlActionLoginView.New())

	return views
end

return M
