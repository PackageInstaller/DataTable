local var_0_0 = class("EquipProposalView", ReduxView)
local var_0_1 = {
	"存为新方案",
	"装备",
	"已装备"
}
local var_0_2 = {
	"detail",
	"rough"
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_equip/HeroEquipOptionUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.selectItem_ = nil
	arg_3_0.heroEquipProposal_ = 0
	arg_3_0.proposalState_ = 1
	arg_3_0.panelState_ = 1

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.inputHandler_ = handler(arg_3_0, arg_3_0.OnInput)
	arg_3_0.inputCancelHandler_ = handler(arg_3_0, arg_3_0.OnInputCancel)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.gridScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.proposalList_, ProposalItem)
	arg_4_0.equipDisc_ = EquipDisc.New(arg_4_0.discGo_)
	arg_4_0.equipOverrall_ = EquipOverall.New(arg_4_0.equipoverrallGo_)

	arg_4_0.equipOverrall_:RegistSkillClick(handler(arg_4_0, arg_4_0.SkillClick))
	arg_4_0.equipOverrall_:RegistOptionButton(handler(arg_4_0, arg_4_0.SaveOptionFunc), handler(arg_4_0, arg_4_0.EquipOptionFunc), handler(arg_4_0, arg_4_0.DeleteOptionFunc))

	arg_4_0.equipSkillPop_ = EquipNewSkillInfoView.New(arg_4_0.equipSkillGo_)
	arg_4_0.skillPopController_ = arg_4_0.transCon_:GetController("skill")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnPopMask_, nil, function()
		arg_5_0:HideMaskMessage()
	end)
end

function var_0_0.CameraEnter(arg_7_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		4,
		0
	})
end

