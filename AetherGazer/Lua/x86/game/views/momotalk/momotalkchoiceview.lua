local var_0_0 = class("MomoTalkChoiceView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.choiceBtns_ = {
		arg_1_0.choice1Btn_,
		arg_1_0.choice2Btn_,
		arg_1_0.choice3Btn_,
		arg_1_0.choice4Btn_
	}
	arg_1_0.choiceTexts_ = {
		arg_1_0.choice1Text_,
		arg_1_0.choice2Text_,
		arg_1_0.choice3Text_,
		arg_1_0.choice4Text_
	}

	arg_1_0:AddListeners()
end

function var_0_0.AddListeners(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.choiceBtns_ or {}) do
		if iter_2_1 then
			arg_2_0:AddBtnListener(iter_2_1, nil, function()
				manager.notify:Invoke(MOMOTALK_CHOICE_SELECTED, iter_2_0)
			end)
		end
	end
end

function var_0_0.GetDisplayOptions(arg_4_0, arg_4_1)
	local var_4_0 = {}

	for iter_4_0 = 1, math.min(#(arg_4_1 or {}), #(arg_4_0.choiceBtns_ or {})) do
		var_4_0[iter_4_0] = arg_4_1[iter_4_0]
	end

	return var_4_0
end

function var_0_0.RefreshButtons(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:GetDisplayOptions(arg_5_1)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.choiceBtns_ or {}) do
		if iter_5_1 then
			local var_5_1 = var_5_0[iter_5_0]
			local var_5_2 = arg_5_0.choiceTexts_[iter_5_0]

			SetActive(iter_5_1.gameObject, var_5_1 ~= nil)

			if var_5_2 then
				if var_5_1 and ChatContentCfg[var_5_1] then
					var_5_2.text = GetI18NText(ChatContentCfg[var_5_1].content or "")
				else
					var_5_2.text = ""
				end
			end
		end
	end

	return var_5_0
end

function var_0_0.Show(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	local var_6_0 = ChatContentCfg[arg_6_1.id]

	if not var_6_0 or not var_6_0.options or #var_6_0.options == 0 then
		return
	end

	arg_6_0.currentItem_ = arg_6_1
	arg_6_0.currentOptions_ = arg_6_0:RefreshButtons(var_6_0.options)
	arg_6_0.isShowing_ = true
end

function var_0_0.Hide(arg_7_0)
	arg_7_0.isShowing_ = false
	arg_7_0.currentItem_ = nil
	arg_7_0.currentOptions_ = nil

	arg_7_0:RefreshButtons(nil)
end

function var_0_0.IsShowing(arg_8_0)
	return arg_8_0.isShowing_ == true
end

function var_0_0.GetCurrentItem(arg_9_0)
	return arg_9_0.currentItem_
end

function var_0_0.GetCurrentOptions(arg_10_0)
	return arg_10_0.currentOptions_
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
