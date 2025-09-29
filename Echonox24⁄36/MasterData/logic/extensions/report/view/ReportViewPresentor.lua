-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/report/view/ReportViewPresentor.lua

module("logic.extensions.report.view.ReportViewPresentor", package.seeall)

local M = class("ReportViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Friend_friend_inform_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ReportView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
