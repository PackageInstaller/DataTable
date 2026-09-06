-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragon/model/BoneDragonFmtMo.lua

module("logic.extensions.bonedragon.model.BoneDragonFmtMo", package.seeall)

local BoneDragonFmtMo = class("BoneDragonFmtMo", BaseCustomFmtMo)

function BoneDragonFmtMo:updateCfg(activityId, stageId, petPosList, petMoList, summonIdx, allPetIds)
	self._summonIdx = checknumber(summonIdx)
	self._allPetIds = allPetIds
	self._activityId = activityId
	self._stageId = stageId
	self._creepsMasterId = BoneDragonConfig.instance:getCreepsMasterId(activityId, stageId)
	self._masterData = BoneDragonConfig.instance:getMasterCfg(self._creepsMasterId)
	self._creepsCfg = BoneDragonConfig.instance:getCreepsCfg(self._creepsMasterId)
	self._petPosList = petPosList
	self._petMoList = petMoList
	self._myFixPosList = {
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
	self.isOnlyUpdateExistPet = true
	self.isShowOneKey = false
	self.isShowClean = false
	self.isOnlyUpdateExistPet = true
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
	self:clearAllPetList()
	self:_createSummonPet()
	self:_resetMyFormation()

	if #self._mySummonPetList > 0 then
		local formationMo = self:getCurFormation()
		local summonedPetId = self._mySummonPetList[1].petId

		formationMo:SetPosition(self._summonIdx, summonedPetId)

		formationMo.summonedPetId = summonedPetId
		formationMo.summonMasterPetId = self._mySummonMap[summonedPetId]
	end
end

function BoneDragonFmtMo:_createSummonPet()
	self._mySummonPetList = {}
	self._mySummonMap = {}

	local map = {}

	for _, petMo in ipairs(self._petMoList) do
		map[petMo.petId] = petMo
	end

	self._myFormationPet = map

	if self._summonIdx > 0 then
		for i, petInfo in ipairs(self._allPetIds or {}) do
			local petId = petInfo.petId

			if not map[petId] then
				local petMo = BoneDragonModel.instance:getSupportPetMo(petId)

				petMo = petMo or BagPetsController.instance:getPet(petId)

				for i, mo in pairs(map) do
					local jobNameList = PetSkinConfig.instance:getJobKeyList(mo.curFaceId)

					if mo.isMyPackPet and table.indexof(jobNameList, GameEnum.JobZhDefine.Zhaohuanshi) and petMo and ContractConfig.instance:getGroupCfg(mo.raceId, petMo.raceId) then
						table.insert(self._mySummonPetList, petMo)

						self._mySummonMap[petMo.petId] = mo.petId
					end
				end
			end
		end
	end
end

function BoneDragonFmtMo:onSummonPosSetdown()
	local formationMo = self:getCurFormation()
	local summonedPetId = checknumber(formationMo.summonedPetId)

	if summonedPetId > 0 then
		local pos = formationMo:GetPetPosition(summonedPetId)

		formationMo:SwapPosition(pos, self._summonIdx)
	else
		self:_resetMyFormation()
	end
end

function BoneDragonFmtMo:_resetMyFormation()
	local formationMo = self:getCurFormation()

	formationMo:ResetPosition(true)

	formationMo.isBanMySummonPet = true

	for i, posIdx in ipairs(self._petPosList) do
		local petId = self._petMoList[i].petId

		formationMo:SetPosition(posIdx, petId)
	end

	formationMo.summonMasterPetId = -1
	formationMo.summonedPetId = -1
end

function BoneDragonFmtMo:initPetList()
	self:clearAllPetList()

	self._usingPetMap = {}
	self._usingRaceIdMap = {}

	for _, petMo in ipairs(self._petMoList) do
		self:addPetToList(self:_changePetMo(petMo))

		self._usingPetMap[petMo.petId] = true
		self._usingRaceIdMap[petMo.raceId] = true
	end

	for _, petMo in ipairs(self._mySummonPetList) do
		self:addPetToList(self:_changePetMo(petMo))

		self._usingPetMap[petMo.petId] = true
		self._usingRaceIdMap[petMo.raceId] = true
	end

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		local raceId = petMo.raceId
		local curRaceIdHasInFmt = self._usingRaceIdMap[raceId]

		if not self._usingPetMap[petMo.petId] and not curRaceIdHasInFmt then
			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

function BoneDragonFmtMo:checkPetIsInOtherTab(petMo)
	if self._myFormationPet[petMo.petId] then
		return true
	end

	return false
end

function BoneDragonFmtMo:onFilterPetShow(petMo)
	return checkbool(self._usingPetMap[petMo.petId])
end

function BoneDragonFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		BoneDragonController.instance:sendPM_BoneDragonClgChallengeReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function BoneDragonFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function BoneDragonFmtMo:getFmtInfoConfig()
	return self._masterData
end

function BoneDragonFmtMo:getFixedPosList()
	return self._myFixPosList
end

function BoneDragonFmtMo:beginDragBagPet(petMo)
	FloatWordMgr.instance:show("不可调整站位")
end

function BoneDragonFmtMo:beginDragFormationPet(bagPetMo, startPosIndex)
	FloatWordMgr.instance:show("不可调整站位")
end

return BoneDragonFmtMo
