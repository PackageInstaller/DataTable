local var_0_0 = class("HeroFileVoiceItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.lockController_ = arg_3_0.voiceControllerEx_:GetController("lock")
	arg_3_0.playController_ = arg_3_0.voiceControllerEx_:GetController("playing")
	arg_3_0.bgController = arg_3_0.voiceControllerEx_:GetController("bg")
end

local var_0_1 = 8

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.unlock_ = arg_4_2.unlock
	arg_4_0.onClick_ = arg_4_3
	arg_4_0.id_ = arg_4_2.id

	local var_4_0 = HeroVoiceCfg[arg_4_2.id]
	local var_4_1 = nullable(var_4_0, "title")
	local var_4_2 = nullable(var_4_0, "tag_id")

	arg_4_0:SetBgState(var_4_2 == var_0_1 and "oath" or "normal")

	arg_4_0.voiceNameText_.text = var_4_1

	if arg_4_2.unlock then
		arg_4_0.lockController_:SetSelectedState("unlock")
	else
		arg_4_0.lockController_:SetSelectedState("lock")

		arg_4_0.voiceLockText_.text = arg_4_0:GetLockMsg(arg_4_2, arg_4_1)
	end
end

function var_0_0.SetBgState(arg_5_0, arg_5_1)
	arg_5_0.bgController:SetSelectedState(arg_5_1)
end

function var_0_0.SetIsShow(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.GetLockMsg(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1.lockMsg then
		return arg_7_1.lockMsg
	elseif DormHeroTools:IsVoiceNeedUnlock(arg_7_1.id, arg_7_2) then
		return string.format(GetTips("DORM_VOICE_UNLOCK_TIP"), DormHeroTools:GetVoiceUnlockLevel(arg_7_2, arg_7_1.id))
	else
		local var_7_0 = nullable(HeroVoiceCfg, arg_7_1.id, "unlock_condition")

		return nullable(ConditionCfg, var_7_0, "desc")
	end
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.voiceBtn_, nil, function()
		if arg_8_0.onClick_ and arg_8_0.unlock_ then
			arg_8_0.onClick_(arg_8_0.id_)
		end
	end)
end

function var_0_0.StopPlay(arg_10_0)
	arg_10_0.playController_:SetSelectedState("stop")
end

function var_0_0.StartPlay(arg_11_0)
	arg_11_0.playController_:SetSelectedState("play")
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
