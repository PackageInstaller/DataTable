local var_0_0 = g.core.common.ModuleUnlock
local var_0_1 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_2 = g.core.config.multi_team_formation_info
local var_0_3 = g.core.const.ConstMgr.ExplorationConst
local var_0_4 = g.core.const.ConstMgr.LineUpConst
local var_0_5 = g.core.config.knight_info
local var_0_6 = g.core.config.exploration_shop_item_value_info
local ExplorationFormationStruct = require("app.view.module.exploration.model.struct.ExplorationFormationStruct")
local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local var_0_9 = g.core.model.User.guildData
local var_0_10 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_11 = g.core.const.ConstMgr.SuccubaConst
local var_0_12 = g.core.config.exploration_parameter_info
local var_0_13 = g.core.common.Goods
local ExplorationFormationData = class("ExplorationFormationData")

function ExplorationFormationData:ctor()
	self._withinKnightDict = {}
	self._withinKnightMySidDict = {}
	self._withinUniteTokenDict = {}
	self._withinArtifactDict = {}
	self._withinPetDict = {}
	self._isGetSvrFormation = false
	self._lastSaveSyncTime = 0
	self._formationDict = {}
	self._helperUsedKnightDict = {}
	self._helperSelfKnightDict = {}
	self._helperUsedKnightNum = 0
	self._lastFightValue = 0
	self._diffFightValue = 0
	self._helperGuildKnightNum = 0
	self._helperGuildList = {}
	self._helperGroupData = {}
	self._helperOtherKnight = nil
	self._helperAllData = {}
	self._helperOwnerDict = {}
	self._sellCfgDict = {}
	self._tempUid = 0
	self._tempSid = 0

	self:initFormationInCfg()
	self:initFormationSellCfg()
end

function ExplorationFormationData:initFormationInCfg()
	for iter_2_0 = 1, var_0_2.get(var_0_4.MulTeamType.EXPLORATION).team_size do
		self:getFormationStruct(iter_2_0)
	end
end

function ExplorationFormationData:initFormationSellCfg()
	for iter_3_0, iter_3_1 in var_0_6.ipairs() do
		self._sellCfgDict[iter_3_1.item_type] = self._sellCfgDict[iter_3_1.item_type] or {}
		self._sellCfgDict[iter_3_1.item_type][iter_3_1.item_quality] = self._sellCfgDict[iter_3_1.item_type][iter_3_1.item_quality] or {}
		self._sellCfgDict[iter_3_1.item_type][iter_3_1.item_quality][iter_3_1.item_star] = iter_3_1
	end
end

function ExplorationFormationData:isGetSvrFormation()
	return self._isGetSvrFormation
end

function ExplorationFormationData:isBagFullByType(arg_5_1)
	local var_5_0 = var_0_12.get(var_0_3.BAG_MAX_PARAMETER_ID).parameter

	if arg_5_1 == var_0_13.TYPE_KNIGHT then
		return var_5_0 <= #self:getWithinKnightListByFilter(function(arg_6_0)
			return not self:isSelfKnight(arg_6_0:getServerId())
		end)
	elseif arg_5_1 == var_0_13.TYPE_ARTIFACT then
		return var_5_0 <= #self:getAllArtifactList()
	elseif arg_5_1 == var_0_13.TYPE_UNITETOKEN then
		return var_5_0 <= #self:getAllUniteTokenList()
	elseif arg_5_1 == var_0_13.TYPE_PET then
		return var_5_0 <= #self:getAllPetList()
	end

	return false
end

function ExplorationFormationData:updateFormationData(arg_7_1, arg_7_2)
	self._isGetSvrFormation = true

	for iter_7_0, iter_7_1 in ipairs(arg_7_1 or {}) do
		self:getFormationStruct(iter_7_1.seq):setSvrData(iter_7_1, arg_7_2)
	end
end

function ExplorationFormationData:autoSendFirstFormation()
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

	for iter_8_14, iter_8_15 in pairs((g.core.model.User.succubaData:getLineUpSuccubaList())) do
		var_8_0:lineupSuccuba(iter_8_14, iter_8_15:getSid())
	end

	g.core.network.GameNetProxy:send_C2S_Formation_Save({
		tp = var_0_4.MulTeamType.EXPLORATION,
		formations = self:getOutBaseFormationArr()
	})
end

function ExplorationFormationData:addPoolMemberKnight(arg_9_1, arg_9_2)
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
			self._withinKnightDict[iter_9_5] = nil

			for iter_9_6, iter_9_7 in pairs(self._withinKnightMySidDict) do
				if iter_9_7 == iter_9_5 then
					self._withinKnightMySidDict[iter_9_6] = nil
				end
			end
		end
	end
end

