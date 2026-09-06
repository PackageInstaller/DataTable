-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/model/BoccaccioChapterC4FmtMo.lua

module("logic.extensions.boccacciochapter.model.BoccaccioChapterC4FmtMo", package.seeall)

local BoccaccioChapterC4FmtMo = class("BoccaccioChapterC4FmtMo", BaseCustomFmtMo)

function BoccaccioChapterC4FmtMo:initParams(activityId, isTrail)
	self.activityId = activityId
	self.isTrail = isTrail

	local actCfg = BoccaccioChapterConfig.instance:getActivityData(self.activityId)

	self._creepsCfg = BoccaccioChapterConfig.instance:getCreepsDatas(actCfg.chapter4CreepsMasterId)
	self._creepsTeamData = BoccaccioChapterConfig.instance:getMasterData(actCfg.chapter4CreepsMasterId)
	self.topTitleStr = self._creepsTeamData.name
	self.ruleDescStr = self._creepsTeamData.ruleDesc
	self.isOnlyUpdateExistPet = true
	self.validatorDescStr = "本挑战中使用的精灵为第三章中的【吞噬精灵】"
	self._lockedPetRaceIdMap = {}

	local chapter4Info = BoccaccioChapterController.instance:getChapterInfo(self.activityId, BoccaccioChapterEnum.ChapterId_4)

	if chapter4Info then
		if not chapter4Info.todayBanRaceId then
			do
				local lockedRaceIds = {}

				for _, raceId in ipairs(lockedRaceIds) do
					self._lockedPetRaceIdMap[checknumber(raceId)] = true
				end
			end

			local petIdMap = {}

			self._canUsePetIds = {}

			local chapter3Info = BoccaccioChapterController.instance:getChapterInfo(self.activityId, BoccaccioChapterEnum.ChapterId_3)

			if chapter3Info then
				if not chapter3Info.stageInfo then
					for _, stageInfo in pairs(chapter3Info.stageInfo) do
						if not stageInfo.hasConsumeCharacterId then
							for _, petId in ipairs(stageInfo.hasConsumeCharacterId) do
								if not petIdMap[petId] and BagPetsController.instance:hasPet(petId) then
									petIdMap[petId] = true

									table.insert(self._canUsePetIds, petId)
								end
							end
						end
					end
				end
			end

			self:clearAllPetList()
			self:tryInitPetList()
		end
	end
end

function BoccaccioChapterC4FmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		BoccaccioChapterController.instance:sendPM_BoccaccioChapter4ClgReq(self.activityId, simpleForm, self.isTrail)
	end

	self:setFightHandler(handler, nil)
end

function BoccaccioChapterC4FmtMo:initPetList()
	self:clearAllPetList()

	for _, petId in pairs(self._canUsePetIds) do
		local petMo = BagPetsController.instance:getPet(petId)

		if petMo then
			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

function BoccaccioChapterC4FmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function BoccaccioChapterC4FmtMo:getFmtInfoConfig()
	return self._creepsTeamData
end

function BoccaccioChapterC4FmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self._lockedPetRaceIdMap[petMo.raceId])
end

function BoccaccioChapterC4FmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵已被锁定")
end

return BoccaccioChapterC4FmtMo
