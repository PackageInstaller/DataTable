local var_0_0 = g.core.common.ModuleUnlock
local var_0_1 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_2 = g.core.config.multi_team_formation_info
local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local var_0_4 = g.core.const.ConstMgr.LineUpConst
local var_0_5 = g.core.config.knight_info
local var_0_6 = g.core.config.exploration_shop_item_value_info
local TeamBattleFormationStruct = require("app.view.module.teamBattle.model.struct.TeamBattleFormationStruct")
local TeamBattleKnightStruct = require("app.view.module.teamBattle.model.struct.TeamBattleKnightStruct")
local var_0_9 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_10 = g.core.config.team_battle_parameter_info
local var_0_11 = g.core.common.Goods
local TeamBattleFormationData = class("TeamBattleFormationData")

function TeamBattleFormationData:ctor()
	self._withinUniteTokenDict = {}
	self._withinArtifactDict = {}
	self._withinPetDict = {}
	self._isGetSvrFormation = false
	self._lastSaveSyncTime = 0
	self._formationDict = {}
	self._lastFightValue = 0
	self._diffFightValue = 0
	self._sellCfgDict = {}
	self._guardList = {}
	self._guardMap = {}
	self._tempGuardMap = {}
	self._isCheckJson = false

	self:initFormationInCfg()
	self:initFormationSellCfg()
end

function TeamBattleFormationData:initFormationInCfg()
	for iter_2_0 = 1, var_0_2.get(var_0_4.MulTeamType.TEAM_BATTLE).team_size do
		self:getFormationStruct(iter_2_0)
	end
end

function TeamBattleFormationData:initFormationSellCfg()
	for iter_3_0, iter_3_1 in var_0_6.ipairs() do
		self._sellCfgDict[iter_3_1.item_type] = self._sellCfgDict[iter_3_1.item_type] or {}
		self._sellCfgDict[iter_3_1.item_type][iter_3_1.item_quality] = self._sellCfgDict[iter_3_1.item_type][iter_3_1.item_quality] or {}
		self._sellCfgDict[iter_3_1.item_type][iter_3_1.item_quality][iter_3_1.item_star] = iter_3_1
	end
end

function TeamBattleFormationData:isGetSvrFormation()
	return self._isGetSvrFormation
end

function TeamBattleFormationData:isBagFullByType(arg_5_1)
	local var_5_0 = var_0_10.get(TeamBattleConst.PARAMETER_ID.BAG_MAX_ID).parameter

	if arg_5_1 == var_0_11.TYPE_KNIGHT then
		return var_5_0 <= #self:getWithinKnightListByFilter(function(arg_6_0)
			return not self:isSelfKnight(arg_6_0:getServerId())
		end)
	elseif arg_5_1 == var_0_11.TYPE_ARTIFACT then
		return var_5_0 <= #self:getAllArtifactList()
	elseif arg_5_1 == var_0_11.TYPE_UNITETOKEN then
		return var_5_0 <= #self:getAllUniteTokenList()
	elseif arg_5_1 == var_0_11.TYPE_PET then
		return var_5_0 <= #self:getAllPetList()
	end

	return false
end

function TeamBattleFormationData:updateFormationData(arg_7_1, arg_7_2)
	self._isGetSvrFormation = true

	for iter_7_0, iter_7_1 in ipairs(arg_7_1 or {}) do
		self:getFormationStruct(iter_7_1.seq):setSvrData(iter_7_1, arg_7_2)
	end
end

