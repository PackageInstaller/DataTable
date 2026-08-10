local var_0_0 = class("HellaPinballActiveSkillUnlockPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Hel/Activity_Hel_Main/Activity_Hel_SkillUnlockUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	return
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		arg_5_0:Back()
		PinballBridge.ShowBackGroundMask(true)
		JumpTools.OpenPageByJump("/pinballHero", {
			roleID = PinballData:GetRoleID()
		})
		PinballBridge.PlayTimelineWithCallBack("skill_stand", function()
			PinballBridge.SetPlayerAniState("skill_stand")
		end)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.skillID_ = getData("Hella_Pinball", "Unlock_Active_Skill") or -1

	if arg_9_0.skillID_ > 0 then
		local var_9_0 = PinballSkillCfg[arg_9_0.skillID_]

		if var_9_0 then
			arg_9_0.skillIcon_.sprite = pureGetSpriteWithoutAtlas(var_9_0.icon)
			arg_9_0.skillNameText_.text = GetI18NText(var_9_0.name)
			arg_9_0.skillDescText_.text = string.format(GetI18NText(var_9_0.description), unpack(var_9_0.effect))
		end

		saveData("Hella_Pinball", "Unlock_Active_Skill", -1)
	end
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
