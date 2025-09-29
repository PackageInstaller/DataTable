-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/supervisor/agent/SupervisorAgent.lua

module("logic.extensions.supervisor.agent.SupervisorAgent", package.seeall)

local M = class("SupervisorAgent", BaseAgent)

function M:sendGetManagerInfoRequest()
	local req = HouseExtension_pb.GetManagerInfoRequest()

	self:sendMsg(req)
end

function M:handleGetManagerInfoReply(status, msg)
	if status == 0 then
		SupervisorModel.instance:updateInfoByAgent(msg.managerInfo)
		GlobalDispatcher:dispatchEvent(EventType.SUPERVISOR_INFO_REPLY)
	end
end

function M:sendManagerLevelUpRequest()
	local req = HouseExtension_pb.ManagerLevelUpRequest()

	self:sendMsg(req)
end

function M:handleManagerLevelUpReply(status, msg)
	if status == 0 then
		local unlockZones = msg.unlockZones

		SupervisorModel.instance:setSupervisorLv(msg.level)
		LivingFacilitiesZoneController.instance:refreshUnlockZones(unlockZones)
		HouseDispatcher:dispatchEvent(HouseEventType.LIVE_UNLOCK_INFO_REFRESH, unlockZones)
		GlobalDispatcher:dispatchEvent(EventType.SUPERVISOR_INFO_CHANGE)
		ViewMgr.instance:open(ViewName.DeviceUpgradeSucceed, HouseEnum.WorkType.Supervisor)
	end
end

function M:handleManagerStoreAddPush(status, msg)
	if status == 0 then
		SupervisorModel.instance:setCurrStore(msg.store)
		SupervisorModel.instance:setCurrProductivity(msg.productivity)

		if SupervisorModel.instance:hasLoadedInfo() then
			SupervisorModel.instance:updateNextProductTimeStamp(true)
		end

		GlobalDispatcher:dispatchEvent(EventType.SUPERVISOR_INFO_CHANGE)
	end
end

function M:sendReceiveManagerStoreRequest()
	local req = HouseExtension_pb.ReceiveManagerStoreRequest()

	self:sendMsg(req)
end

function M:handleReceiveManagerStoreReply(status, msg)
	if status == 0 then
		if SupervisorModel.instance:isStoreFulled() then
			SupervisorModel.instance:updateNextProductTimeStamp()
		end

		SupervisorModel.instance:setCurrStore(msg.store)
		GlobalDispatcher:dispatchEvent(EventType.SUPERVISOR_INFO_CHANGE)
	end
end

M.instance = M.New()

return M
