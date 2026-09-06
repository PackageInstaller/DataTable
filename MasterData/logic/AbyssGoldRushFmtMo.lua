-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/model/AbyssGoldRushFmtMo.lua

module("logic.extensions.abyssgoldrush.model.AbyssGoldRushFmtMo", package.seeall)

local AbyssGoldRushFmtMo = class("AbyssGoldRushFmtMo", BaseCustomFmtMo)
local ALL_FORMATION_POS_LIST = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9
}

function AbyssGoldRushFmtMo:onInit()
	AbyssGoldRushFmtMo.super.onInit(self)

	self.isOnlyUpdateExistPet = true
end

function AbyssGoldRushFmtMo:initFormationMo()
	AbyssGoldRushFmtMo.super.initFormationMo(self)

	self._petMapAsRight = {}
	self._isHideEnemyPets = false
	self._isFormationLock = false
	self._formationMoOfEnemy = FormationMO.New(GameUtil.handler(self.getPetMoByIdOfEnemy, self))
end

function AbyssGoldRushFmtMo:initParams(activityId)
	self.activityId = activityId

	local gameInfo = AbyssGoldRushGameModel.instance:getGameInfo()
	local curStepId = AbyssGoldRushGameController.instance:getNextStepId(activityId)
	local stepCfg = AbyssGoldRushConfig.instance:getStepCfg(self.activityId, curStepId)

	self.roundId = stepCfg.roundId
	self._opInfo = self:getOpInfo()
	self._opGameForm = self._opInfo and self._opInfo.formList and self._opInfo.formList[stepCfg.roundId]
	self._isHideEnemyPets = false
	self._isFormationLock = false

	if self._opInfo then
		local headInfo = self._opInfo.opPlayerHead

		self.topTitleStr = lang("深渊淘金")
		self._robotId = checknumber(headInfo.userId) <= 0 and -checknumber(headInfo.userId) or nil
		self.formationStage = 1

		self:_updateOpponentFmt()

		self._useHolyStripe = AbyssGoldRushGameModel.instance:getUseHolyStripe()

		self:initPetList()
	end
end

function AbyssGoldRushFmtMo:checkUseHolyStripe()
	self._useHolyStripe = AbyssGoldRushGameModel.instance:getUseHolyStripe()
end

function AbyssGoldRushFmtMo:setFormationLock(isLock)
	isLock = isLock == true

	if self._isFormationLock == isLock then
		return
	end

	self._isFormationLock = isLock

	self:_updateFormationLockState()
end

function AbyssGoldRushFmtMo:_updateFormationLockState()
	if self._isFormationLock then
		MissionModel.instance:setFixedPos(ALL_FORMATION_POS_LIST)
	else
		MissionModel.instance:setFixedPos(nil)
	end
end

function AbyssGoldRushFmtMo:getFixedPosList()
	if self._isFormationLock then
		return ALL_FORMATION_POS_LIST
	end

	return nil
end

function AbyssGoldRushFmtMo:checkPetIsForbit(petMo, baseCheck)
	if self._isFormationLock then
		return true
	end

	return AbyssGoldRushFmtMo.super.checkPetIsForbit(self, petMo, baseCheck)
end

function AbyssGoldRushFmtMo:showForbitPetAlert(petMo)
	if self._isFormationLock then
		FloatWordMgr.instance:show("当前无法调整阵上精灵")

		return
	end

	AbyssGoldRushFmtMo.super.showForbitPetAlert(self, petMo)
end

function AbyssGoldRushFmtMo:getFailedTips()
	if self._isFormationLock then
		return "当前无法调整阵上精灵"
	end

	return nil
end

function AbyssGoldRushFmtMo:isPetUnableToLeve(oldPetId, newPetId)
	if self._isFormationLock then
		return true
	end

	return false
end

function AbyssGoldRushFmtMo:hideAllEnemyPets()
	if self._isHideEnemyPets then
		return
	end

	self._isHideEnemyPets = true
	self._petMapAsRight = {}

	if self._formationMoOfEnemy then
		self._formationMoOfEnemy:ResetPosition(true)
	end

	GlobalDispatcher:dispatch(GlobalNotify.RefreshEnemyFmt)
