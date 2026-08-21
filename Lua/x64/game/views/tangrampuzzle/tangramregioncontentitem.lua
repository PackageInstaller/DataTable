local var_0_0 = class("TangramRegionContentItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.statusController_ = ControllerUtil.GetController(arg_1_0.transform_, "status")
	arg_1_0.regionType_ = arg_1_2
	arg_1_0.regionIdList_ = arg_1_3
end

function var_0_0.OnExit(arg_2_0)
	arg_2_0:StopAnimTimer()
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.activityID_ = arg_3_1

	arg_3_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_4_0)
	arg_4_0:RefreshStatus()
end

function var_0_0.RefreshStatus(arg_5_0)
	local var_5_0 = TangramPuzzleData:GetUnlockRegionDic(arg_5_0.activityID_)

	arg_5_0.unlock_ = true

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.regionIdList_) do
		if not var_5_0[iter_5_1] then
			arg_5_0.unlock_ = false

			break
		end
	end

	if not arg_5_0.unlock_ then
		arg_5_0.statusController_:SetSelectedState("lock")
	else
		local var_5_1 = arg_5_0:IsAllReceived()
		local var_5_2 = TangramPuzzleTools.CheckRegionAllRightByType(arg_5_0.activityID_, arg_5_0.regionType_)

		if var_5_1 and var_5_2 then
			arg_5_0:SetActive(false)
		else
			arg_5_0.statusController_:SetSelectedState("normal")
		end
	end
end

function var_0_0.IsAllReceived(arg_6_0)
	local var_6_0 = TangramPuzzleData:GetRegionReceivedDic(arg_6_0.activityID_)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.regionIdList_) do
		if not var_6_0[iter_6_1] then
			return false
		end
	end

	return true
end

function var_0_0.GetRegionContentTrans(arg_7_0)
	return arg_7_0.regionContentTrans_
end

function var_0_0.PlayCompletedAnim(arg_8_0, arg_8_1)
	arg_8_0:PlayAnim(arg_8_0.animator_, "regionContentTemplate", arg_8_1)
end

function var_0_0.SetActive(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.StopAnimTimer(arg_10_0)
	if arg_10_0.animtimer_ then
		arg_10_0.animtimer_:Stop()

		arg_10_0.animtimer_ = nil
	end
end

function var_0_0.PlayAnim(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if not arg_11_1 then
		if arg_11_3 then
			arg_11_3()
		end

		return
	end

	arg_11_0:StopAnimTimer()

	arg_11_1.enabled = true

	arg_11_1:Play(arg_11_2, -1, 0)
	arg_11_1:Update(0)

	arg_11_0.animtimer_ = Timer.New(function()
		local var_12_0 = arg_11_1:GetCurrentAnimatorStateInfo(0)

		if var_12_0:IsName(arg_11_2) and var_12_0.normalizedTime >= 1 then
			arg_11_0:StopAnimTimer()

			arg_11_1.enabled = false

			if arg_11_3 then
				arg_11_3()
			end
		end
	end, 0.033, -1)

	arg_11_0.animtimer_:Start()
end

return var_0_0
