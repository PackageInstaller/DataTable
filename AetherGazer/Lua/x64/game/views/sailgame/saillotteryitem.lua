local var_0_0 = class("SailLotteryItem", ReduxView)

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
	arg_2_0.resultController_ = ControllerUtil.GetController(arg_2_0.transform_, "result")
	arg_2_0.selectController_ = ControllerUtil.GetController(arg_2_0.transform_, "select")
	arg_2_0.pointController_ = ControllerUtil.GetController(arg_2_0.transform_, "point")
	arg_2_0.originPos_ = arg_2_0.transform_.localPosition
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.selectCallback_ then
			arg_3_0.selectCallback_(arg_3_0.index_)
		end
	end)
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.gameObject_ = nil
	arg_5_0.transform_ = nil
	arg_5_0.selectCallback_ = nil

	if arg_5_0.timer_ then
		arg_5_0.timer_:Stop()

		arg_5_0.timer_ = nil
	end

	if arg_5_0.posLeanTween_ then
		arg_5_0.posLeanTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_5_0.posLeanTween_.id)

		arg_5_0.posLeanTween_ = nil
	end

	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.index_ = arg_6_1
	arg_6_0.activityID_ = arg_6_2

	arg_6_0:Recover()
end

function var_0_0.SetActive(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.SetPoint(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.point_ = arg_8_1
	arg_8_0.isMine_ = arg_8_2
	arg_8_0.pointText_.text = arg_8_1

	arg_8_0.pointController_:SetSelectedState(arg_8_1)
end

function var_0_0.Recover(arg_9_0)
	arg_9_0:SetActive(true)

	if arg_9_0.originPos_ then
		arg_9_0.transform_.localPosition = arg_9_0.originPos_
	end

	arg_9_0.statusController_:SetSelectedState("origin")
	arg_9_0.resultController_:SetSelectedState("none")
	arg_9_0.selectController_:SetSelectedState("false")

	local var_9_0 = "cardItem_normal"

	arg_9_0.animator_:Play(var_9_0, -1, 0)
	arg_9_0.animator_:Update(0)
end

function var_0_0.SetResult(arg_10_0, arg_10_1)
	arg_10_0.win_ = arg_10_1
end

function var_0_0.SetSelecteCallback(arg_11_0, arg_11_1)
	arg_11_0.selectCallback_ = arg_11_1
end

function var_0_0.SetTargetPos(arg_12_0, arg_12_1)
	arg_12_0.targetPos_ = arg_12_1

	arg_12_0:PlayMoveAnim()
end

function var_0_0.PlayExitAnim(arg_13_0)
	local var_13_0 = "cardItem_ex"

	arg_13_0.animator_:Play(var_13_0, -1, 0)
	arg_13_0.animator_:Update(0)

	if arg_13_0.timer_ then
		arg_13_0.timer_:Stop()

		arg_13_0.timer_ = nil
	end

	arg_13_0.timer_ = Timer.New(function()
		local var_14_0 = arg_13_0.animator_:GetCurrentAnimatorStateInfo(0)

		if var_14_0:IsName(var_13_0) and var_14_0.normalizedTime >= 1 then
			if arg_13_0.timer_ ~= nil then
				arg_13_0.timer_:Stop()

				arg_13_0.timer_ = nil
			end

			arg_13_0:SetActive(false)
		end
	end, 0.033, -1)

	arg_13_0.timer_:Start()
end

function var_0_0.PlayMoveAnim(arg_15_0)
	local var_15_0 = 0.25

	arg_15_0.posLeanTween_ = LeanTween.moveLocal(arg_15_0.gameObject_, arg_15_0.targetPos_, var_15_0):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		if arg_15_0.posLeanTween_ then
			arg_15_0.posLeanTween_:setOnComplete(nil)

			arg_15_0.posLeanTween_ = nil
		end

		arg_15_0:PlayRotaAnim()
	end))
end

function var_0_0.PlayRotaAnim(arg_17_0)
	local var_17_0 = "cardItem"

	arg_17_0.animator_:Play(var_17_0, -1, 0)
	arg_17_0.animator_:Update(0)

	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end

	local var_17_1 = false

	arg_17_0.timer_ = Timer.New(function()
		local var_18_0 = arg_17_0.animator_:GetCurrentAnimatorStateInfo(0)
		local var_18_1 = var_18_0.normalizedTime

		if var_18_0:IsName(var_17_0) then
			if not var_17_1 and var_18_1 >= 0.5 then
				var_17_1 = true

				arg_17_0.statusController_:SetSelectedState(arg_17_0.isMine_ and "selfPoint" or "oppositePoint")
				arg_17_0.selectController_:SetSelectedState(arg_17_0.isMine_ and "true" or "false")
			elseif var_18_1 >= 1 then
				if arg_17_0.timer_ ~= nil then
					arg_17_0.timer_:Stop()

					arg_17_0.timer_ = nil
				end

				if arg_17_0.isMine_ then
					arg_17_0.resultController_:SetSelectedState(arg_17_0.win_ and "victory" or "lose")
					manager.notify:CallUpdateFunc(SAIL_EVENT_LOTTERY_WAIT_END)
				end
			end
		end
	end, 0.033, -1)

	arg_17_0.timer_:Start()

	if arg_17_0.isMine_ == true then
		if arg_17_0.win_ == true then
			manager.audio:PlayEffect("minigame_activity_2_2_summer_sea", "minigame_activity_2_2_summer_sea_win", "")
		else
			manager.audio:PlayEffect("minigame_activity_2_2_summer_sea", "minigame_activity_2_2_summer_sea_fail", "")
		end
	end
end

return var_0_0