end

function AbyssGoldRushFmtMo:showAllEnemyPets()
	if not self._isHideEnemyPets then
		return
	end

	self._isHideEnemyPets = false

	self:_updateOpponentFmt()
	GlobalDispatcher:dispatch(GlobalNotify.RefreshEnemyFmt)
end

function AbyssGoldRushFmtMo:getGameInfo()
	return AbyssGoldRushGameModel.instance:getGameInfo()
end

function AbyssGoldRushFmtMo:getOpInfo()
	local gameInfo = self:getGameInfo()

	return gameInfo and gameInfo.op
end

function AbyssGoldRushFmtMo:getPetMoByIdOfEnemy(petId)
	return self._petMapAsRight[petId]
end

function AbyssGoldRushFmtMo:initPetList()
	self:clearAllPetList()

	local gameInfo = self:getGameInfo()

	if not gameInfo or not gameInfo.petList then
		return
	end

	for _, gamePet in ipairs(gameInfo.petList) do
		local petMo = self:_createPetMoByCreepsId(gamePet.creepsId, gamePet.withBuff)

		if petMo then
			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

function AbyssGoldRushFmtMo:_changePetMo(petMo)
	local attrStrList = {}

	for i, v in ipairs(self._useHolyStripe) do
		local holyStripeInfo = AbyssGoldRushGameModel.instance:getHolyStripeSingleInfo(v)

		if holyStripeInfo then
			local holystripeCfg = AbyssGoldRushConfig.instance:getHolyStripeCfg(holyStripeInfo.defineId)

			table.insert(attrStrList, holystripeCfg.property)
		end
	end

	local holyStripeAttrStr = table.concat(attrStrList, "#")
	local attrs = string.split(holyStripeAttrStr, "#")
	local holyStripeAttr = {}

	for i = 1, #attrs do
		local attrName, attrVal = FightingPowerFormula.instance:getAttrNameValue(attrs[i])
		local attrType = FightingPowerFormula.instance:getAttrTypeByName(attrName)

		if attrType then
			holyStripeAttr[attrType] = checknumber(holyStripeAttr[attrType]) + attrVal
		end
	end

	for k, v in pairs(holyStripeAttr) do
		petMo.extpropertiesArr[k] = checknumber(petMo.extpropertiesArr[k]) + v
	end

	petMo:calcAllAttr()

	return petMo
end

function AbyssGoldRushFmtMo:_updateOpponentFmt()
	self._petMapAsRight = {}

	if self._formationMoOfEnemy then
		self._formationMoOfEnemy:ResetPosition(true)
	end

	if not self._opGameForm or not self._opGameForm.form then
		return
	end

	local simpleForm = self._opGameForm.form

	for _, petId in ipairs(simpleForm.pos or {}) do
		petId = checknumber(petId)

		if petId > 0 then
			local petMo = self:_createEnemyPetMo(petId)

			if petMo then
				self._petMapAsRight[petId] = petMo
			end
		end
	end

	self._formationMoOfEnemy:SetData(simpleForm)
end

function AbyssGoldRushFmtMo:_createPetMoByCreepsId(creepsId, withBuff)
	local petCfg = AbyssGoldRushConfig.instance:getPetCfg(creepsId)

	if not petCfg then
		return nil
	end

	local fMo = FightingPowerPetMo.New()
	local tempCfg = {}

	for k, v in pairs(petCfg) do
		tempCfg[k] = v
	end

	local attrList = {
		tempCfg.extproperties
	}

	tempCfg.extproperties = table.concat(attrList, "#")

	fMo:fromChallengeCreepCo(petCfg)

	local petMo = fMo:toBaseBagPetMo()

	petMo.petId = creepsId
	petMo.withBuff = withBuff

	return petMo
end

