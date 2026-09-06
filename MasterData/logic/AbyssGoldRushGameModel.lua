-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/model/AbyssGoldRushGameModel.lua

module("logic.extensions.abyssgoldrush.model.AbyssGoldRushGameModel", package.seeall)

local AbyssGoldRushGameModel = class("AbyssGoldRushGameModel", BaseModel)

function AbyssGoldRushGameModel:ctor()
	return
end

function AbyssGoldRushGameModel:onInit()
	self:onReset()
end

function AbyssGoldRushGameModel:onReset()
	self._isInGame = false
	self._gameInfo = nil
	self._holyStripeInfo = {}
	self._presetMap = {}
	self._isAutoWearHolyStripe = false
end

function AbyssGoldRushGameModel:isInGame()
	return self._isInGame
end

function AbyssGoldRushGameModel:setInGame(isInGame)
	self._isInGame = isInGame
end

function AbyssGoldRushGameModel:onStartGame(activityId, msg)
	local useIds = {}
	local presetMap = AbyssGoldRushModel.instance:getPresetMap(activityId)
	local defineIdMap = {}

	if self._gameInfo.holyStripeList then
		for i, v in ipairs(self._gameInfo.holyStripeList) do
			defineIdMap[v.defineId] = defineIdMap[v.defineId] or {}

			table.insert(defineIdMap[v.defineId], v.id)
		end
	end

	self._usePresetId = AbyssGoldRushModel.instance:getUsePresetId(activityId)

	if presetMap then
		self:_fillPresetMap(self._usePresetId, presetMap[self._usePresetId], defineIdMap, useIds)

		for presetId, v in pairs(presetMap) do
			if presetId ~= self._usePresetId then
				self:_fillPresetMap(presetId, v, defineIdMap, useIds)
			end
		end
	end

	self:_updateHolyStripeInfo()
end

function AbyssGoldRushGameModel:_fillPresetMap(presetId, presetIds, defineIdMap, useIds)
	self._presetMap[presetId] = {}

	for j, id in ipairs(presetIds or {}) do
		local findId = -1

		for l, onlyId in ipairs(defineIdMap[id] or {}) do
			if not useIds[onlyId] then
				findId = onlyId
				useIds[onlyId] = true

				break
			end
		end

		table.insert(self._presetMap[presetId], {
			defineId = id,
			id = findId
		})
	end
end

function AbyssGoldRushGameModel:saveGameInfo(msg, isFull)
	local gameInfo = GameUtil.pbToTable(msg)

	if isFull == true then
		self._gameInfo = gameInfo
	end

	self._gameInfo = self._gameInfo or {}

	if gameInfo.holyStripeList ~= nil then
		self._gameInfo.holyStripeList = gameInfo.holyStripeList

		self:_updateHolyStripeInfo()
	end

	if gameInfo.petList ~= nil then
		self._gameInfo.petList = gameInfo.petList
	end

	if gameInfo.op ~= nil then
		self._gameInfo.op = gameInfo.op
	end

	if gameInfo.petsCanSelect ~= nil then
		self._gameInfo.petsCanSelect = gameInfo.petsCanSelect
	end

	if gameInfo.baseInfo ~= nil then
		self._gameInfo.baseInfo = gameInfo.baseInfo
	end

	self._isInGame = true
end

function AbyssGoldRushGameModel:_updateHolyStripeInfo()
	self._holyStripeInfo = {}

	for i, v in ipairs(self._gameInfo.holyStripeList or {}) do
		if v.deleted ~= true then
			self._holyStripeInfo[v.id] = v
		end
	end

	for presetId, presetInfos in pairs(self._presetMap) do
		for posType, presetInfo in pairs(presetInfos) do
			if self._holyStripeInfo[presetInfo.id] == nil then
				presetInfo.id = -1
			end
		end
	end
end

function AbyssGoldRushGameModel:getHolyStripeInfo()
	return self._holyStripeInfo
end

function AbyssGoldRushGameModel:getHolyStripeSingleInfo(id)
	return self._holyStripeInfo and self._holyStripeInfo[id]
end

function AbyssGoldRushGameModel:getGameInfo()
	return self._gameInfo
end

function AbyssGoldRushGameModel:getUseHolyStripe()
	local usePreset = self._presetMap[self._usePresetId]
	local activeIds = {}

	for i, v in ipairs(usePreset or {}) do
		if checknumber(v.id) > 0 then
			table.insert(activeIds, v.id)
		end
	end

	return activeIds
end

function AbyssGoldRushGameModel:resetGame()
	self._isInGame = false
	self._gameInfo = nil
	self._holyStripeInfo = {}
end

function AbyssGoldRushGameModel:getPresetIds(presetId)
	if self._presetMap[presetId] then
		return self._presetMap[presetId] or {}
	end

	return {}
end

function AbyssGoldRushGameModel:getPresetMap()
	return self._presetMap or {}
end

function AbyssGoldRushGameModel:savePresetIds(presetId, ids)
	self._presetMap[presetId] = self._presetMap[presetId] or {}
	self._presetMap[presetId] = ids
end

function AbyssGoldRushGameModel:getUsePresetId()
	return self._usePresetId
end

function AbyssGoldRushGameModel:saveUsePresetId(presetId)
	self._usePresetId = presetId
end

function AbyssGoldRushGameModel:setAutoWearHolyStripe(bool)
	self._isAutoWearHolyStripe = bool
end

function AbyssGoldRushGameModel:isAutoWearHolyStripe()
	return self._isAutoWearHolyStripe
end

AbyssGoldRushGameModel.instance = AbyssGoldRushGameModel.New()

return AbyssGoldRushGameModel