function TeamBattleFormationData:autoSendFirstFormation()
	if self._isGetSvrFormation then
		return
	end

	local var_8_0 = self:getFormationStruct(1)
	local var_8_1 = g.core.model.User.knightsData:getFormation()
	local var_8_2 = {}
	local var_8_3 = {}

	for iter_8_0 = 1, var_0_4.MAX_KNIGHT_NUM do
		local var_8_4 = g.core.model.User.knightsData:getKnight({
			id = var_8_1[iter_8_0]
		})

		if var_8_4 then
			var_8_2[var_8_4:getAdvanceId()] = iter_8_0
			var_8_3[iter_8_0] = var_8_4:getFormationPos()
		end
	end

	for iter_8_1, iter_8_2 in pairs(self:getAllKnightList()) do
		if var_8_2[iter_8_2:getAdvanceId()] then
			var_8_0:lineupKnight(var_8_2[iter_8_2:getAdvanceId()], iter_8_2:getServerId())
		end
	end

	local var_8_5 = {}

	for iter_8_3 = 1, 6 do
		if var_8_3[iter_8_3] then
			local var_8_6 = g.core.model.User.artifactData:getArtifactByPos(var_8_3[iter_8_3])

			if var_8_6 then
				var_8_5[var_8_6:getAdvanceId()] = iter_8_3
			end
		end
	end

	for iter_8_4, iter_8_5 in pairs(self:getAllArtifactList()) do
		local var_8_7 = var_8_5[iter_8_5:getAdvanceId()]

		if var_8_7 and var_8_0:isStationPosLineupKnight(var_8_7) then
			var_8_0:lineupArtifact(var_8_7, iter_8_5:getServerOnlyId())
		end
	end

	local var_8_8 = {}

	for iter_8_6, iter_8_7 in pairs((g.core.model.User.uniteTokenData:getLineupTokenList())) do
		if next(iter_8_7) then
			var_8_8[iter_8_7:getAdvanceId()] = iter_8_6
		end
	end

	for iter_8_8, iter_8_9 in pairs(self:getAllUniteTokenList()) do
		if var_8_8[iter_8_9:getAdvanceId()] then
			var_8_0:lineupUniteToken(var_8_8[iter_8_9:getAdvanceId()], iter_8_9:getAdvanceId())
		end
	end

	local var_8_9 = {}

	for iter_8_10, iter_8_11 in pairs((g.core.model.User.petsData:getLineupSidDict())) do
		local var_8_10 = g.core.model.User.petsData:getPetBySid(iter_8_11)

		if var_8_10 then
			var_8_9[var_8_10:getAdvanceId()] = iter_8_10
		end
	end

	for iter_8_12, iter_8_13 in pairs(self:getAllPetList()) do
		if var_8_9[iter_8_13:getAdvanceId()] then
			var_8_0:lineupPet(var_8_9[iter_8_13:getAdvanceId()], iter_8_13:getSid())
		end
	end

	g.core.network.GameNetProxy:send_C2S_Formation_Save({
		tp = var_0_4.MulTeamType.TEAM_BATTLE,
		formations = self:getOutBaseFormationArr()
	})
end

