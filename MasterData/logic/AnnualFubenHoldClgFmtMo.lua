-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/model/AnnualFubenHoldClgFmtMo.lua

module("logic.extensions.annualfuben.model.AnnualFubenHoldClgFmtMo", package.seeall)

local AnnualFubenHoldClgFmtMo = class("AnnualFubenHoldClgFmtMo", BaseCustomFmtMo)

function AnnualFubenHoldClgFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId

	local stageCfg = AnnualFubenConfig.instance:getHoldStageCfg(self.activityId, self.stageId)
	local creepsMasterId = checknumber(stageCfg.creepsMasterId)

	self._cfgEnemy = AnnualFubenConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = AnnualFubenConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)

	local supportPetCfgs = AnnualFubenConfig.instance:getSupportPetCfgs(self.activityId)

	self._supportPetIdList = {}

	for k, v in pairs(supportPetCfgs) do
		table.insert(self._supportPetIdList, v.creepsId)
	end
end

function AnnualFubenHoldClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		AnnualFubenAgent.instance:sendPM_AnnualFubenSimpleStageChallengeReq(self.activityId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function AnnualFubenHoldClgFmtMo:getMonsterConfigList()
	return self._masterList
end

function AnnualFubenHoldClgFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function AnnualFubenHoldClgFmtMo:updateData()
	self:tryInitPetList()

	if self:_isNeedUpdateSupportPet() then
		self:tryRemovePetByIds(self._lastSupportIdList)

		if self._supportPetIdList then
			for i, shopPosId in ipairs(self._supportPetIdList) do
				local cfgSupport = AnnualFubenConfig.instance:getSupportPetCfg(self.activityId, shopPosId)

				if cfgSupport then
					local fmo = FightingPowerPetMo.New()

					fmo:fromChallengeCreepCo(cfgSupport)
					fmo:setSupportedPet(true)

					local supportPetMo = fmo:toBaseBagPetMo()

					self:addPetToList(supportPetMo)
				end
			end
		end
	end

	self._lastSupportIdList = self._supportPetIdList
end

function AnnualFubenHoldClgFmtMo:_isNeedUpdateSupportPet()
	local curSupportCount = #self._supportPetIdList

	if self._lastSupportIdList then
		if not #self._lastSupportIdList then
			local lastSupportCount = 0

			if curSupportCount ~= lastSupportCount then
				return true
			end

			if curSupportCount == 0 then
				return false
			end

			local sameCount = 0

			for i, id1 in ipairs(self._supportPetIdList) do
				for j, id2 in ipairs(self._lastSupportIdList) do
					if id1 == id2 then
						sameCount = sameCount + 1

						break
					end
				end
			end

			return sameCount ~= curSupportCount
		end
	end
end

return AnnualFubenHoldClgFmtMo
