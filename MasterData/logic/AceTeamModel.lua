-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/model/AceTeamModel.lua

module("logic.extensions.aceteam.model.AceTeamModel", package.seeall)

local AceTeamModel = class("AceTeamModel", BaseModel)
local GROUP_STEP = 10000

AceTeamModel.ITEM_ACE_POINT = 1023
AceTeamModel.ReadFlag = "AceTeamModel.ReadFlag"

function AceTeamModel:ctor()
	AceTeamModel.super.ctor(self)
end

function AceTeamModel:onInit()
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._checkRefreshTime, self)
	ClockMgr.instance:addListener(ClockMgr.TickHour, self._checkRefreshTime, self)
end

function AceTeamModel:_checkRefreshTime()
	self.isInited = false
	self.isTeamInited = false
end

function AceTeamModel:onReset()
	self.isInited = false
	self.isTeamInited = false
	self.activityId = -1
	self.teamId = -1
	self.changedTeam = 0
	self.point = 0
	self.historyPoint = 0
	self.historyMedal = 0
	self.hasMatchFightTimes = 0
	self.buyPointTimes = 0
	self.buyMatchFightTimes = 0
	self.matchForm = nil
	self.bossId = -1
	self.bossHasFightTimes = 0
	self.posHpList = {}
	self._bossHasMetTimes = 0
	self._bossRestHp = 0
	self.teamListMap = {}
	self.groupPetMap = {}
	self._bossFightResultData = false
	self._currBattleBossId = false
	self._rankDataList = {}
	self.formationMO = FormationMO.New(function(petId)
		return self:getCurTeamPetMo(petId)
	end)
end

function AceTeamModel:resetFormationMo()
	if self.matchForm then
		self.formationMO:SetData(self.matchForm)
		self:trySetSummon(self.formationMO)
	end
end

function AceTeamModel:GetCurFormation()
	return self.formationMO
end

function AceTeamModel:getPetList()
	local groupId = self.teamId

	if groupId > 0 then
		return self.teamListMap[groupId]
	end

	return {}
end

function AceTeamModel:getCurTeamPetMo(petId)
	local groupId = self.teamId

	if groupId > 0 then
		local key = self:createPetId(groupId, petId)

		return self:getPetMoByPetId(key)
	end

	return nil
end

function AceTeamModel:getPowerAndSpeed()
	local fmo = self:GetCurFormation()
	local power, speed = fmo:getPowerAndSpeed()

	return power, speed
end

function AceTeamModel:isCurFormationEmpty()
	for i = 1, 9 do
		local pos = self.formationMO:GetPosition(i)

		if checknumber(pos) > 0 then
			return false
		end
	end

	return true
end

function AceTeamModel:initPetData(activityId)
	local cfg = AceTeamConfig.instance:getSeasonCfg(activityId)
	local list = AceTeamConfig.instance:getTeamListBySeasonId(cfg.seasonId)

	for i, v in pairs(list) do
		local petList = AceTeamConfig.instance:getPetListByGroupId(v.groupId)

		for _, petCfg in pairs(petList) do
			local petMo = self:createCfgPetMo(v.groupId, petCfg)
			local key = self:createPetId(v.groupId, petMo.petId)

			self.groupPetMap[key] = petMo
		end
	end
end

function AceTeamModel:getPetMoByCfgId(groupId, creepsId)
	local key = self:createPetId(groupId, creepsId)

	return self:getPetMoByPetId(key)
end

function AceTeamModel:getPetMoByPetId(key)
	return self.groupPetMap[key]
end

