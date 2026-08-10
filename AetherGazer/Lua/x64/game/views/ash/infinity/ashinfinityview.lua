local var_0_0 = class("AshInfinityView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_EkChuah/EkChuah_BattleUI/EkChuah_BoundlessUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("/ashRankView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.confirmBtn_, nil, function()
		arg_5_0.aniTimer_ = Timer.New(function()
			if arg_5_0.mainAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1.2 then
				manager.ui:UIEventEnabled(true)
				arg_5_0:ConfirmBattle()

				if arg_5_0.aniTimer_ then
					arg_5_0.aniTimer_:Stop()

					arg_5_0.aniTimer_ = nil
				end
			end
		end, 0.033, -1)

		manager.ui:UIEventEnabled(false)
		arg_5_0.mainAnimator_:Play("UI_EkChuah_bloom", 0, 0)
		arg_5_0.aniTimer_:Start()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if ActivityData:GetActivityData(ActivityConst.ACTIVITY_ASH_RANK).stopTime <= manager.time:GetServerTime() then
		SetActive(arg_9_0.rankBtn_.gameObject, false)
	else
		SetActive(arg_9_0.rankBtn_.gameObject, true)
	end

	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(AshShootStageCfg.all) do
		if AshShootStageCfg[iter_9_1].stage_group == 4 then
			var_9_0 = iter_9_1

			break
		end
	end

	local var_9_1 = AshSystemData:GetStagePoint(var_9_0)
	local var_9_2 = "-- --"

	if var_9_1 > 0 then
		var_9_2 = tostring(var_9_1)
	end

	arg_9_0.pointTxt_.text = tostring(var_9_2)
end

function var_0_0.ConfirmBattle(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(AshShootStageCfg.all) do
		local var_10_0 = AshShootStageCfg[iter_10_1]

		if var_10_0.stage_group == 4 then
			JumpTools.OpenPageByJump("/ashPrepareView", {
				stageId = var_10_0.stage_id,
				levelId = iter_10_1
			})

			return
		end
	end
end

function var_0_0.OnExit(arg_11_0)
	if arg_11_0.aniTimer_ then
		arg_11_0.aniTimer_:Stop()

		arg_11_0.aniTimer_ = nil
	end

	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.aniTimer_ then
		arg_12_0.aniTimer_:Stop()

		arg_12_0.aniTimer_ = nil
	end

	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
