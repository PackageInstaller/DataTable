local var_0_0 = class("BilliardGameMainUI_5_1", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_BallxPit/Activity_WuLuo_BallxPit_MainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:OnInit()
end

function var_0_0.BuildContext(arg_4_0)
	arg_4_0.bottomInfoModule_ = BilliardGameBottomInfoModule.New(arg_4_0.bottomInfoGo_)
end

function var_0_0.OnInit(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:BuildContext()
	BilliardGameTools.BindBilliardGameUI(arg_5_0.turnBasedObj_)
	arg_5_0:AddEventListner()

	arg_5_0.mergeInfoController_ = arg_5_0.mainControllerEx_:GetController("mergeInfo")
	arg_5_0.magnifyEffectController_ = arg_5_0.mainControllerEx_:GetController("fog")
	arg_5_0.mergeBackHandler_ = handler(arg_5_0.bottomInfoModule_, arg_5_0.bottomInfoModule_.OnMergeBack)
end

function var_0_0.AddEventListner(arg_6_0)
	arg_6_0:RegistEventListener(BilliardGameEvent.BILLIARD_UPDATE_VIEW, function()
		arg_6_0:UpdateView()
	end)
	arg_6_0:RegistEventListener(BilliardGameEvent.BILLIARD_VEHICLE_INJURED, function(arg_8_0)
		arg_6_0.bottomInfoModule_:RefreshHp(arg_8_0)
	end)
	arg_6_0:RegistEventListener(BilliardGameEvent.BILLIARD_MONSTER_DEAD, function(arg_9_0)
		BilliardGameMgr:UpdateKillMonsterCount(BilliardGameMgr:GetKillMonsterCount() + 1)

		local var_9_0 = MergeBallMonsterCfg[arg_9_0] and MergeBallMonsterCfg[arg_9_0].merge_process or 1

		arg_6_0.bottomInfoModule_:RefreshMergeProcess(var_9_0)
	end)
	arg_6_0:RegistEventListener(BilliardGameEvent.TEST_MERGE_PROCESS, function(arg_10_0)
		arg_6_0.bottomInfoModule_:RefreshMergeProcess(arg_10_0)
	end)
	arg_6_0:RegistEventListener(BilliardGameEvent.BILLIARD_PLAYER_ROUND_BEGIN, function()
		arg_6_0:OnPlayerRoundBegin()
	end)
	arg_6_0:RegistEventListener(BilliardGameEvent.BILLIARD_GAME_ROUND_OVER, function()
		arg_6_0:OnRoundOver()
	end)
	arg_6_0:RegistEventListener(BilliardGameEvent.UPDATE_VEHICLE_SKILL, function()
		arg_6_0.bottomInfoModule_:RefreshBuff()
	end)
	arg_6_0:RegistEventListener(BilliardGameEvent.SINGLE_SKILL_UPGRADE, function(arg_14_0)
		arg_6_0.bottomInfoModule_:OnSingleSkillUpgrade(arg_14_0)
	end)
	arg_6_0:RegistEventListener(BilliardGameEvent.SET_BOTTOM_INFO_GO_ACTIVE, function(arg_15_0)
		arg_6_0:RefreshBottomActive(arg_15_0)
	end)
	arg_6_0:RegistEventListener(BilliardGameEvent.SET_MERGE_AND_BALL_ACTIVE, function(arg_16_0)
		arg_6_0.bottomInfoModule_:SetMergeAndBallActive(arg_16_0)
	end)
	arg_6_0:RegistEventListener(BilliardGameEvent.MAIN_POP_END, function()
		arg_6_0:CheckShowPop()
	end)
	arg_6_0:RegistEventListener(BilliardGameEvent.MERGE_PROCESS_FEEDBACK, function(arg_18_0)
		arg_6_0.bottomInfoModule_:FeedbackMergeProcess(arg_18_0)
		arg_6_0.bottomInfoModule_:HideMergePop()
	end)
	arg_6_0:RegistEventListener(BilliardGameEvent.MAGNIFY_EFFECT, function()
		arg_6_0:ShowMagnifyEffect()
	end)
	arg_6_0:RegistEventListener(BilliardGameEvent.SET_CLICK_SKILL_ITEM, function(arg_20_0)
		arg_6_0.bottomInfoModule_:OnSkillClick(arg_20_0, nil, true)
	end)
	arg_6_0:RegistEventListener(BilliardGameEvent.DRAG_STATE, function(arg_21_0)
		arg_6_0.bottomInfoModule_:SetDragState(arg_21_0)
	end)
end

function var_0_0.OnEnter(arg_22_0)
	arg_22_0.bottomInfoModule_:OnEnter()

	arg_22_0.isFirstInGame_ = true
end

function var_0_0.OnTop(arg_23_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_23_0:RefreshBottomActive(false)
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("MERGE_BALL_QUIT_CONFIRM"),
			OkCallback = function()
				local var_25_0 = BilliardGameLuaBridge.GetExchangeData()

				SendBilliardMessage_5_1(var_25_0)
				LuaExchangeHelper.GoToMain()
			end,
			CancelCallback = function()
				arg_23_0:RefreshBottomActive(true)
			end
		})
	end)
	arg_23_0.bottomInfoModule_:OnTop()
	arg_23_0.bottomInfoModule_:SetCanvasSortOrder(1)
