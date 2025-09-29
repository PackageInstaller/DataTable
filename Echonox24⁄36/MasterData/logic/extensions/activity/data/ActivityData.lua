-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activity/data/ActivityData.lua

module("logic.extensions.activity.data.ActivityData", package.seeall)

local M = class("ActivityData", ActivityBaseData)

function M:ctor(ActivityNO)
	M.super.ctor(self, ActivityNO)
end

return M
