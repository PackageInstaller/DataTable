-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/model/BountyPkCompeteFmtMo.lua

module("logic.extensions.bountypkcompete.model.BountyPkCompeteFmtMo", package.seeall)

local BountyPkCompeteFmtMo = class("BountyPkCompeteFmtMo", ICustomFmtMo)

function BountyPkCompeteFmtMo:onReset()
	BountyPkCompeteFmtMo.super.onReset(self)

	self.isShowBtnCutePet = false
end

function BountyPkCompeteFmtMo:updateData()
	self.isShowBtnSave = false
	self.isShowBtnFormation = false
	self.isShowBtnBuffForm = false
	self.isStartButtonAvailable = false
	self.isShowOneKey = false
	self.isShowClean = false
	self.topTitleStr = "赏金PK赛"
	self.ruleDescStr = ""

	self:updateAll()
end

function BountyPkCompeteFmtMo:updateAll()
	local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()
	local needUpPetCount = 0
	local curRoundId = phaseModel.roundId
	local roundConfigs = BountyPKCompeteConfig.instance:getRoundConfigs()

	for i = 1, curRoundId do
		local roundConfig = roundConfigs[i]

		if roundConfig then
			needUpPetCount = needUpPetCount + roundConfig.formNum
		end
	end

	self.needUpPetCount = needUpPetCount

	MissionModel.instance:setMaxPetNum(self.needUpPetCount)
	self:clearAllPetList()
	MissionModel.instance:setFixedPos(phaseModel:getMyFormCachePosIds())
end

function BountyPkCompeteFmtMo:getFinalFmoList(posList, petPool, needPets)
	if self.needUpPetCount > 5 then
		posList, petPool = CustomFmtController.instance:extraPetAtFormation(self.needUpPetCount, needPets, petPool, posList, self:getCurFormation())
	elseif self.needUpPetCount < 5 then
		local count = table.nums(petPool) - self.needUpPetCount

		for i = 1, 9 do
			if count > 0 and petPool[i] then
				petPool[i] = nil
				count = count - 1
			end
		end
	end

	return posList, petPool
end

function BountyPkCompeteFmtMo:isUseMaxStreng()
	return true
end

function BountyPkCompeteFmtMo:sendFightMsg()
	return
end

function BountyPkCompeteFmtMo:initFightHandler()
	return
end

function BountyPkCompeteFmtMo:initSaveHandler()
	return
end

function BountyPkCompeteFmtMo:onClickCloseBtn(handler)
	local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

	phaseModel:reqAbandon()
end

function BountyPkCompeteFmtMo:initPetList()
	local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()
	local configInstance = BountyPKCompeteConfig.instance

	for _, petId in ipairs(phaseModel.myPetIds) do
		local data = configInstance:getSystemPetConfig(petId)

		if data then
			local fmo = FightingPowerPetMo.New()

			fmo:fromChallengeCreepCo(data)

			local petMo = fmo:toBaseBagPetMo()

			if phaseModel:isInFormation(petId) then
				petMo:setPetForbit(true)
			else
				petMo:setPetForbit(false)
			end

			self:addPetToList(petMo)
		else
			printError("查找精灵配置失败。。。。。。。。。", petId)
		end
	end
end

function BountyPkCompeteFmtMo:getMonsterConfigList()
	local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()
	local configInstance = BountyPKCompeteConfig.instance
	local result = {}

	if phaseModel.opForm and phaseModel.opForm.pos then
		for posId, petId in ipairs(phaseModel.opForm.pos) do
			if petId > 0 then
				local data = configInstance:getSystemPetConfig(petId)

				if data then
					local co = {
						creepsId = data.creepsId,
						raceId = data.raceId,
						creepsName = data.creepsName,
						posId = posId,
						lv = data.lv,
						talentLv = data.talentLv,
						awakenLv = data.awakenLv,
						equipment = data.equipment,
						extproperties = data.extproperties,
						onlyUseExtProperties = data.onlyUseExtProperties,
						extBuffs = data.extBuffs,
						maxHp = data.maxHp
					}

					table.insert(result, co)
				else
					printError("查找精灵配置失败。。。。。。。。。", petId)
				end
			end
		end
	end

	return result
end

function BountyPkCompeteFmtMo:getFmtInfoConfig()
	local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()
	local result = {}

	if phaseModel.opForm and phaseModel.opForm.extParams then
		return phaseModel.opForm.extParams
	end

	return result
end

function BountyPkCompeteFmtMo:getExtParams()
	return self:getFmtInfoConfig()
end

function BountyPkCompeteFmtMo:getExtendViewName()
	return ViewName.BountyPKCompeteFmtView
end

function BountyPkCompeteFmtMo:checkBlockClickBtn(buttonName)
	local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()
	local isPhaseSettingForm = phaseModel.phase == BountyPkCompetePhaseHandler.PhaseSettingForm

	if isPhaseSettingForm then
		if buttonName == "ElementSkill" then
			return false
		end

		FloatWordMgr.instance:show("当前无法改变阵型")

		return true
	end

	if phaseModel.phase == BountyPkCompetePhaseHandler.PhaseBetting and buttonName == "ElementSkill" then
		FloatWordMgr.instance:show("当前无法改变阵型")

		return true
	end

	return false
end

return BountyPkCompeteFmtMo