function ExplorationFormationData:_updateKnightByServerData(arg_10_1)
	local var_10_0 = self:getKnightByServerId(arg_10_1.id)
	local var_10_1 = var_0_5.get(arg_10_1.base_id)

	if var_10_0 then
		var_10_0:addCfgInfo(var_10_1)
		var_10_0:setInfo(arg_10_1)
	else
		local var_10_2 = KnightStruct.new(var_10_1.advance_id)

		var_10_2:addCfgInfo(var_10_1)
		var_10_2:setInfo(arg_10_1)

		self._withinKnightDict[arg_10_1.id] = var_10_2
	end

	if arg_10_1.source_type == var_0_3.KNIGHT_TYPE_RES.OTHER then
		self._withinKnightMySidDict[arg_10_1.origin_id] = arg_10_1.id
	end
end

function ExplorationFormationData:getKnightByServerId(arg_11_1)
	if self._withinKnightDict[arg_11_1] then
		return self._withinKnightDict[arg_11_1]
	end
end

function ExplorationFormationData:getPetByServerId(arg_12_1)
	if self._withinPetDict[arg_12_1] then
		return self._withinPetDict[arg_12_1]
	end

	return g.core.model.User.petsData:getPetBySid(arg_12_1)
end

function ExplorationFormationData:getArtifactByServerId(arg_13_1)
	if self._withinArtifactDict[arg_13_1] then
		return self._withinArtifactDict[arg_13_1]
	end

	return g.core.model.User.artifactData:getArtifactBySid(arg_13_1)
end

function ExplorationFormationData:getUniteTokenByServerId(arg_14_1)
	if self._withinUniteTokenDict[arg_14_1] then
		return self._withinUniteTokenDict[arg_14_1]
	end

	return g.core.model.User.uniteTokenData:getTokenByAdvId(arg_14_1)
end

function ExplorationFormationData:getAllKnightList()
	return (table.values(self._withinKnightDict))
end

function ExplorationFormationData:getAllArtifactList()
	local var_16_0 = table.values(self._withinArtifactDict)

	table.insertto(var_16_0, g.core.model.User.artifactData:getOwnArtifactList(true))

	return var_16_0
end

function ExplorationFormationData:getAllUniteTokenList()
	local var_17_0 = table.values(self._withinUniteTokenDict)

	table.insertto(var_17_0, g.core.model.User.uniteTokenData:getOwnTokenList())

	return var_17_0
end

function ExplorationFormationData:getAllPetList()
	local var_18_0 = table.values(self._withinPetDict)

	table.insertto(var_18_0, g.core.model.User.petsData:getOwnPetArr())

	return var_18_0
end

function ExplorationFormationData:isWithinKnight(arg_19_1)
	local var_19_0 = self:getKnightByServerId(arg_19_1)

	if var_19_0 then
		return var_19_0:getInfo().source_type == var_0_3.KNIGHT_TYPE_RES.WITHIN
	end

	return false
end

function ExplorationFormationData:getWithinKnightList()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs((self:getAllKnightList())) do
		if self:isWithinKnight(iter_20_1:getServerId()) then
			table.insert(var_20_0, iter_20_1)
		end
	end

	return var_20_0
end

function ExplorationFormationData:getWithinKnightListByFilter(arg_21_1)
	local var_21_0 = self:getAllKnightList()
	local var_21_1 = {}

	if arg_21_1 then
		for iter_21_0, iter_21_1 in ipairs(var_21_0) do
			if arg_21_1(iter_21_1) then
				table.insert(var_21_1, iter_21_1)
			end
		end

		return var_21_1
	end

	return var_21_0
end

function ExplorationFormationData:isSelfKnight(arg_22_1)
	local var_22_0 = self:getKnightByServerId(arg_22_1)

	if var_22_0 then
		return var_22_0:getInfo().source_type == var_0_3.KNIGHT_TYPE_RES.SELF
	end

	return false
end

function ExplorationFormationData:isOtherUserKnight(arg_23_1)
	local var_23_0 = self:getKnightByServerId(arg_23_1)

	if var_23_0 then
		return var_23_0:getInfo().source_type == var_0_3.KNIGHT_TYPE_RES.OTHER
	end

	return false
end

function ExplorationFormationData:isWithinArtifact(arg_24_1)
	return checkbool(self._withinArtifactDict[arg_24_1])
end

function ExplorationFormationData:isWithinPet(arg_25_1)
	return checkbool(self._withinPetDict[arg_25_1])
end

function ExplorationFormationData:isWithinUniteToken(arg_26_1)
	return checkbool(self._withinUniteTokenDict[arg_26_1])
end

function ExplorationFormationData:isModified()
	for iter_27_0, iter_27_1 in pairs(self._formationDict) do
		if iter_27_1:isModified() then
			return true
		end
	end

	return false
