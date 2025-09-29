-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preface/flow/PrefaceWorkResetBattle.lua

module("logic.extensions.preface.flow.PrefaceWorkResetBattle", package.seeall)

local M = class("PrefaceWorkResetBattle", WorkBase)

function M:onEnter(context)
	self:onDone(WorkResult.Succeed)
end

return M
