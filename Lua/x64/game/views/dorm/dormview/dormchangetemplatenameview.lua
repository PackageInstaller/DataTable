local var_0_0 = class("DormChangeTemplateNameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormPopupChangeNameUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:GetOrAddComponent(arg_3_0.nameinput_.gameObject, typeof(InputFieldHelper))
	dealEnter(arg_3_0.nameinput_.gameObject)
end

function var_0_0._onValidateInput(arg_4_0, arg_4_1, arg_4_2)
	if #arg_4_0 >= 24 then
		return 0
	end

	return arg_4_2
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.cancelbtnBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.okbtnBtn_, nil, function()
		local var_8_0 = arg_5_0.params_.oldName or ""
		local var_8_1 = arg_5_0.nameinput_.text

		if var_8_1 == "" then
			ShowTips(GetTips("DORM_MOULD_NAME_NULL"))

			return
		end

		if var_8_0 == var_8_1 then
			ShowTips(GetTips("DORM_MOULD_NAME_SAME"))

			return
		end

		local var_8_2, var_8_3 = textLimit(var_8_1, GameDisplayCfg.dorm_mould_name_max.value[1])

		arg_5_0.nameinput_.text = GetI18NText(var_8_2)

		local var_8_4 = var_8_2

		if not nameRule(var_8_4) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		if not var_8_3 then
			return
		end

		WordVerifyBySDK(var_8_4, function(arg_9_0)
			if not arg_9_0 then
				ShowTips("ERROR_USER_NAME_VER_WORD")
			elseif arg_5_0.params_.callBack then
				arg_5_0.params_.callBack(var_8_4)
			end
		end, JUDGE_MESSAGE_TYPE.DORM_TEMPLATE)
	end)
end

function var_0_0.Init(arg_10_0)
	arg_10_0:InitUI()
	arg_10_0:AddUIListener()
end

function var_0_0.RegisterEvent(arg_11_0)
	arg_11_0:RegistEventListener(DOMR_RENAME_TEMPLATE_SUCCESS, function()
		ShowTips(GetTips("DORM_MOULD_NAME_CHANGE"))
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.nameinput_.text = ""
	arg_13_0.placeholderText_.text = arg_13_0.params_.showText or ""

	arg_13_0:RegisterEvent()
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveAllListeners()
	arg_15_0.nameinput_.onValueChanged:RemoveAllListeners()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
