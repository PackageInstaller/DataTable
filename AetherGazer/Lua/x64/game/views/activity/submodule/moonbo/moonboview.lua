local var_0_0 = class("MoonBoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIUI/VolumeBocakeMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
	arg_3_0:AddEventListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.isShowDiceController_ = ControllerUtil.GetController(arg_4_0.transform_, "IsShowDice")
	arg_4_0.isShowDice_ = false
	arg_4_0.IsAniSelfPlay_ = false
	arg_4_0.todices_ = {}
	arg_4_0.activedice1_ = nil
	arg_4_0.activedice2_ = nil
	arg_4_0.activedice3_ = nil
	arg_4_0.activedice4_ = nil
	arg_4_0.activedice5_ = nil
	arg_4_0.activedice6_ = nil
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		if arg_5_0.isShowDice_ == false then
			JumpTools.OpenPageByJump("moonBoRewardView", {
				activityId = arg_5_0.activityID_
			})
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.ruleBtn_, nil, function()
		if arg_5_0.isShowDice_ == false then
			JumpTools.OpenPageByJump("moonBoIntroduceView", {
				activityId = arg_5_0.activityID_
			})
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.moonBoBtn_, nil, function()
		if arg_5_0.isShowDice_ == false then
			arg_5_0.isShowDice_ = true

			if ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
				if MoonBoData:GetCanGetCount() <= 0 then
					arg_5_0.isShowDice_ = false

					ShowTips(GetTips("ACTIVITY_MOONCAKE_GAMBLING_NUM_ZERO"))
				else
					MoonBoAction:GetMoonBo(arg_5_0.activityID_)
				end
			else
				arg_5_0.isShowDice_ = false

				ShowTips(GetTips("TIME_OVER"))
			end
		end
	end)
end

function var_0_0.AddEventListeners(arg_9_0)
	arg_9_0:RegistEventListener(MOONBO_SUCCESS, function()
		manager.windowBar:HideBar()
		AnimatorTools.PlayAnimationWithCallback(arg_9_0.selfAni_, "VolumeBocakeMainUI_close", function()
			arg_9_0.isShowDiceController_:SetSelectedState("true")
			SetActive(arg_9_0.diceGo_, true)

			arg_9_0.todices_ = MoonBoData:GetCurDices()

			SetActive(arg_9_0.activedice1_, false)
			SetActive(arg_9_0.activedice2_, false)
			SetActive(arg_9_0.activedice3_, false)
			SetActive(arg_9_0.activedice4_, false)
			SetActive(arg_9_0.activedice5_, false)
			SetActive(arg_9_0.activedice6_, false)

			arg_9_0.activedice1_ = arg_9_0:DiceToRight(arg_9_0.dice1_, 1)
			arg_9_0.activedice2_ = arg_9_0:DiceToRight(arg_9_0.dice2_, 2)
			arg_9_0.activedice3_ = arg_9_0:DiceToRight(arg_9_0.dice3_, 3)
			arg_9_0.activedice4_ = arg_9_0:DiceToRight(arg_9_0.dice4_, 4)
			arg_9_0.activedice5_ = arg_9_0:DiceToRight(arg_9_0.dice5_, 5)
			arg_9_0.activedice6_ = arg_9_0:DiceToRight(arg_9_0.dice6_, 6)

			SetActive(arg_9_0.activedice1_, true)
			SetActive(arg_9_0.activedice2_, true)
			SetActive(arg_9_0.activedice3_, true)
			SetActive(arg_9_0.activedice4_, true)
			SetActive(arg_9_0.activedice5_, true)
			SetActive(arg_9_0.activedice6_, true)
			manager.audio:PlayEffect("minigame_activity_1_3", "minigame_diceroll", "")
			AnimatorTools.PlayAnimationWithCallback(arg_9_0.diceAni_, "VolumeBocakeMainUI_roll", function()
				manager.windowBar:SwitchBar({
					BACK_BAR,
					HOME_BAR,
					INFO_BAR
				})

				arg_9_0.isShowDice_ = false

				arg_9_0.isShowDiceController_:SetSelectedState("false")
				AnimatorTools.Stop()
				JumpTools.OpenPageByJump("moonBoResultView", {
					activityId = arg_9_0.activityID_
				})
			end)
		end)
	end)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.isEnter_ = true
	arg_13_0.activityID_ = arg_13_0.params_.activityID
	arg_13_0.stopTime_ = ActivityData:GetActivityData(arg_13_0.activityID_).stopTime

	if manager.time:GetServerTime() < arg_13_0.stopTime_ then
		arg_13_0.timeText_.text = manager.time:GetLostTimeStr(arg_13_0.stopTime_)
	else
		arg_13_0.timeText_.text = GetTips("TIME_OVER")
	end

	arg_13_0.timer_ = Timer.New(function()
		MoonBoData:FreshTime()

		if manager.time:GetServerTime() < arg_13_0.stopTime_ then
			arg_13_0.timeText_.text = manager.time:GetLostTimeStr(arg_13_0.stopTime_)
		else
			arg_13_0:StopTimer()

			arg_13_0.timeText_.text = GetTips("TIME_OVER")

			return
		end
	end, 1, -1)

	arg_13_0.timer_:Start()

	arg_13_0.canGetCountText_.text = MoonBoData:GetCanGetCount()
	arg_13_0.onNewDayhandler_ = handler(arg_13_0, arg_13_0.OnNewDay)

	manager.notify:RegistListener(ACTIVITY_MOONBO_NEWDAY, arg_13_0.onNewDayhandler_)
	manager.redPoint:bindUIandKey(arg_13_0.moonBoTrs_, string.format("%s_%s", RedPointConst.MOONBO, arg_13_0.activityID_))
	arg_13_0.selfAni_:Play("VolumeBocakeMainUI")

	arg_13_0.diceAniGo_ = Object.Instantiate(Asset.Load("UI/VolumeIIIUI/VolumeBocake_shaizi"))
	arg_13_0.diceAniGo_.transform.position = Vector3(0, 0, 10)

	manager.ui:SetMainCamera("moonBo")
	ComponentBinder.GetInstance():BindCfgUI(arg_13_0, arg_13_0.diceAniGo_)
	arg_13_0.diceAni_:Play("VolumeBocakeMainUI_none")
	SetActive(arg_13_0.diceGo_, false)
	UnityEngine.Physics2D.SyncTransforms()
