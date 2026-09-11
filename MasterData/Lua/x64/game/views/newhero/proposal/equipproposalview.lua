local EquipProposalView = class("EquipProposalView", ReduxView)

function EquipProposalView:UIName()
	return "Widget/System/Hero_equip/HeroEquipOptionUI"
end

function EquipProposalView:UIParent()
	return manager.ui.uiMain.transform
end

function EquipProposalView:Init()
	self.selectItem_ = nil
	self.heroEquipProposal_ = 0
	self.proposalState_ = 1
	self.panelState_ = 1

	self:InitUI()
	self:AddUIListener()

	self.inputHandler_ = handler(self, self.OnInput)
	self.inputCancelHandler_ = handler(self, self.OnInputCancel)
end

function EquipProposalView:InitUI()
	self:BindCfgUI()

	self.gridScroll_ = LuaList.New(handler(self, self.indexItem), self.proposalList_, ProposalItem)
	self.equipDisc_ = EquipDisc.New(self.discGo_)
	self.equipOverrall_ = EquipOverall.New(self.equipoverrallGo_)

	self.equipOverrall_:RegistSkillClick(handler(self, self.SkillClick))
	self.equipOverrall_:RegistOptionButton(handler(self, self.SaveOptionFunc), handler(self, self.EquipOptionFunc), handler(self, self.DeleteOptionFunc))

	self.equipSkillPop_ = EquipNewSkillInfoView.New(self.equipSkillGo_)
	self.skillPopController_ = self.transCon_:GetController("skill")
end

function EquipProposalView:AddUIListener()
	self:AddBtnListener(self.btnPopMask_, nil, function()
		self:HideMaskMessage()
	end)
end

function EquipProposalView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		4,
		0
	})
end

function EquipProposalView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.heroID_ = self.params_.heroID
	self.proposalList_ = ProposalData:GetProposalData()
	self.heroInfo_ = HeroData:GetHeroData(self.heroID_)

	self.equipOverrall_:OnEnter(self.params_.proxy)
	self.equipDisc_:OnEnter({
		isShowDetail = true
	})
	self:HideMaskMessage()
	manager.notify:RegistListener(INPUT_POP_CLICK_OK, self.inputHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CLOSE, self.inputCancelHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CANCEL, self.inputCancelHandler_)
	self:RefreshUI()
end

