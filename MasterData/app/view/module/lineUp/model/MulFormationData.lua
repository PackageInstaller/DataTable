local var_0_0 = g.core.const.ConstMgr.LineUpConst
local var_0_1 = g.core.const.ConstMgr.LineUpConst.MulTeamType
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_3 = g.core.common.ModuleUnlock
local MulFormationStruct = import(".MulFormationStruct")
local MulFormationData = class("MulFormationData")

function MulFormationData:ctor()
	self:initData()
end

function MulFormationData:initData()
	self._formation2DDict = {}
	self._lastSaveSyncTime = 0
end

function MulFormationData:onS2CFormationGet(arg_3_1)
	self:_parseSvrFormationArr(arg_3_1.formations)
end

function MulFormationData:onS2CFormationSaveSuccess(arg_4_1)
	self:_parseSvrFormationArr(arg_4_1.formations)
end

function MulFormationData:onS2CFormationSaveFailed(arg_5_1)
	if not arg_5_1.formations then
		return
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.formations) do
		local var_5_0 = self:getFormationStruct(iter_5_1.tp, iter_5_1.seq)

		if var_5_0 then
			var_5_0:resetFormation()
		end
	end
end

function MulFormationData:onS2CFormationFightValue(arg_6_1)
	local var_6_0 = self:getFormationStruct(arg_6_1.tp, arg_6_1.seq)

	if var_6_0 then
		var_6_0:setFightValue(arg_6_1.fight_value or 0)
	end
end

