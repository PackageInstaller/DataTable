-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gainitem/view/TopToastRewardItemNoticeViewPresentor.lua

module("logic.extensions.gainitem.view.TopToastRewardItemNoticeViewPresentor", package.seeall)

local M = class("TopToastRewardItemNoticeViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Common_Top_Toast_Reward_Notice
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, TopToastRewardItemNoticeView.New())

	return views
end

return M
