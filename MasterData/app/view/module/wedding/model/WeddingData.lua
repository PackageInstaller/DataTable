local var_0_0 = g.core.config.wedding_favor_info
local var_0_1 = g.core.config.wedding_vow_info
local FightValueCalculation = require("app.core.common.FightValue.FightValueCalculation")
local var_0_3 = g.core.const.ConstMgr
local WeddingData = class("WeddingData", require("app.core.model.BaseData"))

function WeddingData:ctor()
	self:initData()
end

function WeddingData:initData()
	self._levelFirstIdDict = {}
	self._levelGroupDict = {}
	self._levelIndexDict = {}
	self._weddingDataDict = {}
	self._waitCheckDict = {}
	self._weddingSkinDict = {}
	self._specialRingDict = {}
	self._specialRingItemDict = {}

	self:initCfg()
end

function WeddingData:initCfg()
	self._weddingSkinDict = {}

	for iter_3_0, iter_3_1 in var_0_1.ipairs() do
		if iter_3_1.skin > 0 then
			self._weddingSkinDict[iter_3_1.skin] = iter_3_1.advance_id
		end

		if iter_3_1.ring_spe_type > 0 and iter_3_1.ring_spe_value > 0 then
			self._specialRingDict[iter_3_1.advance_id] = true
			self._specialRingItemDict[iter_3_1.ring_spe_value] = iter_3_1.advance_id
		end
	end

	self._levelGroupDict = {}
	self._levelFirstIdDict = {}

	for iter_3_2, iter_3_3 in var_0_0.ipairs() do
		if not self._levelGroupDict[iter_3_3.group] then
			self._levelGroupDict[iter_3_3.group] = {}
			self._levelFirstIdDict[iter_3_3.group] = {}
			self._levelIndexDict[iter_3_3.group] = {}
		end

		if not self._levelGroupDict[iter_3_3.group][iter_3_3.level] then
			local var_3_0 = 0

			self._levelFirstIdDict[iter_3_3.group][iter_3_3.level] = iter_3_3.id
			self._levelGroupDict[iter_3_3.group][iter_3_3.level] = {
				[iter_3_3.id] = var_3_0
			}
			self._levelIndexDict[iter_3_3.group][iter_3_3.level] = {
				[var_3_0] = iter_3_3.id
			}

			while iter_3_3.next_id > 0 do
				if var_0_0.get(iter_3_3.next_id).node_type ~= var_0_3.WeddingConst.NODE_TYPE.SMALL then
					break
				end

				var_3_0 = var_3_0 + 1
				self._levelGroupDict[iter_3_3.group][iter_3_3.level][iter_3_3.next_id] = var_3_0
				self._levelIndexDict[iter_3_3.group][iter_3_3.level][var_3_0] = iter_3_3.next_id
			end
		end
	end
end

function WeddingData:onS2CGetInfo(arg_4_1)
	self._weddingDataDict = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.list or {}) do
		self._weddingDataDict[iter_4_1.knight_advance_id] = iter_4_1
	end

	for iter_4_2, iter_4_3 in pairs(self._waitCheckDict) do
		self:checkRelatedWeddingAdvance(iter_4_2)
	end

	self._waitCheckDict = {}
end

function WeddingData:checkRelatedWeddingAdvance(arg_5_1, arg_5_2)
	local var_5_0 = var_0_1.fetch(arg_5_1)

	if var_5_0 then
		local var_5_1 = var_5_0.vow_advance
		local var_5_2 = var_0_1.match(function(arg_6_0)
			return arg_6_0.vow_advance == var_5_1
		end)

		if var_5_2 then
			if not next(self._weddingDataDict) then
				self._waitCheckDict[arg_5_1] = true

				return
			end

			for iter_5_0, iter_5_1 in ipairs(var_5_2) do
				local var_5_3 = g.core.model.User.knightsData:getKnight({
					advance_id = iter_5_1.advance_id
				})

				if arg_5_2 then
					if not self._weddingDataDict[iter_5_1.advance_id] and var_5_3 and var_5_3:isOwn() then
						g.core.network.GameNetProxy:send_C2S_WeddingVow_Active({
							knight_id = var_5_3:getServerId()
						})

						break
					end
				elseif iter_5_1.advance_id and (self._weddingDataDict[iter_5_1.vow_advance] or self._weddingDataDict[iter_5_1.advance_id]) then
					g.core.common.Scheduler:newScheduleOnce(function(arg_7_0)
						if var_5_3:isOwn() and not self._weddingDataDict[arg_5_1] then
							var_5_3 = g.core.model.User.knightsData:getKnight({
								advance_id = arg_5_1
							})

							g.core.network.GameNetProxy:send_C2S_WeddingVow_Active({
								knight_id = var_5_3:getServerId()
							})
						end
					end, 0.5)

					break
				end
			end
		end
	end
end

function WeddingData:onS2VowActive(arg_8_1)
	self._weddingDataDict[arg_8_1.wedding_vow.knight_advance_id] = arg_8_1.wedding_vow

	self:checkRelatedWeddingAdvance(arg_8_1.wedding_vow.knight_advance_id, true)