end

function ExplorationFormationData:getOutBaseFormationArr()
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in pairs(self._formationDict) do
		table.insert(var_28_0, (iter_28_1:toOutBaseFormation()))
	end

	return var_28_0
end

function ExplorationFormationData:isLineUpKnight(arg_29_1)
	for iter_29_0, iter_29_1 in pairs(self._formationDict) do
		if iter_29_1:isKnightLineUp(arg_29_1) then
			return true
		end
	end

	return false
end

function ExplorationFormationData:isLineUpUniteToken(arg_30_1)
	for iter_30_0, iter_30_1 in pairs(self._formationDict) do
		if iter_30_1:isUniteTokenLineUp(arg_30_1) then
			return true
		end
	end

	return false
end

function ExplorationFormationData:isLineUpArtifact(arg_31_1)
	for iter_31_0, iter_31_1 in pairs(self._formationDict) do
		if iter_31_1:isArtifactLineUp(arg_31_1) then
			return true
		end
	end

	return false
end

function ExplorationFormationData:isLineUpPet(arg_32_1)
	for iter_32_0, iter_32_1 in pairs(self._formationDict) do
		if iter_32_1:isPetLineUp(arg_32_1) then
			return true
		end
	end

	return false
end

function ExplorationFormationData:isLineUpSuccuba(arg_33_1)
	for iter_33_0, iter_33_1 in pairs(self._formationDict) do
		if iter_33_1:isSuccubaLineUp(arg_33_1) then
			return true
		end
	end

	return false
end

function ExplorationFormationData:getFormationStruct(arg_34_1)
	self._formationDict[arg_34_1] = self._formationDict[arg_34_1] or ExplorationFormationStruct.new(var_0_4.MulTeamType.EXPLORATION, arg_34_1)

	return self._formationDict[arg_34_1]
end

function ExplorationFormationData:getFormationStructDict()
	return self._formationDict
end

function ExplorationFormationData:getLastSyncTime()
	return self._lastSaveSyncTime
end

function ExplorationFormationData:setLastSyncTime(arg_37_1)
	self._lastSaveSyncTime = arg_37_1
end

function ExplorationFormationData:isKnightLineup(arg_38_1)
	for iter_38_0, iter_38_1 in pairs(self._formationDict) do
		if iter_38_1:isKnightLineUp(arg_38_1) then
			return true
		end
	end

	return false
end

function ExplorationFormationData:isArtifactLineup(arg_39_1)
	for iter_39_0, iter_39_1 in pairs(self._formationDict) do
		if iter_39_1:isArtifactLineUp(arg_39_1) then
			return true
		end
	end

	return false
end

function ExplorationFormationData:isPetLineup(arg_40_1)
	for iter_40_0, iter_40_1 in pairs(self._formationDict) do
		if iter_40_1:isPetLineUp(arg_40_1) then
			return true
		end
	end

	return false
end

function ExplorationFormationData:isSuccubaLineUp(arg_41_1)
	for iter_41_0, iter_41_1 in pairs(self._formationDict) do
		if iter_41_1:isSuccubaLineUp(arg_41_1) then
			return true
		end
	end

	return false
end

function ExplorationFormationData:isUniteTokenLineup(arg_42_1)
	for iter_42_0, iter_42_1 in pairs(self._formationDict) do
		if iter_42_1:isUniteTokenLineUp(arg_42_1) then
			return true
		end
	end

	return false
end

function ExplorationFormationData:getFormationStructKnightLineup(arg_43_1)
	for iter_43_0, iter_43_1 in pairs(self._formationDict) do
		if iter_43_1:isKnightLineUp(arg_43_1) then
			return iter_43_1
		end
	end
end

function ExplorationFormationData:getFormationStructArtifactLineup(arg_44_1)
	for iter_44_0, iter_44_1 in pairs(self._formationDict) do
		if iter_44_1:isArtifactLineUp(arg_44_1) then
			return iter_44_1
		end
	end
end

function ExplorationFormationData:getFormationStructUniteTokenLineup(arg_45_1)
	for iter_45_0, iter_45_1 in pairs(self._formationDict) do
		if iter_45_1:isUniteTokenLineUp(arg_45_1) then
			return iter_45_1
		end
	end
end

function ExplorationFormationData:getFormationStructPetLineup(arg_46_1)
	for iter_46_0, iter_46_1 in pairs(self._formationDict) do
		if iter_46_1:isPetLineUp(arg_46_1) then
			return iter_46_1
		end
	end
end

function ExplorationFormationData:getFormationStructSuccubaLineup(arg_47_1)
	for iter_47_0, iter_47_1 in pairs(self._formationDict) do
		if iter_47_1:isSuccubaLineUp(arg_47_1) then
			return iter_47_1
		end
	end
