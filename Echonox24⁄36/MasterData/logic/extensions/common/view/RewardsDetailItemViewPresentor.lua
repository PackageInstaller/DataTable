-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/RewardsDetailItemViewPresentor.lua

module("logic.extensions.common.view.RewardsDetailItemViewPresentor", package.seeall)

local M = class("RewardsDetailItemViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Common_rewards_detail_item
	}
end

function M:buildViews()
	local views = {}

	return views
end

return M
