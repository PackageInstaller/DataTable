-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/BossIconViewPresentor.lua

module("logic.extensions.common.view.BossIconViewPresentor", package.seeall)

local M = class("BossIconViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Common_boss_icon
	}
end

function M:buildViews()
	local views = {}

	return views
end

return M
