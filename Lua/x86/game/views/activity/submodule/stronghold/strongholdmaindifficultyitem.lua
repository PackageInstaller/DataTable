local var_0_0 = class("StrongholdMainDifficultyItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController = ControllerUtil.GetController(arg_3_0.transform_, "select")
	arg_3_0.lockController = ControllerUtil.GetController(arg_3_0.transform_, "lock")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_btn, function()
		if arg_4_0.clickFunc then
			if CooperationData:GetIsMatching() then
				ShowTips("ERROR_COORDINATOR_ALREADY_IN_MATCH")

				return
			end

			local var_5_0, var_5_1 = arg_4_0:CheckCondition()

			if not var_5_0 then
				ShowTips(var_5_1)

				return
			end

			arg_4_0.clickFunc(arg_4_0.id)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.main_id = arg_6_1
	arg_6_0.id = arg_6_2
	arg_6_0.all_increase_lv = StrongholdData:GetAllIncreaseLevel(arg_6_0.main_id)

	local var_6_0 = ActivityStrongholdCfg[arg_6_2]

	arg_6_0.m_lab.text = var_6_0.difficulty_des

	arg_6_0:RefreshTime()
end

function var_0_0.SetSelect(arg_7_0, arg_7_1)
	arg_7_0.selectController:SetSelectedIndex(arg_7_1 == arg_7_0.id and 1 or 0)
end

function var_0_0.RefreshTime(arg_8_0)
	local var_8_0, var_8_1 = arg_8_0:CheckCondition()

	if var_8_0 then
		arg_8_0.lockController:SetSelectedIndex(0)
	elseif arg_8_0.id == 182203 then
		arg_8_0.m_timeLab.text = var_8_1

		arg_8_0.lockController:SetSelectedIndex(1)
	else
		local var_8_2 = ActivityStrongholdCfg[arg_8_0.id]

		arg_8_0.m_lab.text = var_8_2.difficulty_des .. "-" .. var_8_1

		arg_8_0.lockController:SetSelectedIndex(0)
	end
end

function var_0_0.CheckCondition(arg_9_0)
	if ActivityData:GetActivityIsOpen(arg_9_0.id) then
		local var_9_0 = ActivityStrongholdCfg[arg_9_0.id].limit_increase_all_lv

		if var_9_0 > arg_9_0.all_increase_lv then
			return false, GetTips(string.format(GetTips("ACTIVITY_STRONGHOLD_DIFFICULTY_LOCK_INCREASE"), var_9_0))
		end
	else
		local var_9_1 = ActivityData:GetActivityData(arg_9_0.id)
		local var_9_2 = manager.time:GetServerTime()

		if var_9_1 and var_9_2 < var_9_1.startTime then
			return false, GetTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_9_1.startTime)))
		else
			return false, GetTips("TIME_OUT")
		end
	end

	return true, ""
end

function var_0_0.RegistCallBack(arg_10_0, arg_10_1)
	arg_10_0.clickFunc = arg_10_1
end

return var_0_0
