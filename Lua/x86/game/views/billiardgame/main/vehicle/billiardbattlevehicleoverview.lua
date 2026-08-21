local var_0_0 = class("BilliardBattleVehicleOverView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_BallxPit/Activity_WuLuo_BallxPit_ResultPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.viewStatusController_ = arg_4_0.transCon_:GetController("viewStatus")
	arg_4_0.processController_ = arg_4_0.transCon_:GetController("process")
	arg_4_0.completeController_ = arg_4_0.transCon_:GetController("complete")
	arg_4_0.tipsController_ = arg_4_0.transCon_:GetController("tips")
	arg_4_0.tipsPosController_ = arg_4_0.transCon_:GetController("tipsPos")
	arg_4_0.skillLockController_ = arg_4_0.skillCon_:GetController("lock")
	arg_4_0.ballLockController_ = arg_4_0.ballCon_:GetController("lock")
	arg_4_0.processAnimList_ = {}

	for iter_4_0 = 1, 3 do
		table.insert(arg_4_0.processAnimList_, arg_4_0["processAnim_" .. iter_4_0])
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.confirmBtn_1, nil, function()
		OnExitVehiclBilliardBattle(arg_5_0.victory_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.confirmBtn_2, nil, function()
		OnExitVehiclBilliardBattle(arg_5_0.victory_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.exitBtn_, nil, function()
		OnExitVehiclBilliardBattle(arg_5_0.victory_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.restartBtn_, nil, function()
		manager.ui:SetCanvasAlpha(0)
		BilliardGameMgr:Restart()
	end)
	arg_5_0:AddBtnListener(arg_5_0.skillBtn_, nil, function()
		arg_5_0.descText_.text = arg_5_0.skillCfg_.desc

		arg_5_0.tipsController_:SetSelectedState("show")
		arg_5_0.tipsPosController_:SetSelectedState("skill")
	end)
	arg_5_0:AddBtnListener(arg_5_0.ballBtn_, nil, function()
		arg_5_0.descText_.text = arg_5_0.ballCfg_.desc

		arg_5_0.tipsController_:SetSelectedState("show")
		arg_5_0.tipsPosController_:SetSelectedState("vehicle")
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0.tipsController_:SetSelectedState("hide")
	end)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.stageId_ = arg_13_0.params_.stageId
	arg_13_0.victory_ = arg_13_0.params_.victory
	arg_13_0.passedStageList_ = arg_13_0.params_.passedStageList

	arg_13_0:RefreshView()
	arg_13_0:ShowEnterAnim()
end

function var_0_0.RefreshView(arg_14_0)
	if arg_14_0.victory_ then
		local var_14_0 = MergeBallStageCfg[arg_14_0.stageId_]

		if var_14_0 and var_14_0.ult_progress ~= 0 then
			local var_14_1 = var_14_0.unlock_skill == 0

			arg_14_0.skillLockController_:SetSelectedState(tostring(var_14_1))

			if not var_14_1 then
				arg_14_0.skillCfg_ = MergeBallVehicleCfg[var_14_0.unlock_skill]

				if arg_14_0.skillCfg_ then
					arg_14_0.skillIcon_.sprite = pureGetSpriteWithoutAtlas(arg_14_0.skillCfg_.icon)
				end
			end

			local var_14_2 = var_14_0.unlock_vehicle == 0

			arg_14_0.ballLockController_:SetSelectedState(tostring(var_14_2))

			if not var_14_2 then
				arg_14_0.ballCfg_ = MergeBallVehicleCfg[var_14_0.unlock_vehicle]

				if arg_14_0.ballCfg_ then
					arg_14_0.ballIcon_.sprite = pureGetSpriteWithoutAtlas(arg_14_0.ballCfg_.icon)
				end
			end

			if table.indexof(arg_14_0.passedStageList_, arg_14_0.stageId_) then
				arg_14_0.viewStatusController_:SetSelectedState("success")
			else
				arg_14_0.viewStatusController_:SetSelectedState("firstPass")
			end
		else
			arg_14_0.viewStatusController_:SetSelectedState("success")
		end
	else
		arg_14_0.viewStatusController_:SetSelectedState("failure")
	end
end

function var_0_0.ShowEnterAnim(arg_15_0)
	local var_15_0 = MergeBallStageCfg[arg_15_0.stageId_].ult_progress

	arg_15_0.processController_:SetSelectedState(var_15_0)

	arg_15_0.processAnimTimer_ = Timer.New(function()
		arg_15_0:ShowProcessAnim(var_15_0)
	end, 0.8, 1)

	arg_15_0.processAnimTimer_:Start()
end

function var_0_0.ShowProcessAnim(arg_17_0, arg_17_1)
	for iter_17_0 = 1, arg_17_1 do
		if iter_17_0 ~= arg_17_1 then
			arg_17_0.processAnimList_[iter_17_0]:Play("normal")
		elseif arg_17_1 == BilliardGameConst.StageCount - 1 then
			AnimatorTools.PlayAnimationWithCallback(arg_17_0.processAnimList_[iter_17_0], "process_unlock", function()
				arg_17_0.completeController_:SetSelectedState("true")
				arg_17_0.completeAnim_:Play("base_Complete")
			end)
		else
			arg_17_0.processAnimList_[iter_17_0]:Play("process_unlock")
		end
	end
end

function var_0_0.OnTop(arg_19_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnExit(arg_20_0)
	AnimatorTools.Stop()

	if arg_20_0.processAnimTimer_ then
		arg_20_0.processAnimTimer_:Stop()

		arg_20_0.processAnimTimer_ = nil
	end
end

function var_0_0.Dispose(arg_21_0)
	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
