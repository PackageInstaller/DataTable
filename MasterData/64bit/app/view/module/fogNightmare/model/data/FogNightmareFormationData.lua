local var_0_0 = g.core.config.knight_info
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_2 = g.core.const.ConstMgr.FogNightmareConst
local SpecialFormationStruct = require("app.view.module.fogNightmare.model.struct.SpecialFormationStruct")
local FogNightmareKeepsakeStruct = require("app.view.module.fogNightmare.model.struct.FogNightmareKeepsakeStruct")
local SpecialKnightStruct = require("app.view.module.knight.model.SpecialKnightStruct")
local PetStruct = require("app.view.module.pet.model.PetStruct")
local PreciousSuitStruct = require("app.view.module.precious.model.PreciousSuitStruct")
local SuccubaStruct = require("app.view.module.succuba.model.SuccubaStruct")
local FightValueCalculation = require("app.core.common.FightValue.FightValueCalculation")
local var_0_10 = g.core.const.ConstMgr.QUALITY_TYPE
local FogNightmareFormationData = class("FogNightmareFormationData")

function FogNightmareFormationData:ctor()
	self._selectInfos = {
		knights = {},
		artifacts = {},
		uniteTokens = {},
		keepsakes = {}
	}
	self._defaultMemberPool = {}
	self._memberPool = {}
	self._poolKnightIdMap = {}
	self._formations = {}
	self._lastFormationsString = ""
	self._usedKnightMap = {}
	self._usedArtifactMap = {}
	self._usedFormationMap = {}
	self._tempFormations = {}
	self._requestFormaions = nil
	self._battleFormation = nil
	self._fogCultivateKnightFightValue = {}
	self._formationFightValueList = {}
	self._talentAttrInfo = {}
	self._otherFormationData = {}
	self._debugKnightFightValueList = {}
	self._syncStageIdDic = {}
end

function FogNightmareFormationData:initData()
	self._otherFormationData = {}
	self._defaultMemberPool = {
		placeHolder = 0,
		knights = {},
		artifacts = {},
		uniteTokens = {}
	}

	self:clearPoolMember()

	self._formations = {}

	for iter_2_0 = 1, 4 do
		local var_2_0 = SpecialFormationStruct.new()

		var_2_0:setFormationIdx(iter_2_0)

		self._formations[iter_2_0] = var_2_0
	end

	self._tempFormations = {}
end

function FogNightmareFormationData:updateData(arg_3_1)
	return
end

function FogNightmareFormationData:setTalentData(arg_4_1)
	self._talentAttrInfo = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		self._talentAttrInfo[iter_4_1.id] = iter_4_1.num
	end
end