end

function var_0_0.OnBehind(arg_27_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnPlayerRoundBegin(arg_28_0)
	if not BilliardGameMgr:IsInBilliardGame() then
		return
	end

	arg_28_0.isPlayerRound_ = true
	arg_28_0.delayTimer_ = Timer.New(function()
		if arg_28_0.isFirstInGame_ then
			arg_28_0.isFirstInGame_ = false

			if not manager.guide:IsPlaying() then
				SetActive(arg_28_0.startGo_, true)
			end

			arg_28_0.startTimer_ = Timer.New(function()
				SetActive(arg_28_0.startGo_, false)
				arg_28_0:CheckShowPop()
			end, 2, 1)

			arg_28_0.startTimer_:Start()
		else
			arg_28_0.startTimer_ = Timer.New(function()
				SetActive(arg_28_0.startGo_, false)
				arg_28_0:CheckShowPop()
			end, 1, 1)

			arg_28_0.startTimer_:Start()
		end
	end, 0.33, 1)

	arg_28_0.delayTimer_:Start()
end

function var_0_0.OnRoundOver(arg_32_0)
	arg_32_0.isPlayerRound_ = false
	arg_32_0.isShowedSkillSelectPop_ = false
end

function var_0_0.CheckShowPop(arg_33_0)
	if not arg_33_0.isPlayerRound_ or not BilliardGameMgr:IsInBilliardGame() then
		return
	end

	local var_33_0 = BilliardGameConst.HideSelectPopView[BilliardGameMgr:GetStageId()]
	local var_33_1 = var_33_0 and table.indexof(var_33_0, BilliardGameMgr:GetCurRound())

	local function var_33_2()
		if gameContext:GetLastOpenPage() == "activityWuluoVehicleIllustratePopView" then
			JumpTools.Back()
		end
	end

	local var_33_3 = false

	if not arg_33_0.isShowedSkillSelectPop_ then
		if var_33_1 then
			BilliardGameLuaBridge.SetSelectBuffOver(true)

			return
		end

		var_33_2()
		JumpTools.OpenPageByJump("billiardGameSelectSkillPopView")

		arg_33_0.isShowedSkillSelectPop_ = true
		var_33_3 = true
	elseif arg_33_0.bottomInfoModule_:GetIsNeedMerge() then
		arg_33_0.bottomInfoModule_:HideMergePop()
		var_33_2()
		JumpTools.OpenPageByJump("billiardGameMergeSkillPopView", {
			backCallBack = arg_33_0.mergeBackHandler_
		})

		var_33_3 = true
	end

	if var_33_3 then
		arg_33_0.bottomInfoModule_:SetCanvasSortOrder(10)
		arg_33_0.bottomInfoModule_:CheckGuide()
	else
		arg_33_0.bottomInfoModule_:SetCanvasSortOrder(1)
	end
end

function var_0_0.RefreshBottomActive(arg_35_0, arg_35_1)
	SetActive(arg_35_0.bottomInfoGo_, arg_35_1)
end

function var_0_0.RefreshTips(arg_36_0)
	return
end

function var_0_0.UpdateView(arg_37_0)
	return
end

function var_0_0.ShowMagnifyEffect(arg_38_0)
	arg_38_0.magnifyEffectController_:SetSelectedState("on")
end

function var_0_0.OnExit(arg_39_0)
	if arg_39_0.delayTimer_ then
		arg_39_0.delayTimer_:Stop()

		arg_39_0.delayTimer_ = nil
	end

	if arg_39_0.startTimer_ then
		arg_39_0.startTimer_:Stop()

		arg_39_0.startTimer_ = nil
	end

	arg_39_0.bottomInfoModule_:OnExit()
end

function var_0_0.Dispose(arg_40_0)
	arg_40_0.bottomInfoModule_:Dispose()
	var_0_0.super.Dispose(arg_40_0)
end

return var_0_0