end

function WeddingData:onS2VowUpgrade(arg_9_1)
	self._weddingDataDict[arg_9_1.wedding_vow.knight_advance_id] = arg_9_1.wedding_vow
end

function WeddingData:getCurFavorInfo(arg_10_1)
	local var_10_0 = var_0_1.get(arg_10_1)
	local var_10_1 = self:getKnightWeddingData(arg_10_1)

	return var_0_0.get(not var_10_1 and (self._levelFirstIdDict[var_10_0.favor_group] or {})[0] or var_10_1.vow_id)
end

function WeddingData:getFirstInfoByLevel(arg_11_1, arg_11_2)
	return var_0_0.fetch((self._levelFirstIdDict[arg_11_1] or {})[arg_11_2] or 0)
end

function WeddingData:getFirstFavorInfo(arg_12_1)
	return var_0_0.get((self._levelFirstIdDict[var_0_1.get(arg_12_1).favor_group] or {})[0])
end

function WeddingData:getCurLevelActiveCount(arg_13_1)
	return (self._levelGroupDict[arg_13_1.group][arg_13_1.level] or {})[arg_13_1.id] or 0
end

function WeddingData:getLevelMaxNodeCount(arg_14_1)
	return table.nums(self._levelGroupDict[arg_14_1.group][arg_14_1.level] or {})
end

function WeddingData:getNextFavorInfo(arg_15_1)
	local var_15_0 = self:getKnightWeddingData(arg_15_1)

	if not var_15_0 then
		return nil
	end

	local var_15_1 = var_0_0.get(var_15_0.vow_id)

	if var_15_1.next_id > 0 then
		return var_0_0.get(var_15_1.next_id)
	else
		return nil
	end
end

function WeddingData:isMaxLevel(arg_16_1)
	return self:getNextFavorInfo(arg_16_1) == nil
end

function WeddingData:hasWeddingModule(arg_17_1)
	if arg_17_1 == 0 then
		return false
	end

	return var_0_1.hasData(arg_17_1)
end

function WeddingData:isUnlockWeddingHome()
	if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_3.FUNCTION_TYPE.HOME_LAND_WEDDING) then
		return false
	end

	return self:hasWeddingKnight()
end

function WeddingData:isWeddingDevelopByKnightId(arg_19_1)
	if not self:hasWeddingModule(arg_19_1) then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_3.FUNCTION_TYPE.WEDDING_DEVELOP) then
		return false
	end

	return self:isWeddingVowByKnightId(arg_19_1)
end

function WeddingData:getKnightWeddingData(arg_20_1)
	return self._weddingDataDict[arg_20_1]
end

function WeddingData:isWeddingVowByKnightId(arg_21_1)
	return self:getKnightWeddingData(arg_21_1) ~= nil
end

function WeddingData:hasWeddingKnight()
	return next(self._weddingDataDict)
end

function WeddingData:getAllWeddingKnightList()
	return table.keys(self._weddingDataDict)
end

function WeddingData:getLevelList(arg_24_1)
	local var_24_0 = var_0_1.get(arg_24_1)

	return self._levelGroupDict[var_24_0.favor_group] or {}, self._levelIndexDict[var_24_0.favor_group] or {}
end

function WeddingData:getWeddingVowInfo(arg_25_1)
	return (var_0_1.fetch(arg_25_1))
end

function WeddingData:getFavorAttrList(arg_26_1)
	local var_26_0 = self:getKnightWeddingData(arg_26_1)

	if not var_26_0 then
		return {}, {}
	end

	local var_26_1 = {}
	local var_26_2 = {}
	local var_26_3 = {}
	local var_26_4, var_26_5 = self:getLevelList(arg_26_1)

	for iter_26_0 = 0, table.nums(var_26_4) - 1 do
		local var_26_6 = false
		local var_26_7 = var_26_5[iter_26_0] or {}

		for iter_26_1 = 0, table.nums(var_26_7) - 1 do
			local var_26_8 = var_26_7[iter_26_1]

			if iter_26_0 ~= 0 or iter_26_1 ~= 0 then
				self:_addFavorAttrBy(var_26_8, var_26_1, var_26_2, var_26_3)
			end

			if var_26_8 == var_26_0.vow_id then
				var_26_6 = true

				break
			end
		end

		if var_26_6 then
			break
		end
	end

	return var_26_1, var_26_2, var_26_3
end

function WeddingData:getKnightFavorAllAttrList(arg_27_1)
	local var_27_0 = {}
	local var_27_1 = {}
	local var_27_2 = {}
	local var_27_3, var_27_4 = self:getLevelList(arg_27_1)

	for iter_27_0 = 0, table.nums(var_27_3) - 1 do
		local var_27_5 = var_27_4[iter_27_0] or {}

		for iter_27_1 = 0, table.nums(var_27_5) - 1 do
			if iter_27_0 ~= 0 or iter_27_1 ~= 0 then
				self:_addFavorAttrBy(var_27_5[iter_27_1], var_27_0, var_27_1, var_27_2)
			end
		end
	end

	return var_27_0, var_27_1, var_27_2
