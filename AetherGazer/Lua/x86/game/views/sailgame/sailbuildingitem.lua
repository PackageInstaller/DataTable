local var_0_0 = class("SailBuildingItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.statusController_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
	arg_2_0.durringTime_ = SailGameTools.GetBuildingTimePerReward()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_3_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if arg_3_0.curStatus_ == SailGameConst.BUILDING_STATUS.LOCK then
			local var_4_0 = SailGameBuildingCfg[arg_3_0.id_].unlock_level_need

			ShowTips(string.format(GetTips("ACTIVITY_SKADI_SEA_BUILD_UNLOCK_NEED"), NumberTools.IntToRomam(var_4_0)))
		else
			JumpTools.OpenPageByJump("sailBuilding", {
				ID = arg_3_0.id_,
				activityID = arg_3_0.activityID
			})
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.rewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_3_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if arg_3_0.curStatus_ == SailGameConst.BUILDING_STATUS.REWARD then
			SailGameAction.ReceiveBuildingReward(arg_3_0.activityID_)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.id_ = arg_6_1
	arg_6_0.activityID_ = arg_6_2

	local var_6_0 = SailGameData:GetUnLockBuilding(arg_6_0.activityID_)[arg_6_0.id_] == true

	if arg_6_0.unlock_ == false and var_6_0 == true then
		arg_6_0.unlockAnim_.enabled = true

		arg_6_0.unlockAnim_:Play("buildingIcon", -1, 0)
		arg_6_0.unlockAnim_:Update(0)
		manager.audio:PlayEffect("minigame_activity_2_2_summer_sea", "minigame_activity_2_2_summer_sea_explore", "")
	else
		arg_6_0.unlockAnim_.enabled = false
	end

	arg_6_0.unlock_ = var_6_0

	if arg_6_0.unlock_ then
		arg_6_0.lastReceiveTime_ = SailGameData:GetBuildingLastReceiveTimeList(arg_6_2)[arg_6_1]

		local var_6_1 = manager.time:GetServerTime() - arg_6_0.lastReceiveTime_

		arg_6_0.leftTime_ = arg_6_0.durringTime_ - var_6_1 % arg_6_0.durringTime_ + 1
	end

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshStatus()
	arg_7_0:RefreshTitle()
	arg_7_0:RefreshReward()
end

function var_0_0.RefreshTitle(arg_8_0)
	arg_8_0.nameText_.text = SailGameBuildingCfg[arg_8_0.id_].name

	local var_8_0 = getSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/" .. SailGameBuildingCfg[arg_8_0.id_].picture)

	if var_8_0 then
		arg_8_0.buildingIcon_.sprite = var_8_0
	end
end

function var_0_0.RefreshStatus(arg_9_0)
	local var_9_0 = 0

	arg_9_0.unlock_ = SailGameData:GetUnLockBuilding(arg_9_0.activityID_)[arg_9_0.id_] == true

	if arg_9_0.unlock_ == true then
		if SailGameData:GetIslandLevel(arg_9_0.activityID_) < #SailGameIslandLevelCfg.get_id_list_by_activity_id[arg_9_0.activityID_] then
			if manager.time:GetServerTime() - arg_9_0.lastReceiveTime_ < arg_9_0.durringTime_ then
				var_9_0 = SailGameConst.BUILDING_STATUS.NORMAL
			else
				var_9_0 = SailGameConst.BUILDING_STATUS.REWARD
			end
		else
			var_9_0 = SailGameConst.BUILDING_STATUS.NORMAL
		end
	else
		local var_9_1 = SailGameData:GetIslandLevel(arg_9_0.activityID_)
		local var_9_2 = SailGameBuildingCfg[arg_9_0.id_]
		local var_9_3 = var_9_2.unlock_level_need
		local var_9_4 = var_9_2.cost[1]
		local var_9_5 = var_9_4[1]
		local var_9_6 = var_9_4[2]
		local var_9_7 = ItemTools.getItemNum(var_9_5)

		if var_9_1 < var_9_3 then
			var_9_0 = SailGameConst.BUILDING_STATUS.LOCK
		elseif var_9_7 < var_9_6 then
			var_9_0 = SailGameConst.BUILDING_STATUS.NOT_ENOUGH
		else
			var_9_0 = SailGameConst.BUILDING_STATUS.CAN_BUILD
		end
	end

	arg_9_0.curStatus_ = var_9_0

	arg_9_0.statusController_:SetSelectedIndex(var_9_0)
end

function var_0_0.RefreshReward(arg_10_0)
	arg_10_0.rewardIcon_.sprite = ItemTools.getItemSprite(SailGameBuildingCfg[arg_10_0.id_].token_get[1][1])
	arg_10_0.numText_.text = SailGameTools.GetBuildingTotalReward(arg_10_0.activityID_, arg_10_0.id_)
end

function var_0_0.RefreshTime(arg_11_0)
	if arg_11_0.unlock_ and (arg_11_0.curStatus_ == SailGameConst.BUILDING_STATUS.NORMAL or arg_11_0.curStatus_ == SailGameConst.BUILDING_STATUS.REWARD) then
		arg_11_0.leftTime_ = arg_11_0.leftTime_ - 1

		if arg_11_0.leftTime_ <= 0 then
			arg_11_0.leftTime_ = arg_11_0.durringTime_

			arg_11_0:RefreshStatus()
			arg_11_0:RefreshReward()
			SailGameAction.UpdateBuildingAFKRewardRedPoint(arg_11_0.activityID_)
		end
	end
end

return var_0_0