function FogNightmareFormationData:getAndSaveFormationRequestParam()
	self._requestFormaions = {
		tp = 2,
		formations = {}
	}

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(self._tempFormations) do
		local var_5_1 = iter_5_1:getKnightPosList()
		local var_5_2 = {
			tp = 2,
			position = {},
			knight_id = {},
			artifact_id = {},
			unite_token_id = {},
			pet_id = {},
			pet_equipment_id = {},
			precious_suits = {},
			succuba_id = {},
			seq = iter_5_0
		}
		local var_5_3 = {}

		for iter_5_2 = 1, var_0_1.LINEUP_MAX do
			if var_5_1[iter_5_2] and not var_5_1[iter_5_2]:isDead() then
				table.insert(var_5_2.knight_id, var_5_1[iter_5_2]:getServerId())

				var_5_2.position[#var_5_2.knight_id] = iter_5_2

				local var_5_4 = var_5_1[iter_5_2]:getDevelopStruct(var_0_2.KNIGHT_DEVELOP_KEY.ARTIFACT)

				if var_5_4 and var_5_4:getServerOnlyId() and not var_5_0[var_5_4:getServerOnlyId()] and not self._usedArtifactMap[var_5_4:getServerOnlyId()] then
					var_5_0[var_5_4:getServerOnlyId()] = true

					table.insert(var_5_2.artifact_id, var_5_4:getServerOnlyId())
				else
					table.insert(var_5_2.artifact_id, 0)
				end
			else
				table.insert(var_5_3, iter_5_2)
			end
		end

		for iter_5_3, iter_5_4 in ipairs(var_5_3) do
			table.insert(var_5_2.position, iter_5_4)
			table.insert(var_5_2.artifact_id, 0)
			table.insert(var_5_2.knight_id, 0)
		end

		local var_5_5 = iter_5_1:getUniteTokenList()

		for iter_5_5 = 1, 4 do
			if var_5_5[iter_5_5] then
				table.insert(var_5_2.unite_token_id, var_5_5[iter_5_5]:getServerId())
			else
				table.insert(var_5_2.unite_token_id, 0)
			end
		end

		local var_5_6 = iter_5_1:getPetList()

		for iter_5_6 = 1, 6 do
			if var_5_6[iter_5_6] then
				table.insert(var_5_2.pet_id, var_5_6[iter_5_6]:getSid())
			else
				table.insert(var_5_2.pet_id, 0)
			end
		end

		local var_5_7 = iter_5_1:getPreciousSuitList()

		for iter_5_7 = 1, g.core.const.ConstMgr.PreciousConst.LINEUP_MAX do
			table.insert(var_5_2.precious_suits, var_5_7[iter_5_7] or 0)
		end

		local var_5_9 = iter_5_1:getSuccubaList()

		for iter_5_8 = 1, g.core.const.ConstMgr.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX do
			table.insert(var_5_2.succuba_id, var_5_9[iter_5_8] or 0)
		end

		if not self._usedFormationMap[iter_5_0] then
			table.insert(self._requestFormaions.formations, var_5_2)
		end
	end

	return self._requestFormaions
end

function FogNightmareFormationData:updateFormationByRequestFormations()
	if self._requestFormaions then
		self:updateFormationData(self._requestFormaions.formations)
	end

	self._requestFormaions = nil
end

function FogNightmareFormationData:updateFormationData(arg_7_1)
	arg_7_1 = arg_7_1 or {}

	local var_7_0 = g.core.model.User.uniteTokenData
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		if iter_7_1.tp == 2 then
			local var_7_2 = iter_7_1.artifact_id or {}
			local var_7_3 = {}

			for iter_7_2, iter_7_3 in ipairs(iter_7_1.position) do
				if iter_7_1.knight_id[iter_7_2] and iter_7_1.knight_id[iter_7_2] ~= 0 and not var_7_3[iter_7_1.knight_id[iter_7_2]] then
					local var_7_4 = self:getKnightFromPool(iter_7_1.knight_id[iter_7_2])

					if var_7_4 then
						var_7_3[iter_7_1.knight_id[iter_7_2]] = true

						self._formations[iter_7_1.seq]:setKnight(var_7_4, iter_7_3)
						var_7_4:updatePos(iter_7_3)

						if var_7_2[iter_7_2] and var_7_2[iter_7_2] > 0 and not var_7_1[var_7_2[iter_7_2]] then
							var_7_1[var_7_2[iter_7_2]] = true

							var_7_4:setDevelopStruct(clone(g.core.model.User.artifactData:getArtifactBySid(var_7_2[iter_7_2])), var_0_2.KNIGHT_DEVELOP_KEY.ARTIFACT)
						else
							var_7_4:setDevelopStruct(nil, var_0_2.KNIGHT_DEVELOP_KEY.ARTIFACT)
						end
					end
				else
					self._formations[iter_7_1.seq]:setKnight(nil, iter_7_3)
				end
			end

			for iter_7_4, iter_7_5 in ipairs(iter_7_1.unite_token_id or {}) do
				self._formations[iter_7_1.seq]:setUniteToken(var_7_0:getTokenByAdvId(iter_7_5), iter_7_4)
			end

			for iter_7_6, iter_7_7 in ipairs(iter_7_1.pet_id or {}) do
				local var_7_5 = g.core.model.User.petsData:getPetBySid(iter_7_7)

				if var_7_5 then
					local var_7_6 = PetStruct.new(var_7_5:getAdvanceId())

					var_7_6:setServerData(clone(var_7_5:getServerData()))
					var_7_6:setLineupPos(0)

					var_7_5 = var_7_6
				end

				self._formations[iter_7_1.seq]:setPet(var_7_5, iter_7_6)
			end

			for iter_7_8, iter_7_9 in ipairs(iter_7_1.precious_suits or {}) do
				self._formations[iter_7_1.seq]:setPreciousSuit(iter_7_8, iter_7_9)
			end

			for iter_7_10, iter_7_11 in ipairs(iter_7_1.succuba_id or {}) do
				self._formations[iter_7_1.seq]:setSuccuba(iter_7_10, iter_7_11)
			end

			self._formations[iter_7_1.seq]:checkGroupHalo()
		end
	end

	self:checkUsedFormation()

	self._formationFightValueList = self:updateFormationListFightValue(self._formations)
end

function FogNightmareFormationData:addPoolMember(arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1 or {}

	if arg_8_2 == "update" then
		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			local var_8_1 = self:getKnightByServerId(iter_8_1.id)

			if var_8_1 then
				var_8_1:setInfo(iter_8_1)
			end
		end
	else
		for iter_8_2, iter_8_3 in ipairs(var_8_0) do
			local var_8_2 = self:getKnightByServerId(iter_8_3.id)

			if var_8_2 then
				var_8_2:setInfo(iter_8_3)
			else
				local var_8_3 = SpecialKnightStruct.new(iter_8_3.base_id)

				var_8_3:setInfo(iter_8_3)
				var_8_3:setOwner(g.core.model.User:packUser())
				table.insert(self._memberPool.knights, var_8_3)

				self._poolKnightIdMap[var_8_3:getAdvanceId()] = true
			end
		end
	end
end

function FogNightmareFormationData:saveResultData()
	self._resultPoolMember = {
		knights = self._memberPool.knights
	}
end

function FogNightmareFormationData:getResultData()
	return self._resultPoolMember
end

function FogNightmareFormationData:clearPoolMember()
	self._memberPool = {
		placeHolder = 0,
		knights = {},
		artifacts = {},
		uniteTokens = {},
		pets = {}
	}
	self._poolKnightIdMap = {}
end

function FogNightmareFormationData:updateMemberPoolData(arg_12_1)
	if #self._memberPool.knights == 0 then
		return
	end

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.fog_knights or {}) do
		local var_12_0 = self:getKnightFromPool(iter_12_1.id)
		local var_12_1 = g.core.model.User:packUser()

		if var_12_1.id ~= iter_12_1.user_id then
			var_12_0:setIsOtherUser(true, g.core.lang:get(500227))
		end

		var_12_1.id = iter_12_1.user_id

		var_12_0:setOwner(var_12_1)
		var_12_0:setHpPercent(iter_12_1.hp / 10)

		if iter_12_1.seal_level_id ~= 0 then
			self:_updateKnightKeepsake(var_12_0, iter_12_1.seal_level_id)
		end
	end
end

function FogNightmareFormationData:_updateTempFormation()
	self._tempFormations = {
		{},
		{},
		{},
		{}
	}

	for iter_13_0, iter_13_1 in ipairs(self._formations) do
		local var_13_0 = iter_13_1:getKnightPosList()
		local var_13_1 = iter_13_1

		if self._usedFormationMap[iter_13_0] == true then
			for iter_13_2, iter_13_3 in pairs(var_13_0) do
				if iter_13_3:isDead() then
					iter_13_3:setDevelopStruct(nil, var_0_2.KNIGHT_DEVELOP_KEY.ARTIFACT)
					var_13_1:setKnight(nil, iter_13_2)
					iter_13_3:updateTempFormationPos(0)
				else
					var_13_1:setKnight(iter_13_3, iter_13_2)
				end
			end
		else
			for iter_13_4, iter_13_5 in pairs(var_13_0) do
				if iter_13_5:isDead() or self:isUsedKnight(iter_13_5:getServerId()) then
					iter_13_5:setDevelopStruct(nil, var_0_2.KNIGHT_DEVELOP_KEY.ARTIFACT)
					var_13_1:setKnight(nil, iter_13_4)
					iter_13_5:updateTempFormationPos(0)
				else
					var_13_1:setKnight(iter_13_5, iter_13_4)
				end
			end
		end

		var_13_1:checkGroupHalo()

		self._tempFormations[var_13_1:getFormationIdx()] = var_13_1
	end
end

function FogNightmareFormationData:getAllLineUpFormations(arg_14_1)
	if arg_14_1 then
		self:_updateTempFormation()
	end

	return self._tempFormations
end

function FogNightmareFormationData:getLineUpFormation(arg_15_1)
	return self._tempFormations[arg_15_1]
end

function FogNightmareFormationData:switchLineUpFormation(arg_16_1, arg_16_2)
	if self:isBattled(arg_16_1) or self:isBattled(arg_16_2) then
		return
	end

	self._tempFormations[arg_16_1] = self._tempFormations[arg_16_2]
	self._tempFormations[arg_16_2] = self._tempFormations[arg_16_1]
end

function FogNightmareFormationData:getLastPoolDatas()
	if self:hasPoolMember() then
		return self._memberPool
	else
		return self._defaultMemberPool
	end
end

function FogNightmareFormationData:autoPoolMember(arg_18_1, arg_18_2)
	local var_18_0 = {}
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(self._selectInfos.knights) do
		local var_18_2 = true

		for iter_18_2, iter_18_3 in pairs(arg_18_2) do
			if iter_18_1:getAdvanceId() == iter_18_3.knight:getAdvanceId() then
				var_18_2 = false

				break
			end
		end

		if var_18_2 then
			local var_18_3 = iter_18_1:getQuality()
			local var_18_4 = var_18_1[var_18_3]

			if not var_18_1[var_18_3] then
				var_18_4 = {}
				var_18_1[var_18_3] = var_18_4
			end

			local var_18_5 = iter_18_1:getStarLv() or 0
			local var_18_6 = var_18_4[var_18_5]

			if not var_18_4[var_18_5] then
				var_18_6 = {}
				var_18_4[var_18_5] = var_18_6
			end

			table.insert(var_18_6, iter_18_1)
		end
	end

	for iter_18_4 = var_0_10.MAX_QUALITY, var_0_10.R, -1 do
		if var_18_1[iter_18_4] then
			for iter_18_5 = 7, 0, -1 do
				if var_18_1[iter_18_4][iter_18_5] then
					for iter_18_6, iter_18_7 in ipairs(var_18_1[iter_18_4][iter_18_5]) do
						table.insert(var_18_0, iter_18_7)

						if arg_18_1 <= #var_18_0 then
							return var_18_0
						end
					end
				end
			end
		end
	end

	return var_18_0
end

function FogNightmareFormationData:getKnightFromPool(arg_19_1)
	local var_19_0

	for iter_19_0, iter_19_1 in pairs(self._memberPool.knights) do
		if iter_19_1:getServerId() == arg_19_1 then
			var_19_0 = iter_19_1

			break
		end
	end

	return var_19_0
end

function FogNightmareFormationData:isHasKnightInKnightPool(arg_20_1)
	local var_20_0 = false

	for iter_20_0, iter_20_1 in pairs(self._memberPool.knights) do
		if iter_20_1:getAdvanceId() == arg_20_1 then
			var_20_0 = true

			break
		end
	end

	return var_20_0
end

function FogNightmareFormationData:getKnightFormationInfo(arg_21_1)
	local var_21_0 = {}
	local var_21_1 = arg_21_1:getAdvanceId()

	for iter_21_0, iter_21_1 in pairs(self._formations) do
		if iter_21_1:hasKnight(var_21_1) then
			var_21_0.idx = iter_21_1:getFormationIdx()
			var_21_0.pos = arg_21_1:getFormationPos()

			break
		end
	end

	return var_21_0
end

function FogNightmareFormationData:getKnightByServerId(arg_22_1)
	local var_22_0

	for iter_22_0, iter_22_1 in pairs(self._memberPool.knights) do
		if iter_22_1:getServerId() == arg_22_1 then
			var_22_0 = iter_22_1

			break
		end
	end

	return var_22_0
end

function FogNightmareFormationData:getAllHasKeepsakeKnight(arg_23_1)
	arg_23_1 = arg_23_1 or 1

	local var_23_0 = {}
	local var_23_1 = g.core.model.User.fogNightmareData:getTowerData()
	local var_23_2 = math.min(var_23_1:getFloorStruct(var_23_1:getCurrentFloorNum()):getKeepsakeLevel(), g.core.model.User.fogNightmareData:getFogSealLevel())

	for iter_23_0, iter_23_1 in ipairs(self._memberPool.knights) do
		local var_23_3 = iter_23_1:getDevelopStruct(var_0_2.KNIGHT_DEVELOP_KEY.KEEPSAKE)

		if var_23_3 and not var_23_3:isMaxLevel() and var_23_2 - arg_23_1 >= var_23_3:getCfg().level then
			table.insert(var_23_0, iter_23_1)
		end
	end

	return var_23_0
end

function FogNightmareFormationData:getFormationStructByKnight(arg_24_1)
	local var_24_0

	for iter_24_0, iter_24_1 in pairs(self._tempFormations) do
		local var_24_1, var_24_2

		if iter_24_1:hasKnight(arg_24_1:getAdvanceId()) then
			var_24_0 = iter_24_1
			var_24_1 = iter_24_0
			var_24_2 = iter_24_1:getKnightPos(arg_24_1:getAdvanceId())

			break
		end
	end

	return var_24_0, nil, nil
end

function FogNightmareFormationData:getAllKnightsByStates(arg_25_1)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in pairs(self._memberPool.knights) do
		if arg_25_1[iter_25_1:getKnightState()] then
			table.insert(var_25_0, iter_25_1)
		end
	end

	return var_25_0
end

function FogNightmareFormationData:hasPoolMember()
	return #self._memberPool.knights > 0
end

function FogNightmareFormationData:isInPoolKnightByAdvanceId(arg_27_1)
	return self._poolKnightIdMap[arg_27_1]
end

function FogNightmareFormationData:getPoolMember()
	self._memberPool.artifacts = g.core.model.User.artifactData:getOwnArtifactList()
	self._memberPool.uniteTokens = g.core.model.User.uniteTokenData:getOwnTokenList()
	self._memberPool.pets = {}

	for iter_28_0, iter_28_1 in ipairs(g.core.model.User.petsData:getOwnPetArr()) do
		local var_28_0 = PetStruct.new(iter_28_1:getAdvanceId())

		var_28_0:setServerData(clone(iter_28_1:getServerData()))
		var_28_0:setLineupPos(0)
		table.insert(self._memberPool.pets, var_28_0)
	end

	self._memberPool.succubas = g.core.model.User.succubaData:getSuccubaList()

	return self._memberPool
end

function FogNightmareFormationData:isBattled(arg_29_1)
	return not not (self:getLineUpFormation(arg_29_1) and var_0_2.FORMATION_STATE.BATTLED)
end

function FogNightmareFormationData:updateSelectInfos()
	local var_30_0 = {}
	local SpecialKnightStruct = require("app.view.module.knight.model.SpecialKnightStruct")

	for iter_30_0, iter_30_1 in ipairs((g.core.model.User.knightsData:getOwnerAllList())) do
		local var_30_2 = iter_30_1:getInfo()

		if var_30_2.source_type and var_30_2.source_type == 0 then
			local var_30_3 = SpecialKnightStruct.new(iter_30_1:getBaseId())

			var_30_3:setInfo(clone(iter_30_1:getInfo()))
			var_30_3:updatePos(0)
			var_30_3:setOwner(g.core.model.User:packUser())

			var_30_0[iter_30_0] = var_30_3
		end
	end

	local var_30_4 = {}

	for iter_30_2, iter_30_3 in ipairs((g.core.model.User.artifactData:getOwnArtifactList())) do
		var_30_4[iter_30_2] = clone(iter_30_3)
	end

	self._selectInfos = {
		knights = var_30_0,
		artifacts = var_30_4,
		uniteTokens = g.core.model.User.uniteTokenData:getOwnTokenList(),
		keepsakes = {}
	}
end

function FogNightmareFormationData:updateKnightTempPoss(arg_31_1)
	for iter_31_0 = 1, #arg_31_1 do
		if arg_31_1[iter_31_0] and arg_31_1[iter_31_0].knight then
			local var_31_0 = arg_31_1[iter_31_0].knight:getAdvanceId()

			for iter_31_1, iter_31_2 in ipairs(self._selectInfos.knights) do
				if iter_31_2:getAdvanceId() == var_31_0 then
					iter_31_2:updateTempFormationPos(iter_31_0)
				end
			end
		end
	end
end

function FogNightmareFormationData:getSelectInfos(arg_32_1)
	return self._selectInfos[arg_32_1]
end

function FogNightmareFormationData:getKnightByIndexAndPos(arg_33_1, arg_33_2)
	if self._tempFormations[arg_33_1] then
		return self._tempFormations[arg_33_1]:getKnight(arg_33_2)
	else
		return nil
	end
end

function FogNightmareFormationData:updateKnightKeepsake(arg_34_1)
	local var_34_0 = self:getKnightFromPool(arg_34_1.fog_knight.id)
	local var_34_1 = g.core.model.User:packUser()

	var_34_1.id = arg_34_1.fog_knight.user_id

	var_34_0:setOwner(var_34_1)
	var_34_0:setHpPercent(arg_34_1.fog_knight.hp / 10)

	if arg_34_1.fog_knight.seal_level_id ~= 0 then
		self:_updateKnightKeepsake(var_34_0, arg_34_1.fog_knight.seal_level_id)
	end
end

function FogNightmareFormationData:onlyUpdateKnightKeepsake(arg_35_1, arg_35_2)
	if arg_35_2 ~= 0 then
		self:_updateKnightKeepsake(self:getKnightFromPool(arg_35_1), arg_35_2)
	end
end

function FogNightmareFormationData:updateKnightList(arg_36_1)
	for iter_36_0, iter_36_1 in pairs(arg_36_1 or {}) do
		local var_36_0 = self:getKnightFromPool(iter_36_1.id)
		local var_36_1 = g.core.model.User:packUser()

		var_36_1.id = iter_36_1.user_id

		var_36_0:setOwner(var_36_1)
		var_36_0:setHpPercent(iter_36_1.hp / 10)

		if iter_36_1.seal_level_id ~= 0 then
			self:_updateKnightKeepsake(var_36_0, iter_36_1.seal_level_id)
		end
	end
end

function FogNightmareFormationData:_updateKnightKeepsake(arg_37_1, arg_37_2)
	local var_37_0 = arg_37_1:getDevelopStruct(var_0_2.KNIGHT_DEVELOP_KEY.KEEPSAKE)

	if var_37_0 then
		g.core.model.User.fogNightmareData:getKeepsakeData():removeKeepsakeFromSuit(var_37_0)
	end

	local var_37_1 = FogNightmareKeepsakeStruct.new(arg_37_2)

	arg_37_1:setDevelopStruct(var_37_1, var_0_2.KNIGHT_DEVELOP_KEY.KEEPSAKE)
	g.core.model.User.fogNightmareData:getKeepsakeData():addKeepsakeToSuit(var_37_1)
end

function FogNightmareFormationData:checkFormaionString()
	local var_38_0 = ""

	for iter_38_0, iter_38_1 in pairs(self._tempFormations) do
		var_38_0 = var_38_0 .. iter_38_1:getFormationString()

		if iter_38_0 < table.nums(self._tempFormations) then
			var_38_0 = var_38_0 .. ";"
		end
	end

	return var_38_0 ~= self._lastFormationsString
end

function FogNightmareFormationData:updateUsedKnight(arg_39_1)
	self._usedKnightMap = {}
	arg_39_1 = arg_39_1 or {}

	for iter_39_0, iter_39_1 in ipairs(arg_39_1) do
		self._usedKnightMap[iter_39_1] = true
	end

	self:checkUsedFormation()
end

function FogNightmareFormationData:updateKnightHps(arg_40_1)
	local var_40_0 = arg_40_1 or {}

	if self._battleFormation then
		for iter_40_0, iter_40_1 in pairs(self._battleFormation:getKnightPosList()) do
			iter_40_1:setHpPercent(var_40_0[iter_40_0] / 10)
		end
	end
end

function FogNightmareFormationData:setUseFormation(arg_41_1, arg_41_2)
	self._usedFormationMap[arg_41_1] = arg_41_2 == true
end

function FogNightmareFormationData:clearUseFormation()
	self._usedFormationMap = {}
end

function FogNightmareFormationData:checkUsedFormation()
	return
end

function FogNightmareFormationData:updateUsedArtifact(arg_44_1)
	arg_44_1 = arg_44_1 or {}
	self._usedArtifactMap = {}

	for iter_44_0, iter_44_1 in ipairs(arg_44_1) do
		self._usedArtifactMap[iter_44_1] = true
	end
end

function FogNightmareFormationData:setBattleFormation(arg_45_1)
	self._battleFormation = self._formations[arg_45_1]
end

function FogNightmareFormationData:getBattleFormation()
	return self._battleFormation
end

function FogNightmareFormationData:isUsedKnight(arg_47_1)
	return self._usedKnightMap[arg_47_1]
end

function FogNightmareFormationData:isUsedArtifact(arg_48_1)
	return self._usedArtifactMap[arg_48_1]
end

function FogNightmareFormationData:isUsedUniteToken(arg_49_1, arg_49_2)
	for iter_49_0 = 1, #arg_49_2 do
		if arg_49_2[iter_49_0] and self._formations[iter_49_0]:checkIsWear(arg_49_1) then
			return true
		end
	end

	return false
end

function FogNightmareFormationData:isUsedPet(arg_50_1, arg_50_2)
	for iter_50_0 = 1, #arg_50_2 do
		if arg_50_2[iter_50_0] and self._formations[iter_50_0]:checkPetIsLineUp(arg_50_1) then
			return true
		end
	end

	return false
end

function FogNightmareFormationData:isUsedSuccuba(arg_51_1, arg_51_2)
	for iter_51_0 = 1, #arg_51_2 do
		if arg_51_2[iter_51_0] and self._formations[iter_51_0]:isSuccubaLineUp(arg_51_1:getSid()) then
			return true
		end
	end

	return false
end

function FogNightmareFormationData:isUsedFormation(arg_52_1)
	return self._usedFormationMap[arg_52_1]
end

function FogNightmareFormationData:checkUniteInAllFormation(arg_53_1, arg_53_2)
	if arg_53_2 then
		if not self._tempFormations[arg_53_2] then
			return false
		end

		return self._tempFormations[arg_53_2]:checkIsWear(arg_53_1)
	else
		for iter_53_0, iter_53_1 in pairs(self._tempFormations) do
			if iter_53_1:checkIsWear(arg_53_1) then
				return true
			end
		end
	end

	return false
end

function FogNightmareFormationData:checkPetInAllFormation(arg_54_1, arg_54_2)
	if arg_54_2 then
		if not self._tempFormations[arg_54_2] then
			return false
		end

		return self._tempFormations[arg_54_2]:checkPetIsLineUp(arg_54_1)
	else
		for iter_54_0, iter_54_1 in pairs(self._tempFormations) do
			if iter_54_1:checkPetIsLineUp(arg_54_1) then
				return true
			end
		end
	end

	return false
end

function FogNightmareFormationData:checkSuccubaInAllFormation(arg_55_1, arg_55_2)
	if arg_55_2 then
		if not self._tempFormations[arg_55_2] then
			return false
		end

		return self._tempFormations[arg_55_2]:isSuccubaLineUp(arg_55_1:getSid())
	else
		for iter_55_0, iter_55_1 in pairs(self._tempFormations) do
			if iter_55_1:isSuccubaLineUp(arg_55_1:getSid()) then
				return true
			end
		end
	end

	return false
end

function FogNightmareFormationData:getFormationStructUniteTokenLineUp(arg_56_1)
	for iter_56_0, iter_56_1 in pairs(self._tempFormations) do
		if iter_56_1:checkIsWear(arg_56_1) then
			return iter_56_1
		end
	end
end

function FogNightmareFormationData:getFormationStructPetLineUp(arg_57_1)
	for iter_57_0, iter_57_1 in pairs(self._tempFormations) do
		if iter_57_1:checkPetIsLineUp(arg_57_1) then
			return iter_57_1
		end
	end
end

function FogNightmareFormationData:lineUpUniteToken(arg_58_1, arg_58_2, arg_58_3)
	self._tempFormations[arg_58_1]:setUniteToken(arg_58_2, arg_58_3)
end

function FogNightmareFormationData:lineUpKnight(arg_59_1, arg_59_2, arg_59_3)
	self._tempFormations[arg_59_1]:setKnight(arg_59_2, arg_59_3)
	self._tempFormations[arg_59_1]:checkGroupHalo()
end

function FogNightmareFormationData:lineUpArtifact(arg_60_1, arg_60_2, arg_60_3)
	self._tempFormations[arg_60_1]:getKnight(arg_60_3):setDevelopStruct(arg_60_2, var_0_2.KNIGHT_DEVELOP_KEY.ARTIFACT)
end

function FogNightmareFormationData:changeArtifactPos(arg_61_1, arg_61_2, arg_61_3)
	self._tempFormations[arg_61_1]:switchArtifact(arg_61_2, arg_61_3)
end

function FogNightmareFormationData:changeKnightPos(arg_62_1, arg_62_2, arg_62_3)
	self._tempFormations[arg_62_1]:switchKnight(arg_62_2, arg_62_3)
end

function FogNightmareFormationData:popKnightPos(arg_63_1, arg_63_2)
	self._tempFormations[arg_63_1]:popKnight(arg_63_2)
	self._tempFormations[arg_63_1]:checkGroupHalo()
end

function FogNightmareFormationData:updateFormationListFightValue(arg_64_1)
	local var_64_0 = {}

	for iter_64_0, iter_64_1 in pairs(arg_64_1) do
		var_64_0[iter_64_0] = self:_updateFormationFightValue(iter_64_1)
	end

	return var_64_0
end

function FogNightmareFormationData:_updateFormationFightValue(arg_65_1)
	local var_65_0 = arg_65_1:getGroupHaloInfo().count or 0
	local var_65_1 = 0

	for iter_65_0, iter_65_1 in pairs((arg_65_1:getKnightPosList())) do
		local var_65_2 = {}
		local var_65_3 = iter_65_1:getDevelopStruct(var_0_2.KNIGHT_DEVELOP_KEY.ARTIFACT)

		FightValueCalculation.addAttr(var_65_2, self:getFogKnightAttrList(iter_65_1, arg_65_1))
		FightValueCalculation.checkBaseAttrList(var_65_2)
		FightValueCalculation.checkFogRateAttrList(var_65_2)
		FightValueCalculation.addAttr(var_65_2, FightValueCalculation.getFogGroupHaloAttr(var_65_0))

		local var_65_4 = iter_65_1:getDevelopStruct(var_0_2.KNIGHT_DEVELOP_KEY.KEEPSAKE)

		if var_65_4 then
			FightValueCalculation.addAttr(var_65_2, self:_getKeepsakeAttrList(var_65_4:getCfg()))
		end

		FightValueCalculation.addAttr(var_65_2, self._talentAttrInfo)

		local var_65_5 = FightValueCalculation.calculationFightValue(var_65_2, true)

		self._debugKnightFightValueList[iter_65_1:getServerId()] = {
			fightValue = var_65_5,
			attrList = var_65_2,
			name = iter_65_1:getName(),
			serverId = iter_65_1:getServerId(),
			baseId = iter_65_1:getBaseId()
		}
		var_65_1 = var_65_1 + var_65_5
	end

	return var_65_1
end

function FogNightmareFormationData:getFogKnightAttrList(arg_66_1, arg_66_2)
	local var_66_0 = arg_66_1:getInfo()
	local var_66_1 = 0
	local var_66_2 = arg_66_1:getDevelopStruct(var_0_2.KNIGHT_DEVELOP_KEY.ARTIFACT)

	if var_66_2 then
		var_66_1 = var_66_2:getCfg().id
	end

	local var_66_3 = {}

	if not self._fogCultivateKnightFightValue[var_66_0.base_id] then
		local var_66_4 = var_0_0.get(var_66_0.base_id)

		self._fogCultivateKnightFightValue[var_66_0.base_id] = FightValueCalculation.getFogKnightCultivateAttrList(var_66_4, var_66_0.level, var_66_0.advance_level, var_66_4.star)
	end

	FightValueCalculation.addAttr(var_66_3, self._fogCultivateKnightFightValue[var_66_0.base_id])
	FightValueCalculation.addAttr(var_66_3, FightValueCalculation.getArtifactStarAttrList(var_66_1, var_66_0.base_id))
	FightValueCalculation.addAttr(var_66_3, FightValueCalculation.getAllUniteTokenStarAttrList())

	local var_66_5 = arg_66_2:getPetList()

	for iter_66_0 = 1, 6 do
		if var_66_5[iter_66_0] then
			local var_66_6, var_66_7 = var_66_5[iter_66_0]:getBigSmallStage()

			FightValueCalculation.addAttr(var_66_3, FightValueCalculation.getPetAttrList(var_66_5[iter_66_0], var_66_5[iter_66_0]:getLevel(), var_66_6, var_66_7))
		end
	end

	FightValueCalculation.addAttr(var_66_3, FightValueCalculation.getKnightSoulAttrList())

	return var_66_3
end

function FogNightmareFormationData:_getKeepsakeAttrList(arg_67_1)
	local var_67_0 = {}

	if arg_67_1 then
		for iter_67_0 = 1, 5 do
			var_67_0[arg_67_1["affect_type_" .. iter_67_0]] = var_67_0[arg_67_1["affect_type_" .. iter_67_0]] and var_67_0[arg_67_1["affect_type_" .. iter_67_0]] + arg_67_1["affect_value_" .. iter_67_0] or arg_67_1["affect_value_" .. iter_67_0]
		end
	end

	return var_67_0
end

function FogNightmareFormationData:setOtherFormationData(arg_68_1)
	if not arg_68_1.formations then
		g.core.module.ModuleManager:tip(500228)

		return
	end

	self._otherFormationData = {}

	local var_68_0 = {}

	for iter_68_0, iter_68_1 in ipairs(arg_68_1.artifacts or {}) do
		local var_68_1 = g.core.config.artifact_info.get(iter_68_1.base_id)
		local var_68_2 = require("app.view.module.artifact.model.ArtifactStruct").new(var_68_1.advance_code)

		var_68_2:setServerData(iter_68_1)
		var_68_2:setCfg(var_68_1)

		var_68_0[var_68_2:getServerOnlyId()] = var_68_2
	end

	local var_68_3 = {}

	for iter_68_2, iter_68_3 in ipairs(arg_68_1.unite_tokens or {}) do
		local var_68_4 = require("app.view.module.uniteToken.model.UniteTokenStructData").new(iter_68_3.base_id)

		var_68_4:updateByNetData(iter_68_3)

		var_68_3[var_68_4:getServerId()] = var_68_4
	end

	local var_68_5 = arg_68_1.pets or {}

	for iter_68_4, iter_68_5 in ipairs(var_68_5) do
		local var_68_6 = PetStruct.new(g.core.config.pet_info.get(iter_68_5.base_id).advance_id)

		var_68_6:setServerData(iter_68_5)
		var_68_6:setLineupPos(0)

		var_68_5[var_68_6:getSid()] = var_68_6
	end

	local var_68_7 = {}

	for iter_68_6, iter_68_7 in ipairs(arg_68_1.knights or {}) do
		local var_68_8 = require("app.view.module.knight.model.SpecialKnightStruct").new(iter_68_7.base_id)

		var_68_8:setInfo(iter_68_7)

		var_68_7[var_68_8:getServerId()] = var_68_8
	end

	for iter_68_8, iter_68_9 in ipairs(arg_68_1.fog_seals or {}) do
		var_68_7[iter_68_9.knight_id]:setDevelopStruct(require("app.view.module.fogNightmare.model.struct.FogNightmareKeepsakeStruct").new(iter_68_9.seal_level_id), var_0_2.KNIGHT_DEVELOP_KEY.KEEPSAKE)
	end

	local var_68_9 = {}

	for iter_68_10, iter_68_11 in ipairs(arg_68_1.precious_suits or {}) do
		local var_68_10 = PreciousSuitStruct.new()

		var_68_10:setServerData(iter_68_11)

		var_68_9[var_68_10:getSuitGroup()] = var_68_10
	end

	local var_68_11 = {}

	for iter_68_12, iter_68_13 in ipairs(arg_68_1.succubaes or {}) do
		local var_68_12 = SuccubaStruct.new({
			id = iter_68_13.base_id
		})

		var_68_12:updateSvrInfo(iter_68_13)

		var_68_11[var_68_12:getSid()] = var_68_12
	end

	for iter_68_14, iter_68_15 in ipairs(arg_68_1.formations) do
		local var_68_13 = SpecialFormationStruct.new()

		self:_updateFormationStructByNetInfo(var_68_13, iter_68_15, var_68_0, var_68_3, var_68_7)

		for iter_68_16, iter_68_17 in ipairs(iter_68_15.pet_id or {}) do
			var_68_13:setPet(var_68_5[iter_68_17], iter_68_16)
		end

		for iter_68_18, iter_68_19 in ipairs(iter_68_15.precious_suits or {}) do
			var_68_13:setOtherUserSuit(iter_68_18, var_68_9[iter_68_19])
		end

		for iter_68_20, iter_68_21 in ipairs(iter_68_15.succuba_id or {}) do
			var_68_13:setOtherUserSuccuba(iter_68_20, var_68_11[iter_68_21])
		end

		if var_68_13:getKnightsNum() ~= 0 then
			var_68_13:setFormationIdx(iter_68_14)

			self._otherFormationData[#self._otherFormationData + 1] = var_68_13
		end
	end
end

function FogNightmareFormationData:getOtherFormationData()
	return self._otherFormationData
end

function FogNightmareFormationData:_updateFormationStructByNetInfo(arg_70_1, arg_70_2, arg_70_3, arg_70_4, arg_70_5)
	local var_70_0 = arg_70_2.artifact_id or {}

	for iter_70_0, iter_70_1 in ipairs(arg_70_2.position) do
		if arg_70_2.knight_id[iter_70_0] and arg_70_2.knight_id[iter_70_0] ~= 0 then
			if arg_70_5[arg_70_2.knight_id[iter_70_0]] then
				arg_70_1:setKnight(arg_70_5[arg_70_2.knight_id[iter_70_0]], iter_70_1)
				arg_70_5[arg_70_2.knight_id[iter_70_0]]:updatePos(iter_70_1)

				if var_70_0[iter_70_0] and var_70_0[iter_70_0] > 0 then
					arg_70_5[arg_70_2.knight_id[iter_70_0]]:setDevelopStruct(arg_70_3[var_70_0[iter_70_0]], var_0_2.KNIGHT_DEVELOP_KEY.ARTIFACT)
				else
					arg_70_5[arg_70_2.knight_id[iter_70_0]]:setDevelopStruct(nil, var_0_2.KNIGHT_DEVELOP_KEY.ARTIFACT)
				end
			end
		else
			arg_70_1:setKnight(nil, iter_70_1)
		end
	end

	for iter_70_2, iter_70_3 in ipairs(arg_70_2.unite_token_id or {}) do
		arg_70_1:setUniteToken(arg_70_4[iter_70_3], iter_70_2)
	end

	arg_70_1:checkGroupHalo()
end

function FogNightmareFormationData:getFormationFightValue(arg_71_1, arg_71_2)
	local var_71_0 = self._formationFightValueList[arg_71_1]

	if self._tempFormations[arg_71_1] and arg_71_2 then
		var_71_0 = self:_updateFormationFightValue(self._tempFormations[arg_71_1])
		self._formationFightValueList[arg_71_1] = var_71_0
	end

	return var_71_0 or 0
end

function FogNightmareFormationData:debugGetKnightFightValue(arg_72_1)
	return self._debugKnightFightValueList[arg_72_1]
end

function FogNightmareFormationData:checkTheNumOfKnightAvailableOfBattle(arg_73_1)
	local var_73_0 = g.core.model.User.fogNightmareData:getMaxKnightNum()

	if g.core.model.User.fogNightmareData:getAssistantData():getSelfUseHelperCount() < 1 then
		var_73_0 = var_73_0 - 1
	end

	if var_73_0 > #self._memberPool.knights then
		return
	end

	local var_73_1 = true
	local var_73_2 = 0

	for iter_73_0, iter_73_1 in ipairs(self._memberPool.knights) do
		local var_73_3 = iter_73_1:getServerId()
		local var_73_4 = iter_73_1:isDead()

		if not var_73_4 and not iter_73_1:isLineup() then
			var_73_1 = false

			break
		elseif not var_73_4 and not self._usedKnightMap[var_73_3] then
			var_73_2 = var_73_2 + 1
		end
	end

	return var_73_1 and var_73_2 < arg_73_1
end

function FogNightmareFormationData:getStageSkipFormation()
	return (g.core.common.Storage:load("fogNightmare_skip_formation.json", true) or {
		isSkip = false
	}).isSkip
end

function FogNightmareFormationData:setStageSkipFormation(arg_75_1)
	g.core.common.Storage:save("fogNightmare_skip_formation.json", {
		isSkip = arg_75_1
	}, true)
end

function FogNightmareFormationData:getStageSkipChallenge()
	return self._skipChallengeBtnVisible and (g.core.common.Storage:load("fogNightmare_skip_challenge.json", true) or {
		isSkip = false
	}).isSkip
end

function FogNightmareFormationData:setStageSkipChallengeBtnVisible(arg_77_1)
	self._skipChallengeBtnVisible = arg_77_1
end

function FogNightmareFormationData:setStageSkipChallenge(arg_78_1)
	g.core.common.Storage:save("fogNightmare_skip_challenge.json", {
		isSkip = arg_78_1
	}, true)
end

function FogNightmareFormationData:checkCanSkipFormation()
	local var_79_0 = g.core.model.User.fogNightmareData:getTowerData():getCurFloorStruct()
	local var_79_1 = false

	if not var_79_0 or #var_79_0:getSelectedStage() < 1 then
		var_79_1 = true
	else
		local var_79_2 = var_79_0:getSelectedStage()[1]
		local var_79_3 = var_79_2:getTempSelectWave()

		if var_0_2.WAVE_EFFECT_TYPE.MONSTER_BOSS >= var_79_2:getAllWave()[var_79_3]:getType() then
			local var_79_4 = self:getLineUpFormation(var_79_3)

			if var_79_4 then
				var_79_1 = var_79_4:getKnightsNum() == var_0_2.FORMATION_TIP_COUNT
			end
		end
	end

	return var_79_1
end

function FogNightmareFormationData:isPreciousSuitLineup(arg_80_1)
	for iter_80_0, iter_80_1 in pairs(self._tempFormations) do
		if iter_80_1:isPreciousSuitLineUp(arg_80_1) then
			return true
		end
	end

	return false
end

function FogNightmareFormationData:getFormationStructPreciousSuitLineup(arg_81_1)
	for iter_81_0, iter_81_1 in pairs(self._tempFormations) do
		if iter_81_1:isPreciousSuitLineUp(arg_81_1) then
			return iter_81_1
		end
	end

	return nil
end

function FogNightmareFormationData:isSuccubaLineup(arg_82_1)
	for iter_82_0, iter_82_1 in pairs(self._tempFormations) do
		if iter_82_1:isSuccubaLineUp(arg_82_1) then
			return true
		end
	end

	return false
end

function FogNightmareFormationData:getFormationStructSuccubaLineup(arg_83_1)
	for iter_83_0, iter_83_1 in pairs(self._tempFormations) do
		if iter_83_1:isSuccubaLineUp(arg_83_1) then
			return iter_83_1
		end
	end

	return nil
end

function FogNightmareFormationData:isNeedSyncPoolMemberFight(arg_84_1)
	return not self._syncStageIdDic[arg_84_1]
end

function FogNightmareFormationData:syncPoolMemberFight(arg_85_1)
	local var_85_0 = {}

	for iter_85_0, iter_85_1 in ipairs(self._memberPool.knights) do
		var_85_0[#var_85_0 + 1] = iter_85_1:getServerId()
	end

	g.core.network.GameNetProxy:send_C2S_Knight_GetFightValue({
		ids = var_85_0
	})

	self._syncStageIdDic[arg_85_1] = true
end

function FogNightmareFormationData:clearSyncStage(arg_86_1)
	self._syncStageIdDic[arg_86_1] = nil
end

return FogNightmareFormationData
