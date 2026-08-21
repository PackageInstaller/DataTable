local var_0_0 = class("CoreVerificationInfoTabItem", ReduxView)

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

	arg_3_0.selectController_ = arg_3_0.mainControllerEx_:GetController("select")
	arg_3_0.lockController_ = arg_3_0.mainControllerEx_:GetController("lock")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.mainBtn_, nil, function()
		if arg_4_0.click_ then
			arg_4_0.click_()
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.click_ = arg_6_4

	local var_6_0 = CoreVerificationData:GetInfoCfgByTypeAndDiff(arg_6_1, arg_6_2)
	local var_6_1 = CoreVerificationData:GetStageIdByTypeAndDiff(arg_6_1, arg_6_2 - 1)
	local var_6_2 = CoreVerificationData:GetStageInfoByTypeAndDiff(arg_6_1, arg_6_2 - 1)
	local var_6_3 = CoreVerificationData:IsOpenChallgeByType(1)
	local var_6_4 = CoreVerificationData:IsOpenChallgeByType(2)

	arg_6_0.nameText_.text = ""

	local var_6_5 = PlayerData:GetPlayerInfo().userLevel < var_6_0.unlock_level

	if CoreVerificationData:IsChallengeType(var_6_0.id) then
		if var_6_3 and var_6_4 and not var_6_5 then
			arg_6_0.lockController_:SetSelectedState("false")
		else
			arg_6_0.lockController_:SetSelectedState("true")
		end

		arg_6_0.diffText_.text = GetTips("CORE_VERIFICATION_TAB_DES_2")
	else
		if arg_6_2 == 1 or var_6_2 then
			arg_6_0.lockController_:SetSelectedState("false")
		else
			arg_6_0.lockController_:SetSelectedState("true")
		end

		arg_6_0.diffText_.text = string.format(GetTips("CORE_VERIFICATION_TAB_DES_1"), arg_6_2)

		if var_6_5 then
			arg_6_0.lockController_:SetSelectedState("true")
		end
	end

	arg_6_0.selectController_:SetSelectedState(arg_6_2 == arg_6_3 and "true" or "false")
end

function var_0_0.Select(arg_7_0, arg_7_1)
	arg_7_0.selectController_:SetSelectedState(arg_7_1 and "true" or "false")
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