function AceTeamModel:createCfgPetMo(groupId, creepCo)
	local petMo = BagPetMo.New()

	petMo.isMyPackPet = false
	petMo.isSupportedPet = true
	petMo.raceId = creepCo.raceId
	petMo.petId = creepCo.creepsId
	petMo.level = creepCo.lv
	petMo.curFaceId = checknumber(creepCo.faceId)

	if checknumber(petMo.curFaceId) == 0 then
		petMo.curFaceId = checknumber(petMo.raceId)
	end

	petMo.awakeLevel = 0
	petMo.talentLevel = creepCo.talentLv
	petMo.summonMasterId = checknumber(creepCo.summonMasterId)
	petMo.summonedPetId = checknumber(creepCo.summonedPetId)
	petMo.carriedMasterId = checknumber(creepCo.carriedMasterId)
	petMo.carriedPetId = checknumber(creepCo.carriedPetId)
	petMo.heavenAwakenMasterId = checknumber(creepCo.heavenAwakenMasterId)
	petMo.heavenAwakenSummonPetId = checknumber(creepCo.heavenAwakenSummonPetId)
	petMo.oracleMasterId = checknumber(creepCo.oracleMasterId)
	petMo.oraclePetId = checknumber(creepCo.oraclePetId)
	petMo.oraclePetRaceId = checknumber(creepCo.oraclePetRaceId)
	petMo.contractSkillId = checknumber(creepCo.contractSkillId)
	petMo.bookSpiritPetId = checknumber(creepCo.bookSpiritPetId)
	petMo.bookSpiritRaceId = checknumber(creepCo.bookSpiritRaceId)
	petMo.starGodPlusSlots = {}

	local fixedStarGodId = creepCo.fixedStarGodId

	if fixedStarGodId then
		for i, v in ipairs(fixedStarGodId) do
			local star = {}

			star.slot = i
			star.exp = 0
			star.fillerDefineId = v

			table.insert(petMo.starGodPlusSlots, star)
		end
	end

	petMo.equipments = {}

	local petCfg = MaterialMgr.getMatCfg(MatType.Pet, petMo.raceId)
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)

	for i = 1, 4 do
		local eqCfg = AceTeamConfig.instance:getEquipCfg(firstJobIdx, i, 0)
		local obj = {}

		obj.positionId = i
		obj.defineId = eqCfg.defineId
		obj.lv = 0
		obj.levelExt = 0

		table.insert(petMo.equipments, obj)
	end

	petMo.sourceTraces = {}

	petMo:setAttrMo()
	petMo:calcAllAttr()

	return petMo
end

