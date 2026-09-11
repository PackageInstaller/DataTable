local ChipSchemeItem = class("ChipSchemeItem", ReduxView)

function ChipSchemeItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.renameHandler_ = handler(self, self.OnRenameChipScheme)

	manager.notify:RegistListener(RENAME_CHIP_SCHEME, self.renameHandler_)

	self.inputHandler_ = handler(self, self.OnInput)
	self.inputCancelHandler_ = handler(self, self.OnInputCancel)

	manager.notify:RegistListener(INPUT_POP_CLICK_OK, self.inputHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CLOSE, self.inputCancelHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CANCEL, self.inputCancelHandler_)

	self.controller_ = self.stateControl:GetController("bState")
end

function ChipSchemeItem:SetTemplateData(arg_2_1)
	self.dataTemplate = arg_2_1
end

function ChipSchemeItem:AddListeners()
	self:AddBtnListener(self.renameBtn_, nil, function()
		self.inputPopFlag_ = true

		JumpTools.OpenPageByJump("ProposalPopup")
	end)
	self:AddBtnListener(self.deleteBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("DELETE_CHIP_SCHEME"), self.schemeData_.name),
			OkCallback = function()
				ChipAction.DeleteChipScheme(self.schemeData_.id)
				OperationRecorder.Record("ChipSchemeItem", "okDelete")
			end,
			CancelCallback = function()
				OperationRecorder.Record("ChipSchemeItem", "cancelDelete")
			end
		})
	end)
	self:AddBtnListener(self.saveBtn_, nil, function()
		if #self.schemeData_.chipList < 1 then
			ShowTips("SCHEME_IS_NULL")

			return false
		end

		local var_8_0 = GameSetting.ai_chip_proposal_num_max.value[1]
		local var_8_1 = ChipData:GetSchemeList()

		if GameSetting.ai_chip_proposal_num_max.value[1] <= table.length(var_8_1) then
			ShowTips("MORE_THEN_MAX_SCHEME_CNT")

			return
		end

		for iter_8_0 = 1, var_8_0 do
			if var_8_1[iter_8_0] == nil then
				self.saveFlag_ = true

				JumpTools.OpenPageByJump("ProposalPopup")

				break
			end
		end
	end)
	self:AddBtnListener(self.enabledBtn_, nil, function()
		self:OnEnabledBtn()
	end)
end

function ChipSchemeItem:RefreshUI(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self.chipManagerID_ = arg_10_1
	self.schemeData_ = arg_10_3
	arg_10_4 = arg_10_4 or 0
	self.index_ = arg_10_2

	if arg_10_3.id == -1 then
		self.controller_:SetSelectedState("state0")

		return
	end

	self.nameText_.text = GetI18NText(arg_10_3.name)

	for iter_10_0 = 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
		local var_10_0 = arg_10_3.chipList[iter_10_0]

		if arg_10_3.chipList[iter_10_0] then
			self[string.format("icon%sImg_", iter_10_0)].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[var_10_0].picture_id)

			SetActive(self[string.format("icon%sGo_", iter_10_0)].gameObject, true)
		else
			SetActive(self[string.format("icon%sGo_", iter_10_0)].gameObject, false)
		end

		SetActive(self[string.format("icon%sGo_", iter_10_0)], var_10_0 and true or false)
	end

	if arg_10_2 == 1 then
		if arg_10_3.id == 0 then
			self.controller_:SetSelectedState("state0")
		else
			self.controller_:SetSelectedState("state2")
		end
	else
		self.controller_:SetSelectedState("state1")
	end
end

function ChipSchemeItem:OnInput(arg_11_1, arg_11_2)
	if not self.inputPopFlag_ and not self.saveFlag_ then
		return
	end

	if not self.gameObject_.activeInHierarchy then
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

	if not nameRule(var_11_0) then
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

			if self.saveFlag_ then
				local var_12_0 = ChipData:GetSchemeList()

				for iter_12_0 = 1, GameSetting.ai_chip_proposal_num_max.value[1] do
					if var_12_0[iter_12_0] == nil then
						self.schemeData_.id = iter_12_0
						self.schemeData_.name = arg_11_1

						ChipAction.SaveChipScheme(self.schemeData_)

						break
					end
				end
			else
				ChipAction.RenameChipScheme(self.schemeData_.id, arg_11_1)

				self.schemeData_.name = arg_11_1
			end

			self.inputPopFlag_ = false
			self.saveFlag_ = false

			manager.notify:Invoke(INPUT_POP_BACK)
		end
	end, JUDGE_MESSAGE_TYPE.OTHER)
end

function ChipSchemeItem:OnEnabledBtn()
	self.dataTemplate.useChipIdList = self.schemeData_.chipList

	manager.notify:Invoke(ENABLED_SCHEME)
end

function ChipSchemeItem:OnRenameChipScheme(arg_14_1)
	if self.schemeData_.id == arg_14_1 then
		self.nameText_.text = ChipData:GetSchemeList()[arg_14_1].name
	end
end

function ChipSchemeItem:OnInputCancel()
	self.inputPopFlag_ = false
	self.saveFlag_ = false
end

function ChipSchemeItem:Dispose()
	ChipSchemeItem.super.Dispose(self)

	self.inputPopFlag_ = false
	self.saveFlag_ = false

	manager.notify:RemoveListener(RENAME_CHIP_SCHEME, self.renameHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_OK, self.inputHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CLOSE, self.inputCancelHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CANCEL, self.inputCancelHandler_)

	self.renameHandler_ = nil
	self.inputHandler_ = nil
	self.inputCancelHandler_ = nil
end

return ChipSchemeItem
