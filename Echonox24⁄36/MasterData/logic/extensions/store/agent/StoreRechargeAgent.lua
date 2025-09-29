-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/agent/StoreRechargeAgent.lua

module("logic.extensions.store.agent.StoreRechargeAgent", package.seeall)

local M = class("StoreRechargeAgent", BaseAgent)

function M:sendGetRechargeInfoRequest()
	local isOpen1 = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.AccumulateRecharge)
	local isOpen2 = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FirstRecharge)
	local isOpen = isOpen1 or isOpen2

	if not isOpen then
		return
	end

	local msg = RechargeExtension_pb.GetRechargeInfoRequest()

	self:sendMsg(msg)
end

function M:handleGetRechargeInfoReply(status, msg)
	if status == 0 then
		StoreRechargeModel.instance:setHasGetRewardIds(msg.accumulateReceived)
		StoreRechargeModel.instance:setCurCredit(msg.credit)
		StoreRechargeModel.instance:setFirstStatus(msg.firstStatus)
		StoreRechargeModel.instance:updateRewardList()
		GlobalDispatcher:dispatchEvent(EventType.STORE_RECHARGE_DATA_UPDATE)
	end
end

function M:sendReceiveAccumulateRequest(id)
	local msg = RechargeExtension_pb.ReceiveAccumulateRequest()

	msg.index = id

	self:sendMsg(msg)
end

function M:handleReceiveAccumulateReply(status, msg)
	if status == 0 then
		StoreRechargeModel.instance:setHasGetRewardId(msg.index)
		StoreRechargeModel.instance:updateRewardList()
		GlobalDispatcher:dispatchEvent(EventType.STORE_RECHARGE_GET_REWARD)
	end
end

function M:sendReceiveFirstRequest()
	local msg = RechargeExtension_pb.ReceiveFirstRequest()

	self:sendMsg(msg)
end

function M:handleReceiveFirstReply(status, msg)
	if status == 0 then
		StoreRechargeModel.instance:setFirstStatus(StoreEnum.StoreFirstChargeStatus.hasGet)
		GlobalDispatcher:dispatchEvent(EventType.STORE_FIRST_CHARGE)
	end
end

M.instance = M.New()

return M
