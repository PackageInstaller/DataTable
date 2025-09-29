-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/manufacture/agent/ManufactureAgent.lua

module("logic.extensions.manufacture.agent.ManufactureAgent", package.seeall)

local M = class("ManufactureAgent", BaseAgent)

function M:sendGetManufactureInfoRequest()
	local req = HouseExtension_pb.GetManufactureInfoRequest()

	self:sendMsg(req)
end

function M:handleGetManufactureInfoReply(status, msg)
	if status == 0 then
		ManufactureModel.instance:updateInfoByAgent(msg.manufacture)
		ManufactureModel.instance:setTotalStoreToMainView()
		GlobalDispatcher:dispatchEvent(EventType.MANUFACTURE_INFO_REPLY)
	end
end

function M:sendManufactureLevelUpRequest()
	local req = HouseExtension_pb.ManufactureLevelUpRequest()

	self:sendMsg(req)
end

function M:handleManufactureLevelUpReply(status, msg)
	if status == 0 then
		ManufactureModel.instance:setLv(msg.level)

		for _, plantNO in ipairs(msg.plant or {}) do
			local mo = ManufactureModel.instance:getPlantById(plantNO.id)

			mo:updateByAgent(plantNO)
		end

		GlobalDispatcher:dispatchEvent(EventType.MANUFACTURE_PLANT_INFO_CHANGE)
		ViewMgr.instance:open(ViewName.DeviceUpgradeSucceed, HouseEnum.WorkType.Manufacturing)
	end
end

function M:sendChangeManufactureSchemaRequest(plantId, schemeId)
	local req = HouseExtension_pb.ChangeManufactureSchemaRequest()

	req.plant = plantId
	req.schema = schemeId

	self:sendMsg(req)
end

function M:handleChangeManufactureSchemaReply(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show(lang("tip_change_precept_success"))
		self:_plantInfoChange(msg.plant)
	end
end

function M:handleManufactureSchemaChangePush(status, msg)
	if status == 0 then
		self:_plantInfoChange(msg.plant)
	end
end

function M:_plantInfoChange(plantsInfo)
	for _, plantNO in ipairs(plantsInfo) do
		local mo = ManufactureModel.instance:getPlantById(plantNO.id)

		mo:updateByAgent(plantNO)
	end

	ManufactureModel.instance:setTotalStoreToMainView()
	GlobalDispatcher:dispatchEvent(EventType.MANUFACTURE_PLANT_INFO_CHANGE)
end

function M:sendManufactureSpeedUpRequest(plantId, count)
	local req = HouseExtension_pb.ManufactureSpeedUpRequest()

	req.plant = plantId
	req.count = count

	self:sendMsg(req)
end

function M:handleManufactureSpeedUpReply(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show(lang("tip_accelerate_success"))

		local mo = ManufactureModel.instance:getPlantById(msg.plant)

		mo:setCurrProductivity(msg.productivity)
		mo:setCurrStore(msg.store)
		mo:updateNextProductTimeStamp()
		ManufactureModel.instance:setTotalStoreToMainView()
		GlobalDispatcher:dispatchEvent(EventType.MANUFACTURE_PLANT_INFO_CHANGE)
	end
end

function M:sendReceivePlantStoreRequest(plantId)
	local req = HouseExtension_pb.ReceivePlantStoreRequest()

	req.plant = plantId

	self:sendMsg(req)
end

function M:handleReceivePlantStoreReply(status, msg)
	if status == 0 then
		local mo = ManufactureModel.instance:getPlantById(msg.plant)

		if mo:isStoreFulled() then
			mo:updateNextProductTimeStamp()
		end

		mo:setCurrStore(msg.store)
		ManufactureModel.instance:setTotalStoreToMainView()
		GlobalDispatcher:dispatchEvent(EventType.MANUFACTURE_PLANT_INFO_CHANGE)
	end
end

function M:handlePlantStoreAddPush(status, msg)
	if status == 0 then
		for _, plantNO in ipairs(msg.plants or {}) do
			local mo = ManufactureModel.instance:getPlantById(plantNO.id)

			mo:updateByAgent(plantNO, true)
		end

		ManufactureModel.instance:setTotalStoreToMainView()
		GlobalDispatcher:dispatchEvent(EventType.MANUFACTURE_PLANT_INFO_CHANGE)
	end
end

M.instance = M.New()

return M
