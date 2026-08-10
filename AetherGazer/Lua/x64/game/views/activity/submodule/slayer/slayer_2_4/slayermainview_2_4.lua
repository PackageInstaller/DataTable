local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("SlayerMainView_2_4", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return SlayerTools.GetMainUIName(arg_1_0.activityID_ or 0)
end

function var_0_1.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("slayerRewardView_1_7", {
			slayer_activity_id = arg_2_0.activityID_
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.m_entrustBtn, nil, function()
		if not ActivityTools.GetActivityIsOpenWithTip(arg_2_0.activityID_, true) then
			return
		end

		JumpTools.OpenPageByJump("/slayerStageView_2_4", {
			init_tag = true,
			slayer_activity_id = arg_2_0.activityID_
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.m_descBtn, nil, function()
		local var_5_0 = GetTips("ACTIVITY_SLAYER_DESCRIBE")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_SLAYER_DESCRIBE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_5_0
		})
	end)
end

function var_0_1.OnEnter(arg_6_0)
	var_0_1.super.OnEnter(arg_6_0)

	if arg_6_0.descText_ then
		arg_6_0.descText_.text = GetTips("ACTIVITY_SLAYER_GENERAL_DESCRIBE")
	end

	manager.redPoint:bindUIandKey(arg_6_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, arg_6_0.activityID_))
	manager.redPoint:bindUIandKey(arg_6_0.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, arg_6_0.activityID_))
end

function var_0_1.OnExit(arg_7_0)
	var_0_1.super.OnExit(arg_7_0)
	manager.redPoint:unbindUIandKey(arg_7_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, arg_7_0.activityID_))
	manager.redPoint:unbindUIandKey(arg_7_0.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, arg_7_0.activityID_))
end

function var_0_1.RefreshTimeText(arg_8_0)
	if arg_8_0.m_timeLab then
		arg_8_0.m_timeLab.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(arg_8_0.stopTime_, true)
	end
end

return var_0_1
