local FightValueCalculation = require("app.core.common.FightValue.FightValueCalculation")
local var_0_1 = g.core.config.multi_team_info
local var_0_2 = g.core.const.ConstMgr.FormationConst
local GveKnightStruct = require("app.view.module.gve.model.struct.GveKnightStruct")
local PreFormationStruct = require("app.view.module.formation.model.PreFormationStruct")
local GveFormationStruct = require("app.view.module.lineUp.model.GveFormationStruct")
local var_0_6 = g.core.const.ConstMgr.LineUpConst
local var_0_7 = g.core.const.ConstMgr.UniteTokenConst
local var_0_8 = g.core.const.ConstMgr.PetConst
local var_0_9 = g.core.model.User.gveDataMgr
local var_0_10 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_11 = g.core.const.ConstMgr.PreciousConst
local var_0_12 = g.core.const.ConstMgr.SuccubaConst
local GveFormationData = class("GveFormationData")

function GveFormationData:ctor()
	self:initData()
end

function GveFormationData:initData()
	self._posDataList = {}
	self._equipKnightDataList = {}
	self._allKnightArtifactDict = {}
	self._posUsedKnightAdvanceList = {}
	self._usedKnightList = {}
	self._lastActionReplyTime = 0
	self._formationStructDict = {}
	self._battleUseSeq = 1
	self._curUsedFormationIndex = 0
	self._isGetFormation = false
	self._presetFormationDataList = {}
	self._presetFormationIndexDict = {}
	self._isGetPreFormationData = false
	self._needSaveFormationData = {}
	self._knightAttrs = {}
	self._curDayIsTipSelectTime = (g.core.common.Storage:load("gve_select_knight_tip.json", true) or {}).lastTipTime or 0
end

function GveFormationData:updateFormationData(arg_3_1)
	self._isGetFormation = true

	self:getFormationStruct():setSvrData(arg_3_1[self._battleUseSeq], true)
end

function GveFormationData:resetFormation()
	self:getFormationStruct():resetFormation()
end

function GveFormationData:getFormationStruct()
	self._formationStructDict[self._battleUseSeq] = self._formationStructDict[self._battleUseSeq] or GveFormationStruct.new(var_0_6.MulTeamType.GVE, self._battleUseSeq)

	return self._formationStructDict[self._battleUseSeq]
end

function GveFormationData:getFormationStructDict()
	return self._formationStructDict
end

function GveFormationData:onS2CPreFormationFlush(arg_7_1)
	if not self._isGetPreFormationData then
		local var_7_0 = 0

		for iter_7_0, iter_7_1 in var_0_1.ipairs() do
			if iter_7_1.type == var_0_2.PRESET_FORMATION_TYPE.GVE then
				var_7_0 = var_7_0 + 1
				self._presetFormationDataList[var_7_0] = self:getPresetFormationStruct(var_7_0, iter_7_1.id)
				self._presetFormationIndexDict[iter_7_1.id] = var_7_0
			end
		end
	end

	self._isGetPreFormationData = true

	for iter_7_2, iter_7_3 in pairs(arg_7_1.data or {}) do
		local var_7_1 = self:getPresetFormationStruct(self._presetFormationIndexDict[iter_7_3.id])

		var_7_1:setSvrData(iter_7_3)

		for iter_7_4, iter_7_5 in pairs(var_7_1:getKnightSidArr()) do
			if not self:getKnightByServerId(iter_7_5) then
				var_7_1:lineupKnight(iter_7_4, 0)
			end
		end
	end
end

function GveFormationData:isCanChallengeByKnight()
	for iter_8_0, iter_8_1 in pairs(self:getFormationStruct():getKnightSidArr()) do
		if self:getKnightByServerId(iter_8_1) then
			return true
		end
	end

	return false
end