function TeamBattleFormationData:addPoolMemberKnight(arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1 or {}

	if arg_9_2 == "update" then
		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			self:_updateKnightByServerData(iter_9_1)
		end
	elseif arg_9_2 == "insert" then
		for iter_9_2, iter_9_3 in ipairs(var_9_0) do
			self:_updateKnightByServerData(iter_9_3)
		end
	elseif arg_9_2 == "del" then
		for iter_9_4, iter_9_5 in ipairs(var_9_0) do
			if self._guardMap[iter_9_5] then
				self._guardMap[iter_9_5] = nil
			end
		end
	end
end

function TeamBattleFormationData:_updateKnightByServerData(arg_10_1)
	local var_10_0 = self:getKnightByServerId(arg_10_1.id)

	if var_10_0 then
		var_10_0:addCfgInfo((var_0_5.get(arg_10_1.base_id)))
		var_10_0:setInfo(arg_10_1)
	else
		self:_addGuardById(arg_10_1)
	end
end

function TeamBattleFormationData:updateKnightHP(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		self:getGuardById(iter_11_1.id):updateHpRatio(iter_11_1.hp)
	end
end

function TeamBattleFormationData:getKnightByServerId(arg_12_1)
	return self._guardMap[arg_12_1]
end

function TeamBattleFormationData:getPetByServerId(arg_13_1)
	if self._withinPetDict[arg_13_1] then
		return self._withinPetDict[arg_13_1]
	end

	return g.core.model.User.petsData:getPetBySid(arg_13_1)
end

function TeamBattleFormationData:getArtifactByServerId(arg_14_1)
	if self._withinArtifactDict[arg_14_1] then
		return self._withinArtifactDict[arg_14_1]
	end

	return g.core.model.User.artifactData:getArtifactBySid(arg_14_1)
end

function TeamBattleFormationData:getUniteTokenByServerId(arg_15_1)
	if self._withinUniteTokenDict[arg_15_1] then
		return self._withinUniteTokenDict[arg_15_1]
	end

	return g.core.model.User.uniteTokenData:getTokenByAdvId(arg_15_1)
end

function TeamBattleFormationData:getAllKnightList()
	while 1 <= #self._guardList do
		local var_16_0

		if not self._guardMap[self._guardList[1]:getInfo().id] then
			table.remove(self._guardList, 1)
		else
			var_16_0 = 1 + 1
		end
	end

	return self._guardList
end

function TeamBattleFormationData:getAllArtifactList()
	local var_17_0 = table.values(self._withinArtifactDict)

	table.insertto(var_17_0, g.core.model.User.artifactData:getOwnArtifactList(true))

	return var_17_0
end

function TeamBattleFormationData:getAllUniteTokenList()
	local var_18_0 = table.values(self._withinUniteTokenDict)

	table.insertto(var_18_0, g.core.model.User.uniteTokenData:getOwnTokenList())

	return var_18_0
end

function TeamBattleFormationData:getAllPetList()
	local var_19_0 = table.values(self._withinPetDict)

	table.insertto(var_19_0, g.core.model.User.petsData:getOwnPetArr())

	return var_19_0
end

function TeamBattleFormationData:getWithinKnightListByFilter(arg_20_1)
	local var_20_0 = self:getAllKnightList()
	local var_20_1 = {}

	if arg_20_1 then
		for iter_20_0, iter_20_1 in ipairs(var_20_0) do
			if arg_20_1(iter_20_1) then
				table.insert(var_20_1, iter_20_1)
			end
		end

		return var_20_1
	end

	return var_20_0
end

function TeamBattleFormationData:isSelfKnight(arg_21_1)
	local var_21_0 = self:getKnightByServerId(arg_21_1)

	if var_21_0 then
		return var_21_0:getInfo().source_type == TeamBattleConst.KNIGHT_TYPE_RES.SELF
	end

	return false
end

function TeamBattleFormationData:isWithinArtifact(arg_22_1)
	return checkbool(self._withinArtifactDict[arg_22_1])
end

function TeamBattleFormationData:isWithinPet(arg_23_1)
	return checkbool(self._withinPetDict[arg_23_1])
end

function TeamBattleFormationData:isWithinUniteToken(arg_24_1)
	return checkbool(self._withinUniteTokenDict[arg_24_1])
end

function TeamBattleFormationData:isModified()
	for iter_25_0, iter_25_1 in pairs(self._formationDict) do
		if iter_25_1:isModified() then
			return true
		end
	end

	return false
end

function TeamBattleFormationData:getOutBaseFormationArr()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(self._formationDict) do
		table.insert(var_26_0, (iter_26_1:toOutBaseFormation()))
	end

	return var_26_0
end

function TeamBattleFormationData:isLineUpKnight(arg_27_1)
	for iter_27_0, iter_27_1 in pairs(self._formationDict) do
		if iter_27_1:isKnightLineUp(arg_27_1) then
			return true
		end
	end

	return false
end

function TeamBattleFormationData:isLineUpUniteToken(arg_28_1)
	for iter_28_0, iter_28_1 in pairs(self._formationDict) do
		if iter_28_1:isUniteTokenLineUp(arg_28_1) then
			return true
		end
	end

	return false
end

function TeamBattleFormationData:isLineUpArtifact(arg_29_1)
	for iter_29_0, iter_29_1 in pairs(self._formationDict) do
		if iter_29_1:isArtifactLineUp(arg_29_1) then
			return true
		end
	end

	return false
end

function TeamBattleFormationData:isLineUpPet(arg_30_1)
	for iter_30_0, iter_30_1 in pairs(self._formationDict) do
		if iter_30_1:isPetLineUp(arg_30_1) then
			return true
		end
	end

	return false
end

function TeamBattleFormationData:getFormationStruct(arg_31_1)
	self._formationDict[arg_31_1] = self._formationDict[arg_31_1] or TeamBattleFormationStruct.new(var_0_4.MulTeamType.TEAM_BATTLE, arg_31_1)

	return self._formationDict[arg_31_1]
end

function TeamBattleFormationData:getFormationStructDict()
	return self._formationDict
end

function TeamBattleFormationData:getLastSyncTime()
	return self._lastSaveSyncTime
end

function TeamBattleFormationData:setLastSyncTime(arg_34_1)
	self._lastSaveSyncTime = arg_34_1
end

function TeamBattleFormationData:isKnightLineup(arg_35_1)
	for iter_35_0, iter_35_1 in pairs(self._formationDict) do
		if iter_35_1:isKnightLineUp(arg_35_1) then
			return true
		end
	end

	return false
end

function TeamBattleFormationData:isArtifactLineup(arg_36_1)
	for iter_36_0, iter_36_1 in pairs(self._formationDict) do
		if iter_36_1:isArtifactLineUp(arg_36_1) then
			return true
		end
	end

	return false
end

function TeamBattleFormationData:isPetLineup(arg_37_1)
	for iter_37_0, iter_37_1 in pairs(self._formationDict) do
		if iter_37_1:isPetLineUp(arg_37_1) then
			return true
		end
	end

	return false
end

function TeamBattleFormationData:isUniteTokenLineup(arg_38_1)
	for iter_38_0, iter_38_1 in pairs(self._formationDict) do
		if iter_38_1:isUniteTokenLineUp(arg_38_1) then
			return true
		end
	end

	return false
end

function TeamBattleFormationData:getFormationStructKnightLineup(arg_39_1)
	for iter_39_0, iter_39_1 in pairs(self._formationDict) do
		if iter_39_1:isKnightLineUp(arg_39_1) then
			return iter_39_1
		end
	end
end

function TeamBattleFormationData:getFormationStructArtifactLineup(arg_40_1)
	for iter_40_0, iter_40_1 in pairs(self._formationDict) do
		if iter_40_1:isArtifactLineUp(arg_40_1) then
			return iter_40_1
		end
	end
end

function TeamBattleFormationData:getFormationStructUniteTokenLineup(arg_41_1)
	for iter_41_0, iter_41_1 in pairs(self._formationDict) do
		if iter_41_1:isUniteTokenLineUp(arg_41_1) then
			return iter_41_1
		end
	end
end

function TeamBattleFormationData:getFormationStructPetLineup(arg_42_1)
	for iter_42_0, iter_42_1 in pairs(self._formationDict) do
		if iter_42_1:isPetLineUp(arg_42_1) then
			return iter_42_1
		end
	end
end

function TeamBattleFormationData:isUsingKnight(arg_43_1)
	for iter_43_0, iter_43_1 in pairs(self._formationDict) do
		if iter_43_1:isUsingKnight(arg_43_1) then
			return iter_43_1
		end
	end
end

function TeamBattleFormationData:isUsingArtifact(arg_44_1)
	for iter_44_0, iter_44_1 in pairs(self._formationDict) do
		if iter_44_1:isUsingArtifact(arg_44_1) then
			return iter_44_1
		end
	end
end

function TeamBattleFormationData:isUsingPet(arg_45_1)
	for iter_45_0, iter_45_1 in pairs(self._formationDict) do
		if iter_45_1:isUsingPet(arg_45_1) then
			return iter_45_1
		end
	end
end

function TeamBattleFormationData:isUsingUniteToken(arg_46_1)
	for iter_46_0, iter_46_1 in pairs(self._formationDict) do
		if iter_46_1:isUsingUniteToken(arg_46_1) then
			return iter_46_1
		end
	end
end

function TeamBattleFormationData:resetFormationStruct()
	for iter_47_0, iter_47_1 in pairs(self._formationDict) do
		iter_47_1:resetFormation()
	end
end

function TeamBattleFormationData:onS2CFormationFightValue(arg_48_1)
	local var_48_0 = self:getFormationStruct(arg_48_1.seq)

	if var_48_0 then
		var_48_0:setFightValue(arg_48_1.fight_value or 0)
		self:_checkFightValue()
	end
end

function TeamBattleFormationData:onCheckFightValue()
	self:_checkFightValue()
end

function TeamBattleFormationData:_checkFightValue()
	local var_50_0 = self:getMaxFormationFightValue()

	if var_50_0 > 0 and self._lastFightValue > 0 then
		self._diffFightValue = self._diffFightValue + (var_50_0 - self._lastFightValue)
	end

	self._lastFightValue = var_50_0
end

function TeamBattleFormationData:getDiffFightValue()
	self._diffFightValue = 0

	return self._diffFightValue
end

function TeamBattleFormationData:autoAddArtifact(arg_52_1, arg_52_2)
	if arg_52_1:isStationPosLineupArtifact(arg_52_2) then
		return
	end

	local var_52_0 = self:getKnightByServerId(arg_52_1:getKnightSid(arg_52_2)):getAdvanceId()
	local var_52_1 = {}

	for iter_52_0, iter_52_1 in ipairs(self:getAllArtifactList()) do
		if iter_52_1:getBelongToKnightAvdIdIncludingMainRole() == var_52_0 and not self:isLineUpArtifact(iter_52_1:getServerOnlyId()) then
			table.insert(var_52_1, iter_52_1)
		end
	end

	local var_52_2 = var_52_1[1] and var_52_1[1]:getServerOnlyId() or 0

	if #var_52_1 > 1 then
		table.sort(var_52_1, function(arg_53_0, arg_53_1)
			local var_53_0 = arg_53_0:getQuality()
			local var_53_1 = arg_53_1:getQuality()

			if var_53_0 ~= var_53_1 then
				return var_53_1 < var_53_0
			end

			local var_53_2 = arg_53_0:getStar()
			local var_53_3 = arg_53_1:getStar()

			if var_53_2 ~= var_53_3 then
				return var_53_3 < var_53_2
			end

			return arg_53_0:getAdvanceId() > arg_53_1:getAdvanceId()
		end)

		var_52_2 = var_52_1[1]:getServerOnlyId()
	end

	arg_52_1:lineupArtifact(arg_52_2, var_52_2)
end

function TeamBattleFormationData:getEmbryoCfg(arg_54_1, arg_54_2, arg_54_3)
	return self._sellCfgDict[arg_54_1][arg_54_2][arg_54_3]
end

function TeamBattleFormationData:isHigherStarByKnight(arg_55_1, arg_55_2)
	local var_55_0 = -1

	for iter_55_0, iter_55_1 in pairs(self:getAllKnightList()) do
		if iter_55_1:getAdvanceId() == arg_55_1 then
			local var_55_1 = iter_55_1:getStarLv()

			if var_55_1 >= var_0_9.STAR_MAX then
				return false
			elseif var_55_0 < var_55_1 then
				var_55_0 = var_55_1
			end

			return var_55_0 < arg_55_2
		end
	end

	return false
end

function TeamBattleFormationData:hasHigherKnightQualityByParam(arg_56_1)
	local var_56_0 = self:_getMaxCanLineupKnightQuality()

	if var_56_0 == -1 then
		return false
	end

	if arg_56_1.formationIndex then
		local var_56_1 = self:getFormationStruct(arg_56_1.formationIndex)

		if var_56_1 then
			if arg_56_1.pos then
				return self:_hasHigherKnightQualityInFormation(var_56_1, var_56_0, arg_56_1.pos)
			else
				for iter_56_0 = 1, var_0_4.MAX_KNIGHT_NUM do
					if self:_hasHigherKnightQualityInFormation(var_56_1, var_56_0, iter_56_0) then
						return true
					end
				end
			end
		end
	else
		for iter_56_1, iter_56_2 in pairs(self._formationDict) do
			if self:_hasHigherKnightQualityInFormation(iter_56_2, var_56_0, nil) then
				return true
			end
		end
	end

	return false
end

function TeamBattleFormationData:_getMaxCanLineupKnightQuality()
	local var_57_0 = self:getAllKnightList()

	table.sort(var_57_0, function(arg_58_0, arg_58_1)
		return arg_58_0:getQuality() > arg_58_1:getQuality()
	end)

	for iter_57_0, iter_57_1 in ipairs(var_57_0) do
		if not self:isKnightLineup(iter_57_1:getServerId()) then
			return iter_57_1:getQuality()
		end
	end

	return -1
end

function TeamBattleFormationData:_hasHigherKnightQualityInFormation(arg_59_1, arg_59_2, arg_59_3)
	local var_59_0 = arg_59_1:getKnightDict()

	if arg_59_3 then
		if not var_59_0[arg_59_3] or arg_59_2 > var_59_0[arg_59_3]:getQuality() then
			return true
		end
	else
		for iter_59_0 = 1, var_0_4.MAX_KNIGHT_NUM do
			if not var_59_0[iter_59_0] or arg_59_2 > var_59_0[iter_59_0]:getQuality() then
				return true
			end
		end
	end

	return false
end

function TeamBattleFormationData:hasHigherArtifactQualityByParam(arg_60_1)
	if arg_60_1.formationIndex then
		local var_60_0 = self:getFormationStruct(arg_60_1.formationIndex)

		if var_60_0 then
			if arg_60_1.pos then
				return self:_hasHigherArtifactQualityInFormation(var_60_0, arg_60_1.pos)
			else
				for iter_60_0 = 1, var_0_4.MAX_KNIGHT_NUM do
					if self:_hasHigherArtifactQualityInFormation(var_60_0, iter_60_0) then
						return true
					end
				end
			end
		end
	else
		for iter_60_1, iter_60_2 in pairs(self._formationDict) do
			if self:_hasHigherArtifactQualityInFormation(iter_60_2) then
				return true
			end
		end
	end

	return false
end

function TeamBattleFormationData:_hasHigherArtifactQualityInFormation(arg_61_1, arg_61_2)
	local var_61_0 = arg_61_1:getArtifactSidArr()

	if arg_61_2 then
		if var_61_0[arg_61_2] > 0 then
			local var_61_1 = self:_getMaxCanLineupArtifactQuality(var_61_0[arg_61_2], arg_61_2)

			if var_61_1 == -1 then
				return false
			end

			return var_61_1 > self:getArtifactByServerId(var_61_0[arg_61_2]):getQuality()
		elseif arg_61_1:getKnightSid(arg_61_2) > 0 then
			local var_61_2 = arg_61_1:getKnightDict()[arg_61_2]

			for iter_61_0, iter_61_1 in ipairs((self:getAllArtifactList())) do
				if iter_61_1:checkWearKnight(var_61_2:getAdvanceId()) and not self:isArtifactLineup(iter_61_1:getServerOnlyId()) then
					return true
				end
			end
		else
			return false
		end
	else
		for iter_61_2, iter_61_3 in pairs(var_61_0) do
			if iter_61_3 > 0 then
				local var_61_3 = self:getArtifactByServerId(iter_61_3)
				local var_61_4 = self:_getMaxCanLineupArtifactQuality(iter_61_3, iter_61_2)

				if var_61_4 == -1 then
					return false
				end

				if var_61_3 and var_61_4 > var_61_3:getQuality() then
					return true
				end
			elseif arg_61_1:getKnightSid(iter_61_2) > 0 then
				local var_61_5 = arg_61_1:getKnightDict()[iter_61_2]

				for iter_61_4, iter_61_5 in ipairs((self:getAllArtifactList())) do
					if iter_61_5:checkWearKnight(var_61_5:getAdvanceId()) and not self:isArtifactLineup(iter_61_5:getServerOnlyId()) then
						return true
					end
				end
			end
		end
	end

	return false
end

function TeamBattleFormationData:_getMaxCanLineupArtifactQuality(arg_62_1, arg_62_2)
	local var_62_0 = self:getFormationStructArtifactLineup(arg_62_1):getKnightDict()[arg_62_2]

	if not var_62_0 then
		return -1
	end

	local var_62_1 = self:getAllArtifactList()

	table.sort(var_62_1, function(arg_63_0, arg_63_1)
		return arg_63_0:getQuality() > arg_63_1:getQuality()
	end)

	for iter_62_0, iter_62_1 in ipairs(var_62_1) do
		if iter_62_1:checkWearKnight(var_62_0:getAdvanceId()) and not self:isArtifactLineup(iter_62_1:getServerOnlyId()) then
			return iter_62_1:getQuality()
		end
	end

	return -1
end

function TeamBattleFormationData:hasHigherUniteQualityByParam(arg_64_1)
	local var_64_0 = self:_getMaxCanLineupUnityQuality()

	if var_64_0 == -1 then
		return false
	end

	if arg_64_1.formationIndex then
		local var_64_1 = self:getFormationStruct(arg_64_1.formationIndex)

		if var_64_1 then
			if arg_64_1.pos then
				return self:_hasHigherUniteQualityInFormation(var_64_1, var_64_0, arg_64_1.pos)
			else
				for iter_64_0 = 1, var_0_4.MAX_UNITE_TOKEN_NUM do
					if self:_hasHigherUniteQualityInFormation(var_64_1, var_64_0, iter_64_0) then
						return true
					end
				end
			end
		end
	else
		for iter_64_1, iter_64_2 in pairs(self._formationDict) do
			if self:_hasHigherUniteQualityInFormation(iter_64_2, var_64_0) then
				return true
			end
		end
	end

	return false
end

function TeamBattleFormationData:_hasHigherUniteQualityInFormation(arg_65_1, arg_65_2, arg_65_3)
	local var_65_0 = arg_65_1:getUniteTokenSidArr()

	if arg_65_3 then
		if var_65_0[arg_65_3] > 0 then
			local var_65_1 = self:getUniteTokenByServerId(var_65_0[arg_65_3])

			if var_65_1 then
				return arg_65_2 > var_65_1:getQuality()
			else
				return false
			end
		else
			return true
		end
	else
		for iter_65_0, iter_65_1 in pairs(var_65_0) do
			if iter_65_1 > 0 then
				local var_65_2 = self:getUniteTokenByServerId(iter_65_1)

				if var_65_2 and arg_65_2 > var_65_2:getQuality() then
					return true
				end
			else
				return true
			end
		end
	end

	return false
end

function TeamBattleFormationData:_getMaxCanLineupUnityQuality()
	local var_66_0 = self:getAllUniteTokenList()

	table.sort(var_66_0, function(arg_67_0, arg_67_1)
		return arg_67_0:getQuality() > arg_67_1:getQuality()
	end)

	for iter_66_0, iter_66_1 in ipairs(var_66_0) do
		if not self:isUniteTokenLineup(iter_66_1:getAdvanceId()) then
			return iter_66_1:getQuality()
		end
	end

	return -1
end

function TeamBattleFormationData:hasHigherPetQualityByParam(arg_68_1)
	local var_68_0 = self:_getMaxCanLineupPetQuality()

	if var_68_0 == -1 then
		return false
	end

	local var_68_1 = arg_68_1.pos

	if arg_68_1.formationIndex then
		local var_68_2 = self:getFormationStruct(arg_68_1.formationIndex)

		if var_68_2 then
			if var_68_1 then
				return self:_hasHigherPetQualityInFormation(var_68_2, var_68_0, var_68_1)
			else
				for iter_68_0 = 1, var_0_4.MAX_PEN_NUM do
					if var_0_0:isModuleUnlock(var_0_1["PET_LINE_UP_" .. iter_68_0]) and self:_hasHigherPetQualityInFormation(var_68_2, var_68_0, iter_68_0) then
						return true
					end
				end
			end
		end
	else
		for iter_68_1, iter_68_2 in pairs(self._formationDict) do
			if self:_hasHigherPetQualityInFormation(iter_68_2, var_68_0) then
				return true
			end
		end
	end

	return false
end

function TeamBattleFormationData:_hasHigherPetQualityInFormation(arg_69_1, arg_69_2, arg_69_3)
	local var_69_0 = arg_69_1:getPetSidArr()

	if arg_69_3 then
		if var_69_0[arg_69_3] > 0 then
			return arg_69_2 > self:getPetByServerId(var_69_0[arg_69_3]):getQuality()
		else
			return true
		end
	else
		for iter_69_0, iter_69_1 in pairs(var_69_0) do
			if iter_69_1 > 0 then
				local var_69_1 = self:getPetByServerId(iter_69_1)

				if var_69_1 and arg_69_2 > var_69_1:getQuality() then
					return true
				end
			else
				return true
			end
		end
	end

	return false
end

function TeamBattleFormationData:_getMaxCanLineupPetQuality()
	local var_70_0 = self:getAllPetList()

	table.sort(var_70_0, function(arg_71_0, arg_71_1)
		return arg_71_0:getQuality() > arg_71_1:getQuality()
	end)

	for iter_70_0, iter_70_1 in ipairs(var_70_0) do
		if not self:isPetLineup(iter_70_1:getSid()) then
			return iter_70_1:getQuality()
		end
	end

	return -1
end

function TeamBattleFormationData:getMaxFormationFightValue()
	local var_72_0 = 0

	for iter_72_0, iter_72_1 in pairs(self._formationDict) do
		var_72_0 = math.max(var_72_0, iter_72_1:getFightValue())
	end

	return var_72_0
end

function TeamBattleFormationData:canRecycle(arg_73_1)
	return not self:isSelfKnight(arg_73_1) and not self:isUsingKnight(arg_73_1)
end

function TeamBattleFormationData:getGuardById(arg_74_1)
	return self._guardMap[arg_74_1]
end

function TeamBattleFormationData:_addGuardById(arg_75_1)
	local var_75_0 = var_0_5.get(arg_75_1.base_id)
	local var_75_1 = TeamBattleKnightStruct.new(var_75_0.advance_id)

	var_75_1:addCfgInfo(var_75_0)
	var_75_1:setInfo(arg_75_1)

	self._guardMap[arg_75_1.id] = var_75_1
	self._guardList[#self._guardList + 1] = var_75_1
end

function TeamBattleFormationData:setTempGuardByAdvanceId(arg_76_1, arg_76_2)
	self._tempGuardMap[arg_76_2] = arg_76_1
end

function TeamBattleFormationData:isInTempGuardMap(arg_77_1)
	for iter_77_0, iter_77_1 in pairs(self._tempGuardMap) do
		if arg_77_1 == iter_77_1 then
			return true
		end
	end

	return false
end

function TeamBattleFormationData:getTempGuardMap()
	if not self._isCheckJson then
		self._tempGuardMap = self:getSavedKnightPoolInfo()
	end

	return self._tempGuardMap
end

function TeamBattleFormationData:clearTempGuardMap()
	self._tempGuardMap = {}
end

function TeamBattleFormationData:autoPoolMember(arg_80_1, arg_80_2)
	local var_80_0 = {}
	local var_80_1 = {}

	for iter_80_0, iter_80_1 in ipairs((g.core.model.User.knightsData:getOwnKnightList(0))) do
		local var_80_2 = true

		for iter_80_2, iter_80_3 in pairs(self._tempGuardMap) do
			if iter_80_3 == iter_80_1:getAdvanceId() then
				var_80_2 = false

				break
			end
		end

		if var_80_2 then
			local var_80_3 = iter_80_1:getQuality()
			local var_80_4 = var_80_1[var_80_3]

			if not var_80_1[var_80_3] then
				var_80_4 = {}
				var_80_1[var_80_3] = var_80_4
			end

			local var_80_5 = iter_80_1:getStarLv() or 0
			local var_80_6 = var_80_4[var_80_5]

			if not var_80_4[var_80_5] then
				var_80_6 = {}
				var_80_4[var_80_5] = var_80_6
			end

			table.insert(var_80_6, iter_80_1)
		end
	end

	for iter_80_4 = g.core.const.ConstMgr.QUALITY_TYPE.MAX_QUALITY, g.core.const.ConstMgr.QUALITY_TYPE.R, -1 do
		if var_80_1[iter_80_4] then
			for iter_80_5 = 7, 0, -1 do
				if var_80_1[iter_80_4][iter_80_5] then
					for iter_80_6, iter_80_7 in ipairs(var_80_1[iter_80_4][iter_80_5]) do
						table.insert(var_80_0, iter_80_7)

						if arg_80_1 <= #var_80_0 then
							return var_80_0
						end
					end
				end
			end
		end
	end

	return var_80_0
end

function TeamBattleFormationData:saveKnightPoolInfo()
	g.core.common.Storage:save("team_battle_guard_info.json", {
		pool = self._tempGuardMap
	}, true)
end

function TeamBattleFormationData:getSavedKnightPoolInfo()
	local var_82_0 = g.core.common.Storage:load("team_battle_guard_info.json", true)

	if var_82_0 and var_82_0.pool then
		return var_82_0.pool
	else
		return {}
	end
end

function TeamBattleFormationData:checkDeadKnightAndLineUp()
	local var_83_0 = self:getFormationStruct(1)

	for iter_83_0, iter_83_1 in pairs((var_83_0:getKnightDict())) do
		if iter_83_1:getHpRatio() <= 0 then
			var_83_0:lineupKnight(iter_83_0, 0)
		end
	end
end

return TeamBattleFormationData
