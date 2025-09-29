-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/PlayerViewsUtil.lua

module("logic.extensions.playerinfo.view.info.PlayerViewsUtil", package.seeall)

local M = class("PlayerViewsUtil")

function sort(moA, moB)
	local a = moA.isUnlock and 1 or 0
	local b = moB.isUnlock and 1 or 0

	if a + b == 1 then
		return b < a
	else
		return moA.id < moB.id
	end
end
