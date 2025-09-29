-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/work/AirWorkShopWorkResourceLoaded.lua

module("logic.extensions.airworkshop.flow.defflow.work.AirWorkShopWorkResourceLoaded", package.seeall)

local M = class("AirWorkShopWorkResourceLoaded", WorkBase)

function M:onEnter(context)
	context:internal_NotifyComponent(AirWorkShopFunctionName.onResourceLoaded)
	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	return
end

return M
