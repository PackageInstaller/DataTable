-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/model/AoqiGodModel.lua

module("logic.extensions.aoqigod.model.AoqiGodModel", package.seeall)

local AoqiGodModel = class("AoqiGodModel", BaseModel)

function AoqiGodModel:ctor()
	return
end

function AoqiGodModel:onInit()
	self:onReset()
end

function AoqiGodModel:onReset()
	self._buffEnable = false
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end
end

function AoqiGodModel:getAoqiGodMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = AoqiGodMo.New(activityId)
	end

	return self._moPool[activityId]
end

function AoqiGodModel:setBuffEnable(enable)
	self._buffEnable = checkbool(enable)
end

function AoqiGodModel:isBuffEnable()
	return self._buffEnable
end

AoqiGodModel.instance = AoqiGodModel.New()

return AoqiGodModel