function AceTeamModel:updatePetMoWithBaseView(petMo, groupId, msg)
	petMo.isMyPackPet = false
	petMo.raceId = msg.raceId
	petMo.petId = msg.petId
	petMo.level = msg.curLv
	petMo.curFaceId = checknumber(msg.curFaceId)

	if checknumber(petMo.curFaceId) == 0 then
		petMo.curFaceId = checknumber(petMo.raceId)
	end

	petMo.awakeLevel = msg.awakenLv
	petMo.talentLevel = msg.talentLevel
	petMo.summonMasterId = checknumber(msg.summonMasterId)
	petMo.summonedPetId = checknumber(msg.summonedPetId)
	petMo.carriedMasterId = checknumber(msg.carriedMasterId)
	petMo.carriedPetId = checknumber(msg.carriedPetId)
	petMo.oracleMasterId = checknumber(msg.oracleMasterId)
	petMo.oraclePetId = checknumber(msg.oraclePetId)
	petMo.oraclePetRaceId = checknumber(msg.oraclePetRaceId)
	petMo.normalSkillLv = msg.normalSkillLv
	petMo.ultimateSkillLv = msg.ultimateSkillLv
	petMo.passiveSkillLv = msg.passiveSkillLv
	petMo.contractSkillId = msg.contractSkillId
	petMo.psychicedUltimateSkillLv = msg.psychicedUltimateSkillLv
	petMo.psychicedNormalSkillLv = msg.psychicedNormalSkillLv
	petMo.holyStripeSuitId = msg.holyStripeSuitId
	petMo.bookSpiritPetId = msg.bookSpiritPetId
	petMo.bookSpiritRaceId = msg.bookSpiritRaceId
	petMo.starGodPlusSlots = {}

	local starGodPlusSlots = msg.starGodPlusSlots

	if starGodPlusSlots then
		for i, v in ipairs(starGodPlusSlots) do
			local star = {}

			star.slot = v.slot
			star.exp = v.exp
			star.fillerDefineId = v.fillerDefineId

			table.insert(petMo.starGodPlusSlots, star)
		end
	end

	petMo.equipments = {}

	local equipments = msg.equipments

	for i, v in ipairs(equipments) do
		local obj = {}

		obj.positionId = v.positionId
		obj.defineId = v.defineId
		obj.lv = v.equipmentLv
		obj.levelExt = v.level

		table.insert(petMo.equipments, obj)
	end

	petMo.holyStripeSlots = {}
	petMo.holyStripeSlotsLevel = {}

	local holyStripeSlots = msg.holyStripeSlots

	if holyStripeSlots then
		for i, v in ipairs(holyStripeSlots) do
			local holyStripeSlot = {}

			holyStripeSlot.positionId = v.positionId
			holyStripeSlot.level = v.level

			table.insert(petMo.holyStripeSlots, holyStripeSlot)

			petMo.holyStripeSlotsLevel[v.positionId] = v.level
		end
	end

	petMo.sourceTraces = {}

	local sourceTraces = msg.sourceTraces

	if sourceTraces then
		for i, v in ipairs(sourceTraces) do
			local st = {}

			st.nodeId = v.nodeId
			st.effectId = v.effectId
			st.unlockEffectIds = v.unlockEffectIds

			table.insert(petMo.sourceTraces, st)
		end
	end

	petMo:setAttrMo()

	petMo.extpropertiesArr = self:calcByHolyStripeAttrs(petMo.holyStripeSlots, petMo.holyStripeSuitId)

	petMo:calcAllAttr()

	return petMo
end

function AceTeamModel:createPetId(groupId, creepsId)
	return groupId * GROUP_STEP + checknumber(creepsId)
end

function AceTeamModel:setCurrPetMo(petMo)
	self.currPetMo = petMo

	GlobalDispatcher:dispatch(GlobalNotify.PM_ACETEAM_PETCHANGE)
end

function AceTeamModel:getCurrPetMo()
	return self.currPetMo
end

function AceTeamModel:getInfo()
	if self.isInited then
		GlobalDispatcher:dispatch(GlobalNotify.PM_ACETEAM_GETINFO)
	else
		AceTeamAgent.instance:sendPM_AceTeamGetInfoReq()
	end
end

function AceTeamModel:onGetInfoErr(status, msg)
	local content = TipsFacade.instance:openTipWindowNoX(lang("tip"), content, function()
		UIStateManager.instance:popByName(ViewName.AceteammainView)
	end)
end

function AceTeamModel:setInfo(msg)
	self.isInited = true
	self.activityId = msg.activityId
	self.teamId = msg.teamId
	self.changedTeam = msg.changedTeam
	self.point = msg.point
	self.historyPoint = msg.historyPoint
	self.historyMedal = msg.historyMedal
	self.hasMatchFightTimes = msg.hasMatchFightTimes
	self.buyPointTimes = msg.buyPointTimes
	self.buyMatchFightTimes = msg.buyMatchFightTimes
	self.matchForm = msg.matchForm
	self.bossId = msg.bossId
	self.bossHasFightTimes = msg.bossHasFightTimes
	self.posHpList = msg.posHpList
	self._bossHasMetTimes = msg.bossHasMetTimes

	MaterialModel.instance:UpdateMaterial(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT, self.point)
	self:initPetData(self.activityId)
	self:sendUpdatePetMo()
	self.formationMO:SetData(self.matchForm)
	self:trySetSummon(self.formationMO)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ACETEAM_GETINFO)
end

function AceTeamModel:sendSelectTeam(teamId)
	self.tmpTeamId = teamId

	AceTeamAgent.instance:sendPM_AceTeamChangeTeamReq(teamId)
end

