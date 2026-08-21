local var_0_0 = class("HodurMainlineEventItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController_ = arg_2_0.mainControllerEx_:GetController("state")
	arg_2_0.selectController_ = arg_2_0.mainControllerEx_:GetController("select")
	arg_2_0.selected_ = false
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.eventBtn_, nil, function()
		if arg_3_0.onClickHandler_ then
			arg_3_0.onClickHandler_(arg_3_0.eventID_)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.eventID_ = arg_5_1
	arg_5_0.chapterID_ = arg_5_2

	arg_5_0:RefreshUI()
end

function var_0_0.SetClickHandler(arg_6_0, arg_6_1)
	arg_6_0.onClickHandler_ = arg_6_1
end

function var_0_0.SetSelected(arg_7_0, arg_7_1)
	arg_7_0.selected_ = arg_7_1

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = ActivityHodurEventCfg[arg_8_0.eventID_]

	arg_8_0.titleText_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")

	arg_8_0.selectController_:SetSelectedState(arg_8_0.selected_ and "on" or "off")

	if HodurTools.GetEventComplete(arg_8_0.eventID_, arg_8_0.chapterID_) then
		arg_8_0.stateController_:SetSelectedState("Complete")
	else
		arg_8_0.stateController_:SetSelectedState("Normal")
	end

	if HodurTools.GetEventUnlock(arg_8_0.eventID_, arg_8_0.chapterID_) and not getData("activity_hodur", "first_unlock_event_" .. arg_8_0.eventID_) then
		saveData("activity_hodur", "first_unlock_event_" .. arg_8_0.eventID_, true)
		FrameTimer.New(function()
			if arg_8_0.aniTimer_ then
				arg_8_0.aniTimer_:Stop()

				arg_8_0.aniTimer_ = nil
				arg_8_0.isAni_ = false
			end

			arg_8_0.aniTimer_ = Timer.New(function()
				if arg_8_0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
					if arg_8_0.aniTimer_ then
						arg_8_0.aniTimer_:Stop()

						arg_8_0.aniTimer_ = nil
					end

					manager.ui:UIEventEnabledByUI(true, false)

					arg_8_0.isAni_ = false
				end
			end, 0.033, -1)

			arg_8_0.aniTimer_:Start()
		end, 1, 1):Start()
		arg_8_0.animator_:Play("UI_itemEvent_unlock", -1, 0)
		manager.ui:UIEventEnabledByUI(false, true)

		arg_8_0.isAni_ = true
	end
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.aniTimer_ then
		arg_11_0.aniTimer_:Stop()

		arg_11_0.aniTimer_ = nil
		arg_11_0.isAni_ = false
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
