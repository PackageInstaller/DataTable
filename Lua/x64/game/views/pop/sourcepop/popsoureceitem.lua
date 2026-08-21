local var_0_0 = class("PopsoureceItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.itemStateControll = arg_3_0.accessbtnControllerexcollection_:GetController("btnState")
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	arg_4_0:StopTimer()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		if arg_5_0.state == 3 then
			if arg_5_0.callback_ ~= nil then
				arg_5_0.callback_()
			end

			JumpTools.JumpToPage2(arg_5_0.data_)
		end
	end)
end

function var_0_0.RemoveListeners(arg_7_0)
	arg_7_0.button_.onClick:RemoveAllListeners()
end

function var_0_0.SetJumpCallback(arg_8_0, arg_8_1)
	arg_8_0.callback_ = arg_8_1
end

function var_0_0.RefreshUI(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.data_ = arg_9_2

	if arg_9_2[1] == 0 then
		arg_9_0.state = 1
		arg_9_0.nameText_.text, arg_9_0.frontText_.text = GetI18NText(arg_9_0.data_[3]), GetI18NText(arg_9_0.data_[2])

		arg_9_0.itemStateControll:SetSelectedState("display")
	elseif SystemLinkCfg[arg_9_2[1]].text_invalid ~= 0 then
		arg_9_0.state = 2
		arg_9_0.nameText_.text, arg_9_0.frontText_.text = JumpTools.GetName(arg_9_0.data_)

		arg_9_0.itemStateControll:SetSelectedState("display")
	else
		arg_9_0.state = 3
		arg_9_0.nameText_.text, arg_9_0.frontText_.text = JumpTools.GetName(arg_9_0.data_)

		local var_9_0 = SystemLinkCfg[arg_9_0.data_[1]]
		local var_9_1 = var_9_0.activity_id

		if type(var_9_0.paramName) == "table" then
			local var_9_2 = table.keyof(var_9_0.paramName, "activityId") or table.keyof(var_9_0.paramName, "activityID")

			if var_9_2 then
				var_9_1 = arg_9_0.data_[var_9_2 + 1]
			end
		end

		if var_9_1 and var_9_1 ~= 0 then
			local var_9_3, var_9_4, var_9_5 = JumpTools.GetActivityTime(var_9_1)

			arg_9_0.startTime_ = var_9_3
			arg_9_0.stopTime_ = var_9_4

			if var_9_4 > manager.time:GetServerTime() then
				arg_9_0:AddTimer()
			end
		end

		arg_9_0:RefreshLock()
	end
end

function var_0_0.RefreshLock(arg_10_0)
	if JumpTools.GetLinkIsLocked(arg_10_0.data_) then
		arg_10_0.itemStateControll:SetSelectedState("locked")
	else
		arg_10_0.itemStateControll:SetSelectedState("unlocked")
	end
end

function var_0_0.AddTimer(arg_11_0)
	arg_11_0:StopTimer()

	arg_11_0.timer_ = not arg_11_0.timer_ and Timer.New(function()
		arg_11_0:RefreshLock()

		if manager.time:GetServerTime() > arg_11_0.stopTime_ then
			arg_11_0:StopTimer()
		end
	end, 1, -1)

	arg_11_0.timer_:Start()
end

function var_0_0.StopTimer(arg_13_0)
	if arg_13_0.timer_ then
		arg_13_0.timer_:Stop()

		arg_13_0.timer_ = nil
	end
end

return var_0_0