function AceTeamModel:onChangeTeam(msg)
	if self.teamId == -1 then
		-- block empty
	else
		self.point = checknumber(self.historyPoint)

		MaterialModel.instance:UpdateMaterial(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT, self.point)

		self.changedTeam = checknumber(self.changedTeam) + 1
	end

	self.teamId = self.tmpTeamId
	self.isTeamInited = false
	self.matchForm = nil

	local positions = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}

	self.formationMO:_setAllPositions(positions)
	self:sendUpdatePetMo()
end

function AceTeamModel:sendSaveForm()
	self.temSimpleForm = self.formationMO:createFormPb()
	self.temSimpleForm.formId = 0

	AceTeamAgent.instance:sendPM_AceTeamSetMatchFormReq(self.activityId, self.temSimpleForm)
end

function AceTeamModel:onSaveForm(msg)
	if msg:HasField("simpleForm") and msg.simpleForm then
		self.matchForm = msg.simpleForm

		self.formationMO:SetData(self.matchForm)
		self:trySetSummon(self.formationMO)
	elseif self.temSimpleForm then
		self.matchForm = self.temSimpleForm
		self.temSimpleForm = nil
	end
end

function AceTeamModel:sendUpdatePetMo()
	if self.isTeamInited == false and checknumber(self.teamId) > 0 then
		AceTeamAgent.instance:sendPM_AceTeamLoadPetsReq()
	end
end

function AceTeamModel:getUpdatePetMo(msg)
	self.isTeamInited = true

	local teamId = msg.teamId
	local teamPetViews = msg.teamPetViews

	for i, baseView in ipairs(teamPetViews) do
		self:updateOnePetMo(teamId, baseView)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_ACETEAM_GETINFO)
end

function AceTeamModel:updateOnePetMo(teamId, baseView)
	local petMo = self:getPetMoByCfgId(teamId, baseView.petId)

	if petMo == nil then
		petMo = BagPetMo.New()
	end

	petMo = self:updatePetMoWithBaseView(petMo, teamId, baseView)

	local key = self:createPetId(teamId, petMo.petId)

	self.groupPetMap[key] = petMo
	self.teamListMap[teamId] = self.teamListMap[teamId] or {}

	local canFind = false

	for i, v in ipairs(self.teamListMap[teamId]) do
		if v.petId == petMo.petId then
			self.teamListMap[teamId][i] = petMo
			canFind = true

			break
		end
	end

	if canFind == false then
		table.insert(self.teamListMap[teamId], petMo)
	end
end

function AceTeamModel:updatePoint(msg)
	self.activityId = msg.activityId
	self.point = msg.point
	self.historyPoint = msg.historyPoint

	MaterialModel.instance:UpdateMaterial(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT, self.point)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ACETEAM_GETINFO)
end

function AceTeamModel:onNotifyFight(msg)
	self.changeSetId = msg.changeSetId
	self.bossId = msg.bossId
	self.btlResult = msg.btlResult
	self.historyMedal = msg.historyMedal
	self.hasMatchFightTimes = checknumber(self.hasMatchFightTimes) + 1

	if self.bossId > 0 then
		self._bossHasMetTimes = self._bossHasMetTimes + 1
		self.bossHasFightTimes = 0
	end

	if msg:HasField("myTeamId") then
		self.myTeamId = msg.myTeamId

		BattleModel.instance:setLeftTeamId(msg.myTeamId)
	else
		self.myTeamId = 0
	end

	MaterialController.instance:saveChangeSetToTemp(self.changeSetId)
	BattleFacade.instance:startAceTeamFight(msg.btlResult)
	UIJumper.instance:pushOneStack(ViewName.AceteammainView, true)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ACETEAM_FIGHTING_END)
	GlobalDispatcher:dispatch(GlobalNotify.PM_ACETEAM_GETINFO)
end

function AceTeamModel:sendGoMatch()
	AceTeamAgent.instance:sendPM_AceTeamMatchFightReq(self.activityId)
