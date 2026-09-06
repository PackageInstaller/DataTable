-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/awakenoathancestor/model/AwakenOathAncestorModel.lua

module("logic.extensions.awakenoathancestor.model.AwakenOathAncestorModel", package.seeall)

local AwakenOathAncestorModel = class("AwakenOathAncestorModel", BaseModel)

function AwakenOathAncestorModel:onInit()
	self:onReset()
end

function AwakenOathAncestorModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._clgFmtMo = nil
end

function AwakenOathAncestorModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = AwakenOathAncestorSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function AwakenOathAncestorModel:getClgFmtMo()
	if self._clgFmtMo == nil then
		self._clgFmtMo = AwakenOathAncestorFmtMo.New()
	end

	return self._clgFmtMo
end

AwakenOathAncestorModel.instance = AwakenOathAncestorModel.New()

return AwakenOathAncestorModel
