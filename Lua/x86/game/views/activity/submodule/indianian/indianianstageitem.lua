local var_0_0 = class("InidaNianStageItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "state")
	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "select")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		IndiaNianData:SetSelectedStage(arg_2_0.cfg_.stage_id)
		IndiaNianData:SetSelectedStageCost(arg_2_0.cfg_.cost)

		if arg_2_0.cfg_.round < IndiaNianData:GetRound() or arg_2_0.cfg_.round == IndiaNianData:GetRound() and IndiaNianData:GetCurrentHpByID(arg_2_0.cfg_.id) == 0 then
			local var_3_0 = IndiaNianCfg.get_id_list_by_group_id[arg_2_0.cfg_.group_id]

			for iter_3_0, iter_3_1 in ipairs(var_3_0) do
				if IndiaNianCfg[iter_3_1].activity_id == arg_2_0.cfg_.activity_id and IndiaNianCfg[iter_3_1].stage_type == 1 then
					IndiaNianData:SetSelectedDestID(iter_3_1)
				end
			end
		else
			IndiaNianData:SetSelectedDestID(arg_2_0.cfg_.id)
		end

		if arg_2_0.callback then
			arg_2_0.callback(arg_2_0.index_)
		end
	end)
	arg_2_0:AddBtnListener(arg_2_0.clearBtn_, nil, function()
		ShowTips("ACTIVITY_INDIA_NIAN_DESC_CLEAR")
	end)
end

function var_0_0.SetCallBack(arg_5_0, arg_5_1)
	arg_5_0.callback = arg_5_1
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0.nameText_.text = arg_6_0.cfg_.name
	arg_6_0.iconImg_.sprite = getSprite("Atlas/IndiaUI_2_8", arg_6_0.cfg_.icon)

	arg_6_0:RefreshState()
end

function var_0_0.RefreshState(arg_7_0)
	local var_7_0 = arg_7_0.cfg_.round > IndiaNianData:GetRound()
	local var_7_1 = arg_7_0.cfg_.round == IndiaNianData:GetRound()
	local var_7_2 = arg_7_0.cfg_.round < IndiaNianData:GetRound() or arg_7_0.cfg_.round == IndiaNianData:GetRound() and IndiaNianData:GetCurrentHpByID(arg_7_0.cfg_.id) == 0
	local var_7_3 = IndiaNianData:GetStageHasClearedByID(arg_7_0.cfg_.id)
	local var_7_4 = arg_7_0.index_ == IndiaNianData:GetMainSelectedIndex()

	if var_7_0 then
		arg_7_0.controller_:SetSelectedState("lock")
	elseif var_7_3 then
		arg_7_0.controller_:SetSelectedState("finished")
	elseif var_7_2 then
		arg_7_0.controller_:SetSelectedState("final")
	elseif var_7_1 then
		arg_7_0.controller_:SetSelectedState("open")
	end

	local var_7_5 = IndiaNianData:GetCurrentHpByID(arg_7_0.cfg_.id) / arg_7_0.cfg_.boss_hp

	arg_7_0.selectController_:SetSelectedState(tostring(var_7_4 and not var_7_3 and not var_7_0))

	arg_7_0.silderImg_.fillAmount = var_7_5
	arg_7_0.percentText_.text = math.ceil(var_7_5 * 100) .. "%"
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.index_ = arg_8_1
	arg_8_0.cfg_ = arg_8_2

	arg_8_0:RefreshUI()
end

return var_0_0