end

function AceTeamModel:sendCancelMatch()
	AceTeamAgent.instance:sendPM_AceTeamCancelMatchReq()
end

function AceTeamModel:getCurrBossId()
	return self.bossId
end

function AceTeamModel:sendStarGodLvlup(petId, slot, targetLv)
	AceTeamAgent.instance:sendPM_AceTeamStarGodPlusLvUpReq(petId, slot, targetLv)
end

function AceTeamModel:sendSkillLvlup(petId, selectType, targetLv)
	local serType = CharacterConfig.skillTypeMap[selectType]

	AceTeamAgent.instance:sendPM_AceTeamSkillLvUpReq(petId, serType, targetLv)
end

function AceTeamModel:sendEquipLvlup(petId, positionId, targetLv)
	AceTeamAgent.instance:sendPM_AceTeamEquipmentLvReq(petId, positionId, targetLv)
end

function AceTeamModel:sendAwakeLvlup(petId, targetLv)
	AceTeamAgent.instance:sendPM_AceTeamAwakenLvUpReq(petId, targetLv)
end

function AceTeamModel:sendChangeStarGod(petId, slot, id)
	AceTeamAgent.instance:sendPM_AceTeamChangeStarGodPlusReq(petId, slot, id)
end

function AceTeamModel:sendHolyStripeLvlup(petId, positionId, targetLv)
	AceTeamAgent.instance:sendPM_AceTeamHolyStripeLevelUpReq(petId, positionId, targetLv)
end

function AceTeamModel:sendChangeHolyStripe(petId, suitId)
	AceTeamAgent.instance:sendPM_AceTeamHoyStripeChangeSuitReq(petId, suitId)
end

function AceTeamModel:sendAddPointCount(buyTimes)
	self.tempBuyPointTimes = buyTimes

	AceTeamAgent.instance:sendPM_AceTeamBuyPointReq(buyTimes)
end

function AceTeamModel:onAddPointCount(msg)
	self.buyPointTimes = checknumber(self.buyPointTimes) + checknumber(self.tempBuyPointTimes)
	self.tempBuyPointTimes = 0

	GlobalDispatcher:dispatch(GlobalNotify.PM_ACETEAM_GETINFO)
	TipsFacade.instance:openCommonTips(lang("aceteamagent__1"))
end

function AceTeamModel:onAddBuyTimeCount(msg)
	self.buyMatchFightTimes = checknumber(self.buyMatchFightTimes) + 1

	GlobalDispatcher:dispatch(GlobalNotify.PM_ACETEAM_GETINFO)
end

function AceTeamModel:getPointNum()
	return self.point
end

function AceTeamModel:getBossHasFightTimes()
	return self.bossHasFightTimes
end

function AceTeamModel:getCurrActivityId()
	return self.activityId
end

function AceTeamModel:getCurrSeasonId()
	local cfg = AceTeamConfig.instance:getSeasonCfg(self.activityId)

	if cfg then
		return cfg.seasonId
	end

	return 1
end

function AceTeamModel:getBossHasMetTimes()
	return self._bossHasMetTimes
end

function AceTeamModel:notifyFightBossFinish(msg)
	self.activityId = msg.activityId
	self._bossRestHp = msg.bossRestHp
	self.bossHasFightTimes = self.bossHasFightTimes + 1

	if self._currBattleBossId and self._currBattleBossId > 0 then
		local monsterCfg = AceTeamConfig.instance:getMonsterCfg(self._currBattleBossId)

		if msg.bossRestHp <= 0 or self.bossHasFightTimes >= monsterCfg.challengeTimes then
			self.bossId = 0

			UIJumper.instance:pushOneStack(ViewName.AceteammainView)
		else
			UIJumper.instance:pushOneStack(ViewName.AceteammainView)
			UIJumper.instance:pushOneStack(ViewName.AceteambossView)
		end

		local monsterCfg = AceTeamConfig.instance:getMonsterCfg(self._currBattleBossId)
		local isWin = self._bossRestHp <= 0
		local addPoint = 0
		local addMedal = 0

		if isWin then
			addPoint = monsterCfg.winScoreNum
			addMedal = monsterCfg.winMedalNum
		else
			addPoint = monsterCfg.loseScoreNum
			addMedal = monsterCfg.loseMedalNum
		end

		self._bossFightResultData = {
			bossRestHp = msg.bossRestHp,
			bossId = self._currBattleBossId,
			addPoint = addPoint,
			addMedal = addMedal
		}
	end

	self.historyMedal = msg.historyMedal

	GlobalDispatcher:dispatch(GlobalNotify.PM_ACETEAM_GETINFO)
