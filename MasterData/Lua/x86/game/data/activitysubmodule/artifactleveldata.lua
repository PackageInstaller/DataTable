local var_0_0 = singletonClass("ArtifactLevelData")

function var_0_0:Init()
	self.curOpenLevelList_ = {}
	self.curAwardedLevelList_ = {}
	self.levelId_ = {}
	self.selectedLevelList_ = {}
	self.awardsList_ = {}
	self.levelCount_ = 0
	self.curLevelIndex_ = 1

	local var_1_0 = ActivityData:GetActivityData(ActivityConst.SUMMER_ARTIFACT)

	for iter_1_0, iter_1_1 in pairs(ActivityArtifactLevelCfg.all) do
		table.insert(self.levelId_, iter_1_1)

		self.levelCount_ = self.levelCount_ + 1
	end

	for iter_1_2, iter_1_3 in pairs(BattleArtifactCfg.all) do
		self.awardsList_[iter_1_2] = BattleArtifactCfg[iter_1_3].drop_lib_id
	end

	self:InitRedPoint(ActivityConst.SUMMER_ARTIFACT)
end

function var_0_0:SetData(arg_2_1)
	for iter_2_0, iter_2_1 in pairs(self.levelId_) do
		self.curAwardedLevelList_[iter_2_0] = false
	end

	if arg_2_1.artifact.already_clear_activity_id_list then
		for iter_2_2, iter_2_3 in ipairs(arg_2_1.artifact.already_clear_activity_id_list) do
			if self:GetIndexByLevelId(iter_2_3) then
				self.curAwardedLevelList_[self:GetIndexByLevelId(iter_2_3)] = true
			end
		end
	end

	for iter_2_4, iter_2_5 in pairs(ActivityArtifactLevelCfg.all) do
		if ActivityData:GetActivityIsOpen(iter_2_5) then
			self.curOpenLevelList_[iter_2_4] = true
		end
	end

	self:UpdateRedPoint()
end

function var_0_0:GetIndexByLevelId(arg_3_1)
	for iter_3_0, iter_3_1 in pairs(self.levelId_) do
		if iter_3_1 == arg_3_1 then
			return iter_3_0
		end
	end

	return nil
end

function var_0_0:GetLevelCount()
	return self.levelCount_
end

function var_0_0:GetLevelIdByIndex(arg_5_1)
	return self.levelId_[arg_5_1]
end

function var_0_0:GetIsAwardedByIndex(arg_6_1)
	return self.curAwardedLevelList_[arg_6_1]
end

function var_0_0:GetLevelNameByIndex(arg_7_1)
	return ActivityArtifactLevelCfg[self.levelId_[arg_7_1]].name
end

function var_0_0:GetLevelDesc(arg_8_1)
	return ActivityArtifactLevelCfg[self.levelId_[arg_8_1]].desc
end

function var_0_0:GetIsOpenByIndex(arg_9_1)
	return ActivityData:GetActivityIsOpen(self.levelId_[arg_9_1])
end

function var_0_0:GetAwardListByIndex(arg_10_1)
	return self.awardsList_[arg_10_1]
end

function var_0_0:GetLevelIdByStageId(arg_11_1)
	for iter_11_0, iter_11_1 in pairs(self.levelId_) do
		if ActivityArtifactLevelCfg[iter_11_1].stage_id == arg_11_1 then
			return iter_11_1
		end
	end

	return nil
end

function var_0_0:GetCurLevelIndex()
	return self.curLevelIndex_
end

function var_0_0.SetCurLevelIndex(arg_13_0, arg_13_1)
	arg_13_0.curLevelIndex_ = arg_13_1
end

function var_0_0:SetSelectedByIndex(arg_14_1)
	self.selectedLevelList_[arg_14_1] = true
end

function var_0_0:UpdateRedPoint()
	for iter_15_0 = 1, self.levelCount_ do
		if not not (ActivityData:GetActivityIsOpen(self.levelId_[iter_15_0]) and self.selectedLevelList_[iter_15_0] == nil and self.curAwardedLevelList_[iter_15_0] == false) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ARTIFACT, self.levelId_[iter_15_0]), 1)
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ARTIFACT, self.levelId_[iter_15_0]), 0)
		end
	end
end

function var_0_0:InitRedPoint(arg_16_1)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(self.levelId_) do
		table.insert(var_16_0, string.format("%s_%s", RedPointConst.ARTIFACT, iter_16_1))
	end

	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ARTIFACT, ActivityConst.SUMMER_ARTIFACT), var_16_0)
end

return var_0_0