end

function ExplorationFormationData:isUsingKnight(arg_48_1)
	for iter_48_0, iter_48_1 in pairs(self._formationDict) do
		if iter_48_1:isUsingKnight(arg_48_1) then
			return iter_48_1
		end
	end
end

function ExplorationFormationData:isUsingArtifact(arg_49_1)
	for iter_49_0, iter_49_1 in pairs(self._formationDict) do
		if iter_49_1:isUsingArtifact(arg_49_1) then
			return iter_49_1
		end
	end
end

function ExplorationFormationData:isUsingPet(arg_50_1)
	for iter_50_0, iter_50_1 in pairs(self._formationDict) do
		if iter_50_1:isUsingPet(arg_50_1) then
			return iter_50_1
		end
	end
end

function ExplorationFormationData:isUsingSuccuba(arg_51_1)
	for iter_51_0, iter_51_1 in pairs(self._formationDict) do
		if iter_51_1:isUsingSuccuba(arg_51_1) then
			return iter_51_1
		end
	end
end

function ExplorationFormationData:isUsingUniteToken(arg_52_1)
	for iter_52_0, iter_52_1 in pairs(self._formationDict) do
		if iter_52_1:isUsingUniteToken(arg_52_1) then
			return iter_52_1
		end
	end
end

function ExplorationFormationData:resetFormationStruct()
	for iter_53_0, iter_53_1 in pairs(self._formationDict) do
		iter_53_1:resetFormation()
	end
end

function ExplorationFormationData:onS2CFormationFightValue(arg_54_1)
	local var_54_0 = self:getFormationStruct(arg_54_1.seq)

	if var_54_0 then
		var_54_0:setFightValue(arg_54_1.fight_value or 0)
		self:_checkFightValue()
	end
end

function ExplorationFormationData:_checkFightValue()
	local var_55_0 = self:getMaxFormationFightValue()

	if var_55_0 > 0 and self._lastFightValue > 0 then
		self._diffFightValue = self._diffFightValue + (var_55_0 - self._lastFightValue)
	end

	self._lastFightValue = var_55_0
end

function ExplorationFormationData:getDiffFightValue()
	self._diffFightValue = 0

	return self._diffFightValue
end

function ExplorationFormationData:autoAddArtifact(arg_57_1, arg_57_2)
	if arg_57_1:isStationPosLineupArtifact(arg_57_2) then
		return
	end

	local var_57_0 = self:getKnightByServerId(arg_57_1:getKnightSid(arg_57_2)):getAdvanceId()
	local var_57_1 = {}

	for iter_57_0, iter_57_1 in ipairs(self:getAllArtifactList()) do
		if iter_57_1:getBelongToKnightAvdIdIncludingMainRole() == var_57_0 and not self:isLineUpArtifact(iter_57_1:getServerOnlyId()) then
			table.insert(var_57_1, iter_57_1)
		end
	end

	local var_57_2 = var_57_1[1] and var_57_1[1]:getServerOnlyId() or 0

	if #var_57_1 > 1 then
		table.sort(var_57_1, function(arg_58_0, arg_58_1)
			local var_58_0 = arg_58_0:getQuality()
			local var_58_1 = arg_58_1:getQuality()

			if var_58_0 ~= var_58_1 then
				return var_58_1 < var_58_0
			end

			local var_58_2 = arg_58_0:getStar()
			local var_58_3 = arg_58_1:getStar()

			if var_58_2 ~= var_58_3 then
				return var_58_3 < var_58_2
			end

			return arg_58_0:getAdvanceId() > arg_58_1:getAdvanceId()
		end)

		var_57_2 = var_57_1[1]:getServerOnlyId()
	end

	arg_57_1:lineupArtifact(arg_57_2, var_57_2)
end

function ExplorationFormationData:isKnightUsedBySid(arg_59_1)
	return checkbool(self._helperUsedKnightDict[arg_59_1])
end

function ExplorationFormationData:getSelfHelpKnightDict()
	return self._helperSelfKnightDict
end

function ExplorationFormationData:_updateSelfHelpDict(arg_61_1)
	self._helperSelfKnightDict[arg_61_1.indice] = arg_61_1.id
	self._helperUsedKnightDict[arg_61_1.id] = true
end

function ExplorationFormationData:getUsedKnightNum()
	return self._helperUsedKnightNum
end

function ExplorationFormationData:getHelperDataByGroup(arg_63_1)
	return self._helperGroupData[arg_63_1] or {}
end

