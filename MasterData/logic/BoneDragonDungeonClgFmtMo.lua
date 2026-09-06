-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragondungeon/model/BoneDragonDungeonClgFmtMo.lua

module("logic.extensions.divineskliexinclg.model.BoneDragonDungeonClgFmtMo", package.seeall)

local BoneDragonDungeonClgFmtMo = class("BoneDragonDungeonClgFmtMo", BaseCustomFmtMo)

function BoneDragonDungeonClgFmtMo:initParams(activityId, stageId, eventId, roleId)
	self.activityId = activityId
	self.stageId = stageId
	self.eventId = eventId
	self.roleId = roleId

	local stageCfg = BoneDragonDungeonConfig.instance:getStageCfg(self.activityId, self.stageId)
	local eventCfg = BoneDragonDungeonConfig.instance:getEventCfg(stageCfg.eventPlanId, self.eventId)
	local creepsMasterId = checknumber(eventCfg.eventParam)

	self._cfgEnemy = BoneDragonDungeonConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = BoneDragonDungeonConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)

	self._supportPetIdList = BoneDragonDungeonModel.instance:getBuyPets()
end

function BoneDragonDungeonClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		BoneDragonDungeonAgent.instance:sendPM_BoneDragonDungeonHandleEventReq(self.activityId, self.stageId, self.eventId, self.roleId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function BoneDragonDungeonClgFmtMo:getMonsterConfigList()
	return self._masterList
end

function BoneDragonDungeonClgFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function BoneDragonDungeonClgFmtMo:updateData()
	self:tryInitPetList()

	if self:_isNeedUpdateSupportPet() then
		self:tryRemovePetByIds(self._lastSupportIdList)

		if self._supportPetIdList then
			for i, shopPosId in ipairs(self._supportPetIdList) do
				local cfgSupport = BoneDragonDungeonConfig.instance:getPetShopCfg(self.activityId, shopPosId)

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

function BoneDragonDungeonClgFmtMo:_isNeedUpdateSupportPet()
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

return BoneDragonDungeonClgFmtMo
