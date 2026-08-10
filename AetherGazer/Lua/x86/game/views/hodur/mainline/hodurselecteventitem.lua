local var_0_0 = class("HodurSelectEventItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.obtainController_ = arg_2_0.mainControllerEx_:GetController("obtain")
	arg_2_0.selectController_ = arg_2_0.mainControllerEx_:GetController("select")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.selfBtn_, nil, function()
		arg_3_0.onClickHandler_(arg_3_0.optionID_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.optionID_ = arg_5_1
	arg_5_0.eventID_ = arg_5_2
	arg_5_0.chapterID_ = arg_5_3

	arg_5_0:RefreshUI()
end

function var_0_0.SetClickHandler(arg_6_0, arg_6_1)
	arg_6_0.onClickHandler_ = arg_6_1
end

function var_0_0.SetSelected(arg_7_0, arg_7_1)
	arg_7_0.selected_ = arg_7_1

	arg_7_0:RefreshUI()
end

function var_0_0.SetComplete(arg_8_0, arg_8_1)
	arg_8_0.isCompleted_ = arg_8_1

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.selectController_:SetSelectedState(arg_9_0.selected_ and "on" or "off")

	local var_9_0 = ActivityHodurEventOptionCfg[arg_9_0.optionID_]
	local var_9_1 = tonumber(var_9_0.buff_id)
	local var_9_2 = AffixTypeCfg[var_9_1]

	arg_9_0.nameText_.text = var_9_0.option_title
	arg_9_0.descText_.text = var_9_0.option_desc
	arg_9_0.affixText_.text = var_9_0.ending_desc
	arg_9_0.affixdescText_.text = var_9_2.name

	if arg_9_0.isCompleted_ then
		arg_9_0.obtainController_:SetSelectedState("obtain")

		local var_9_3, var_9_4 = HodurTools.GetEventComplete(arg_9_0.eventID_, arg_9_0.chapterID_)

		if var_9_4 == arg_9_0.optionID_ then
			arg_9_0:Show(true)
		else
			arg_9_0:Show(false)
		end
	else
		arg_9_0:Show(true)
		arg_9_0.obtainController_:SetSelectedState("event")
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.eventTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.eventTrs_)
end

function var_0_0.Show(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)

	if arg_10_1 then
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.eventTrs_)
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.eventTrs_)
	end
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
