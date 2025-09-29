-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newnotice/view/NewNoticeViewPresentor.lua

module("logic.extensions.newnotice.view.NewNoticeViewPresentor", package.seeall)

local M = class("NewNoticeViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Notice_notice_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, NewNoticeView.New())
	table.insert(views, BlurBgView.New())

	return views
end

function M:attachToWhichRoot()
	return ViewRootType.TopMost
end

return M