end

function WeddingData:getCurFavorAttrList(arg_28_1)
	local var_28_0 = self:getKnightWeddingData(arg_28_1)

	if not var_28_0 then
		return {}, {}, {}
	end

	local var_28_1 = {}
	local var_28_2 = {}
	local var_28_3 = {}

	self:_addFavorAttrBy(var_28_0.vow_id, var_28_1, var_28_2, var_28_3)

	return var_28_1, var_28_2, var_28_3
end

function WeddingData:_addFavorAttrBy(arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	local var_29_0 = var_0_0.get(arg_29_1)

	if var_29_0.talent_self > 0 then
		FightValueCalculation._getTalentAttrList(var_29_0.talent_self, arg_29_2)
	end

	if var_29_0.talent_all_2 > 0 then
		FightValueCalculation._getTalentAttrList(var_29_0.talent_all_2, arg_29_4)
	end

	if var_29_0.talent_all > 0 then
		FightValueCalculation._getTalentAttrList(var_29_0.talent_all, arg_29_3)
	end
end

function WeddingData:getWeddingAllTalentData(arg_30_1)
	if not var_0_1.fetch(arg_30_1) then
		return 0, {}
	else
		local var_30_0 = self:getCurFavorInfo(arg_30_1)
		local var_30_1 = {}

		for iter_30_0, iter_30_1 in ipairs((self:getLevelList(arg_30_1))) do
			for iter_30_2, iter_30_3 in pairs(iter_30_1) do
				local var_30_2 = var_0_0.get(iter_30_2)

				if var_30_2.talent_all > 0 then
					table.insert(var_30_1, {
						talentId = var_30_2.talent_all,
						value = var_30_0.level
					})
				end
			end
		end

		return #var_30_1, var_30_1
	end
end

function WeddingData:isWeddingSkin(arg_31_1)
	return checkbool(self._weddingSkinDict[arg_31_1])
end

function WeddingData:getWeddingSkinAdvId(arg_32_1)
	return self._weddingSkinDict[arg_32_1]
end

function WeddingData:getWeddingSpRingAdvId(arg_33_1)
	return self._specialRingItemDict[arg_33_1] or 0
end

function WeddingData:hasWeddingRedPoint(arg_34_1, arg_34_2)
	local var_34_0 = arg_34_1.advId or 0
	local var_34_1 = g.core.model.User.bagData

	if var_34_0 > 0 then
		if not self:isWeddingVowByKnightId(var_34_0) then
			return false
		end

		local var_34_2 = self:getCurFavorInfo(var_34_0)

		if not var_34_2 or var_34_2.next_id == 0 then
			return false
		end

		if arg_34_2 and not g.core.model.User.knightsData:getKnight({
			advance_id = var_34_0
		}):isLineup() then
			return false
		end

		return var_34_1:getOwnNum(var_34_2.active_type, var_34_2.active_value) >= var_34_2.active_size
	else
		local var_34_3 = g.core.model.User.formationData:getKnightList()

		for iter_34_0 = 1, var_0_3.KNIGHT_CONST.LINEUP_MAX do
			local var_34_4 = g.core.model.User.knightsData:getKnight({
				id = var_34_3[iter_34_0]
			})

			if var_34_4 then
				local var_34_5 = self:getCurFavorInfo(var_34_4:getAdvanceId())

				if var_34_5 and var_34_5.next_id > 0 and var_34_1:getOwnNum(var_34_5.active_type, var_34_5.active_value) >= var_34_5.active_size then
					return true
				end
			end
		end
	end

	return false
end

function WeddingData:hasWeddingSpecialRing(arg_35_1)
	local var_35_0 = arg_35_1.advId or 0
	local var_35_1 = g.core.model.User.bagData

	if var_35_0 > 0 then
		if self:isWeddingVowByKnightId(var_35_0) then
			return false
		end

		local var_35_2 = g.core.model.User.knightsData:getKnight({
			advance_id = var_35_0
		})

		if not var_35_2 or not var_35_2:isOwn() then
			return false
		end

		local var_35_3 = self:getWeddingVowInfo(var_35_0)

		if not var_35_3 or var_35_3.ring_spe_type == 0 or var_35_3.ring_spe_value == 0 then
			return false
		end

		return var_35_1:getOwnNum(var_35_3.ring_spe_type, var_35_3.ring_spe_value) >= var_35_3.ring_spe_size
	else
		for iter_35_0, iter_35_1 in pairs(self._specialRingDict) do
			if not self:isWeddingVowByKnightId(iter_35_0) then
				local var_35_4 = g.core.model.User.knightsData:getKnight({
					advance_id = iter_35_0
				})

				if var_35_4 and var_35_4:isOwn() then
					local var_35_5 = self:getWeddingVowInfo(iter_35_0)

					if var_35_1:getOwnNum(var_35_5.ring_spe_type, var_35_5.ring_spe_value) >= var_35_5.ring_spe_size then
						return true
					end
				end
			end
		end
	end

	return false
end

return WeddingData
