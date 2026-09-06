-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/model/AbyssGoldRushModel.lua

module("logic.extensions.abyssgoldrush.model.AbyssGoldRushModel", package.seeall)

local AbyssGoldRushModel = class("AbyssGoldRushModel", BaseModel)

function AbyssGoldRushModel:ctor()
	return
end

function AbyssGoldRushModel:onInit()
	self:onReset()
end

function AbyssGoldRushModel:onReset()
	self._fmtMo = nil
	self._infos = {}
	self._presetMaps = {}
	self._usePresetIdMap = {}
end

function AbyssGoldRushModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._infos[data.activityId] = data

	local ownHolyStripe = {}

	if data.holyStripePack then
		for i, v in ipairs(data.holyStripePack) do
			ownHolyStripe[v.left] = v.right
		end
	end

	local presetMap = {}
	local countMap = {}

	if data.presetList then
		for _, preset in ipairs(data.presetList) do
			local presetId = checknumber(preset.presetId)

			if presetId > 0 then
				local presetContain = {}

				for _, itemId in ipairs(preset.holyStripePreset) do
					if checknumber(countMap[itemId]) + 1 <= checknumber(ownHolyStripe[itemId]) then
						table.insert(presetContain, itemId)

						countMap[itemId] = checknumber(countMap[itemId]) + 1
					end
				end

				presetMap[presetId] = presetContain
			end
		end
	end

	self._presetMaps[data.activityId] = presetMap
end

function AbyssGoldRushModel:saveResultInfo(msg)
	local data = GameUtil.pbToTable(msg)

	if self._infos[data.activityId] then
		self._infos[data.activityId].abyssCoinCount = data.abyssCoinCount
		self._infos[data.activityId].todayGainPrizeTimes = data.todayGainPrizeTimes
		self._infos[data.activityId].holyStripePack = data.holyStripePack
		self._infos[data.activityId].historyMaxAbyssCoinCount = data.historyMaxAbyssCoinCount
		self._infos[data.activityId].levelScore = data.levelScore
		self._infos[data.activityId].winStreak = data.winStreak
	end
end

function AbyssGoldRushModel:getUsePresetId(activityId)
	if self._infos[activityId] then
		return self._infos[activityId].useHoluStripePresetId
	end

	return 1
end

function AbyssGoldRushModel:getLevelScore(activityId)
	if self._infos[activityId] then
		return self._infos[activityId].levelScore or 0
	end

	return 0
end

function AbyssGoldRushModel:saveUsePresetId(msg)
	if self._infos[msg.activityId] then
		self._infos[msg.activityId].useHoluStripePresetId = msg.useHolyStripePresetId
	end
end

function AbyssGoldRushModel:saveHolyStripePreset(activityId, presetId, holyStripePreset)
	self._presetMaps[activityId] = self._presetMaps[activityId] or {}
	self._presetMaps[activityId][presetId] = holyStripePreset or {}
end

function AbyssGoldRushModel:getPresetPlanIndex(activityId)
	return self:getUsePresetId(activityId)
end

function AbyssGoldRushModel:getCurHolyStripePreset(activityId)
	if not self._presetMaps[activityId] then
		return {}
	end

	return self._presetMaps[activityId][self:getUsePresetId(activityId)] or {}
end

function AbyssGoldRushModel:getPresetMap(activityId)
	return self._presetMaps[activityId]
end

function AbyssGoldRushModel:getPresetInfo(activityId, presetId)
	if self._presetMaps[activityId] then
		return self._presetMaps[activityId][presetId] or {}
	end

	return {}
end

function AbyssGoldRushModel:getInfo(activityId)
	return self._infos[activityId]
end

function AbyssGoldRushModel:getFmtMo()
	self._fmtMo = self._fmtMo or AbyssGoldRushFmtMo.New()

	return self._fmtMo
end

function AbyssGoldRushModel:getAbyssCoinCount(activityId)
	if self._infos[activityId] then
		return self._infos[activityId].abyssCoinCount
	end
end

function AbyssGoldRushModel:getHolyStripeInfo(activityId)
	if self._infos[activityId] then
		return self._infos[activityId].holyStripePack or {}
	end

	return {}
end

function AbyssGoldRushModel:getWinStreak(activityId)
	if self._infos[activityId] then
		return self._infos[activityId].winStreak
	end
end

function AbyssGoldRushModel:saveRankInfo(msg)
	self._rankInfo = GameUtil.pbToTable(msg)
end

function AbyssGoldRushModel:getRankInfo()
	return self._rankInfo
end

AbyssGoldRushModel.instance = AbyssGoldRushModel.New()

return AbyssGoldRushModel