function AbyssGoldRushFmtMo:_createEnemyPetMo(creepsId)
	local petCfg = AbyssGoldRushConfig.instance:getPetCfg(creepsId)

	if not petCfg then
		return nil
	end

	local fMo = FightingPowerPetMo.New()

	fMo:fromChallengeCreepCo(petCfg)

	local petMo = fMo:toBaseBagPetMo()

	petMo.petId = creepsId
	petMo.isMyPackPet = false

	return petMo
end

function AbyssGoldRushFmtMo:getMonsterConfigList()
	if self._robotId then
		local robotCfg = AbyssGoldRushConfig.instance:getRobotCfg(self._robotId, self.roundId)

		return AbyssGoldRushConfig.instance:getCreepsCfg(robotCfg.creepsMasterId)
	else
		return {}
	end
end

function AbyssGoldRushFmtMo:getExtParams()
	if self._isHideEnemyPets then
		return {}
	end

	if self._robotId then
		return nil
	end

	if self._formationMoOfEnemy then
		local simpleForm = CustomFmtController.instance:createFormPb(self._formationMoOfEnemy)

		return simpleForm.extParams or {}
	end

	return {}
end

function AbyssGoldRushFmtMo:getFmtInfoConfig()
	if self._isHideEnemyPets then
		return {}
	end

	if self._robotId then
		local robotCfg = AbyssGoldRushConfig.instance:getRobotCfg(self._robotId, self.roundId)

		return AbyssGoldRushConfig.instance:getTeamCfg(robotCfg.creepsMasterId)
	end

	if self._formationMoOfEnemy then
		local simpleForm = CustomFmtController.instance:createFormPb(self._formationMoOfEnemy)

		return simpleForm.extParams or {}
	end

	return {}
end

function AbyssGoldRushFmtMo:getTeamAndFormation(creepCfg)
	if self._isHideEnemyPets then
		return {}, {}
	end

	if self._robotId then
		return AbyssGoldRushFmtMo.super.getTeamAndFormation(self, creepCfg)
	end

	local fmtMo = self._formationMoOfEnemy

	if not fmtMo then
		return {}, {}
	end

	local teams, formations = fmtMo:getTeamAndFormation()

	ArraySort.sortOn(teams, "position")

	local resultFormations = {}

	for posId, bagPetMo in pairs(formations) do
		local fightingPowerMo = bagPetMo:toFightingPowerPetMo()

		fightingPowerMo.petId = bagPetMo:getPetId()
		resultFormations[posId] = fightingPowerMo
	end

	return teams, resultFormations
end

function AbyssGoldRushFmtMo:initFightHandler()
	local function handler()
		self:fightHandler()
	end

	self:setFightHandler(handler, nil)
end

function AbyssGoldRushFmtMo:fightHandler()
	ViewMgr.instance:close(ViewName.AbyssGoldRushBagView)
	UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

	local simpleForm = self:getCurSimpleForm()
	local useHolyStripeIds = AbyssGoldRushGameModel.instance:getUseHolyStripe()

	AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushFightReq(self.activityId, simpleForm, useHolyStripeIds)
end

function AbyssGoldRushFmtMo:onClickCloseBtn(handler)
	return
end

function AbyssGoldRushFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if self.formationStage == 1 then
		GlobalDispatcher:dispatch(GlobalNotify.AbyssGoldRushFormationConfirm)

		return true
	end

	return AbyssGoldRushFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
end

function AbyssGoldRushFmtMo:getExtendViewName()
	return ViewName.AbyssGoldRushFmtView
end

function AbyssGoldRushFmtMo:setFormationStage(stage)
	self.formationStage = stage
end

function AbyssGoldRushFmtMo:isEmpty()
	return self:getCurFormation():isEmpty()
end

function AbyssGoldRushFmtMo:updateCellTop(cell, petMo)
	local luaCls = AbyssGoldRushFmtPet
	local url = AbyssGoldRushFmtPet.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		if petMo.withBuff == true then
			local petCfg = AbyssGoldRushConfig.instance:getSupportPet(petMo.petId)

			proxy.binder:onUpdateView(petCfg.buffRes)
		else
			proxy.binder:onUpdateView()
		end
	end
end

return AbyssGoldRushFmtMo
