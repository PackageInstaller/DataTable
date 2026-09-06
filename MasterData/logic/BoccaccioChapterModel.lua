-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/model/BoccaccioChapterModel.lua

module("logic.extensions.boccacciochapter.model.BoccaccioChapterModel", package.seeall)

local BoccaccioChapterModel = class("BoccaccioChapterModel", BaseModel)

function BoccaccioChapterModel:onInit()
	self:onReset()
end

function BoccaccioChapterModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._customFmtMoC1 = {}
	self._customFmtMoC2 = {}
	self._customFmtMoC3Map = {}
	self._customFmtMoC4Map = {}
end

function BoccaccioChapterModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = BoccaccioChapterSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function BoccaccioChapterModel:getFmtMoC1(activityId)
	if self._customFmtMoC1[activityId] == nil then
		self._customFmtMoC1[activityId] = BoccaccioChapterC1FmtMo.New()
	end

	return self._customFmtMoC1[activityId]
end

function BoccaccioChapterModel:getFmtMoC2(activityId)
	if self._customFmtMoC2[activityId] == nil then
		self._customFmtMoC2[activityId] = BoccaccioChapterC2FmtMo.New()
	end

	return self._customFmtMoC2[activityId]
end

function BoccaccioChapterModel:getFmtMoC3(activityId)
	if self._customFmtMoC3Map[activityId] == nil then
		self._customFmtMoC3Map[activityId] = BoccaccioChapterC3FmtMo.New()
	end

	return self._customFmtMoC3Map[activityId]
end

function BoccaccioChapterModel:getFmtMoC4(activityId)
	if self._customFmtMoC4Map[activityId] == nil then
		self._customFmtMoC4Map[activityId] = BoccaccioChapterC4FmtMo.New()
	end

	return self._customFmtMoC4Map[activityId]
end

BoccaccioChapterModel.instance = BoccaccioChapterModel.New()

return BoccaccioChapterModel