function GveFormationData:isEnoughKnightsAction(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(self:getFormationStruct():getKnightSidArr()) do
		if iter_9_1 > 0 and self:getKnightActionBySid(iter_9_1) < arg_9_1 then
			return false
		end
	end

	return true
end

function GveFormationData:isLockKnights()
	for iter_10_0, iter_10_1 in pairs(self:getFormationStruct():getKnightSidArr()) do
		if self:checkKnightIsUsed(iter_10_1) then
			return false
		end
	end

	return true
end

function GveFormationData:checkIsTipPop()
	if self._curDayIsTipSelectTime > 0 then
		return not g.core.common.ServerTime:isToday(self._curDayIsTipSelectTime)
	else
		return true
	end
end

function GveFormationData:setLastTipTime(arg_12_1)
	if arg_12_1 > 0 and g.core.common.ServerTime:isToday(self._curDayIsTipSelectTime) then
		return
	end

	self._curDayIsTipSelectTime = arg_12_1

	g.core.common.Storage:save("gve_select_knight_tip.json", {
		lastTipTime = arg_12_1
	}, true)
end

function GveFormationData:getEquipKnightList()
	return self._posDataList
end

function GveFormationData:isGetFormation()
	return self._isGetFormation
end

function GveFormationData:hasKnightCanEquip()
	for iter_15_0, iter_15_1 in pairs((g.core.model.User.knightsData:getOwnerAllList())) do
		if not self._posUsedKnightAdvanceList[iter_15_1:getAdvanceId()] and not iter_15_1:isMain() then
			return true
		end
	end

	return false
end

function GveFormationData:getPoolKnightList()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs((g.core.model.User.knightsData:getOwnerAllList())) do
		if not self._posUsedKnightAdvanceList[iter_16_1:getAdvanceId()] and not iter_16_1:isMain() then
			table.insert(var_16_0, iter_16_1)
		end
	end

	return var_16_0
end

function GveFormationData:getPosCurNum()
	return (table.nums(self._posDataList))
end

function GveFormationData:checkKnightIsLineUp(arg_18_1)
	return self:getFormationStruct():isKnightLineUp(arg_18_1)
end

function GveFormationData:checkKnightIsUsed(arg_19_1)
	return self._usedKnightList[arg_19_1]
end

function GveFormationData:checkUniteIsLineUp(arg_20_1)
	return self:getFormationStruct():isUniteTokenLineUp(arg_20_1)
end

function GveFormationData:checkPetIsLineUp(arg_21_1)
	return self:getFormationStruct():isPetLineUp(arg_21_1)
end

function GveFormationData:checkSuccubaIsLineUp(arg_22_1)
	return self:getFormationStruct():isSuccubaLineUp(arg_22_1)
end

function GveFormationData:getKnightByServerId(arg_23_1)
	return (self._equipKnightDataList[arg_23_1] or {}).knight
end

function GveFormationData:getKnightByPos(arg_24_1)
	return self:getKnightByServerId((self:getFormationStruct():getKnightSid(arg_24_1)))
end

function GveFormationData:getUniteByPos(arg_25_1)
	return g.core.model.User.uniteTokenData:getTokenByAdvId((self:getFormationStruct():getUniteTokenSid(arg_25_1)))
end

function GveFormationData:getArtifactByPos(arg_26_1)
	return g.core.model.User.artifactData:getArtifactBySid((self:getFormationStruct():getArtifactSid(arg_26_1)))
end

function GveFormationData:getPetByPos(arg_27_1)
	return g.core.model.User.petsData:getPetBySid((self:getFormationStruct():getPetSid(arg_27_1)))
end

function GveFormationData:getSuccubaPos(arg_28_1)
	return g.core.model.User.succubaData:getSuccubaBySid((self:getFormationStruct():getSuccubaSid(arg_28_1)))
end

function GveFormationData:getKnightActionBySid(arg_29_1)
	return self:getKnightActionByPos((self._equipKnightDataList[arg_29_1] or {}).pos or 0)
end

function GveFormationData:getKnightActionByPos(arg_30_1)
	return (self._posDataList[arg_30_1] or {}).action or 0
end

function GveFormationData:getActionReplyTime()
	return self._lastActionReplyTime
end

function GveFormationData:getAllEquipKnight()
	return self._equipKnightDataList
end

function GveFormationData:getAllEquipKnightStruct()
	local var_33_0 = {}

	for iter_33_0, iter_33_1 in pairs(self._equipKnightDataList) do
		if iter_33_1.knight and iter_33_1.pos > 0 then
			table.insert(var_33_0, iter_33_1.knight)
		end
	end

	return var_33_0
end

function GveFormationData:setKnightPosAndActionByList(arg_34_1, arg_34_2)
	self._posDataList = {}

	for iter_34_0, iter_34_1 in pairs(arg_34_1 or {}) do
		local var_34_0 = self._equipKnightDataList[iter_34_1.knight_id] or {}

		var_34_0.pos = iter_34_1.pos
		self._posDataList[iter_34_1.pos] = {
			knight = var_34_0.knight,
			action = iter_34_1.action,
			pos = iter_34_1.pos
		}
	end

	self._lastActionReplyTime = arg_34_2 or 0
end

function GveFormationData:setKnightPosAndAction(arg_35_1)
	for iter_35_0, iter_35_1 in pairs(arg_35_1.datas or {}) do
		if self._posDataList[iter_35_1.id] then
			if self._equipKnightDataList[iter_35_1.num] then
				self._posDataList[iter_35_1.id].knight = self._equipKnightDataList[iter_35_1.num].knight
				self._equipKnightDataList[iter_35_1.num].pos = iter_35_1.id
			end
		end
	end
end

function GveFormationData:onS2CKnightActionNotify(arg_36_1)
	for iter_36_0, iter_36_1 in pairs(arg_36_1.knights or {}) do
		if self._posDataList[iter_36_1.pos] then
			self._posDataList[iter_36_1.pos].action = iter_36_1.action
		end
	end

	self._lastActionReplyTime = arg_36_1.recover_ts or 0
end

function GveFormationData:onS2CBattleBegin(arg_37_1)
	for iter_37_0, iter_37_1 in pairs(arg_37_1.knight_action or {}) do
		if self._posDataList[iter_37_1.pos] then
			self._posDataList[iter_37_1.pos].action = iter_37_1.action
		end
	end
end

function GveFormationData:onWorldCellDetail(arg_38_1)
	self._usedKnightList = {}

	for iter_38_0, iter_38_1 in pairs(arg_38_1.lock_knights or {}) do
		self._usedKnightList[iter_38_1] = true
	end
end

function GveFormationData:resetKnights()
	self._usedKnightList = {}
end

function GveFormationData:updateKnightAction(arg_40_1)
	for iter_40_0, iter_40_1 in pairs(arg_40_1.knight_action or {}) do
		if self._posDataList[iter_40_1.pos] then
			self._posDataList[iter_40_1.pos].action = iter_40_1.action
		end
	end
end

function GveFormationData:addPoolMember(arg_41_1, arg_41_2)
	local var_41_0 = arg_41_1 or {}

	if arg_41_2 == "update" then
		for iter_41_0, iter_41_1 in ipairs(var_41_0) do
			local var_41_1 = self:getKnightByServerId(iter_41_1.id)

			if var_41_1 then
				var_41_1:setInfo(iter_41_1)
			end
		end
	elseif arg_41_2 == "insert" then
		for iter_41_2, iter_41_3 in ipairs(var_41_0) do
			local var_41_2 = self:getKnightByServerId(iter_41_3.id)

			if var_41_2 then
				var_41_2:setInfo(iter_41_3)
			else
				local var_41_3 = GveKnightStruct.new(iter_41_3.base_id)

				var_41_3:setInfo(iter_41_3)

				self._equipKnightDataList[var_41_3:getServerId()] = {
					pos = 0,
					knight = var_41_3
				}
				self._posUsedKnightAdvanceList[var_41_3:getAdvanceId()] = true
			end
		end
	elseif arg_41_2 == "del" then
		for iter_41_4, iter_41_5 in ipairs(var_41_0) do
			if self._equipKnightDataList[iter_41_5] then
				if self._posDataList[self._equipKnightDataList[iter_41_5].pos] then
					self._posDataList[self._equipKnightDataList[iter_41_5].pos].knight = nil
				end
			end

			self._equipKnightDataList[iter_41_5] = nil
		end
	end
end

function GveFormationData:lineupKnight(arg_42_1, arg_42_2)
	self:getFormationStruct():lineupKnight(arg_42_1, arg_42_2 and arg_42_2:getServerId() or 0)
	self:refreshLineUpArtifact()
end

function GveFormationData:lineupUnite(arg_43_1, arg_43_2)
	self:getFormationStruct():lineupUniteToken(arg_43_1, arg_43_2 and arg_43_2:getAdvanceId() or 0)
end

function GveFormationData:lineupPet(arg_44_1, arg_44_2)
	self:getFormationStruct():lineupPet(arg_44_1, arg_44_2 and arg_44_2:getSid() or 0)
end

function GveFormationData:lineupSuccuba(arg_45_1, arg_45_2)
	self:getFormationStruct():lineupSuccuba(arg_45_1, arg_45_2 and arg_45_2:getSid() or 0)
end

function GveFormationData:refreshLineUpArtifact()
	local var_46_0 = self:getFormationStruct()

	for iter_46_0, iter_46_1 in pairs(var_46_0:getKnightSidArr()) do
		local var_46_1 = self:getArtifactByKnightSid(iter_46_1)

		var_46_0:lineupArtifact(iter_46_0, var_46_1 and var_46_1:getServerOnlyId() or 0, true)
	end
end

function GveFormationData:refreshAllKnightArtifact()
	self._allKnightArtifactDict = {}

	local var_47_0 = {}

	for iter_47_0, iter_47_1 in ipairs((self:getAllEquipKnightStruct())) do
		var_47_0[iter_47_1:getAdvanceId()] = {
			sid = iter_47_1:getServerId()
		}
	end

	g.core.model.User.artifactData:getArtifactByAdvId()

	for iter_47_2, iter_47_3 in pairs((g.core.model.User.artifactData:getAllArtifactList())) do
		local var_47_1 = var_47_0[iter_47_3:getBelongToKnightAvdIdIncludingMainRole()]

		if var_47_1 ~= nil then
			if var_47_1.artifact then
				if var_47_1.artifact:getQuality() < iter_47_3:getQuality() and iter_47_3:isOwn() then
					var_47_1.artifact = iter_47_3
				elseif not var_47_1.artifact:isOwn() and iter_47_3:isOwn() then
					var_47_1.artifact = iter_47_3
				end
			else
				var_47_1.artifact = iter_47_3
			end
		end
	end

	for iter_47_4, iter_47_5 in pairs(var_47_0) do
		self._allKnightArtifactDict[iter_47_5.sid] = iter_47_5.artifact
	end
end

function GveFormationData:getArtifactByKnightSid(arg_48_1)
	return self._allKnightArtifactDict[arg_48_1]
end

function GveFormationData:getFormationRequestParam()
	local var_49_0 = {
		tp = 3,
		formations = {}
	}

	table.insert(var_49_0.formations, self:getFormationStruct():toOutBaseFormation())

	return var_49_0
end

function GveFormationData:getFormationFightValue()
	local var_50_0 = 0

	for iter_50_0, iter_50_1 in pairs(self:getFormationStruct():getKnightDict()) do
		local var_50_1 = {}

		FightValueCalculation.addAttr(var_50_1, self:_getKnightAttrs(iter_50_1))
		FightValueCalculation.addAttr(var_50_1, self:_getSealAttrs())

		var_50_0 = var_50_0 + FightValueCalculation.calculationFightValue(var_50_1, true)
	end

	return var_50_0
end

function GveFormationData:_getKnightAttrs(arg_51_1)
	local var_51_0 = {}
	local var_51_1 = arg_51_1:getServerId()

	if not self._knightAttrs[var_51_1] then
		local var_51_2 = {}
		local var_51_3 = arg_51_1:getBaseInfo()

		FightValueCalculation.addAttr(var_51_2, FightValueCalculation.getKnightLevelAttrList(var_51_3, var_0_9:getGveBaseCfg().knight_lv))
		FightValueCalculation.addAttr(var_51_2, FightValueCalculation.getKnightRankAttrList(var_51_3, var_0_9:getGveBaseCfg().knight_advance))
		FightValueCalculation.addAttr(var_51_2, FightValueCalculation.getKnightStarAttrList(var_51_3, arg_51_1:getStarLv()))

		self._knightAttrs[var_51_1] = var_51_2
	end

	FightValueCalculation.addAttr(var_51_0, self._knightAttrs[var_51_1])

	return var_51_0
end

function GveFormationData:_getSealAttrs()
	local var_52_0, var_52_1 = var_0_9:getGveBagData():getAttrList()

	return var_52_1
end

function GveFormationData:getPresetFormationStruct(arg_53_1, arg_53_2)
	self._presetFormationDataList[arg_53_1] = self._presetFormationDataList[arg_53_1] or PreFormationStruct.new(arg_53_1, arg_53_2 or 0)

	return self._presetFormationDataList[arg_53_1]
end

function GveFormationData:getPresetFormationNum()
	return #self._presetFormationDataList
end

function GveFormationData:setNeedSaveFormation(arg_55_1)
	self._needSaveFormationData[arg_55_1:getFormationUniqueId()] = arg_55_1:toOutBaseFormation()
end

function GveFormationData:setFormationByPresetIndex(arg_56_1)
	local var_56_0 = self:getPresetFormationStruct(arg_56_1):getServerData()

	var_56_0 = var_56_0 or {}

	local var_56_1 = var_56_0.knight_id or {}

	for iter_56_0 = 1, var_0_10.LINEUP_MAX do
		if self:getKnightByServerId(var_56_1[iter_56_0]) then
			self:getFormationStruct():lineupKnight(iter_56_0, var_56_1[iter_56_0], true)
		else
			self:getFormationStruct():lineupKnight(iter_56_0, 0, true)
		end
	end

	self:refreshLineUpArtifact()

	local var_56_2 = var_56_0.unite_token_id or {}

	for iter_56_1 = 1, var_0_7.FORMAT_UNITE_NUM_MAX do
		self:getFormationStruct():lineupUniteToken(iter_56_1, var_56_2[iter_56_1], true)
	end

	local var_56_3 = var_56_0.pet_id or {}

	for iter_56_2 = 1, var_0_8.LINEUP_MAX do
		self:getFormationStruct():lineupPet(iter_56_2, var_56_3[iter_56_2], true)
	end

	local var_56_4 = var_56_0.precious_suits or {}

	for iter_56_3 = 1, var_0_11.LINEUP_MAX do
		self:getFormationStruct():lineupPreciousSuit(iter_56_3, var_56_4[iter_56_3], true)
	end

	local var_56_5 = var_56_0.succuba_id or {}

	for iter_56_4 = 1, var_0_12.FORMAT_SUCCUBA_NUM_MAX do
		self:getFormationStruct():lineupSuccuba(iter_56_4, var_56_5[iter_56_4], true)
	end
end

function GveFormationData:onS2CPreFormationSaveById(arg_57_1)
	if self._needSaveFormationData[arg_57_1] then
		self:getPresetFormationStruct(self._presetFormationIndexDict[arg_57_1]):setSvrData(self._needSaveFormationData[arg_57_1])

		self._needSaveFormationData[arg_57_1] = nil
	end
end

function GveFormationData:isGetPresetFormationData()
	return self._isGetPreFormationData
end

function GveFormationData:isHasPetCanUp()
	for iter_59_0, iter_59_1 in pairs((g.core.model.User.petsData:getOwnPetArr())) do
		if not self:checkPetIsLineUp(iter_59_1:getSid()) then
			return true
		end
	end

	return false
end

function GveFormationData:isHasSuccubaCanUp(arg_60_1)
	arg_60_1 = arg_60_1 or self:getFormationStruct()

	for iter_60_0, iter_60_1 in pairs((g.core.model.User.succubaData:getSuccubaList())) do
		if not arg_60_1:isSuccubaLineUp(iter_60_1:getSid()) then
			return true
		end
	end

	return false
end

function GveFormationData:isHasUniteTokenCanUp()
	for iter_61_0, iter_61_1 in pairs((g.core.model.User.uniteTokenData:getTokenListByQuality(0))) do
		if not self:checkUniteIsLineUp(iter_61_1:getAdvanceId()) then
			return true
		end
	end

	return false
end

function GveFormationData:canLineUpSuccubaInEmptyPos(arg_62_1)
	local var_62_0 = arg_62_1.formationStruct or self:getFormationStruct()
	local var_62_1 = false

	if arg_62_1.pos then
		if var_62_0:getSuccubaSid(arg_62_1.pos) == 0 then
			var_62_1 = self:isHasSuccubaCanUp(var_62_0)
		end
	else
		for iter_62_0 = 1, var_0_12.FORMAT_SUCCUBA_NUM_MAX do
			if var_62_0:getSuccubaSid(iter_62_0) == 0 then
				var_62_1 = self:isHasSuccubaCanUp(var_62_0)

				break
			end
		end
	end

	return var_62_1
end

function GveFormationData:isChangeBtnHasRedPoint(arg_63_1)
	if arg_63_1 == 0 then
		if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PET) then
			return false
		end

		for iter_63_0 = 1, var_0_8.LINEUP_MAX do
			if not self:getPetByPos(iter_63_0) and self:isHasPetCanUp() then
				return true
			end
		end
	elseif arg_63_1 == 1 then
		for iter_63_1 = 1, var_0_7.FORMAT_UNITE_NUM_MAX do
			if not self:getUniteByPos(iter_63_1) and self:isHasUniteTokenCanUp() then
				return true
			end
		end
	end

	return false
end

function GveFormationData:getCurUserFormationIndex()
	if self._curUsedFormationIndex == 0 then
		self:loadGveFormationIndex()
	end

	return self._curUsedFormationIndex
end

function GveFormationData:setCurUserFormationIndex(arg_65_1)
	self._curUsedFormationIndex = arg_65_1

	self:saveGveFormationIndex()
end

function GveFormationData:saveGveFormationIndex()
	g.core.common.Storage:save("gve_formation_record_index.json", {
		index = self._curUsedFormationIndex
	})
end

function GveFormationData:loadGveFormationIndex()
	self._curUsedFormationIndex = (g.core.common.Storage:load("gve_formation_record_index.json") or {
		index = 1
	}).index
end

return GveFormationData