function ExplorationFormationData:_updateHelperData(arg_64_1)
	self._helperAllData = {}
	self._helperGroupData = {}
	self._helperOwnerDict = {}
	self._helperOtherKnight = nil

	for iter_64_0, iter_64_1 in ipairs(arg_64_1) do
		local var_64_0 = var_0_5.get(iter_64_1.base_id)
		local var_64_1 = KnightStruct.new(var_64_0.advance_id)

		var_64_1:addCfgInfo(var_64_0)

		if not var_64_1:isMain() then
			local var_64_2 = {
				svrHelperData = iter_64_1,
				struct = var_64_1,
				ownerId = iter_64_1.uid,
				hasSameLineUp = self:isKnightLineup(iter_64_1.id)
			}

			self._helperOwnerDict[iter_64_1.uid] = self._helperOwnerDict[iter_64_1.uid] or var_0_9:getGuildMemberByPlayerId(iter_64_1.uid) or {}

			table.insert(self._helperAllData, var_64_2)

			if self:isOtherUserKnight(self._withinKnightMySidDict[iter_64_1.id] or 0) then
				self._helperOtherKnight = var_64_2
			end
		end
	end

	table.sort(self._helperAllData, function(arg_65_0, arg_65_1)
		local var_65_0 = arg_65_1.struct
		local var_65_1 = arg_65_0.struct:getQuality()
		local var_65_2 = arg_65_1.struct:getQuality()

		if var_65_1 ~= var_65_2 then
			return var_65_2 < var_65_1
		end

		local var_65_3 = arg_65_0.struct:getStarLv()
		local var_65_4 = var_65_0:getStarLv()

		if var_65_3 ~= var_65_4 then
			return var_65_4 < var_65_3
		end

		return arg_65_0.struct:getAdvanceId() > var_65_0:getAdvanceId()
	end)

	self._helperGroupData[var_0_10.GROUP_TYPE.DEFAULT] = self._helperAllData

	for iter_64_2, iter_64_3 in ipairs(self._helperAllData) do
		if iter_64_3.struct then
			local var_64_3 = iter_64_3.struct:getGroup()

			self._helperGroupData[var_64_3] = self._helperGroupData[var_64_3] or {}

			table.insert(self._helperGroupData[var_64_3], iter_64_3)
		end
	end
end

function ExplorationFormationData:updateHelperSnapshot(arg_66_1)
	for iter_66_0, iter_66_1 in ipairs(arg_66_1.snapshots or {}) do
		self._helperOwnerDict[iter_66_1.id] = iter_66_1
	end
end

function ExplorationFormationData:getOtherUserKnight()
	return self._helperOtherKnight
end

function ExplorationFormationData:getHelperSnapshotByUid(arg_68_1)
	return self._helperOwnerDict[arg_68_1]
end

function ExplorationFormationData:getHelperSnapshotDict()
	return self._helperOwnerDict
end

function ExplorationFormationData:getNewSidByOriginSid(arg_70_1)
	return self._withinKnightMySidDict[arg_70_1] or 0
end

function ExplorationFormationData:getEmbryoCfg(arg_71_1, arg_71_2, arg_71_3)
	return self._sellCfgDict[arg_71_1][arg_71_2][arg_71_3]
end

function ExplorationFormationData:isHigherStarByKnight(arg_72_1, arg_72_2)
	local var_72_0 = -1

	for iter_72_0, iter_72_1 in pairs(self:getAllKnightList()) do
		if iter_72_1:getAdvanceId() == arg_72_1 then
			local var_72_1 = iter_72_1:getStarLv()

			if var_72_1 >= var_0_10.STAR_MAX then
				return false
			elseif var_72_0 < var_72_1 then
				var_72_0 = var_72_1
			end
		end
	end

	return var_72_0 < arg_72_2
end

function ExplorationFormationData:isOtherUserKnightUsing()
	for iter_73_0, iter_73_1 in ipairs((self:getAllKnightList())) do
		local var_73_0 = iter_73_1:getServerId()

		if self:isOtherUserKnight(var_73_0) and self:isUsingKnight(var_73_0) then
			return true
		end
	end

	return false
end

function ExplorationFormationData:saveTempHelper(arg_74_1, arg_74_2)
	self._tempUid = arg_74_1
	self._tempSid = arg_74_2
end

function ExplorationFormationData:getTempHelper()
	return self._tempUid, self._tempSid
end

function ExplorationFormationData:onS2CFriendHelperGetKnights(arg_76_1)
	self._helperGuildKnightNum = arg_76_1.total_knights or 0
	self._helperGuildList = arg_76_1.helper or {}

	self:_updateHelperData(self._helperGuildList)
end

function ExplorationFormationData:onS2CFriendHelperUseKnights(arg_77_1)
	for iter_77_0, iter_77_1 in ipairs(self._helperAllData) do
		for iter_77_2, iter_77_3 in ipairs(arg_77_1.use) do
			if iter_77_1.svrHelperData.id == iter_77_3.id then
				self._helperOtherKnight = iter_77_1

				break
			end
		end
	end
