-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragon/model/BoneDragonModel.lua

module("logic.extensions.bonedragon.model.BoneDragonModel", package.seeall)

local BoneDragonModel = class("BoneDragonModel", BaseModel)

BoneDragonModel.FORMATION_POS_NUM = 9

function BoneDragonModel:ctor()
	return
end

function BoneDragonModel:onInit()
	self:onReset()
end

function BoneDragonModel:onReset()
	BoneDragonModel.super.onReset(self)

	self._infos = {}
	self._summonIdxDic = {}
	self._activityId = nil
	self._customFmtMoPool = {}
	self._changeSetIdList = {}
	self._formationPetDic = {
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
	self._supportPetDic = {}
end

function BoneDragonModel:getInfo(activityId)
	return self._infos[activityId]
end

function BoneDragonModel:getActivityId()
	return self._activityId
end

function BoneDragonModel:setActivityId(activityId)
	self._activityId = activityId
end

function BoneDragonModel:getSummonPetId(activityId)
	return self._summonIdxDic[activityId]
end

function BoneDragonModel:setSummonPetId(activityId, summonIdx)
	self._summonIdxDic[activityId] = summonIdx
end

function BoneDragonModel:clearSummonPetId(activityId)
	self._summonIdxDic[activityId] = nil
end

function BoneDragonModel:getFormationPetDic(activityId)
	local formationDic = GameUtil.getUserData("BoneDragonModel" .. activityId) or {
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

	self._formationPetDic = formationDic

	return formationDic
end

function BoneDragonModel:setFormationPetDic(activityId, formationIdx, petId)
	if self._formationPetDic == nil then
		self._formationPetDic = GameUtil.getUserData("BoneDragonModel" .. activityId)
	end

	self._formationPetDic[formationIdx] = petId

	GameUtil.saveUserData("BoneDragonModel" .. activityId, self._formationPetDic)
end

function BoneDragonModel:getFormationPetNum(activityId)
	local formationDic = GameUtil.getUserData("BoneDragonModel" .. activityId) or {
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
	local num = 0

	for k, v in pairs(formationDic) do
		if v ~= 0 then
			num = num + 1
		end
	end

	return num
end

function BoneDragonModel:clearFormationPetDic(activityId)
	self._formationPetDic = {
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

	GameUtil.saveUserData("BoneDragonModel" .. activityId, self._formationPetDic)
end

function BoneDragonModel:getSupportPetMo(petId)
	local petMo = self._supportPetDic[petId]

	if petMo == nil then
		local supportPetCfg = BoneDragonConfig.instance:getSupportCfg(petId)

		if supportPetCfg then
			local fmo = FightingPowerPetMo.New()

			fmo:fromChallengeCreepCo(supportPetCfg)

			petMo = fmo:toBaseBagPetMo()

			petMo:setSupportedPet(true)

			self._supportPetDic[petId] = petMo
		end
	end

	return petMo
end

function BoneDragonModel:getFormationPosAndMo(activityId)
	self._formationPetDic = self:getFormationPetDic(activityId)

	local posList = {}
	local moList = {}

	for pos, petId in pairs(self._formationPetDic) do
		if petId ~= 0 then
			local petMo = self:getSupportPetMo(petId)

			if petMo then
				table.insert(moList, petMo)
			else
				local curBagPetMo = BagPetsController.instance:getPet(petId)

				table.insert(moList, curBagPetMo)
			end

			table.insert(posList, pos)
		end
	end

	return posList, moList
end

function BoneDragonModel:isInFormationPetDic(petId)
	for k, curPetId in ipairs(self._formationPetDic) do
		if curPetId == petId then
			return true
		end
	end

	return false
end

function BoneDragonModel:handlePM_BoneDragonClgInfoRes(msg)
	local pb = GameUtil.pbToTable(msg)

	self._infos[msg.activityId] = self._infos[msg.activityId] or {}
	self._infos[msg.activityId].bestStageId = msg.bestStageId
	self._infos[msg.activityId].curInfo = pb.curInfo or {}
end

function BoneDragonModel:handlePM_BoneDragonClgSelectPetRes(msg)
	local pb = GameUtil.pbToTable(msg)
	local info = self._infos[msg.activityId]

	info.curInfo.pets = info.curInfo.pets or {}

	for i, petId in ipairs(pb.petIds) do
		local curPet = {}

		curPet.petId = petId
		curPet.leftHp = -1

		table.insert(info.curInfo.pets, curPet)
	end
end

function BoneDragonModel:handlePM_BoneDragonClgSelectFormationRes(msg)
	local info = self._infos[msg.activityId]

	info.stageId = msg.stageId
	info.curInfo.formationId = msg.formationId
end

function BoneDragonModel:handlePM_BoneDragonClgRefreshFormationRes(msg)
	local info = self._infos[msg.activityId]

	info.stageId = msg.stageId
	info.selectFormationId = msg.selectFormationId or {}
end

function BoneDragonModel:handlePM_BoneDragonClgConfirmRes(msg)
	local info = self._infos[msg.activityId]

	info.save = msg.save
	info.finish = msg.finish

	if msg.save then
		self:saveChangeSetId(msg.activityId, msg.changeSetId)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end
end

function BoneDragonModel:handlePM_NotifyBoneDragonClgChallengeFinishRes(msg)
	local pb = GameUtil.pbToTable(msg)
	local info = self._infos[msg.activityId]

	info.stageId = msg.stageId
	info.isWin = msg.isWin

	if msg.isWin then
		info.curInfo.pets = pb.pets
	end
end

function BoneDragonModel:handlePM_BoneDragonClgResetRes(msg)
	self._infos[msg.activityId] = self._infos[msg.activityId] or {}
	self._infos[msg.activityId].bestStageId = 0
	self._infos[msg.activityId].curInfo = {}
end

function BoneDragonModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = BoneDragonFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function BoneDragonModel:getPetHp(activityId, petId)
	if self._infos[activityId] then
		if self._infos[activityId] and self._infos[activityId].pets then
			for i, data in ipairs(self._infos[activityId].pets) do
				if petId == data.petId then
					return data.leftHp
				end
			end
		end
	end
end

function BoneDragonModel:getChangeSetId(activityId)
	return self._changeSetIdList[activityId]
end

function BoneDragonModel:saveChangeSetId(activityId, changeSetId)
	self._changeSetIdList[activityId] = changeSetId
end

function BoneDragonModel:getCurChallengePetDic(activityId)
	local info = self._infos[activityId]
	local pets = info.curInfo.pets
	local petDic = {}

	if pets then
		for i, pet in pairs(pets) do
			petDic[pet.petId] = pet.leftHp
		end
	end

	return petDic
end

BoneDragonModel.instance = BoneDragonModel.New()

return BoneDragonModel
