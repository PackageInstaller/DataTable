local MetaProgress = class("MetaProgress", import("..BaseVO"))

MetaProgress.STATE_LESS_PT = 1
MetaProgress.STATE_LESS_STORY = 2
MetaProgress.STATE_CAN_AWARD = 3
MetaProgress.STATE_CAN_FINISH = 4
MetaProgress.STATE_GOT_SHIP = 5

function MetaProgress:bindConfigTable()
	return pg.ship_strengthen_meta
end

function MetaProgress:Ctor(arg_2_1)
	self.id = arg_2_1.id
	self.configId = self.id
	self.metaType = self:getConfig("type")
	self.actID = self:getConfig("activity_id")
	self.metaShipVO = nil

	if self:isPtType() then
		self.unlockPTNum = self:getConfig("synchronize")
		self.unlockPTLevel = nil
		self.metaPtData = MetaPTData.New({
			group_id = self.id
		})

		local var_2_0

		for iter_2_0, iter_2_1 in ipairs(pg.world_joint_boss_template.all) do
			if pg.world_joint_boss_template[iter_2_1].meta_id == self.id then
				var_2_0 = pg.world_joint_boss_template[iter_2_1]

				break
			end
		end

		if var_2_0 then
			self.timeConfig = var_2_0.state
		end
	end

	return
end

function MetaProgress:updateMetaPtData(arg_3_1)
	if self.metaPtData then
		self.metaPtData:Update(arg_3_1)
	end

	return
end

function MetaProgress:getSynRate()
	local var_4_0, var_4_1, var_4_2 = self.metaPtData:GetResProgress()

	return var_4_0 / self.unlockPTNum
end