end

function ExplorationFormationData:onS2CFriendHelperShowSetKnights(arg_78_1)
	self._helperUsedKnightNum = 0
	self._helperUsedKnightDict = {}

	for iter_78_0, iter_78_1 in ipairs(arg_78_1.setting or {}) do
		if iter_78_1.id > 0 then
			self._helperUsedKnightNum = self._helperUsedKnightNum + 1
		end

		self:_updateSelfHelpDict(iter_78_1)
	end
end

function ExplorationFormationData:onS2CFriendHelperSetKnights(arg_79_1)
	self._helperUsedKnightNum = 0
	self._helperUsedKnightDict = {}

	for iter_79_0, iter_79_1 in ipairs(arg_79_1.setting) do
		if iter_79_1.id > 0 then
			self._helperUsedKnightNum = self._helperUsedKnightNum + 1
		end

		self:_updateSelfHelpDict(iter_79_1)
	end
end

function ExplorationFormationData:hasHigherKnightQualityByParam(arg_80_1)
	local var_80_0 = self:_getMaxCanLineupKnightQuality()

	if var_80_0 == -1 then
		return false
	end

	if arg_80_1.formationIndex then
		local var_80_1 = self:getFormationStruct(arg_80_1.formationIndex)

		if var_80_1 then
			if arg_80_1.pos then
				return self:_hasHigherKnightQualityInFormation(var_80_1, var_80_0, arg_80_1.pos)
			else
				for iter_80_0 = 1, var_0_4.MAX_KNIGHT_NUM do
					if self:_hasHigherKnightQualityInFormation(var_80_1, var_80_0, iter_80_0) then
						return true
					end
				end
			end
		end
	else
		for iter_80_1, iter_80_2 in pairs(self._formationDict) do
			if self:_hasHigherKnightQualityInFormation(iter_80_2, var_80_0, nil) then
				return true
			end
		end
	end

	return false
end

function ExplorationFormationData:_getMaxCanLineupKnightQuality()
	local var_81_0 = self:getAllKnightList()

	table.sort(var_81_0, function(arg_82_0, arg_82_1)
		return arg_82_0:getQuality() > arg_82_1:getQuality()
	end)

	for iter_81_0, iter_81_1 in ipairs(var_81_0) do
		if not self:isKnightLineup(iter_81_1:getServerId()) then
			return iter_81_1:getQuality()
		end
	end

	return -1
end

function ExplorationFormationData:_hasHigherKnightQualityInFormation(arg_83_1, arg_83_2, arg_83_3)
	local var_83_0 = arg_83_1:getKnightDict()

	if arg_83_3 then
		if not var_83_0[arg_83_3] or arg_83_2 > var_83_0[arg_83_3]:getQuality() then
			return true
		end
	else
		for iter_83_0 = 1, var_0_4.MAX_KNIGHT_NUM do
			if not var_83_0[iter_83_0] or arg_83_2 > var_83_0[iter_83_0]:getQuality() then
				return true
			end
		end
	end

	return false
end

function ExplorationFormationData:hasHigherArtifactQualityByParam(arg_84_1)
	if arg_84_1.formationIndex then
		local var_84_0 = self:getFormationStruct(arg_84_1.formationIndex)

		if var_84_0 then
			if arg_84_1.pos then
				return self:_hasHigherArtifactQualityInFormation(var_84_0, arg_84_1.pos)
			else
				for iter_84_0 = 1, var_0_4.MAX_KNIGHT_NUM do
					if self:_hasHigherArtifactQualityInFormation(var_84_0, iter_84_0) then
						return true
					end
				end
			end
		end
	else
		for iter_84_1, iter_84_2 in pairs(self._formationDict) do
			if self:_hasHigherArtifactQualityInFormation(iter_84_2) then
				return true
			end
		end
	end

	return false
end

