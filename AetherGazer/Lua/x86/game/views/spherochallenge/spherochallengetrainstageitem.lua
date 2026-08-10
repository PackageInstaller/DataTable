local var_0_0 = class("SPHeroChallengeTrainStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController = arg_2_0.controller:GetController("state")
	arg_2_0.buffControler = arg_2_0.controller:GetController("buff")

	arg_2_0:AddUIListener()
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.uiIndex = arg_3_3

	local var_3_0 = BattleVerthandiExclusiveCfg[arg_3_1]
	local var_3_1 = table.indexof(BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[var_3_0.sub_type], arg_3_1)

	if var_3_0 and var_3_1 then
		arg_3_0.stageID = arg_3_1

		local var_3_2, var_3_3 = SPHeroChallengeTools:CheckStageIsOpen(arg_3_1)

		arg_3_0.trainnameText_.text = BattleVerthandiExclusiveCfg[arg_3_1].name

		if not var_3_2 then
			arg_3_0.stateController:SetSelectedState("unlock")

			local var_3_4, var_3_5 = SPHeroChallengeTools:GetTrainPercentByStage(arg_3_1, var_3_1)

			arg_3_0.addexptextText_.text = GetTips("TIP_CLEARTIMES") .. "+" .. var_3_4

			if var_3_5 and var_3_5 < 100 then
				arg_3_0.buffControler:SetSelectedState("show")
			else
				arg_3_0.buffControler:SetSelectedState("close")
			end

			arg_3_0.buffText.text = "-" .. 100 - var_3_5 .. "%"

			if arg_3_2 == arg_3_1 then
				arg_3_0.stateController:SetSelectedState("selected")
			end
		else
			arg_3_0.buffControler:SetSelectedState("close")
			arg_3_0.stateController:SetSelectedState("lock")

			arg_3_0.conditiontextText_.text = var_3_3
		end
	end
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.trainstageitemBtn_, nil, function()
		if arg_4_0.stateController:GetSelectedState() == "lock" then
			return
		end

		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.stageID, arg_4_0.uiIndex)
		end
	end)
end

function var_0_0.RegisterClickCallBack(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.clickFunc = arg_6_1
	end
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