end

function var_0_0.DiceToRight(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.todices_[arg_15_2]
	local var_15_1

	if var_15_0 == 1 then
		var_15_1 = arg_15_1.transform:Find("1").gameObject
	elseif var_15_0 == 2 then
		var_15_1 = arg_15_1.transform:Find("2").gameObject
	elseif var_15_0 == 3 then
		var_15_1 = arg_15_1.transform:Find("3").gameObject
	elseif var_15_0 == 4 then
		var_15_1 = arg_15_1.transform:Find("4").gameObject
	elseif var_15_0 == 5 then
		var_15_1 = arg_15_1.transform:Find("5").gameObject
	elseif var_15_0 == 6 then
		var_15_1 = arg_15_1.transform:Find("6").gameObject
	end

	return var_15_1
end

function var_0_0.OnNewDay(arg_16_0)
	if ActivityData:GetActivityIsOpen(arg_16_0.activityID_) then
		arg_16_0.canGetCountText_.text = MoonBoData:GetCanGetCount()
	else
		arg_16_0.canGetCountText_.text = 0
	end
end

function var_0_0.OnTop(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MOONCAKE_GAMBLING_DESCRIPE")

	if MoonBoData:GetIsShowReward() == true then
		MoonBoData:SetIsShowReward(false)
		getReward(formatRewardCfgList(MoonBoData:GetCurReward()))
	end

	arg_17_0.canGetCountText_.text = MoonBoData:GetCanGetCount()

	if arg_17_0.isEnter_ == false then
		arg_17_0.selfAni_:Play("VolumeBocakeMainUI", 0, 1)
	end

	arg_17_0.diceAni_:Play("VolumeBocakeMainUI_none")
	SetActive(arg_17_0.diceGo_, false)

	arg_17_0.isEnter_ = false
end

function var_0_0.OnExit(arg_18_0)
	manager.windowBar:HideBar()
	AnimatorTools.Stop()
	arg_18_0:StopTimer()
	manager.notify:RemoveListener(ACTIVITY_MOONBO_NEWDAY, arg_18_0.onNewDayhandler_)
	manager.redPoint:unbindUIandKey(arg_18_0.moonBoTrs_, string.format("%s_%s", RedPointConst.MOONBO, arg_18_0.activityID_))
	manager.ui:ResetMainCamera()

	if arg_18_0.diceAniGo_ then
		Object.Destroy(arg_18_0.diceAniGo_)

		arg_18_0.diceAniGo_ = nil
	end
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:StopTimer()
	arg_19_0:RemoveAllEventListener()
	arg_19_0.super.Dispose(arg_19_0)
end

function var_0_0.StopTimer(arg_20_0)
	if arg_20_0.timer_ then
		arg_20_0.timer_:Stop()

		arg_20_0.timer_ = nil
	end
end

return var_0_0