function ExplorationFormationData:_hasHigherArtifactQualityInFormation(arg_85_1, arg_85_2)
	local var_85_0 = arg_85_1:getArtifactSidArr()

	if arg_85_2 then
		if var_85_0[arg_85_2] > 0 then
			local var_85_1 = self:_getMaxCanLineupArtifactQuality(var_85_0[arg_85_2], arg_85_2)

			if var_85_1 == -1 then
				return false
			end

			return var_85_1 > self:getArtifactByServerId(var_85_0[arg_85_2]):getQuality()
		elseif arg_85_1:getKnightSid(arg_85_2) > 0 then
			local var_85_2 = arg_85_1:getKnightDict()[arg_85_2]

			for iter_85_0, iter_85_1 in ipairs((self:getAllArtifactList())) do
				if iter_85_1:checkWearKnight(var_85_2:getAdvanceId()) and not self:isArtifactLineup(iter_85_1:getServerOnlyId()) then
					return true
				end
			end
		else
			return false
		end
	else
		for iter_85_2, iter_85_3 in pairs(var_85_0) do
			if iter_85_3 > 0 then
				local var_85_3 = self:getArtifactByServerId(iter_85_3)
				local var_85_4 = self:_getMaxCanLineupArtifactQuality(iter_85_3, iter_85_2)

				if var_85_4 == -1 then
					return false
				end

				if var_85_3 and var_85_4 > var_85_3:getQuality() then
					return true
				end
			elseif arg_85_1:getKnightSid(iter_85_2) > 0 then
				local var_85_5 = arg_85_1:getKnightDict()[iter_85_2]

				for iter_85_4, iter_85_5 in ipairs((self:getAllArtifactList())) do
					if iter_85_5:checkWearKnight(var_85_5:getAdvanceId()) and not self:isArtifactLineup(iter_85_5:getServerOnlyId()) then
						return true
					end
				end
			end
		end
	end

	return false
end

function ExplorationFormationData:_getMaxCanLineupArtifactQuality(arg_86_1, arg_86_2)
	local var_86_0 = self:getFormationStructArtifactLineup(arg_86_1):getKnightDict()[arg_86_2]

	if not var_86_0 then
		return -1
	end

	local var_86_1 = self:getAllArtifactList()

	table.sort(var_86_1, function(arg_87_0, arg_87_1)
		return arg_87_0:getQuality() > arg_87_1:getQuality()
	end)

	for iter_86_0, iter_86_1 in ipairs(var_86_1) do
		if iter_86_1:checkWearKnight(var_86_0:getAdvanceId()) and not self:isArtifactLineup(iter_86_1:getServerOnlyId()) then
			return iter_86_1:getQuality()
		end
	end

	return -1
end

function ExplorationFormationData:hasHigherUniteQualityByParam(arg_88_1)
	local var_88_0 = self:_getMaxCanLineupUnityQuality()

	if var_88_0 == -1 then
		return false
	end

	if arg_88_1.formationIndex then
		local var_88_1 = self:getFormationStruct(arg_88_1.formationIndex)

		if var_88_1 then
			if arg_88_1.pos then
				return self:_hasHigherUniteQualityInFormation(var_88_1, var_88_0, arg_88_1.pos)
			else
				for iter_88_0 = 1, var_0_4.MAX_UNITE_TOKEN_NUM do
					if self:_hasHigherUniteQualityInFormation(var_88_1, var_88_0, iter_88_0) then
						return true
					end
				end
			end
		end
	else
		for iter_88_1, iter_88_2 in pairs(self._formationDict) do
			if self:_hasHigherUniteQualityInFormation(iter_88_2, var_88_0) then
				return true
			end
		end
	end

	return false
end

function ExplorationFormationData:_hasHigherUniteQualityInFormation(arg_89_1, arg_89_2, arg_89_3)
	local var_89_0 = arg_89_1:getUniteTokenSidArr()

	if arg_89_3 then
		if var_89_0[arg_89_3] > 0 then
			local var_89_1 = self:getUniteTokenByServerId(var_89_0[arg_89_3])

			if var_89_1 then
				return arg_89_2 > var_89_1:getQuality()
			else
				return false
			end
		else
			return true
		end
	else
		for iter_89_0, iter_89_1 in pairs(var_89_0) do
			if iter_89_1 > 0 then
				local var_89_2 = self:getUniteTokenByServerId(iter_89_1)

				if var_89_2 and arg_89_2 > var_89_2:getQuality() then
					return true
				end
			else
				return true
			end
		end
	end

	return false
end

function ExplorationFormationData:_getMaxCanLineupUnityQuality()
	local var_90_0 = self:getAllUniteTokenList()

	table.sort(var_90_0, function(arg_91_0, arg_91_1)
		return arg_91_0:getQuality() > arg_91_1:getQuality()
	end)

	for iter_90_0, iter_90_1 in ipairs(var_90_0) do
		if not self:isUniteTokenLineup(iter_90_1:getAdvanceId()) then
			return iter_90_1:getQuality()
		end
	end

	return -1
end

function ExplorationFormationData:hasHigherPetQualityByParam(arg_92_1)
	local var_92_0 = self:_getMaxCanLineupPetQuality()

	if var_92_0 == -1 then
		return false
	end

	local var_92_1 = arg_92_1.pos

	if arg_92_1.formationIndex then
		local var_92_2 = self:getFormationStruct(arg_92_1.formationIndex)

		if var_92_2 then
			if var_92_1 then
				return self:_hasHigherPetQualityInFormation(var_92_2, var_92_0, var_92_1)
			else
				for iter_92_0 = 1, var_0_4.MAX_PEN_NUM do
					if var_0_0:isModuleUnlock(var_0_1["PET_LINE_UP_" .. iter_92_0]) and self:_hasHigherPetQualityInFormation(var_92_2, var_92_0, iter_92_0) then
						return true
					end
				end
			end
		end
	else
		for iter_92_1, iter_92_2 in pairs(self._formationDict) do
			if self:_hasHigherPetQualityInFormation(iter_92_2, var_92_0) then
				return true
			end
		end
	end

	return false