function var_0_0.OnEnter(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_8_0.heroID_ = arg_8_0.params_.heroID
	arg_8_0.proposalList_ = ProposalData:GetProposalData()
	arg_8_0.heroInfo_ = HeroData:GetHeroData(arg_8_0.heroID_)

	arg_8_0.equipOverrall_:OnEnter(arg_8_0.params_.proxy)
	arg_8_0.equipDisc_:OnEnter({
		isShowDetail = true
	})
	arg_8_0:HideMaskMessage()
	manager.notify:RegistListener(INPUT_POP_CLICK_OK, arg_8_0.inputHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CLOSE, arg_8_0.inputCancelHandler_)
	manager.notify:RegistListener(INPUT_POP_CLICK_CANCEL, arg_8_0.inputCancelHandler_)
	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:UpdateData()

	arg_9_0.selectItem_ = 1

	arg_9_0.gridScroll_:StartScroll(#arg_9_0.sortedList_)
	arg_9_0:RefreshRight(1)

	local var_9_0 = #arg_9_0.sortedList_ - (arg_9_0.heroEquipProposal_ == 0 and 1 or 0)

	arg_9_0.curproposalText_.text = GetTips("EQUIP_PROPOSAL") .. string.format("：%s/%s", var_9_0, GameSetting.equip_proposal_num_max.value[1])
end

function var_0_0.UpdateData(arg_10_0)
	arg_10_0.sortedList_ = {}

	local var_10_0 = HeroTools.GetHeroEquipS(arg_10_0.heroID_)
	local var_10_1

	for iter_10_0, iter_10_1 in pairs(arg_10_0.proposalList_) do
		if table.equal(iter_10_1.equip_list, var_10_0, "all") then
			var_10_1 = iter_10_1
			arg_10_0.sortedList_[1] = iter_10_1
		end
	end

	if var_10_1 then
		arg_10_0.sortedList_[1] = var_10_1
	else
		arg_10_0.sortedList_[1] = {
			proposal_id = 0,
			proposal_name = GetTips("CURRENT_SCHEME"),
			equip_list = var_10_0
		}
	end

	local var_10_2 = 2

	for iter_10_2, iter_10_3 in pairs(arg_10_0.proposalList_) do
		if var_10_1 then
			if iter_10_3.proposal_id ~= var_10_1.proposal_id then
				arg_10_0.sortedList_[var_10_2] = iter_10_3
				var_10_2 = var_10_2 + 1
			end
		else
			arg_10_0.sortedList_[var_10_2] = iter_10_3
			var_10_2 = var_10_2 + 1
		end
	end

	arg_10_0.heroEquipProposal_ = var_10_1 and var_10_1.proposal_id or 0
end

function var_0_0.indexItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:ShowSelect(arg_11_0.selectItem_ == arg_11_1)
	arg_11_2:RefreshUI(arg_11_0.sortedList_[arg_11_1])

	local function var_11_0()
		arg_11_0:SelectItem(arg_11_1)
	end

	local function var_11_1()
		arg_11_0.renameFlag_ = true

		JumpTools.OpenPageByJump("ProposalPopup")
	end

	arg_11_2:RegistCallBack(var_11_0, var_11_1)
end

function var_0_0.RefreshRight(arg_14_0, arg_14_1)
	arg_14_0:RefreshButtonState(arg_14_0.sortedList_[arg_14_1].proposal_id)
	arg_14_0.equipOverrall_:RefreshHeroInfo(arg_14_0.heroInfo_, arg_14_0.sortedList_[arg_14_1].equip_list, arg_14_0.proposalState_)

	arg_14_0.equipDataList_ = EquipTools.GetEquipDataList(arg_14_0.sortedList_[arg_14_1].equip_list)

	arg_14_0.equipDisc_:RefreshItem(arg_14_0.equipDataList_)
end

function var_0_0.SelectItem(arg_15_0, arg_15_1)
	local var_15_0, var_15_1 = arg_15_0.gridScroll_:GetHeadAndTail()

	if arg_15_0.selectItem_ and var_15_0 <= arg_15_0.selectItem_ and var_15_1 >= arg_15_0.selectItem_ then
		arg_15_0.gridScroll_:GetItemByIndex(arg_15_0.selectItem_):ShowSelect(false)
	end

	arg_15_0.selectItem_ = arg_15_1

	arg_15_0.gridScroll_:GetItemByIndex(arg_15_0.selectItem_):ShowSelect(true)
	arg_15_0:RefreshRight(arg_15_1)
end

function var_0_0.OnEquipQuickDressOn(arg_16_0, arg_16_1, arg_16_2)
	for iter_16_0 = 1, 6 do
		HeroAction.HeroChangeEquip(arg_16_2.hero_id, arg_16_2.use_equip_list[iter_16_0].equip_id, arg_16_2.use_equip_list[iter_16_0].pos)
	end

	arg_16_0:RefreshUI()
	ShowTips("SUCCESS_EQUIP_PROPOSAL")
end

function var_0_0.OnAddProposal(arg_17_0)
	arg_17_0:RefreshUI()
	ShowTips("SUCCESS_SAVE_EQUIP_PROPOSAL")
end

function var_0_0.OnModifyProposal(arg_18_0)
	local var_18_0, var_18_1 = arg_18_0.gridScroll_:GetHeadAndTail()

	if arg_18_0.selectItem_ and var_18_0 <= arg_18_0.selectItem_ and var_18_1 >= arg_18_0.selectItem_ then
		arg_18_0.gridScroll_:GetItemByIndex(arg_18_0.selectItem_):RefreshUI(arg_18_0.sortedList_[arg_18_0.selectItem_])
	end

	ShowTips("SUCCESS_SAVE_EQUIP_PROPOSAL")
end

function var_0_0.OnDeleteProposal(arg_19_0)
	arg_19_0:RefreshUI()
end

function var_0_0.EquipOptionFunc(arg_20_0)
	if arg_20_0.proposalState_ == "notEquip" then
		local var_20_0 = arg_20_0.sortedList_[arg_20_0.selectItem_].equip_list
		local var_20_1 = {}
		local var_20_2 = HeroData:GetEquipMap()
		local var_20_3 = 0

		for iter_20_0, iter_20_1 in ipairs(var_20_0) do
			local var_20_4 = var_20_2[iter_20_1.equip_id]

			var_20_1[iter_20_0] = {
				equip_id = iter_20_1.equip_id,
				pos = iter_20_1.pos
			}

			if var_20_4 and var_20_4 ~= arg_20_0.heroID_ then
				var_20_3 = var_20_3 + 1
				var_20_1[iter_20_0].equiping = var_20_4
			end
		end

		if var_20_3 ~= 0 then
			arg_20_0:Go("ProposalCheck", {
				equipS = var_20_1
			})
		else
			local var_20_5 = {}

			for iter_20_2 = 1, #var_20_1 do
				var_20_5[iter_20_2] = {
					pos = var_20_1[iter_20_2].pos,
					equip_id = var_20_1[iter_20_2].equip_id
				}
			end

			EquipAction.EquipQuickDressOn(arg_20_0.heroID_, var_20_5)
		end
	end
end

function var_0_0.SaveOptionFunc(arg_21_0)
	if arg_21_0.proposalState_ == "notSave" then
		if #arg_21_0.sortedList_ > GameSetting.equip_proposal_num_max.value[1] then
			ShowTips("ERROR_EQUIP_PROPOSAL_NUM_LIMIT")

			return
		end

		arg_21_0.saveFlag_ = true

		JumpTools.OpenPageByJump("ProposalPopup")
	end
end

function var_0_0.DeleteOptionFunc(arg_22_0)
	local var_22_0 = arg_22_0.sortedList_[arg_22_0.selectItem_].proposal_id

	ProposalAction.DeleteProposal(var_22_0)
end

function var_0_0.SkillClick(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.equipSkillPop_:RefreshData(arg_23_0, arg_23_2)
	arg_23_0.skillPopController_:SetSelectedState("show")
end

function var_0_0.HideMaskMessage(arg_24_0)
	arg_24_0.skillPopController_:SetSelectedState("hide")
	arg_24_0.equipOverrall_:DeSelect()
end

function var_0_0.RefreshButtonState(arg_25_0, arg_25_1)
	local var_25_0

	arg_25_0.proposalState_ = arg_25_1 == 0 and "notSave" or arg_25_1 ~= arg_25_0.heroEquipProposal_ and "notEquip" or "equipping"
end

function var_0_0.OnInput(arg_26_0, arg_26_1, arg_26_2)
	if not arg_26_0.renameFlag_ and not arg_26_0.saveFlag_ then
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

	if not nameRule(arg_26_1) then
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

			if arg_26_0.renameFlag_ then
				local var_27_0 = arg_26_0.sortedList_[arg_26_0.selectItem_].proposal_id

				ProposalAction.ModifyProposal(arg_26_0.heroID_, arg_26_1, var_27_0)
			else
				ProposalAction.AddProposal(arg_26_0.heroID_, arg_26_1, 0)
			end

			arg_26_0.renameFlag_ = false
			arg_26_0.saveFlag_ = false

			manager.notify:Invoke(INPUT_POP_BACK)
		end
	end, JUDGE_MESSAGE_TYPE.OTHER)
end

function var_0_0.OnInputCancel(arg_28_0)
	arg_28_0.renameFlag_ = false
	arg_28_0.saveFlag_ = false
end

function var_0_0.OnExit(arg_29_0)
	manager.windowBar:HideBar()
	arg_29_0.equipOverrall_:OnExit()
	arg_29_0.equipDisc_:OnExit()
	arg_29_0:OnInputCancel()
	manager.notify:RemoveListener(INPUT_POP_CLICK_OK, arg_29_0.inputHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CLOSE, arg_29_0.inputHandler_)
	manager.notify:RemoveListener(INPUT_POP_CLICK_CANCEL, arg_29_0.inputCancelHandler_)
end

function var_0_0.Dispose(arg_30_0)
	arg_30_0:RemoveAllListeners()
	arg_30_0.equipSkillPop_:Dispose()
	arg_30_0.equipOverrall_:Dispose()
	arg_30_0.equipDisc_:Dispose()
	arg_30_0.gridScroll_:Dispose()

	arg_30_0.inputHandler_ = nil
	arg_30_0.inputCancelHandler_ = nil

	var_0_0.super.Dispose(arg_30_0)
end

return var_0_0
