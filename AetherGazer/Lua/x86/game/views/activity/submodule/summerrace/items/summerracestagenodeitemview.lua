local var_0_0 = class("SummerRaceStageNodeItemView", ReduxView)

local function var_0_1(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0:Find(arg_1_1)

	if var_1_0 == nil then
		return nil
	end

	return var_1_0:GetComponent(arg_1_2)
end

local function var_0_2(arg_2_0)
	if arg_2_0 == nil then
		return "main"
	end

	local var_2_0 = tostring(arg_2_0.nodeVisualType or arg_2_0.nodeType or "")

	if var_2_0 == "side" or var_2_0 == "boss" or var_2_0 == "plot" then
		return var_2_0
	end

	return "main"
end

local function var_0_3(arg_3_0)
	if arg_3_0 == "side" then
		return "UI_SummerRace_StageItem_side_unlock"
	end

	if arg_3_0 == "boss" then
		return "UI_SummerRace_StageItem_boss_unlock"
	end

	if arg_3_0 == "plot" then
		return "UI_SummerRace_StageItem_plot_unlock"
	end

	return "UI_SummerRace_StageItem_unlock"
end

local function var_0_4(arg_4_0, arg_4_1)
	if arg_4_1 == "side" then
		return arg_4_0.sideAnimator_
	end

	if arg_4_1 == "boss" then
		return arg_4_0.bossAnimator_
	end

	if arg_4_1 == "plot" then
		return arg_4_0.plotAnimator_
	end

	return arg_4_0.mainAnimator_
end

local function var_0_5(arg_5_0, arg_5_1)
	if arg_5_0 ~= nil then
		arg_5_0.enabled = arg_5_1
	end
end

local var_0_6 = 0.05

function var_0_0.OnCtor(arg_6_0, arg_6_1)
	arg_6_0.gameObject_ = arg_6_1
	arg_6_0.transform_ = arg_6_1.transform

	arg_6_0:Init()
end

function var_0_0.Init(arg_7_0)
	arg_7_0:BindCfgUI()

	arg_7_0.controllerEx_ = arg_7_0.transform_:GetComponent("ControllerExCollection")
	arg_7_0.typeController_ = arg_7_0.controllerEx_:GetController("type")
	arg_7_0.gouController_ = arg_7_0.controllerEx_:GetController("gou")
	arg_7_0.lockController_ = arg_7_0.controllerEx_:GetController("lock")
	arg_7_0.mainText_ = var_0_1(arg_7_0.transform_, "root/main/text_shadow/text", typeof(Text))
	arg_7_0.plotText_ = var_0_1(arg_7_0.transform_, "root/plot/text_shadow/text", typeof(Text))
	arg_7_0.sideText_ = var_0_1(arg_7_0.transform_, "root/side/text_shadow/text", typeof(Text))
	arg_7_0.bossText_ = var_0_1(arg_7_0.transform_, "root/boss/text", typeof(Text))
	arg_7_0.mainAnimator_ = var_0_1(arg_7_0.transform_, "root/main", typeof(Animator))
	arg_7_0.plotAnimator_ = var_0_1(arg_7_0.transform_, "root/plot", typeof(Animator))
	arg_7_0.sideAnimator_ = var_0_1(arg_7_0.transform_, "root/side", typeof(Animator))
	arg_7_0.bossAnimator_ = var_0_1(arg_7_0.transform_, "root/boss", typeof(Animator))

	arg_7_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.clickBtn_, nil, function()
		if arg_8_0.clickHandler_ then
			arg_8_0.clickHandler_(arg_8_0.index_, arg_8_0.stageData_)
		end
	end)
end

function var_0_0.SetData(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.stageData_ = arg_10_1
	arg_10_0.index_ = arg_10_2
	arg_10_0.clickHandler_ = arg_10_3

	arg_10_0:RefreshView()
end

function var_0_0.RefreshView(arg_11_0)
	if arg_11_0.stageData_ == nil then
		SetActive(arg_11_0.gameObject_, false)

		return
	end

	SetActive(arg_11_0.gameObject_, true)

	local var_11_0 = tostring(arg_11_0.stageData_.stageName or "")
	local var_11_1 = var_0_2(arg_11_0.stageData_)

	if arg_11_0.mainText_ ~= nil then
		arg_11_0.mainText_.text = var_11_0
	end

	if arg_11_0.plotText_ ~= nil then
		arg_11_0.plotText_.text = var_11_0
	end

	if arg_11_0.sideText_ ~= nil then
		arg_11_0.sideText_.text = var_11_0
	end

	if arg_11_0.bossText_ ~= nil then
		arg_11_0.bossText_.text = var_11_0
	end

	arg_11_0.typeController_:SetSelectedState(var_11_1)
	arg_11_0.gouController_:SetSelectedState(arg_11_0.stageData_.isCompleted == true and "show" or "hide")
	arg_11_0.lockController_:SetSelectedState(arg_11_0.stageData_.isUnlocked == true and "hide" or "show")
end

function var_0_0.SetUnlockLockVisible(arg_12_0, arg_12_1)
	if arg_12_0.lockController_ ~= nil then
		arg_12_0.lockController_:SetSelectedState(arg_12_1 == true and "show" or "hide")
	end
end

function var_0_0.StopUnlockAnimTimer(arg_13_0)
	if arg_13_0.unlockAnimTimer_ ~= nil then
		arg_13_0.unlockAnimTimer_:Stop()

		arg_13_0.unlockAnimTimer_ = nil
	end
end

function var_0_0.PlayUnlockAnim(arg_14_0)
	if arg_14_0.stageData_ == nil or arg_14_0.stageData_.isUnlocked ~= true then
		return false
	end

	arg_14_0:StopUnlockAnimTimer()
	arg_14_0:SetUnlockLockVisible(true)

	local var_14_0 = var_0_2(arg_14_0.stageData_)
	local var_14_1 = var_0_3(var_14_0)
	local var_14_2 = var_0_4(arg_14_0, var_14_0)

	if var_14_2 == nil then
		arg_14_0:SetUnlockLockVisible(false)

		return false
	end

	var_14_2.enabled = true

	var_14_2:Play(var_14_1, 0, 0)
	var_14_2:Update(0)

	arg_14_0.unlockAnimTimer_ = Timer.New(function()
		local var_15_0 = var_14_2:GetCurrentAnimatorStateInfo(0)

		if var_15_0 ~= nil and var_15_0:IsName(var_14_1) and var_15_0.normalizedTime >= 1 then
			arg_14_0:StopUnlockAnimTimer()
			arg_14_0:SetUnlockLockVisible(false)
		end
	end, var_0_6, -1)

	arg_14_0.unlockAnimTimer_:Start()

	return true
end

function var_0_0.StopUnlockAnim(arg_16_0)
	arg_16_0:StopUnlockAnimTimer()
	var_0_5(arg_16_0.mainAnimator_, false)
	var_0_5(arg_16_0.plotAnimator_, false)
	var_0_5(arg_16_0.sideAnimator_, false)
	var_0_5(arg_16_0.bossAnimator_, false)
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:StopUnlockAnim()

	arg_17_0.stageData_ = nil
	arg_17_0.clickHandler_ = nil

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
