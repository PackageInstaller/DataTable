-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemopen/view/ChapterOpenTipsViewPresentor.lua

module("logic.extensions.systemopen.view.ChapterOpenTipsViewPresentor", package.seeall)

local M = class("ChapterOpenTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Chapter_open_tips_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ChapterOpenTipsView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
