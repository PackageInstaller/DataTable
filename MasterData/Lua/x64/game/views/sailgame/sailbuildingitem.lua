local SailBuildingItem = class("SailBuildingItem", ReduxView)

function SailBuildingItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:Init()
end

function SailBuildingItem:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.durringTime_ = SailGameTools.GetBuildingTimePerReward()
end

function SailBuildingItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if self.curStatus_ == SailGameConst.BUILDING_STATUS.LOCK then
			ShowTips(string.format(GetTips("ACTIVITY_SKADI_SEA_BUILD_UNLOCK_NEED"), NumberTools.IntToRomam(SailGameBuildingCfg[self.id_].unlock_level_need)))
		else
			JumpTools.OpenPageByJump("sailBuilding", {
				ID = self.id_,
				activityID = self.activityID
			})
		end
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if self.curStatus_ == SailGameConst.BUILDING_STATUS.REWARD then
			SailGameAction.ReceiveBuildingReward(self.activityID_)
		end
	end)
end

function SailBuildingItem:SetData(arg_6_1, arg_6_2)
	self.id_ = arg_6_1
	self.activityID_ = arg_6_2

	local var_6_0 = SailGameData:GetUnLockBuilding(self.activityID_)[self.id_] == true

	if self.unlock_ == false and var_6_0 == true then
		self.unlockAnim_.enabled = true

		self.unlockAnim_:Play("buildingIcon", -1, 0)
		self.unlockAnim_:Update(0)
		manager.audio:PlayEffect("minigame_activity_2_2_summer_sea", "minigame_activity_2_2_summer_sea_explore", "")
	else
		self.unlockAnim_.enabled = false
	end

	self.unlock_ = var_6_0

	if self.unlock_ then
		self.lastReceiveTime_ = SailGameData:GetBuildingLastReceiveTimeList(arg_6_2)[arg_6_1]
		self.leftTime_ = self.durringTime_ - (manager.time:GetServerTime() - self.lastReceiveTime_) % self.durringTime_ + 1
	end

	self:RefreshUI()
end

function SailBuildingItem:RefreshUI()
	self:RefreshStatus()
	self:RefreshTitle()
	self:RefreshReward()
end

function SailBuildingItem:RefreshTitle()
	self.nameText_.text = SailGameBuildingCfg[self.id_].name

	local var_8_0 = getSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/" .. SailGameBuildingCfg[self.id_].picture)

	if var_8_0 then
		self.buildingIcon_.sprite = var_8_0
	end
end

function SailBuildingItem:RefreshStatus()
	local var_9_0 = 0

	self.unlock_ = SailGameData:GetUnLockBuilding(self.activityID_)[self.id_] == true
	var_9_0 = self.unlock_ == true and (SailGameData:GetIslandLevel(self.activityID_) < #SailGameIslandLevelCfg.get_id_list_by_activity_id[self.activityID_] and (manager.time:GetServerTime() - self.lastReceiveTime_ < self.durringTime_ and SailGameConst.BUILDING_STATUS.NORMAL or SailGameConst.BUILDING_STATUS.REWARD) or SailGameConst.BUILDING_STATUS.NORMAL) or SailGameData:GetIslandLevel(self.activityID_) < SailGameBuildingCfg[self.id_].unlock_level_need and SailGameConst.BUILDING_STATUS.LOCK or ItemTools.getItemNum(SailGameBuildingCfg[self.id_].cost[1][1]) < SailGameBuildingCfg[self.id_].cost[1][2] and SailGameConst.BUILDING_STATUS.NOT_ENOUGH or SailGameConst.BUILDING_STATUS.CAN_BUILD
	self.curStatus_ = var_9_0

	self.statusController_:SetSelectedIndex(var_9_0)
end

function SailBuildingItem:RefreshReward()
	self.rewardIcon_.sprite = ItemTools.getItemSprite(SailGameBuildingCfg[self.id_].token_get[1][1])
	self.numText_.text = SailGameTools.GetBuildingTotalReward(self.activityID_, self.id_)
end

function SailBuildingItem:RefreshTime()
	if self.unlock_ and (self.curStatus_ == SailGameConst.BUILDING_STATUS.NORMAL or self.curStatus_ == SailGameConst.BUILDING_STATUS.REWARD) then
		self.leftTime_ = self.leftTime_ - 1

		if self.leftTime_ <= 0 then
			self.leftTime_ = self.durringTime_

			self:RefreshStatus()
			self:RefreshReward()
			SailGameAction.UpdateBuildingAFKRewardRedPoint(self.activityID_)
		end
	end
end

return SailBuildingItem
