-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/model/BoccaccioChapterC2FmtMo.lua

module("logic.extensions.boccacciochapter.model.BoccaccioChapterC2FmtMo", package.seeall)

local BoccaccioChapterC2FmtMo = class("BoccaccioChapterC2FmtMo", BaseCustomFmtMo)

function BoccaccioChapterC2FmtMo:onReset()
	BoccaccioChapterC2FmtMo.super.onReset(self)
end

function BoccaccioChapterC2FmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._chapterId = BoccaccioChapterEnum.ChapterId_2

	local stageData = BoccaccioChapterConfig.instance:getChapter2StageData(self._activityId, self._stageId)

	self._storyId = stageData.storyId
	self._creepsMasterId = stageData.creepsMasterId
	self._creepsTeamData = BoccaccioChapterConfig.instance:getMasterData(self._creepsMasterId)
	self._creepsCfg = BoccaccioChapterConfig.instance:getCreepsDatas(self._creepsMasterId)

	local chapterData = BoccaccioChapterConfig.instance:getChapterData(self._activityId, self._chapterId)

	if chapterData then
		if not chapterData.supportPetPlan then
			local supportPetPlan = 0
			local supportPetDataList = BoccaccioChapterConfig.instance:getSupportPetDatasByPlan(self._activityId, supportPetPlan)

			if chapterData then
				self._mustDeployPetId = chapterData.mustDeployPetId or 0
			end

			self._supportCreepsIdList = {}

			for _, data in ipairs(supportPetDataList) do
				table.insert(self._supportCreepsIdList, data.creepsId)
			end

			self.topTitleStr = self._creepsTeamData.name
			self.validatorDescStr = self._creepsTeamData.missionDesc
			self.ruleDescStr = self._creepsTeamData.ruleDesc

			self:setFormCondition(self._creepsTeamData.formCondition)

			self.isOnlyUpdateExistPet = true
		end
	end
end

function BoccaccioChapterC2FmtMo:getActivityId()
	return self._activityId
end

function BoccaccioChapterC2FmtMo:getStageId()
	return self._stageId
end

function BoccaccioChapterC2FmtMo:getChapterId()
	return self._chapterId
end

function BoccaccioChapterC2FmtMo:getStoryId()
	return self._storyId
end

function BoccaccioChapterC2FmtMo:initPetList()
	self:clearAllPetList()

	for _, creepsId in pairs(self._supportCreepsIdList) do
		local data = BoccaccioChapterConfig.instance:getSupportPetData(self._activityId, creepsId)

		self._fmo = self._fmo or FightingPowerPetMo.New()

		self._fmo:fromChallengeCreepCo(data)

		local petMo = self._fmo:toBaseBagPetMo()

		petMo:setSupportedPet(true)
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function BoccaccioChapterC2FmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		BoccaccioChapterController.instance:sendPM_BoccaccioChapter2ClgReq(self._activityId, self._storyId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function BoccaccioChapterC2FmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if self._mustDeployPetId > 0 then
		local fmo = self:getCurFormation()
		local petMo = self:getPetMoById(self._mustDeployPetId)
		local raceId = petMo and petMo:getDefineId() or 0

		if not fmo:HasRace(raceId) then
			local deployPetData = BoccaccioChapterConfig.instance:getSupportPetData(self._activityId, self._mustDeployPetId)
			local name = deployPetData and deployPetData.creepsName

			FloatWordMgr.instance:show(string.format("阵容缺失%s，无法挑战", name))

			return true
		end
	end

	return ChopKingAgainstTwoFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
end

function BoccaccioChapterC2FmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function BoccaccioChapterC2FmtMo:getFmtInfoConfig()
	return self._creepsTeamData
end

function BoccaccioChapterC2FmtMo:getFinalFmoList(posList, petList, needPets)
	local fixPosList = {}
	local fixPetMoList = {}
	local petMo = self:getPetMoById(self._mustDeployPetId)
	local formation = self:getCurFormation()

	if petMo and not formation:HasRace(petMo:getDefineId()) then
		local fitPosId = 0

		for posId = 1, 9 do
			local id = checknumber(formation:GetPosition(posId))

			if id == 0 then
				fitPosId = posId

				break
			end
		end

		table.insert(fixPosList, fitPosId)
		table.insert(fixPetMoList, petMo)
	end

	posList, petList = CustomFmtController.instance:getFinalFmoListAsFixPos(self:getCurFormation(), posList, petList, needPets, fixPosList, fixPetMoList, self.needUpPetCount)

	if self.needUpPetCount > 5 then
		posList, petList = CustomFmtController.instance:extraPetAtFormation(self.needUpPetCount, needPets, petList, posList, self:getCurFormation())
	end

	return posList, petList
end

function BoccaccioChapterC2FmtMo:getExtendViewName()
	return ViewName.BoccaccioChapterTwoStageFmtExView
end

return BoccaccioChapterC2FmtMo