function MetaProgress:getStoryIndexList()
	return self:getConfig("unlock_story") or {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
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
end

function MetaProgress:getCurLevelStoryIndex()
	local var_6_0, var_6_1, var_6_2 = self.metaPtData:GetLevelProgress()

	return self:getStoryIndexList()[var_6_0]
end

function MetaProgress:isFinishCurLevelStory()
	local var_7_0 = self:getCurLevelStoryIndex()
	local var_7_1 = false

	if var_7_0 == 0 then
		var_7_1 = true
	else
		local var_7_2 = pg.NewStoryMgr.GetInstance()

		if var_7_2:IsPlayed((var_7_2:StoryName2StoryId(var_7_0))) then
			var_7_1 = true
		end
	end

	return var_7_1
end

function MetaProgress:getCurLevelStoryName()
	return pg.memory_template[self:getCurLevelStoryIndex()].title
end

function MetaProgress:isCanGetAward()
	local var_9_0 = self.metaPtData:CanGetAward()
	local var_9_1 = self:getCurLevelStoryIndex()
	local var_9_2 = false

	if var_9_1 == 0 then
		var_9_2 = true
	else
		local var_9_3 = pg.NewStoryMgr.GetInstance()
		local var_9_4 = var_9_3:GetStoryByName("index")[var_9_1]

		if var_9_3:IsPlayed(var_9_1) then
			var_9_2 = true
		end
	end

	return var_9_0 and var_9_2
end

function MetaProgress:getMetaProgressPTState()
	local var_10_0 = self.metaPtData:CanGetAward()
	local var_10_1 = self:isFinishCurLevelStory()
	local var_10_2 = self:isUnlocked()

	if self.metaPtData.level + 1 < self.unlockPTLevel then
		if not var_10_0 then
			return MetaProgress.STATE_LESS_PT
		elseif var_10_1 == false then
			return MetaProgress.STATE_LESS_STORY
		elseif var_10_1 == true then
			return MetaProgress.STATE_CAN_AWARD
		end
	elseif self.metaPtData.level + 1 == self.unlockPTLevel then
		if not var_10_0 then
			return MetaProgress.STATE_LESS_PT
		elseif var_10_1 == false then
			return MetaProgress.STATE_LESS_STORY
		elseif var_10_1 == true then
			return MetaProgress.STATE_CAN_FINISH
		end
	elseif self.metaPtData.level + 1 > self.unlockPTLevel then
		return MetaProgress.STATE_GOT_SHIP
	end

	return
end

function MetaProgress:IsGotAllAwards()
	return self:isInAct() and self:isInArchive() and not self.metaPtData:CanGetNextAward()
end

function MetaProgress:getRepairRateFromMetaCharacter()
	assert(self.metaShipVO, "metaShipVO is null")
	assert(self.metaShipVO.metaCharacter, "metaCharacterVO is null")

	return (self.metaShipVO.metaCharacter:getRepairRate())
end

function MetaProgress:isPtType()
	return self.metaType == MetaCharacterConst.Meta_Type_Act_PT
end

function MetaProgress:isPassType()
	return self.metaType == MetaCharacterConst.Meta_Type_Pass
end

function MetaProgress:isBuildType()
	return self.metaType == MetaCharacterConst.Meta_Type_Build
end

function MetaProgress:isInAct()
	if self:isPtType() then
		return WorldBossConst.IsCurrBoss(self.id)
	elseif self:isPassType() or self:isBuildType() then
		local var_16_0 = getProxy(ActivityProxy):getActivityById((self:getConfig("activity_id")))

		return var_16_0 and not var_16_0:isEnd()
	end

	return
end

function MetaProgress:isInArchive()
	return WorldBossConst.IsAchieveBoss(self.id)
end

function MetaProgress:isUnlocked()
	return self.metaShipVO ~= nil
end

function MetaProgress:isShow()
	if self:isUnlocked() then
		return true
	elseif self:isInArchive() then
		return true
	elseif self:isInAct() then
		if self:isPtType() and true then
			return true
		elseif self:isPassType() or self:isBuildType() then
			return true
		else
			return false
		end
	else
		return false
	end

	return
end

function MetaProgress:getMetaShipFromBayProxy()
	local var_20_0 = getProxy(BayProxy):getMetaShipByGroupId(self.configId)

	self.metaShipVO = var_20_0

	return var_20_0
end

function MetaProgress:getShip()
	return self.metaShipVO
end

function MetaProgress:updateShip(arg_22_1)
	assert(arg_22_1, "metaShipVO can not be null!")

	self.metaShipVO = arg_22_1

	return
end

function MetaProgress:setDataBeforeGet()
	self.metaShipVO = self:getMetaShipFromBayProxy()

	if self:isPtType() and self.metaPtData and not self.unlockPTLevel then
		for iter_23_0, iter_23_1 in ipairs(self.metaPtData.targets) do
			if iter_23_1 == self.unlockPTNum then
				self.unlockPTLevel = iter_23_0

				break
			end
		end
	end

	if (self:isPassType() or self:isBuildType()) and not self.timeConfig then
		local var_23_0 = getProxy(ActivityProxy):getActivityById((self:getConfig("activity_id")))

		if var_23_0 then
			self.timeConfig = {
				var_23_0:getConfig("time")[2],
				var_23_0:getConfig("time")[3]
			}
		end
	end

	return
end

function MetaProgress:updateDataAfterAddShip()
	self.metaShipVO = self:getMetaShipFromBayProxy()

	return
end

function MetaProgress:addPT(arg_25_1)
	if self:isPtType() and self.metaPtData then
		self.metaPtData:addPT(arg_25_1)
	end

	return
end

function MetaProgress:updatePTLevel(arg_26_1)
	if self:isPtType() and self.metaPtData then
		self.metaPtData:updateLevel(arg_26_1)
	end

	return
end

function MetaProgress:getPaintPathAndName()
	local var_27_0, var_27_1 = MetaCharacterConst.GetMetaCharacterPaintPath(self.configId, (self:isUnlocked()))

	return var_27_0, var_27_1
end

function MetaProgress:getBannerPathAndName()
	local var_28_0, var_28_1 = MetaCharacterConst.GetMetaCharacterBannerPath(self.configId)

	return var_28_0, var_28_1
end

function MetaProgress:getBGNamePathAndName()
	local var_29_0, var_29_1 = MetaCharacterConst.GetMetaCharacterNamePath(self.configId)

	return var_29_0, var_29_1
end

function MetaProgress:getPtIconPath()
	assert(self:isPtType() and self.metaPtData)

	return Item.getConfigData(self.metaPtData.resId).icon
end

return MetaProgress
