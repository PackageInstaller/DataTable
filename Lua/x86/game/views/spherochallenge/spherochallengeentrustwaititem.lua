local var_0_0 = class("SPHeroChallengeEntrustWaitItem", ReduxView)

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

	arg_3_0.stateController = arg_3_0.controller:GetController("state")
	arg_3_0.rankController = arg_3_0.controller:GetController("rank")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	if arg_4_1 then
		arg_4_0.showiIndex = arg_4_1.showiIndex

		if arg_4_1.state then
			if arg_4_1.state == "lock" then
				arg_4_0.stateController:SetSelectedState("lock")

				local var_4_0 = SPHeroChallengeData:GetActivityID()
				local var_4_1 = SPHeroChallengeTools:GetMaxStartEntrustPosNum(var_4_0)
				local var_4_2 = SPHeroChallengeData.activityCfg[var_4_0].waitEntrustListOpenCondition[arg_4_0.showiIndex - var_4_1][2]
				local var_4_3, var_4_4 = SPHeroChallengeTools:GetConditionDesc(var_4_2)

				arg_4_0.lockdescText_.text = GetTips("RETURN_MATERIAL_MAX_POINT")

				ItemTools.GetItemSpriteAsync(var_4_4, function(arg_5_0, arg_5_1)
					arg_4_0.currencyiconImg_.sprite = arg_5_1
				end)

				local var_4_5, var_4_6, var_4_7 = IsConditionAchieved(var_4_2)

				arg_4_0.locknumText_.text = string.format("<color='#FF000B'>%d</color>", var_4_6) .. "/" .. var_4_7
			elseif arg_4_1.state == "empty" then
				arg_4_0.stateController:SetSelectedState("empty")
			end
		else
			local var_4_8 = arg_4_1.entrustIndex
			local var_4_9 = SPHeroChallengeData:GetCurActivityInfo():GetEntrustEndTime(var_4_8)

			arg_4_0:RefreshBaseInfo(var_4_8)

			if var_4_9 then
				arg_4_0.stateController:SetSelectedState("end")
			else
				arg_4_0.stateController:SetSelectedState("start")
			end
		end
	end
end

function var_0_0.RefreshBaseInfo(arg_6_0, arg_6_1)
	local var_6_0 = SPHeroChallengeData:GetCurActivityInfo():GetEntrustInfoByIndex(arg_6_1).entrustID
	local var_6_1 = ActivityHeroChallengeTaskCfg[var_6_0]

	arg_6_0.entrustnameText_.text = var_6_1.name

	arg_6_0.rankController:SetSelectedState(tostring(var_6_1.task_level))
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.emptyBtn_, nil, function()
		if arg_7_0.clickEmptyFunc then
			arg_7_0.clickEmptyFunc(arg_7_0.showIndex)
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.cancelBtn, nil, function()
		local var_9_0 = SPHeroChallengeData:GetCurActivityInfo():GetShowIndexEntrustInfo(arg_7_0.showiIndex)

		if var_9_0 then
			local var_9_1 = {
				index = var_9_0.index,
				entrustID = arg_7_0.id
			}

			SPHeroChallengeAction:CancelEntrust(var_9_1)
		end
	end)
end

function var_0_0.ClickEmptyFunc(arg_10_0, arg_10_1)
	if arg_10_1 then
		arg_10_0.clickEmptyFunc = arg_10_1
	end
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