end

function ExplorationFormationData:_hasHigherPetQualityInFormation(arg_93_1, arg_93_2, arg_93_3)
	local var_93_0 = arg_93_1:getPetSidArr()

	if arg_93_3 then
		if var_93_0[arg_93_3] > 0 then
			return arg_93_2 > self:getPetByServerId(var_93_0[arg_93_3]):getQuality()
		else
			return true
		end
	else
		for iter_93_0, iter_93_1 in pairs(var_93_0) do
			if iter_93_1 > 0 then
				local var_93_1 = self:getPetByServerId(iter_93_1)

				if var_93_1 and arg_93_2 > var_93_1:getQuality() then
					return true
				end
			else
				return true
			end
		end
	end

	return false
end

function ExplorationFormationData:_getMaxCanLineupPetQuality()
	local var_94_0 = self:getAllPetList()

	table.sort(var_94_0, function(arg_95_0, arg_95_1)
		return arg_95_0:getQuality() > arg_95_1:getQuality()
	end)

	for iter_94_0, iter_94_1 in ipairs(var_94_0) do
		if not self:isPetLineup(iter_94_1:getSid()) then
			return iter_94_1:getQuality()
		end
	end

	return -1
end

function ExplorationFormationData:hasHigherSuccubaQualityByParam(arg_96_1)
	local var_96_0 = self:_getMaxCanLineupSuccubaQuality()

	if var_96_0 == -1 then
		return false
	end

	local var_96_1 = arg_96_1.pos

	if arg_96_1.formationIndex then
		local var_96_2 = self:getFormationStruct(arg_96_1.formationIndex)

		if var_96_2 then
			if var_96_1 then
				return self:_hasHigherSuccubaQualityInFormation(var_96_2, var_96_0, var_96_1)
			else
				for iter_96_0 = 1, var_0_11.FORMAT_SUCCUBA_NUM_MAX do
					if self:_hasHigherSuccubaQualityInFormation(var_96_2, var_96_0, iter_96_0) then
						return true
					end
				end
			end
		end
	else
		for iter_96_1, iter_96_2 in pairs(self._formationDict) do
			if self:_hasHigherSuccubaQualityInFormation(iter_96_2, var_96_0) then
				return true
			end
		end
	end

	return false
end

function ExplorationFormationData:_hasHigherSuccubaQualityInFormation(arg_97_1, arg_97_2, arg_97_3)
	local var_97_0 = arg_97_1:getSuccubaSidArr()

	if arg_97_3 then
		if var_97_0[arg_97_3] > 0 then
			return arg_97_2 > g.core.model.User.succubaData:getSuccubaBySid(var_97_0[arg_97_3]):getQuality()
		else
			return true
		end
	else
		for iter_97_0, iter_97_1 in pairs(var_97_0) do
			if iter_97_1 > 0 then
				local var_97_1 = g.core.model.User.succubaData:getSuccubaBySid(iter_97_1)

				if var_97_1 and arg_97_2 > var_97_1:getQuality() then
					return true
				end
			else
				return true
			end
		end
	end

	return false
end

function ExplorationFormationData:_getMaxCanLineupSuccubaQuality()
	local var_98_0 = g.core.model.User.succubaData:getSuccubaList()

	table.sort(var_98_0, function(arg_99_0, arg_99_1)
		return arg_99_0:getQuality() > arg_99_1:getQuality()
	end)

	for iter_98_0, iter_98_1 in ipairs(var_98_0) do
		if not self:isSuccubaLineUp(iter_98_1:getSid()) then
			return iter_98_1:getQuality()
		end
	end

	return -1
end

function ExplorationFormationData:getGuildHelperList()
	return self._helperGuildList or {}
end

function ExplorationFormationData:getMaxFormationFightValue()
	local var_101_0 = 0

	for iter_101_0, iter_101_1 in pairs(self._formationDict) do
		var_101_0 = math.max(var_101_0, iter_101_1:getFightValue())
	end

	return var_101_0
end

function ExplorationFormationData:canRecycle(arg_102_1)
	return not self:isSelfKnight(arg_102_1) and not self:isUsingKnight(arg_102_1)
end

function ExplorationFormationData:getAllLineUpAdvIdDic()
	return
end

return ExplorationFormationData
