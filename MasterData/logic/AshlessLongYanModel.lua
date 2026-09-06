-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashlesslongyan/model/AshlessLongYanModel.lua

module("logic.extensions.ashlesslongyan.model.AshlessLongYanModel", package.seeall)

local AshlessLongYanModel = class("AshlessLongYanModel", BaseModel)

function AshlessLongYanModel:ctor()
	return
end

function AshlessLongYanModel:onInit()
	self:onReset()
end

function AshlessLongYanModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._customFmtMo = nil
end

function AshlessLongYanModel:getLongYanMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = LongYanMo.New(activityId)
	end

	return self._moPool[activityId]
end

function AshlessLongYanModel:getLongYanFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = AshlessLongYanFmtMo.New()
	end

	return self._customFmtMo
end

AshlessLongYanModel.instance = AshlessLongYanModel.New()

return AshlessLongYanModel
