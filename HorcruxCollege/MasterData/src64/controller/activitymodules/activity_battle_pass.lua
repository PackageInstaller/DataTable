local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager.initActivityBattlePass(arg_1_0, arg_1_1)
	return
end

function activity_base_manager:getBattlePassLevelData(arg_2_1, arg_2_2)
	if not self.activities or not self.activities[arg_2_1] then
		return
	end

	return self.activities[arg_2_1]:getBattlePassLevelData(arg_2_2)
end

function activity_base_manager:getCurBattlePassLevel(arg_3_1)
	if not self.activities or not self.activities[arg_3_1] then
		return
	end

	return self.activities[arg_3_1]:getCurBattlePassLevel()
end

function activity_base_manager:getBattlePassExp(arg_4_1, arg_4_2)
	if not self.activities or not self.activities[arg_4_1] then
		return
	end

	return self.activities[arg_4_1]:getBattlePassExp(arg_4_2)
end

function activity_base_manager:isBattlePassVIP(arg_5_1)
	if not self.activities or not self.activities[arg_5_1] then
		return
	end

	return self.activities[arg_5_1]:isBattlePassVIP()
end

function activity_base_manager:isBattlePassSVIP(arg_6_1)
	if not self.activities or not self.activities[arg_6_1] then
		return
	end

	return self.activities[arg_6_1]:isBattlePassSVIP()
end

function activity_base_manager:getCurLevelProceed(arg_7_1, arg_7_2)
	if not self.activities or not self.activities[arg_7_1] then
		return
	end

	return self.activities[arg_7_1]:getCurLevelProceed(arg_7_2)
end

function activity_base_manager:getBattlePassDrop(arg_8_1, arg_8_2)
	if not self.activities or not self.activities[arg_8_1] then
		return
	end

	return self.activities[arg_8_1]:getBattlePassDrop(arg_8_2)
end

function activity_base_manager:getBattlePassReward(arg_9_1, arg_9_2)
	if not self.activities or not self.activities[arg_9_1] then
		return
	end

	return self.activities[arg_9_1]:getBattlePassReward(arg_9_2)
end

function activity_base_manager:getActivityTask(arg_10_1, arg_10_2)
	if not self.activities or not self.activities[arg_10_1] then
		return
	end

	return self.activities[arg_10_1]:getActivityTask(arg_10_2)
end

function activity_base_manager:getActivityTaskData(arg_11_1)
	if not self.activities or not self.activities[arg_11_1] then
		return
	end

	return self.activities[arg_11_1]:getActivityTaskData()
end

function activity_base_manager:isHasRewardCanGet(arg_12_1)
	if not self.activities or not self.activities[arg_12_1] then
		return
	end

	return self.activities[arg_12_1]:isHasRewardCanGet()
end

function activity_base_manager:isHasCanCompleteTask(arg_13_1)
	if not self.activities or not self.activities[arg_13_1] then
		return
	end

	return self.activities[arg_13_1]:isHasCanCompleteTask()
end

function activity_base_manager:getBPTaskReward(arg_14_1, arg_14_2)
	if not self.activities or not self.activities[arg_14_1] then
		return
	end

	return self.activities[arg_14_1]:getBPTaskReward(arg_14_2)
end

function activity_base_manager:getBPTaskRewardOneKey(arg_15_1)
	if not self.activities or not self.activities[arg_15_1] then
		return
	end

	return self.activities[arg_15_1]:getTaskRewardOneKey()
end

function activity_base_manager:getAllVIPLevelGift(arg_16_1, arg_16_2)
	if not self.activities or not self.activities[arg_16_1] then
		return
	end

	return self.activities[arg_16_1]:getAllVIPLevelGift(arg_16_2)
end

function activity_base_manager:canLevelUp(arg_17_1, arg_17_2)
	if not self.activities or not self.activities[arg_17_1] then
		return
	end

	return self.activities[arg_17_1]:canLevelUp(arg_17_2)
end

function activity_base_manager:getLevelupCanGetDrop(arg_18_1, arg_18_2)
	if not self.activities or not self.activities[arg_18_1] then
		return
	end

	return self.activities[arg_18_1]:getLevelupCanGetDrop(arg_18_2)
end

function activity_base_manager:buyVipById(arg_19_1, arg_19_2)
	if not self.activities or not self.activities[arg_19_1] then
		return
	end

	return self.activities[arg_19_1]:buyVipById(arg_19_2)
end

function activity_base_manager:getbuyBpVipCouponid(arg_20_1, arg_20_2)
	if not self.activities or not self.activities[arg_20_1] then
		return
	end

	return self.activities[arg_20_1]:getbuyBpVipCouponid(arg_20_2)
end

function activity_base_manager:isVIPBtnLock(arg_21_1)
	if not self.activities or not self.activities[arg_21_1] then
		return
	end

	return self.activities[arg_21_1]:isVIPBtnLock()
end

function activity_base_manager:getVipPriceById(arg_22_1, arg_22_2)
	if not self.activities or not self.activities[arg_22_1] then
		return
	end

	return self.activities[arg_22_1]:getVipPriceById(arg_22_2)
end

function activity_base_manager:getLevelUpCost(arg_23_1, arg_23_2)
	if not self.activities or not self.activities[arg_23_1] then
		return
	end

	return self.activities[arg_23_1]:getLevelUpCost(arg_23_2)
