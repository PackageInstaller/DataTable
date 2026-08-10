local var_0_0 = class("PopSourceUnlockItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.data_ = arg_1_3

	arg_1_0:Init()
	SetActive(arg_1_0.gameObject_, true)
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.controller_ = ControllerUtil.GetController(arg_2_0.transform_, "name")

	arg_2_0:RefreshUI()
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:StopTimer()
	arg_3_0:RemoveListeners()

	arg_3_0.callback_ = nil
	arg_3_0.btn_ = nil
	arg_3_0.sourceText_ = nil
	arg_3_0.sourceContent_ = nil

	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.transform_ = nil
	arg_3_0.gameObject_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.callback_ ~= nil then
			arg_4_0.callback_()
		end

		JumpTools.JumpToPage2(arg_4_0.data_)
	end)
end

function var_0_0.RemoveListeners(arg_6_0)
	arg_6_0.btn_.onClick:RemoveAllListeners()
end

function var_0_0.SetJumpCallback(arg_7_0, arg_7_1)
	arg_7_0.callback_ = arg_7_1
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.sourceContent_.text, arg_8_0.sourceText_.text = JumpTools.GetName(arg_8_0.data_)

	local var_8_0 = SystemLinkCfg[arg_8_0.data_[1]]
	local var_8_1 = var_8_0.activity_id

	if type(var_8_0.paramName) == "table" then
		local var_8_2 = table.keyof(var_8_0.paramName, "activityId") or table.keyof(var_8_0.paramName, "activityID")

		if var_8_2 then
			var_8_1 = arg_8_0.data_[var_8_2 + 1]
		end
	end

	if var_8_1 and var_8_1 ~= 0 then
		local var_8_3, var_8_4, var_8_5 = JumpTools.GetActivityTime(var_8_1)

		arg_8_0.startTime_ = var_8_3
		arg_8_0.stopTime_ = var_8_4

		if var_8_4 > manager.time:GetServerTime() then
			arg_8_0:AddTimer()
		end
	end

	arg_8_0:RefreshLock()
end

function var_0_0.RefreshLock(arg_9_0)
	if JumpTools.GetLinkIsLocked(arg_9_0.data_) then
		arg_9_0.controller_:SetSelectedState("true")
	else
		arg_9_0.controller_:SetSelectedState("false")
	end
end

function var_0_0.AddTimer(arg_10_0)
	arg_10_0:StopTimer()

	arg_10_0.timer_ = Timer.New(function()
		arg_10_0:RefreshLock()

		if manager.time:GetServerTime() > arg_10_0.stopTime_ then
			arg_10_0:StopTimer()
		end
	end, 1, -1)

	arg_10_0.timer_:Start()
end

function var_0_0.StopTimer(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end
end

return var_0_0
