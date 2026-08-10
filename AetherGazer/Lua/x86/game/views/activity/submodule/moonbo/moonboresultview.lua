local var_0_0 = class("MoonBoResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIUI/VolumeBocakeResultUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.longController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "IsShowLong")
	arg_4_0.shortController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "IsShowShort")
	arg_4_0.discControllers_ = {}
	arg_4_0.discControllers_[1] = ControllerUtil.GetController(arg_4_0.diceTrans1_, "num")
	arg_4_0.discControllers_[2] = ControllerUtil.GetController(arg_4_0.diceTrans2_, "num")
	arg_4_0.discControllers_[3] = ControllerUtil.GetController(arg_4_0.diceTrans3_, "num")
	arg_4_0.discControllers_[4] = ControllerUtil.GetController(arg_4_0.diceTrans4_, "num")
	arg_4_0.discControllers_[5] = ControllerUtil.GetController(arg_4_0.diceTrans5_, "num")
	arg_4_0.discControllers_[6] = ControllerUtil.GetController(arg_4_0.diceTrans6_, "num")
	arg_4_0.isPlaying = false
	arg_4_0.curFrame_ = 0
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0:RefreshUI()

	arg_5_0.settingData_ = SettingData:GetPicSettingData()

	local var_5_0 = arg_5_0.settingData_.frame + 1
	local var_5_1 = 0
	local var_5_2 = var_5_0 == 1 and 30 or 60

	arg_5_0.timer_ = FrameTimer.New(function()
		arg_5_0.curFrame_ = arg_5_0.curFrame_ + 1

		if arg_5_0.curFrame_ > var_5_2 * 2 then
			arg_5_0.isPlaying = false
		end
	end, 1, var_5_2 * 2 + 10)

	arg_5_0.timer_:Start()
end

function var_0_0.RefreshUI(arg_7_0)
	SetActive(arg_7_0.liziGo1_, false)
	SetActive(arg_7_0.liziGo2_, false)
	SetActive(arg_7_0.liziGo3_, false)
	SetActive(arg_7_0.liziGo4_, false)
	SetActive(arg_7_0.liziGo5_, false)
	SetActive(arg_7_0.liziGo6_, false)

	local var_7_0 = MoonBoData:GetCurDices()

	for iter_7_0 = 1, 6 do
		arg_7_0.discControllers_[iter_7_0]:SetSelectedState(string.format("%s", var_7_0[iter_7_0]))
		SetActive(arg_7_0.discControllers_[iter_7_0].gameObject, false)
	end

	if MoonBoData:GetCurLevel() == 0 then
		arg_7_0.shortController_:SetSelectedState("false")
		arg_7_0.longController_:SetSelectedState("false")
		arg_7_0.noflashDir_:Play()
		manager.audio:PlayEffect("minigame_activity_1_3", "minigame_diceresult", "")

		arg_7_0.curDir_ = arg_7_0.noflashDir_
		arg_7_0.isPlaying = true
		arg_7_0.curFrame_ = 0
	else
		arg_7_0.shortController_:SetSelectedState("true")

		local var_7_1 = Color.New(arg_7_0.levelText_.color.r, arg_7_0.levelText_.color.g, arg_7_0.levelText_.color.b, 0)

		arg_7_0.levelText_.color = var_7_1

		local var_7_2 = MoonBoData:LevelNumToLanguage(MoonBoData:GetCurLevel())

		arg_7_0.levelText_.text = var_7_2

		if MoonBoData:GetIsShowText() then
			arg_7_0.longController_:SetSelectedState("true")

			local var_7_3 = Color.New(arg_7_0.resultText_.color.r, arg_7_0.resultText_.color.g, arg_7_0.resultText_.color.b, 0)

			arg_7_0.resultText_.color = var_7_3
			arg_7_0.resultText_.text = string.format(GetTips("ACTIVITY_MOONCAKE_GAMBLING_REWARD_NONE"), var_7_2, var_7_2)
		else
			arg_7_0.longController_:SetSelectedState("false")
		end

		arg_7_0.flashDir_:Play()
		manager.audio:PlayEffect("minigame_activity_1_3", "minigame_diceresult", "")

		arg_7_0.curDir_ = arg_7_0.flashDir_
		arg_7_0.isPlaying = true
		arg_7_0.curFrame_ = 0
	end
end

function var_0_0.AddUIListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.bgBtn_, nil, function()
		if arg_8_0.isPlaying then
			arg_8_0.isPlaying = false
			arg_8_0.curDir_.time = 2

			manager.audio:StopEffect()
		else
			MoonBoData:SetIsShowReward(true)
			arg_8_0:Back()
		end
	end)
end

function var_0_0.OnExit(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