function EquipProposalView:RefreshUI()
	self:UpdateData()

	self.selectItem_ = 1

	self.gridScroll_:StartScroll(#self.sortedList_)
	self:RefreshRight(1)

	self.curproposalText_.text = GetTips("EQUIP_PROPOSAL") .. string.format("：%s/%s", #self.sortedList_ - (self.heroEquipProposal_ == 0 and 1 or 0), GameSetting.equip_proposal_num_max.value[1])
end

function EquipProposalView:UpdateData()
	self.sortedList_ = {}

	local var_10_0 = HeroTools.GetHeroEquipS(self.heroID_)
	local var_10_1

	for iter_10_0, iter_10_1 in pairs(self.proposalList_) do
		if table.equal(iter_10_1.equip_list, var_10_0, "all") then
			var_10_1 = iter_10_1
			self.sortedList_[1] = iter_10_1
		end
	end

	self.sortedList_[1] = var_10_1 and var_10_1 or {
		proposal_id = 0,
		proposal_name = GetTips("CURRENT_SCHEME"),
		equip_list = var_10_0
	}

	local var_10_2 = 2

	for iter_10_2, iter_10_3 in pairs(self.proposalList_) do
		if var_10_1 then
			if iter_10_3.proposal_id ~= var_10_1.proposal_id then
				self.sortedList_[var_10_2] = iter_10_3
				var_10_2 = var_10_2 + 1
			end
		else
			self.sortedList_[var_10_2] = iter_10_3
			var_10_2 = var_10_2 + 1
		end
	end

	if var_10_1 then
		self.heroEquipProposal_ = var_10_1.proposal_id or 0
	end
end

function EquipProposalView:indexItem(arg_11_1, arg_11_2)
	arg_11_2:ShowSelect(self.selectItem_ == arg_11_1)
	arg_11_2:RefreshUI(self.sortedList_[arg_11_1])
	arg_11_2:RegistCallBack(function()
		self:SelectItem(arg_11_1)
	end, function()
		self.renameFlag_ = true

		JumpTools.OpenPageByJump("ProposalPopup")
	end)
end

function EquipProposalView:RefreshRight(arg_14_1)
	self:RefreshButtonState(self.sortedList_[arg_14_1].proposal_id)
	self.equipOverrall_:RefreshHeroInfo(self.heroInfo_, self.sortedList_[arg_14_1].equip_list, self.proposalState_)

	self.equipDataList_ = EquipTools.GetEquipDataList(self.sortedList_[arg_14_1].equip_list)

	self.equipDisc_:RefreshItem(self.equipDataList_)
end

function EquipProposalView:SelectItem(arg_15_1)
	local var_15_0, var_15_1 = self.gridScroll_:GetHeadAndTail()

	if self.selectItem_ and var_15_0 <= self.selectItem_ and var_15_1 >= self.selectItem_ then
		self.gridScroll_:GetItemByIndex(self.selectItem_):ShowSelect(false)
	end

	self.selectItem_ = arg_15_1

	self.gridScroll_:GetItemByIndex(self.selectItem_):ShowSelect(true)
	self:RefreshRight(arg_15_1)
end

function EquipProposalView:OnEquipQuickDressOn(arg_16_1, arg_16_2)
	for iter_16_0 = 1, 6 do
		HeroAction.HeroChangeEquip(arg_16_2.hero_id, arg_16_2.use_equip_list[iter_16_0].equip_id, arg_16_2.use_equip_list[iter_16_0].pos)
	end

	self:RefreshUI()
	ShowTips("SUCCESS_EQUIP_PROPOSAL")
end

function EquipProposalView:OnAddProposal()
	self:RefreshUI()
	ShowTips("SUCCESS_SAVE_EQUIP_PROPOSAL")
end

function EquipProposalView:OnModifyProposal()
	local var_18_0, var_18_1 = self.gridScroll_:GetHeadAndTail()

	if self.selectItem_ and var_18_0 <= self.selectItem_ and var_18_1 >= self.selectItem_ then
		self.gridScroll_:GetItemByIndex(self.selectItem_):RefreshUI(self.sortedList_[self.selectItem_])
	end

	ShowTips("SUCCESS_SAVE_EQUIP_PROPOSAL")
end

function EquipProposalView:OnDeleteProposal()
	self:RefreshUI()
end

function EquipProposalView:EquipOptionFunc()
	if self.proposalState_ == "notEquip" then
		local var_20_0 = {}
		local var_20_1 = HeroData:GetEquipMap()
		local var_20_2 = 0

		for iter_20_0, iter_20_1 in ipairs(self.sortedList_[self.selectItem_].equip_list) do
			var_20_0[iter_20_0] = {
				equip_id = iter_20_1.equip_id,
				pos = iter_20_1.pos
			}

			if var_20_1[iter_20_1.equip_id] and var_20_1[iter_20_1.equip_id] ~= self.heroID_ then
				var_20_2 = var_20_2 + 1
				var_20_0[iter_20_0].equiping = var_20_1[iter_20_1.equip_id]
			end
		end

		if var_20_2 ~= 0 then
			self:Go("ProposalCheck", {
				equipS = var_20_0
			})
		else
			local var_20_3 = {}

			for iter_20_2 = 1, #var_20_0 do
				var_20_3[iter_20_2] = {
					pos = var_20_0[iter_20_2].pos,
					equip_id = var_20_0[iter_20_2].equip_id
				}
			end

			EquipAction.EquipQuickDressOn(self.heroID_, var_20_3)
		end
	end
end

function EquipProposalView:SaveOptionFunc()
	if self.proposalState_ == "notSave" then
		if #self.sortedList_ > GameSetting.equip_proposal_num_max.value[1] then
			ShowTips("ERROR_EQUIP_PROPOSAL_NUM_LIMIT")

			return
		end

		self.saveFlag_ = true

		JumpTools.OpenPageByJump("ProposalPopup")
	end
end

function EquipProposalView:DeleteOptionFunc()
	ProposalAction.DeleteProposal(self.sortedList_[self.selectItem_].proposal_id)
end

function EquipProposalView:SkillClick(arg_23_1, arg_23_2)
	self.equipSkillPop_:RefreshData(self, arg_23_2)
	self.skillPopController_:SetSelectedState("show")
end

function EquipProposalView:HideMaskMessage()
	self.skillPopController_:SetSelectedState("hide")
	self.equipOverrall_:DeSelect()
end

function EquipProposalView:RefreshButtonState(arg_25_1)
	self.proposalState_ = arg_25_1 == 0 and "notSave" or arg_25_1 ~= self.heroEquipProposal_ and "notEquip" or "equipping"
end

function EquipProposalView:OnInput(arg_26_1, arg_26_2)
	if not self.renameFlag_ and not self.saveFlag_ then
		return
	end

	if arg_26_1 == "" then
		ShowTips("INPUT_EQUIP_PROPOSAL_NAME")

		return
	end

	if IsAllSpace(arg_26_1) then
		ShowTips("INPUT_CHAT_CONTENT")

		arg_26_2.text = ""

		return
	end

	local var_26_0, var_26_1 = textLimit(arg_26_1, GameSetting.user_name_max.value[1])

	arg_26_2.text = var_26_0
	arg_26_1 = var_26_0

	if not nameRule(var_26_0) then
		ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

		arg_26_2.text = ""

		return
	end

	WordVerifyBySDK(arg_26_1, function(arg_27_0)
		if not arg_27_0 then
			ShowTips("SENSITIVE_WORD")

			arg_26_2.text = ""

			return
		else
			if not var_26_1 then
				return
			end

			if self.renameFlag_ then
				ProposalAction.ModifyProposal(self.heroID_, arg_26_1, self.sortedList_[self.selectItem_].proposal_id)
			else
				ProposalAction.AddProposal(self.heroID_, arg_26_1, 0)
			end

			self.renameFlag_ = false
			self.saveFlag_ = false

			manager.notify:Invoke(INPUT_POP_BACK)
		end
	end, JUDGE_MESSAGE_TYPE.OTHER)
end

function EquipProposalView:OnInputCancel()
	self.renameFlag_ = false
	self.saveFlag_ = false
end

function EquipProposalView:OnExit()
	manager.windowBar:HideBar()
	self.equipOverrall_:OnExit()
	self.equipDisc_:OnExit()
	self:OnInputCancel()
	manager.notify:RemoveListener(INPUT_POP_CLICK_OK, self.inputHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CLOSE, self.inputHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CANCEL, self.inputCancelHandler_)
end

function EquipProposalView:Dispose()
	self:RemoveAllListeners()
	self.equipSkillPop_:Dispose()
	self.equipOverrall_:Dispose()
	self.equipDisc_:Dispose()
	self.gridScroll_:Dispose()

	self.inputHandler_ = nil
	self.inputCancelHandler_ = nil

	EquipProposalView.super.Dispose(self)
end

return EquipProposalView
