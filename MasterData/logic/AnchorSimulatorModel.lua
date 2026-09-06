-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anchorsimulator/model/AnchorSimulatorModel.lua

module("logic.extensions.anchorsimulator.model.AnchorSimulatorModel", package.seeall)

local AnchorSimulatorModel = class("AnchorSimulatorModel", BaseModel)

function AnchorSimulatorModel:onInit()
	self:onReset()
end

function AnchorSimulatorModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end
end

function AnchorSimulatorModel:getAnchorSimulatorMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = AnchorSimulatorMo.New(activityId)
	end

	return self._moPool[activityId]
end

AnchorSimulatorModel.instance = AnchorSimulatorModel.New()

return AnchorSimulatorModel
