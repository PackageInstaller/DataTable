local var_0_0 = class("ChipSchemeItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.renameHandler_ = handler(arg_1_0, arg_1_0.OnRenameChipScheme)

	manager.notify:RegistListener(RENAME_CHIP_SCHEME, arg_1_0.renameHandler_)

	arg_1_0.inputHandler_ = handler(arg_1_0, arg_1_0.OnInput)
	arg_1_0.inputCancelHandler_ = handler(arg_1_0, arg_1_0.OnInputCancel)

	manager.notify:RegistListener(INPUT_POP_CLICK_OK, arg_1_0.inputHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CLOSE, arg_1_0.inputCancelHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CANCEL, arg_1_0.inputCancelHandler_)

	arg_1_0.controller_ = arg_1_0.stateControl:GetController("bState")
end

function var_0_0.SetTemplateData(arg_2_0, arg_2_1)
	arg_2_0.dataTemplate = arg_2_1
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.renameBtn_, nil, function()
		arg_3_0.inputPopFlag_ = true

		JumpTools.OpenPageByJump("ProposalPopup")
	end)
	arg_3_0:AddBtnListener(arg_3_0.deleteBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("DELETE_CHIP_SCHEME"), arg_3_0.schemeData_.name),
			OkCallback = function()
				ChipAction.DeleteChipScheme(arg_3_0.schemeData_.id)
				OperationRecorder.Record("ChipSchemeItem", "okDelete")
			end,
			CancelCallback = function()
				OperationRecorder.Record("ChipSchemeItem", "cancelDelete")
			end
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.saveBtn_, nil, function()
		if #arg_3_0.schemeData_.chipList < 1 then
			ShowTips("SCHEME_IS_NULL")

			return false
		end

		local var_8_0 = GameSetting.ai_chip_proposal_num_max.value[1]
		local var_8_1 = ChipData:GetSchemeList()

		if var_8_0 <= table.length(var_8_1) then
			ShowTips("MORE_THEN_MAX_SCHEME_CNT")

			return
		end

		for iter_8_0 = 1, var_8_0 do
			if var_8_1[iter_8_0] == nil then
				arg_3_0.saveFlag_ = true

				JumpTools.OpenPageByJump("ProposalPopup")

				break
			end
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.enabledBtn_, nil, function()
		arg_3_0:OnEnabledBtn()
	end)
end

function var_0_0.RefreshUI(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	arg_10_0.chipManagerID_ = arg_10_1
	arg_10_0.schemeData_ = arg_10_3
	arg_10_4 = arg_10_4 or 0
	arg_10_0.index_ = arg_10_2

	local var_10_0 = arg_10_3.id

	if var_10_0 == -1 then
		arg_10_0.controller_:SetSelectedState("state0")

		return
	end

	arg_10_0.nameText_.text = GetI18NText(arg_10_3.name)

	for iter_10_0 = 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
		local var_10_1 = arg_10_3.chipList[iter_10_0]

		if var_10_1 then
			arg_10_0[string.format("icon%sImg_", iter_10_0)].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[var_10_1].picture_id)

			SetActive(arg_10_0[string.format("icon%sGo_", iter_10_0)].gameObject, true)
		else
			SetActive(arg_10_0[string.format("icon%sGo_", iter_10_0)].gameObject, false)
		end

		SetActive(arg_10_0[string.format("icon%sGo_", iter_10_0)], var_10_1 and true or false)
	end

	if arg_10_2 == 1 then
		if var_10_0 == 0 then
			arg_10_0.controller_:SetSelectedState("state0")
		else
			arg_10_0.controller_:SetSelectedState("state2")
		end
	else
		arg_10_0.controller_:SetSelectedState("state1")
	end
end

function var_0_0.OnInput(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.inputPopFlag_ and not arg_11_0.saveFlag_ then
		return
	end

	if not arg_11_0.gameObject_.activeInHierarchy then
		return
	end

	if arg_11_1 == "" then
		ShowTips("INPUT_EQUIP_PROPOSAL_NAME")

		return
	end

	if IsAllSpace(arg_11_1) then
		ShowTips("INPUT_CHAT_CONTENT")

		arg_11_2.text = ""

		return
	end

	local var_11_0, var_11_1 = textLimit(arg_11_1, GameSetting.user_name_max.value[1])

	arg_11_2.text = var_11_0
	arg_11_1 = var_11_0

	if not nameRule(arg_11_1) then
		ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

		arg_11_2.text = ""

		return
	end

	WordVerifyBySDK(arg_11_1, function(arg_12_0)
		if not arg_12_0 then
			ShowTips("SENSITIVE_WORD")

			arg_11_2.text = ""

			return
		else
			if not var_11_1 then
				return
			end

			if arg_11_0.saveFlag_ then
				local var_12_0 = GameSetting.ai_chip_proposal_num_max.value[1]
				local var_12_1 = ChipData:GetSchemeList()

				for iter_12_0 = 1, var_12_0 do
					if var_12_1[iter_12_0] == nil then
						arg_11_0.schemeData_.id = iter_12_0
						arg_11_0.schemeData_.name = arg_11_1

						ChipAction.SaveChipScheme(arg_11_0.schemeData_)

						break
					end
				end
			else
				ChipAction.RenameChipScheme(arg_11_0.schemeData_.id, arg_11_1)

				arg_11_0.schemeData_.name = arg_11_1
			end

			arg_11_0.inputPopFlag_ = false
			arg_11_0.saveFlag_ = false

			manager.notify:Invoke(INPUT_POP_BACK)
		end
	end, JUDGE_MESSAGE_TYPE.OTHER)
end

function var_0_0.OnEnabledBtn(arg_13_0)
	arg_13_0.dataTemplate.useChipIdList = arg_13_0.schemeData_.chipList

	manager.notify:Invoke(ENABLED_SCHEME)
end

function var_0_0.OnRenameChipScheme(arg_14_0, arg_14_1)
	if arg_14_0.schemeData_.id == arg_14_1 then
		local var_14_0 = ChipData:GetSchemeList()[arg_14_1]

		arg_14_0.nameText_.text = var_14_0.name
	end
end

function var_0_0.OnInputCancel(arg_15_0)
	arg_15_0.inputPopFlag_ = false
	arg_15_0.saveFlag_ = false
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)

	arg_16_0.inputPopFlag_ = false
	arg_16_0.saveFlag_ = false

	manager.notify:RemoveListener(RENAME_CHIP_SCHEME, arg_16_0.renameHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_OK, arg_16_0.inputHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CLOSE, arg_16_0.inputCancelHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CANCEL, arg_16_0.inputCancelHandler_)

	arg_16_0.renameHandler_ = nil
	arg_16_0.inputHandler_ = nil
	arg_16_0.inputCancelHandler_ = nil
end

return var_0_0