end

function AceTeamModel:getFightBossEndData()
	return self._bossFightResultData
end

function AceTeamModel:clearFightBossEndData()
	self._bossFightResultData = false
end

function AceTeamModel:recordBattleBossId()
	self._currBattleBossId = AceTeamModel.instance:getCurrBossId()
end

function AceTeamModel:rankDataRes(rankType, msg)
	self._rankDataList[rankType] = rankType == AceteamrankView.TabDefine.Person and {
		rankInfoList = msg.rankInfoList,
		myRank = msg.myRank
	} or {
		rankInfoList = msg.rankInfoList,
		myTeamId = msg.myTeamId,
		activityId = msg.activityId
	}
end

function AceTeamModel:getRankData(rankType)
	return self._rankDataList[rankType]
end

function AceTeamModel:checkBossExits()
	if self.bossId > 0 then
		local monsterCfg = AceTeamConfig.instance:getMonsterCfg(self.bossId)

		return self.bossHasFightTimes < monsterCfg.challengeTimes
	end

	return false
end

function AceTeamModel:calcByHolyStripeAttrs(holyStripeSlots, holyStripeSuitId)
	local res = {}

	for i, v in ipairs(holyStripeSlots or {}) do
		local cfg

		if v.level == 0 then
			-- block empty
		else
			cfg = AceTeamConfig.instance:getHolyStripeCfg(v.positionId, v.level)
		end

		if cfg then
			local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.extproperties) or {}

			res = AttrMo.addSameAttrs(attrs, res)
		end
	end

	if holyStripeSuitId ~= nil then
		local cfg = AceTeamConfig.instance:getHolyStripeSuitCfg(holyStripeSuitId)

		if cfg ~= nil and not string.nilorempty(cfg.attr) then
			local attrs = FightingPowerFormula.instance:parseAttrValues(cfg.extproperties) or {}

			res = AttrMo.addSameAttrs(attrs, res)
		end
	end

	return res
end

function AceTeamModel:setHolyStripeStrengthTip(status)
	GameUtil.saveUserDayData(AceTeamModel.ReadFlag .. "#HolyStripeStrengthTip#", status)
end

function AceTeamModel:getHolyStripeStrengthTip()
	return GameUtil.getUserDayData(AceTeamModel.ReadFlag .. "#HolyStripeStrengthTip#")
end

function AceTeamModel:trySetSummon(formationMo)
	local masterId = 0
	local summonId = 0

	for i, v in pairs(formationMo:GetPositions() or {}) do
		local petMo = formationMo:_getPet(v, true)

		if petMo then
			local summonMasterId = checknumber(petMo.summonMasterId)
			local summonMasterPos = formationMo:GetPetPosition(summonMasterId)

			if summonMasterId > 0 and summonMasterPos ~= nil then
				summonId = petMo.petId
				masterId = checknumber(petMo.summonMasterId)
			end
		end
	end

	if checknumber(formationMo.summonMasterPetId) <= 0 and checknumber(formationMo.summonedPetId) <= 0 and masterId > 0 and summonId > 0 then
		formationMo.summonMasterPetId = masterId
		formationMo.summonedPetId = summonId
	end
end

AceTeamModel.instance = AceTeamModel.New()

return AceTeamModel