function MulFormationData:_parseSvrFormationArr(arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		var_7_0 = iter_7_1.tp

		local var_7_1 = self:getFormationStruct(iter_7_1.tp, iter_7_1.seq)

		if var_7_1 then
			var_7_1:setSvrData(iter_7_1)
		end
	end

	if var_7_0 == var_0_0.MulTeamType.BLAZING_ARENA then
		g.core.model.User.blazingArenaData:checkAndRemoveLineOffHelpMembers()
	end
end

function MulFormationData:getFormationStruct(arg_8_1, arg_8_2)
	if not arg_8_1 or not arg_8_2 then
		g.core.log:error("---------         Error! GetFormationStruct formationType or index is nil :", tostring(arg_8_1), tostring(arg_8_2))

		return
	elseif arg_8_2 < 1 then
		g.core.log:error("---------         Error! GetFormationStruct index is invalid :", tostring(arg_8_2))

		return
	elseif arg_8_1 == var_0_0.MulTeamType.EXPLORATION then
		return g.core.model.User.explorationData:getFormationData():getFormationStruct(arg_8_2)
	elseif arg_8_1 == var_0_0.MulTeamType.TEAM_BATTLE then
		g.core.model.User.teamBattleData:getFormationData():getFormationStruct(arg_8_2)
	elseif arg_8_1 == var_0_0.MulTeamType.GVE then
		return g.core.model.User.gveDataMgr:getGveFormationData():getFormationStruct(arg_8_2)
	end

	local var_8_0 = self._formation2DDict[arg_8_1]

	if not self._formation2DDict[arg_8_1] then
		if table.keyof(var_0_1, arg_8_1) then
			var_8_0 = {}
			self._formation2DDict[arg_8_1] = var_8_0
		else
			g.core.log:error("---------         Error! GetFormationStruct formationType is invalid :", tostring(arg_8_1))

			return
		end
	end

	local var_8_1 = var_8_0[arg_8_2]

	if not var_8_0[arg_8_2] then
		var_8_1 = MulFormationStruct.new(arg_8_1, arg_8_2)
		var_8_0[arg_8_2] = var_8_1

		if arg_8_1 == var_0_0.MulTeamType.BLAZING_ARENA then
			var_8_1:setAdvanceIdEnable(true)
			var_8_1:setLimitKnightNum(arg_8_2)
			var_8_1:setLimitUpUniteTokenCnt(arg_8_2)
			var_8_1:setLimitUpPetCnt(arg_8_2)
		elseif arg_8_1 == var_0_0.MulTeamType.ANCIENTS then
			var_8_1:setMinKnightCnt(1)
		end
	end

	return var_8_1
end

function MulFormationData:getFormationStructDict(arg_9_1)
	if arg_9_1 == var_0_0.MulTeamType.EXPLORATION then
		return g.core.model.User.explorationData:getFormationData():getFormationStructDict()
	elseif arg_9_1 == var_0_0.MulTeamType.TEAM_BATTLE then
		g.core.model.User.teamBattleData:getFormationData():getFormationStructDict()
	elseif arg_9_1 == var_0_0.MulTeamType.GVE then
		return g.core.model.User.gveDataMgr:getGveFormationData():getFormationStructDict()
	end

	return self._formation2DDict[arg_9_1] or {}
end

function MulFormationData:resetFormationStruct(arg_10_1)
	for iter_10_0, iter_10_1 in pairs((self:getFormationStructDict(arg_10_1))) do
		iter_10_1:resetFormation()
	end
end

function MulFormationData:getOutBaseFormationArr(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs((self:getFormationStructDict(arg_11_1))) do
		table.insert(var_11_0, (iter_11_1:toOutBaseFormation()))
	end

	return var_11_0
end

function MulFormationData:isInitWithSvrData(arg_12_1)
	for iter_12_0, iter_12_1 in pairs((self:getFormationStructDict(arg_12_1))) do
		if iter_12_1:isInitWithSvrData() then
			return true
		end
	end

	return false
end

function MulFormationData:isKnightLineup(arg_13_1, arg_13_2)
	return checkbool((self:getFormationStructKnightLineup(arg_13_1, arg_13_2)))
end

function MulFormationData:isArtifactLineup(arg_14_1, arg_14_2)
	return checkbool((self:getFormationStructArtifactLineup(arg_14_1, arg_14_2)))
end

function MulFormationData:isPetLineup(arg_15_1, arg_15_2, arg_15_3)
	return checkbool(arg_15_3 and self:getFormationStructPetLineupWithAdvanceId(arg_15_1, arg_15_3) or self:getFormationStructPetLineup(arg_15_1, arg_15_2))
end

function MulFormationData:isUniteTokenLineup(arg_16_1, arg_16_2)
	return checkbool((self:getFormationStructUniteTokenLineup(arg_16_1, arg_16_2)))
end

function MulFormationData:isPreciousSuitLineup(arg_17_1, arg_17_2)
	return checkbool((self:getFormationStructPreciousSuitLineup(arg_17_1, arg_17_2)))
end

function MulFormationData:isSuccubaLineUp(arg_18_1, arg_18_2)
	return checkbool((self:getFormationStructSuccubaLineup(arg_18_1, arg_18_2)))
end

function MulFormationData:getFormationStructKnightLineup(arg_19_1, arg_19_2)
	for iter_19_0, iter_19_1 in pairs((self:getFormationStructDict(arg_19_1))) do
		if iter_19_1:isKnightLineUp(arg_19_2) then
			return iter_19_1
		end
	end
end

function MulFormationData:getFormationStructArtifactLineup(arg_20_1, arg_20_2)
	for iter_20_0, iter_20_1 in pairs((self:getFormationStructDict(arg_20_1))) do
		if iter_20_1:isArtifactLineUp(arg_20_2) then
			return iter_20_1
		end
	end
end

function MulFormationData:getFormationStructPetLineup(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = self:getFormationStructDict(arg_21_1)

	if arg_21_3 then
		for iter_21_0, iter_21_1 in pairs(var_21_0) do
			if iter_21_1:isPetLineUpByAdvanceId(arg_21_3) then
				return iter_21_1
			end
		end
	else
		for iter_21_2, iter_21_3 in pairs(var_21_0) do
			if iter_21_3:isPetLineUp(arg_21_2) then
				return iter_21_3
			end
		end
	end
end

function MulFormationData:getFormationStructPetLineupWithAdvanceId(arg_22_1, arg_22_2)
	for iter_22_0, iter_22_1 in pairs((self:getFormationStructDict(arg_22_1))) do
		if iter_22_1:isPetLineUpByAdvanceId(arg_22_2) then
			return iter_22_1
		end
	end
end

function MulFormationData:getFormationStructUniteTokenLineup(arg_23_1, arg_23_2)
	for iter_23_0, iter_23_1 in pairs((self:getFormationStructDict(arg_23_1))) do
		if iter_23_1:isUniteTokenLineUp(arg_23_2) then
			return iter_23_1
		end
	end
end

function MulFormationData:getFormationStructPreciousSuitLineup(arg_24_1, arg_24_2)
	for iter_24_0, iter_24_1 in pairs((self:getFormationStructDict(arg_24_1))) do
		if iter_24_1:isPreciousSuitLineUp(arg_24_2) then
			return iter_24_1
		end
	end
end

function MulFormationData:getFormationStructSuccubaLineup(arg_25_1, arg_25_2)
	for iter_25_0, iter_25_1 in pairs((self:getFormationStructDict(arg_25_1))) do
		if iter_25_1:isSuccubaLineUp(arg_25_2) then
			return iter_25_1
		end
	end
end

function MulFormationData:replaceAllKnights(arg_26_1, arg_26_2)
	local var_26_0 = arg_26_1:getFormationType()

	for iter_26_0, iter_26_1 in pairs(arg_26_2) do
		local var_26_1 = self:getFormationStructKnightLineup(var_26_0, iter_26_1)

		if var_26_1 and var_26_1 ~= arg_26_1 then
			var_26_1:takeOffKnight(iter_26_1)
		end
	end

	arg_26_1:replaceAllKnights(arg_26_2)
end

function MulFormationData:isModified(arg_27_1)
	for iter_27_0, iter_27_1 in pairs((self:getFormationStructDict(arg_27_1))) do
		if iter_27_1:isModified() then
			return true
		end
	end

	return false
end

function MulFormationData:hasHigherKnightQualityByParam(arg_28_1)
	local var_28_0 = arg_28_1.group or 0
	local var_28_1 = arg_28_1.formationType
	local var_28_2 = self:_getMaxCanLineupKnightQuality(arg_28_1.formationType, var_28_0)

	if var_28_2 == -1 then
		return false
	end

	if arg_28_1.formationIndex then
		local var_28_3 = self:getFormationStruct(var_28_1, arg_28_1.formationIndex)

		if var_28_3 then
			if arg_28_1.pos then
				return self:_hasHigherKnightQualityInFormation(var_28_3, var_28_2, arg_28_1.pos, var_28_0)
			else
				for iter_28_0 = 1, var_0_0.MAX_KNIGHT_NUM do
					if self:_hasHigherKnightQualityInFormation(var_28_3, var_28_2, iter_28_0, var_28_0) then
						return true
					end
				end
			end
		end
	else
		for iter_28_1, iter_28_2 in pairs(self:getFormationStructDict(var_28_1)) do
			if self:_hasHigherKnightQualityInFormation(iter_28_2, var_28_2, nil, var_28_0) then
				return true
			end
		end
	end

	return false
end

function MulFormationData:_hasHigherKnightQualityInFormation(arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	local var_29_0 = arg_29_1:getKnightDict()

	for iter_29_0, iter_29_1 in pairs(var_29_0) do
		if iter_29_1 then
			-- block empty
		end
	end

	if arg_29_3 then
		if not arg_29_1:canLineUpKnight(arg_29_3) then
			return false
		end

		if not var_29_0[arg_29_3] or arg_29_2 > var_29_0[arg_29_3]:getQuality() then
			return true
		end
	else
		for iter_29_2 = 1, var_0_0.MAX_KNIGHT_NUM do
			if arg_29_1:canLineUpKnight(iter_29_2) and (not var_29_0[iter_29_2] or arg_29_2 > var_29_0[iter_29_2]:getQuality()) then
				return true
			end
		end
	end

	return false
end

function MulFormationData:_getMaxCanLineupKnightQuality(arg_30_1, arg_30_2)
	local var_30_0 = g.core.model.User.knightsData:getKnightListByParams({
		group = arg_30_2
	}, true)

	table.sort(var_30_0, function(arg_31_0, arg_31_1)
		return arg_31_0:getQuality() > arg_31_1:getQuality()
	end)

	for iter_30_0, iter_30_1 in ipairs(var_30_0) do
		if not self:isKnightLineup(arg_30_1, iter_30_1:getServerId()) then
			return iter_30_1:getQuality()
		end
	end

	return -1
end

function MulFormationData:hasHigherArtifactQualityByParam(arg_32_1)
	if arg_32_1.formationIndex then
		local var_32_0 = self:getFormationStruct(arg_32_1.formationType, arg_32_1.formationIndex)

		if var_32_0 then
			if arg_32_1.pos then
				return self:_hasHigherArtifactQualityInFormation(var_32_0, arg_32_1.pos)
			else
				for iter_32_0 = 1, var_0_0.MAX_KNIGHT_NUM do
					if self:_hasHigherArtifactQualityInFormation(var_32_0, iter_32_0) then
						return true
					end
				end
			end
		end
	else
		for iter_32_1, iter_32_2 in pairs(self:getFormationStructDict(arg_32_1.formationType)) do
			if self:_hasHigherArtifactQualityInFormation(iter_32_2) then
				return true
			end
		end
	end

	return false
end

function MulFormationData:_hasHigherArtifactQualityInFormation(arg_33_1, arg_33_2)
	local var_33_0 = arg_33_1:getArtifactSidArr()

	if arg_33_2 then
		if var_33_0[arg_33_2] > 0 then
			local var_33_1 = self:_getMaxCanLineupArtifactQuality(arg_33_1:getFormationType(), var_33_0[arg_33_2], arg_33_2)

			if var_33_1 == -1 then
				return false
			end

			return var_33_1 > g.core.model.User.artifactData:getArtifactBySid(var_33_0[arg_33_2]):getQuality()
		elseif arg_33_1:getKnightSid(arg_33_2) > 0 then
			local var_33_2 = arg_33_1:getKnightDict()[arg_33_2]

			for iter_33_0, iter_33_1 in ipairs((g.core.model.User.artifactData:getOwnArtifactList(true))) do
				if iter_33_1:checkWearKnight(var_33_2:getAdvanceId()) and not self:isArtifactLineup(arg_33_1:getFormationType(), iter_33_1:getServerOnlyId()) then
					return true
				end
			end
		else
			return false
		end
	else
		for iter_33_2, iter_33_3 in pairs(var_33_0) do
			if iter_33_3 > 0 then
				local var_33_3 = g.core.model.User.artifactData:getArtifactBySid(iter_33_3)
				local var_33_4 = self:_getMaxCanLineupArtifactQuality(arg_33_1:getFormationType(), iter_33_3, iter_33_2)

				if var_33_4 == -1 then
					return false
				end

				if var_33_3 and var_33_4 > var_33_3:getQuality() then
					return true
				end
			elseif arg_33_1:getKnightSid(iter_33_2) > 0 then
				local var_33_5 = arg_33_1:getKnightDict()[iter_33_2]

				for iter_33_4, iter_33_5 in ipairs((g.core.model.User.artifactData:getOwnArtifactList(true))) do
					if iter_33_5:checkWearKnight(var_33_5:getAdvanceId()) and not self:isArtifactLineup(arg_33_1:getFormationType(), iter_33_5:getServerOnlyId()) then
						return true
					end
				end
			end
		end
	end

	return false
end

function MulFormationData:_getMaxCanLineupArtifactQuality(arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = g.core.model.User.artifactData:getOwnArtifactList(true)

	table.sort(var_34_0, function(arg_35_0, arg_35_1)
		return arg_35_0:getQuality() > arg_35_1:getQuality()
	end)

	local var_34_1 = self:getFormationStructArtifactLineup(arg_34_1, arg_34_2):getKnightDict()[arg_34_3]

	if not var_34_1 then
		return -1
	end

	for iter_34_0, iter_34_1 in ipairs(var_34_0) do
		if iter_34_1:checkWearKnight(var_34_1:getAdvanceId()) and not self:isArtifactLineup(arg_34_1, iter_34_1:getServerOnlyId()) then
			return iter_34_1:getQuality()
		end
	end

	return -1
end

function MulFormationData:hasHigherUniteQualityByParam(arg_36_1)
	local var_36_0 = self:_getMaxCanLineupUnityQuality(arg_36_1.formationType)

	if var_36_0 == -1 then
		return false
	end

	if arg_36_1.formationIndex then
		local var_36_1 = self:getFormationStruct(arg_36_1.formationType, arg_36_1.formationIndex)

		if var_36_1 then
			if arg_36_1.pos then
				return self:_hasHigherUniteQualityInFormation(var_36_1, var_36_0, arg_36_1.pos)
			else
				for iter_36_0 = 1, var_0_0.MAX_UNITE_TOKEN_NUM do
					if self:_hasHigherUniteQualityInFormation(var_36_1, var_36_0, iter_36_0) then
						return true
					end
				end
			end
		end
	else
		for iter_36_1, iter_36_2 in pairs(self:getFormationStructDict(arg_36_1.formationType)) do
			if self:_hasHigherUniteQualityInFormation(iter_36_2, var_36_0) then
				return true
			end
		end
	end

	return false
end

function MulFormationData:_hasHigherUniteQualityInFormation(arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = arg_37_1:getUniteTokenSidArr()
	local var_37_1 = 0
	local var_37_2 = self:getAllLineUpUnite(arg_37_1:getFormationType(), {
		offLine = true,
		judgeLimitNum = true
	})
	local var_37_3 = #var_37_2

	if arg_37_1:getFormationType() == var_0_0.MulTeamType.BLAZING_ARENA then
		var_37_3 = 0

		for iter_37_0, iter_37_1 in ipairs(var_37_2) do
			var_37_3 = var_37_3 + #iter_37_1
		end
	end

	for iter_37_2, iter_37_3 in ipairs(var_37_0) do
		if iter_37_3 > 0 then
			var_37_1 = var_37_1 + 1
		end
	end

	if arg_37_3 then
		if not arg_37_1:canLineUpUniteToken(arg_37_3) then
			return
		end

		if var_37_0[arg_37_3] > 0 then
			return arg_37_2 > self:getUniteTokenBySid(arg_37_1:getFormationType(), var_37_0[arg_37_3]):getQuality()
		elseif var_37_1 < var_37_3 then
			return true
		end
	else
		local var_37_4 = arg_37_1:canLineUpUniteToken(arg_37_3)

		for iter_37_4, iter_37_5 in pairs(var_37_0) do
			if iter_37_5 > 0 then
				local var_37_5 = self:getUniteTokenBySid(arg_37_1:getFormationType(), iter_37_5)

				if var_37_4 and var_37_5 and arg_37_2 > var_37_5:getQuality() then
					return true
				end
			elseif var_37_4 and var_37_1 < #g.core.model.User.uniteTokenData:getOwnTokenList() then
				return true
			end
		end
	end

	return false
end

function MulFormationData:_getMaxCanLineupUnityQuality(arg_38_1)
	local var_38_0 = self:getAllLineUpUnite(arg_38_1, {
		offLine = true,
		judgeLimitNum = true
	})

	if arg_38_1 == var_0_0.MulTeamType.BLAZING_ARENA then
		local var_38_1 = -1

		for iter_38_0, iter_38_1 in ipairs(var_38_0) do
			for iter_38_2, iter_38_3 in ipairs(iter_38_1) do
				if not self:isUniteTokenLineup(arg_38_1, iter_38_3:getAdvanceId()) and var_38_1 < iter_38_3:getQuality() then
					var_38_1 = iter_38_3:getQuality()
				end
			end
		end

		return var_38_1
	end

	table.sort(var_38_0, function(arg_39_0, arg_39_1)
		return arg_39_0:getQuality() > arg_39_1:getQuality()
	end)

	for iter_38_4, iter_38_5 in ipairs(var_38_0) do
		if not self:isUniteTokenLineup(arg_38_1, iter_38_5:getAdvanceId()) then
			return iter_38_5:getQuality()
		end
	end

	return -1
end

function MulFormationData:hasHigherPetQualityByParam(arg_40_1)
	local var_40_0 = self:_getMaxCanLineupPetQuality(arg_40_1.formationType)

	if var_40_0 == -1 then
		return false
	end

	if arg_40_1.formationIndex then
		local var_40_1 = self:getFormationStruct(arg_40_1.formationType, arg_40_1.formationIndex)

		if var_40_1 then
			if arg_40_1.pos then
				return self:_hasHigherPetQualityInFormation(var_40_1, var_40_0, arg_40_1.pos)
			else
				for iter_40_0 = 1, var_0_0.MAX_PEN_NUM do
					if var_0_3:isModuleUnlock(var_0_2["PET_LINE_UP_" .. iter_40_0]) and self:_hasHigherPetQualityInFormation(var_40_1, var_40_0, iter_40_0) then
						return true
					end
				end
			end
		end
	else
		for iter_40_1, iter_40_2 in pairs(self:getFormationStructDict(arg_40_1.formationType)) do
			if self:_hasHigherPetQualityInFormation(iter_40_2, var_40_0) then
				return true
			end
		end
	end

	return false
end

function MulFormationData:_hasHigherPetQualityInFormation(arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = arg_41_1:getPetSidArr()
	local var_41_1 = 0

	for iter_41_0, iter_41_1 in ipairs(var_41_0) do
		if iter_41_1 > 0 then
			var_41_1 = var_41_1 + 1
		end
	end

	if arg_41_3 then
		if not arg_41_1:canLineUpPet(arg_41_3) then
			return
		end

		local var_41_2 = var_41_0[arg_41_3]
		local var_41_3 = self:getAllLineUpPet(arg_41_1:getFormationType(), {
			offLine = true,
			judgeLimitNum = true
		})
		local var_41_4 = #var_41_3

		if arg_41_1:getFormationType() == var_0_0.MulTeamType.BLAZING_ARENA then
			var_41_4 = 0

			for iter_41_2, iter_41_3 in ipairs(var_41_3) do
				var_41_4 = var_41_4 + #iter_41_3
			end
		end

		if var_41_2 > 0 then
			return arg_41_2 > self:getPetBySid(arg_41_1:getFormationType(), var_41_2):getQuality()
		elseif var_41_1 < var_41_4 then
			return true
		end
	else
		for iter_41_4, iter_41_5 in pairs(var_41_0) do
			local var_41_5 = arg_41_1:canLineUpPet(iter_41_4)

			if iter_41_5 > 0 then
				local var_41_6 = self:getPetBySid(arg_41_1:getFormationType(), iter_41_5)

				if var_41_5 and var_41_6 and arg_41_2 > var_41_6:getQuality() then
					return true
				end
			elseif var_41_5 and var_0_3:isModuleUnlock(var_0_2["PET_LINE_UP_" .. iter_41_4]) and var_41_1 < #g.core.model.User.petsData:getOwnPetArr() then
				return true
			end
		end
	end

	return false
end

function MulFormationData:_getMaxCanLineupPetQuality(arg_42_1)
	local var_42_0 = self:getAllLineUpPet(arg_42_1, {
		offLine = true,
		judgeLimitNum = true
	})

	if arg_42_1 == var_0_0.MulTeamType.BLAZING_ARENA then
		local var_42_1 = -1

		for iter_42_0, iter_42_1 in ipairs(var_42_0) do
			for iter_42_2, iter_42_3 in ipairs(iter_42_1) do
				if not self:isPetLineup(arg_42_1, iter_42_3:getSid(), iter_42_3:getCfg().advance_id) and var_42_1 < iter_42_3:getQuality() then
					var_42_1 = iter_42_3:getQuality()
				end
			end
		end

		return var_42_1
	end

	table.sort(var_42_0, function(arg_43_0, arg_43_1)
		return arg_43_0:getQuality() > arg_43_1:getQuality()
	end)

	for iter_42_4, iter_42_5 in ipairs(var_42_0) do
		if not self:isPetLineup(arg_42_1, iter_42_5:getSid()) then
			return iter_42_5:getQuality()
		end
	end

	return -1
end

function MulFormationData:hasHigherSuccubaQualityByParam(arg_44_1)
	local var_44_0 = self:_getMaxCanLineupSuccubaQuality(arg_44_1.formationType)

	if var_44_0 == -1 then
		return false
	end

	if arg_44_1.formationIndex then
		local var_44_1 = self:getFormationStruct(arg_44_1.formationType, arg_44_1.formationIndex)

		if var_44_1 then
			if arg_44_1.pos then
				return self:_hasHigherSuccubaQualityInFormation(var_44_1, var_44_0, arg_44_1.pos)
			else
				for iter_44_0 = 1, var_0_0.MAX_PEN_NUM do
					if self:_hasHigherSuccubaQualityInFormation(var_44_1, var_44_0, iter_44_0) then
						return true
					end
				end
			end
		end
	else
		for iter_44_1, iter_44_2 in pairs(self:getFormationStructDict(arg_44_1.formationType)) do
			if self:_hasHigherSuccubaQualityInFormation(iter_44_2, var_44_0) then
				return true
			end
		end
	end

	return false
end

function MulFormationData:_hasHigherSuccubaQualityInFormation(arg_45_1, arg_45_2, arg_45_3)
	local var_45_0 = arg_45_1:getSuccubaSidArr()
	local var_45_1 = g.core.model.User.succubaData:getSuccubaList()
	local var_45_2 = 0

	for iter_45_0, iter_45_1 in ipairs(var_45_0) do
		if iter_45_1 > 0 then
			var_45_2 = var_45_2 + 1
		end
	end

	if arg_45_3 then
		if not arg_45_1:canLineUpSuccuba(arg_45_3) then
			return
		end

		if var_45_0[arg_45_3] > 0 then
			return arg_45_2 > g.core.model.User.succubaData:getSuccubaBySid(var_45_0[arg_45_3]):getQuality()
		elseif var_45_2 < #var_45_1 then
			return true
		end
	else
		for iter_45_2, iter_45_3 in pairs(var_45_0) do
			local var_45_3 = arg_45_1:canLineUpSuccuba(iter_45_2)

			if iter_45_3 > 0 then
				local var_45_4 = g.core.model.User.succubaData:getSuccubaBySid(iter_45_3)

				if var_45_3 and var_45_4 and arg_45_2 > var_45_4:getQuality() then
					return true
				end
			elseif var_45_3 and var_45_2 < #var_45_1 then
				return true
			end
		end
	end

	return false
end

function MulFormationData:_getMaxCanLineupSuccubaQuality(arg_46_1)
	local var_46_0 = g.core.model.User.succubaData:getSuccubaList()

	table.sort(var_46_0, function(arg_47_0, arg_47_1)
		return arg_47_0:getQuality() > arg_47_1:getQuality()
	end)

	for iter_46_0, iter_46_1 in ipairs(var_46_0) do
		if not self:isSuccubaLineUp(arg_46_1, iter_46_1:getSid()) then
			return iter_46_1:getQuality()
		end
	end

	return -1
end

function MulFormationData:setLastSyncTime(arg_48_1)
	self._lastSaveSyncTime = arg_48_1
end

function MulFormationData:getLastSyncTime()
	return self._lastSaveSyncTime
end

function MulFormationData:getAllLineUpKnight(arg_50_1, arg_50_2)
	return (g.core.model.User.knightsData:getKnightListByParams(arg_50_2, true))
end

function MulFormationData:getAllLineUpUnite(arg_51_1, arg_51_2)
	local var_51_0 = g.core.model.User.uniteTokenData:getOwnTokenList()

	if arg_51_1 == var_0_0.MulTeamType.BLAZING_ARENA then
		var_51_0 = {
			var_51_0,
			(g.core.model.User.blazingArenaData:getWaitHelpMembers(g.core.common.Goods.TYPE_UNITETOKEN, arg_51_2))
		}
	end

	return var_51_0
end

function MulFormationData:getAllLineUpArtifact(arg_52_1, arg_52_2)
	if arg_52_1 == var_0_0.MulTeamType.BLAZING_ARENA then
		return g.core.model.User.artifactData:getOwnArtifactList()
	else
		return g.core.model.User.artifactData:getOwnArtifactList()
	end
end

function MulFormationData:getAllLineUpPet(arg_53_1, arg_53_2)
	local var_53_0 = g.core.model.User.petsData:getOwnPetArr()

	if arg_53_1 == var_0_0.MulTeamType.BLAZING_ARENA then
		var_53_0 = {
			var_53_0,
			(g.core.model.User.blazingArenaData:getWaitHelpMembers(g.core.common.Goods.TYPE_PET, arg_53_2))
		}
	end

	return var_53_0
end

function MulFormationData:getAllLineUpSuccuba(arg_54_1, arg_54_2)
	return g.core.model.User.succubaData:getSuccubaList()
end

function MulFormationData:getPetBySid(arg_55_1, arg_55_2)
	local var_55_0
	local var_55_1 = false

	if arg_55_1 == var_0_0.MulTeamType.BLAZING_ARENA then
		var_55_0 = g.core.model.User.blazingArenaData:getHelpMemberWithServerId(g.core.common.Goods.TYPE_PET, arg_55_2)
	end

	if not var_55_0 then
		var_55_0 = g.core.model.User.petsData:getPetBySid(arg_55_2)
		var_55_1 = true
	end

	return var_55_0, var_55_1
end

function MulFormationData:getUniteTokenBySid(arg_56_1, arg_56_2)
	local var_56_0

	if arg_56_1 == var_0_0.MulTeamType.BLAZING_ARENA then
		var_56_0 = g.core.model.User.blazingArenaData:getHelpMemberWithServerId(g.core.common.Goods.TYPE_UNITETOKEN, arg_56_2)
	end

	var_56_0 = var_56_0 or g.core.model.User.uniteTokenData:getTokenByServerId(arg_56_2)

	return var_56_0
end

return MulFormationData
