local var_0_0 = class("BossAdvanceSwitchItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.bossIndex_ = arg_1_3

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "bossItem")
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0:RefreshUI()
	arg_2_0:AddTimer()
	arg_2_0:AddDelayTimer()
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:StopTimer()
	arg_3_0:StopDelayTimer()
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	arg_4_0:RemoveListeners()
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.gameObject_ = nil
	arg_4_0.transform_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		if arg_5_0.isLock_ then
			local var_6_0 = BattleBossChallengeAdvanceData:GetBossList()[arg_5_0.bossIndex_].timestamp

			ShowTips(string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(var_6_0)))
		else
			arg_5_0:Go("/bossAdvanceInfo", {
				bossIndex = arg_5_0.bossIndex_
			})
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.resetBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_CHALLENGE_RESET"),
			OkCallback = function()
				BattleBossChallengeAction.ResetHardModeBoss(arg_5_0.bossIndex_, function(arg_9_0)
					if isSuccess(arg_9_0.result) then
						arg_5_0:RefreshUI()
					else
						ShowTips(arg_9_0.result)
					end
				end)
			end
		})
	end)
end

function var_0_0.RemoveListeners(arg_10_0)
	return
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = BattleBossChallengeAdvanceData:GetBossList()[arg_11_0.bossIndex_]
	local var_11_1 = BossChallengeUICfg[var_11_0.templateID]

	arg_11_0.icon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.BossLittlePaint.path, var_11_1.icon))
	arg_11_0.nameText_.text = GetI18NText(var_11_1.main_name)
	arg_11_0.weaknessText_.text = GetI18NText(var_11_1.weakness)
	arg_11_0.numText_.text = string.format("NO.%02d", arg_11_0.bossIndex_)
	arg_11_0.pointText_.text = var_11_0.maxPoint

	local var_11_2 = BossChallengeAdvancePosCfg[arg_11_0.bossIndex_].position

	arg_11_0.transform_.localPosition = Vector3(var_11_2[1], var_11_2[2], 0)

	arg_11_0:RefreshResetBtn()
	arg_11_0:Show(true)
end

function var_0_0.RefreshResetBtn(arg_12_0)
	if #BattleBossChallengeAdvanceData:GetReceiveRewardList() > 0 then
		SetActive(arg_12_0.resetGo_, false)

		return
	end

	if BattleBossChallengeAdvanceData:GetBossList()[arg_12_0.bossIndex_].maxPoint > 0 then
		SetActive(arg_12_0.resetGo_, true)
	else
		SetActive(arg_12_0.resetGo_, false)
	end
end

function var_0_0.Show(arg_13_0, arg_13_1)
	SetActive(arg_13_0.gameObject_, arg_13_1)
end

function var_0_0.RefreshLock(arg_14_0, arg_14_1)
	if arg_14_1 then
		arg_14_0.controller_:SetSelectedState("lock")
	else
		arg_14_0.controller_:SetSelectedState("false")
	end
end

function var_0_0.AddTimer(arg_15_0)
	arg_15_0:StopTimer()

	local var_15_0 = BattleBossChallengeAdvanceData:GetBossList()[arg_15_0.bossIndex_].timestamp
	local var_15_1 = var_15_0 > manager.time:GetServerTime()

	arg_15_0:RefreshLock(var_15_1)

	arg_15_0.isLock_ = var_15_1

	if var_15_1 then
		arg_15_0.timeText_.text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(var_15_0))
		arg_15_0.timer_ = Timer.New(function()
			arg_15_0.timeText_.text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(var_15_0))

			if manager.time:GetServerTime() >= var_15_0 then
				arg_15_0:StopTimer()

				arg_15_0.isLock_ = false

				arg_15_0:RefreshLock(false)
			end
		end, 1, -1)

		arg_15_0.timer_:Start()
	end
end

function var_0_0.StopTimer(arg_17_0)
	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end
end

function var_0_0.AddDelayTimer(arg_18_0)
	arg_18_0:StopDelayTimer()
	arg_18_0:Show(false)

	arg_18_0.delayTimer_ = Timer.New(function()
		arg_18_0:Show(true)
	end, 0.1 * (arg_18_0.bossIndex_ - 1), 1)

	arg_18_0.delayTimer_:Start()
end

function var_0_0.StopDelayTimer(arg_20_0)
	if arg_20_0.delayTimer_ then
		arg_20_0.delayTimer_:Stop()

		arg_20_0.delayTimer_ = nil
	end
end

return var_0_0
