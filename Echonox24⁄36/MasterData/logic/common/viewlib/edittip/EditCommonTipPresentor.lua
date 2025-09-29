-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/edittip/EditCommonTipPresentor.lua

module("logic.common.viewlib.edittip.EditCommonTipPresentor", package.seeall)

local M = class("EditCommonTipPresentor", ViewPresentor)

M.Url_View = ResName.Playerinfo_rename_tips

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		M.Url_View
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, EditCommonTip.New())

	return views
end

return M