end

function activity_base_manager:buyActivityLevel(arg_24_1, arg_24_2, arg_24_3)
	if not self.activities or not self.activities[arg_24_1] then
		return
	end

	return self.activities[arg_24_1]:buyActivityLevel(arg_24_2, arg_24_3)
end

function activity_base_manager:getGiftPreviewList(arg_25_1)
	if not self.activities or not self.activities[arg_25_1] then
		return
	end

	return self.activities[arg_25_1]:getGiftPreviewList()
end

function activity_base_manager:getSpGiftPreviewList(arg_26_1)
	if not self.activities or not self.activities[arg_26_1] then
		return
	end

	return self.activities[arg_26_1]:getSpGiftPreviewList()
end

function activity_base_manager:getBuySVIPDrop(arg_27_1)
	if not self.activities or not self.activities[arg_27_1] then
		return
	end

	return self.activities[arg_27_1]:getBuySVIPDrop()
end

function activity_base_manager:getActivityEndTime(arg_28_1)
	if not self.activities or not self.activities[arg_28_1] then
		return
	end

	return self.activities[arg_28_1]:getActivityEndTime()
end

function activity_base_manager:getBattlePassLive2d(arg_29_1)
	if not self.activities or not self.activities[arg_29_1] then
		return
	end

	return self.activities[arg_29_1]:getBattlePassLive2d()
end

function activity_base_manager:getBuyVipJumpTo(arg_30_1)
	if not self.activities or not self.activities[arg_30_1] then
		return
	end

	return self.activities[arg_30_1]:getBuyVipJumpTo()
end

function activity_base_manager:isBPRewardCanGet(arg_31_1, arg_31_2)
	if not self.activities or not self.activities[arg_31_1] then
		return
	end

	return self.activities[arg_31_1]:isBPRewardCanGet(arg_31_2)
end

function activity_base_manager:getBattlePassMaxLevel(arg_32_1)
	if not self.activities or not self.activities[arg_32_1] then
		return
	end

	return self.activities[arg_32_1]:getBattlePassMaxLevel()
end

function activity_base_manager:getCompleteTaskNum(arg_33_1)
	if not self.activities or not self.activities[arg_33_1] then
		return
	end

	return self.activities[arg_33_1]:getCompleteTaskNum()
end

function activity_base_manager:isBPRewardCanGet(arg_34_1, arg_34_2)
	if not self.activities or not self.activities[arg_34_1] then
		return
	end

	return self.activities[arg_34_1]:isBPRewardCanGet(arg_34_2)
end

function activity_base_manager:getBPLayerName(arg_35_1)
	if not self.activities or not self.activities[arg_35_1] then
		return
	end

	return self.activities[arg_35_1]:getBPLayerName()
end

function activity_base_manager:isRechargeBP(arg_36_1, arg_36_2)
	if not self.activities or not self.activities[arg_36_1] then
		return
	end

	return self.activities[arg_36_1]:isRechargeBP(arg_36_2)
end

function activity_base_manager:getBPShowFurniture(arg_37_1)
	if not self.activities or not self.activities[arg_37_1] then
		return
	end

	return self.activities[arg_37_1]:getBPShowFurniture()
end

function activity_base_manager:getBPVipBuyBtnPos(arg_38_1)
	if not self.activities or not self.activities[arg_38_1] then
		return
	end

	return self.activities[arg_38_1]:getBPVipBuyBtnPos()
end

function activity_base_manager:getBPVipBuyIncoPos(arg_39_1)
	if not self.activities or not self.activities[arg_39_1] then
		return
	end

	return self.activities[arg_39_1]:getBPVipBuyIncoPos()
end

function activity_base_manager:getBPMaxLevel(arg_40_1)
	if not self.activities or not self.activities[arg_40_1] then
		return
	end

	return self.activities[arg_40_1]:getBPMaxLevel()
end

function activity_base_manager:getBPReturnbackGuideList(arg_41_1)
	if not self.activities or not self.activities[arg_41_1] then
		return
	end

	return self.activities[arg_41_1]:getBPReturnbackGuideList()
end

function activity_base_manager:getExtraTaskList(arg_42_1, arg_42_2)
	if not self.activities or not self.activities[arg_42_1] then
		return
	end

	return self.activities[arg_42_1]:getExtraTaskList(arg_42_2)
end

function activity_base_manager:isGuideComplete(arg_43_1)
	if not self.activities or not self.activities[arg_43_1] then
		return
	end

	return self.activities[arg_43_1]:isGuideComplete()
end

function activity_base_manager:isBpComplete(arg_44_1)
	if not self.activities or not self.activities[arg_44_1] then
		return
	end

	return self.activities[arg_44_1]:isBpComplete()
end

function activity_base_manager:getBpLevelInheritItem(arg_45_1)
	if not self.activities or not self.activities[arg_45_1] then
		return
	end

	return self.activities[arg_45_1]:getBpLevelInheritItem()
end

function activity_base_manager:getActivityBPTaskUseModule(arg_46_1)
	if not self.activities or not self.activities[arg_46_1] then
		return
	end

	return self.activities[arg_46_1]:getActivityBPTaskUseModule()
end
