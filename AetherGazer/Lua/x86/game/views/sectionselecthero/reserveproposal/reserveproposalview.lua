local var_0_0 = class("ReserveProposalView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Formation/FormationProposalUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.ReserveCameraEnter(arg_4_0)
	manager.loadScene:SetSceneActive(SceneConst.SCENE_NAME.reserve, true)
	manager.reserveCamera:SwitchCamera(ReserveCameraConst.CAMERA_TYPE.common, ReserveCameraConst.VIRTUAL_CAMERA.reserveProposal)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:InitSubViewCfg()
	arg_5_0:InitHandler()
end

function var_0_0.InitSubViewCfg(arg_6_0)
	arg_6_0.subViewDic_ = {
		selectHeroView = {
			go = arg_6_0.selectHeroGo_,
			getClassFunc = handler(arg_6_0, arg_6_0.GetSelectHeroViewClass)
		},
		additionalView = {
			go = arg_6_0.additionalGo_,
			getClassFunc = handler(arg_6_0, arg_6_0.GetAdditionalViewClass)
		}
	}
end

function var_0_0.InitHandler(arg_7_0)
	arg_7_0.clickHeroHandler_ = handler(arg_7_0, arg_7_0.OnSectionClickHero)
	arg_7_0.inputHandler_ = handler(arg_7_0, arg_7_0.OnInput)
	arg_7_0.deleteProposalHandler_ = handler(arg_7_0, arg_7_0.OnDeleteProposal)
	arg_7_0.changeHeroTeamHandler_ = handler(arg_7_0, arg_7_0.OnChangeHeroTeam)
	arg_7_0.changeComboSkillHander_ = handler(arg_7_0, arg_7_0.OnChangeComboSkill)
end

function var_0_0.OnTop(arg_8_0)
	arg_8_0:UpdateBar()
end

function var_0_0.OnBehind(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:ProcessParams()
	arg_10_0:ProcessSubView()
	arg_10_0:AddEventListener()
	arg_10_0:ResetTempData()
	arg_10_0:SubViewOnEnter()
	arg_10_0:Refresh()
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0.params_.lastContIDList = arg_11_0.contIDList_
	arg_11_0.params_.lastEditContID = arg_11_0.editContID_

	arg_11_0:RemoveAllEventListener()
	arg_11_0:SubViewOnExit()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:SubViewCallFunc("Dispose")

	for iter_12_0, iter_12_1 in pairs(arg_12_0.subViewDic_) do
		iter_12_1.go = nil
		iter_12_1.instance = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.AddEventListener(arg_13_0)
	arg_13_0:RegistEventListener(SECTION_CLICK_HERO, arg_13_0.clickHeroHandler_)
	arg_13_0:RegistEventListener(INPUT_POP_CLICK_OK, arg_13_0.inputHandler_)
	arg_13_0:RegistEventListener(RESERVE_RESET_CONT_DATA, arg_13_0.deleteProposalHandler_)
	arg_13_0:RegistEventListener(SECTION_CHANGE_HERO_TEAM, arg_13_0.changeHeroTeamHandler_)
	arg_13_0:RegistEventListener(COMBO_SKILL_SELECT, arg_13_0.changeComboSkillHander_)
end

function var_0_0.ProcessParams(arg_14_0)
	arg_14_0:ProcessBaseParams()
	arg_14_0:ProcessReserveParams()
	arg_14_0:ProcessProxyParams()
	arg_14_0:ProcessProposalParams()
end

function var_0_0.ProcessBaseParams(arg_15_0)
	arg_15_0.stageID_ = arg_15_0.params_.stage_id
	arg_15_0.stageType_ = arg_15_0.params_.stage_type or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
	arg_15_0.outerSectionProxy_ = arg_15_0.params_.sectionProxy
end

function var_0_0.ProcessReserveParams(arg_16_0)
	if not arg_16_0.reserveParams_ then
		arg_16_0.reserveParams_ = ReserveParams.New(ReserveConst.RESERVE_TYPE.PROPOSAL, 1)
	end

	arg_16_0.reserveTemplate_ = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.PROPOSAL)
end

function var_0_0.ProcessProxyParams(arg_17_0)
	if not arg_17_0.sectionProxy_ then
		arg_17_0.sectionProxy_ = ReserveProposalSelectHeroProxy.New({
			outerLockHeroList = clone(arg_17_0.params_.lockHeroList)
		}, arg_17_0.reserveParams_, HeroConst.HERO_DATA_TYPE.DEFAULT)
	end

	arg_17_0.sectionProxy_:SetOuterLockHeroList(clone(arg_17_0.params_.lockHeroList))
end

function var_0_0.ProcessProposalParams(arg_18_0)
	if not arg_18_0.params_.isBack then
		ReserveTools.CleanCacheData(ReserveConst.RESERVE_TYPE.PROPOSAL)
	end

	arg_18_0:ProcessOuterTeam()
	arg_18_0:UpdateCurSavedProposal()
	arg_18_0:InitContIDList()
	arg_18_0:InitEditContData()
end

function var_0_0.ProcessOuterTeam(arg_19_0)
	arg_19_0.outerHeroList_ = clone(arg_19_0.params_.heroList)
	arg_19_0.outerTrialList_ = clone(arg_19_0.params_.trialList)
	arg_19_0.outerComboSkillID_ = arg_19_0.params_.comboSkillID
	arg_19_0.outerMimirID_ = arg_19_0.params_.mimirID
	arg_19_0.outerChipList_ = clone(arg_19_0.params_.chipList)
	arg_19_0.outerCharChipBaseID_ = clone(arg_19_0.params_.charChipBaseID)
	arg_19_0.outerLockHeroList_ = clone(arg_19_0.params_.lockHeroList)

	arg_19_0:CheckOuterHeroList()
end

function var_0_0.InitContIDList(arg_20_0)
	if arg_20_0.params_.lastContIDList then
		arg_20_0.contIDList_ = arg_20_0.params_.lastContIDList
	else
		local var_20_0 = {
			arg_20_0:GetCurUseProposalContID() or arg_20_0:CreateTempProposal()
		}

		for iter_20_0, iter_20_1 in ipairs(arg_20_0.curProposalContIDList_) do
			if iter_20_1 ~= var_20_0[1] then
				var_20_0[#var_20_0 + 1] = iter_20_1
			end
		end

		arg_20_0.contIDList_ = var_20_0
	end
end

function var_0_0.GetCurUseProposalContID(arg_21_0)
	local var_21_0

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.curProposalContIDList_) do
		if SectionSelectHeroTools.IsReserveProposalEqual(iter_21_1, arg_21_0.outerHeroList_, arg_21_0.outerComboSkillID_, arg_21_0.outerMimirID_, arg_21_0.outerChipList_, nil, arg_21_0.outerCharChipBaseID_) then
			var_21_0 = iter_21_1

			break
		end
	end

	return var_21_0
end

function var_0_0.CreateTempProposal(arg_22_0)
	local var_22_0 = arg_22_0.reserveTemplate_:GreateTempContID()
	local var_22_1 = ReserveParams.New(ReserveConst.RESERVE_TYPE.PROPOSAL, var_22_0)

	ReserveTools.SetTeam(var_22_1, arg_22_0.outerHeroList_, {
		0,
		0,
		0
	}, arg_22_0.outerComboSkillID_, arg_22_0.outerMimirID_, arg_22_0.outerChipList_, arg_22_0.outerCharChipBaseID_)

	return var_22_0
end

function var_0_0.InitEditContData(arg_23_0)
	local var_23_0

	if arg_23_0.params_.lastEditContID then
		var_23_0 = arg_23_0.params_.lastEditContID
	else
		var_23_0 = arg_23_0.contIDList_[1]
	end

	arg_23_0:UpdateEditContData(var_23_0)
end

function var_0_0.UpdateEditContData(arg_24_0, arg_24_1)
	arg_24_0.editContID_ = arg_24_1
	arg_24_0.reserveParams_.contID = arg_24_1
	arg_24_0.editHeroList_ = arg_24_0.sectionProxy_:GetHeroTeam()
	arg_24_0.editTrialList_ = {
		0,
		0,
		0
	}
	arg_24_0.editComboSkillID_ = arg_24_0.sectionProxy_:GetComboSkillID()
	arg_24_0.editMimirID_, arg_24_0.editChipList_ = arg_24_0.sectionProxy_:GetMimirData()
	arg_24_0.editCharChipBaseID_ = arg_24_0.sectionProxy_:GetCharChipBaseID()
end

function var_0_0.ProcessSubView(arg_25_0)
	arg_25_0:InitSubView()
	arg_25_0:TryReloadSubView()
	arg_25_0:ProcessSubViewParams()
end

function var_0_0.ProcessSubViewParams(arg_26_0)
	arg_26_0:SubViewCallFunc("SetProxy", arg_26_0.sectionProxy_)
end

function var_0_0.SubViewOnEnter(arg_27_0)
	arg_27_0:SubViewCallFunc("OnEnter")
end

function var_0_0.OnExit(arg_28_0)
	arg_28_0.params_.lastContIDList = arg_28_0.contIDList_
	arg_28_0.params_.lastEditContID = arg_28_0.editContID_

	arg_28_0:RemoveAllEventListener()
	arg_28_0:SubViewOnExit()
	manager.windowBar:HideBar()
	manager.loadScene:SetSceneActive(SceneConst.SCENE_NAME.reserve, false)
end

function var_0_0.SubViewOnExit(arg_29_0)
	arg_29_0:SubViewCallFunc("OnExit")
end

function var_0_0.UpdateBar(arg_30_0)
	arg_30_0.sectionProxy_:UpdateBar()
end

function var_0_0.ResetTempData(arg_31_0)
	arg_31_0.subViewDic_.selectHeroView.instance:ResetTempData()
end

function var_0_0.Refresh(arg_32_0)
	arg_32_0:RefreshSubView()
	arg_32_0:RefreshReserveUI()
	arg_32_0:RefreshSwitchList()
	arg_32_0:RefreshBtnPanel()
end

function var_0_0.RefreshSubView(arg_33_0)
	arg_33_0:SubViewCallFunc("Refresh")
end

function var_0_0.RefreshReserveUI(arg_34_0)
	arg_34_0.subViewDic_.selectHeroView.instance:SetContID(arg_34_0.editContID_)
end

function var_0_0.RefreshBtnPanel(arg_35_0)
	arg_35_0.subViewDic_.additionalView.instance:RefreshBtnPanel(arg_35_0.editContID_, arg_35_0.outerHeroList_, arg_35_0.outerComboSkillID_, arg_35_0.outerMimirID_, arg_35_0.outerChipList_, arg_35_0.outerCharChipBaseID_)
end

function var_0_0.RefreshSwitchList(arg_36_0)
	arg_36_0.subViewDic_.additionalView.instance:RefreshSwitchList(arg_36_0.contIDList_, arg_36_0.editContID_, arg_36_0.curSavedProposalNum_)
end

function var_0_0.SaveProposal(arg_37_0)
	ReserveAction.SaveReserveProposal(arg_37_0.saveContID_, handler(arg_37_0, arg_37_0.OnSaveProposal))
end

function var_0_0.SaveName(arg_38_0, arg_38_1, arg_38_2)
	ReserveAction.RenameReserveProposal(arg_38_0.saveContID_, arg_38_1, arg_38_2, handler(arg_38_0, arg_38_0.OnSaveProposal))
end

function var_0_0.OnSaveProposal(arg_39_0)
	if arg_39_0.saveContID_ == arg_39_0.editContID_ then
		arg_39_0:TryAutoApplyProposal()
	end

	ShowTips("FORMATION_PLAN_SAVED")
	manager.notify:Invoke(INPUT_POP_BACK)
	arg_39_0:UpdateCurSavedProposal()
	arg_39_0:RefreshSwitchList()
	arg_39_0:RefreshBtnPanel()
end

function var_0_0.OnReserveProposalClickSave(arg_40_0)
	local var_40_0 = arg_40_0.reserveTemplate_:GetContDataTemplateById(arg_40_0.editContID_)

	if var_40_0:GetIsTemp() and GameSetting.default_formation_num_max.value[1] == #arg_40_0.curProposalContIDList_ then
		ShowTips("RESERVE_PROPOSAL_SAVE_LIMIT")

		return
	end

	if arg_40_0.editHeroList_[1] == 0 then
		ShowTips("TEAM_SET_NEEDED")

		return
	end

	for iter_40_0, iter_40_1 in ipairs(arg_40_0.curProposalContIDList_) do
		if iter_40_1 ~= arg_40_0.editContID_ and SectionSelectHeroTools.IsReserveProposalEqual(iter_40_1, arg_40_0.editHeroList_, arg_40_0.editComboSkillID_, arg_40_0.editMimirID_, arg_40_0.editChipList_, true, arg_40_0.editCharChipBaseID_) then
			ShowTips("RESERVE_PROPOSAL_SAME")

			return
		end
	end

	arg_40_0.saveContID_ = arg_40_0.editContID_

	if var_40_0:GetName() == "" then
		arg_40_0:GotoRenameView(arg_40_0.saveContID_)
	else
		arg_40_0:SaveProposal()
	end
end

function var_0_0.OnReserveProposalClickApply(arg_41_0)
	local var_41_0 = arg_41_0:GetFilterLockHeroList(arg_41_0.editHeroList_)

	if #var_41_0 > 0 then
		JumpTools.OpenPageByJump("filterLockHero", {
			heroIDList = var_41_0,
			type = SectionSelectHeroConst.DISPLAY_FILTER_LOCK_HERO_TYPE.PROPOSAL
		})

		return
	end

	arg_41_0:ApplyProposal()
	arg_41_0:OnApplyProposalSuccess()
end

function var_0_0.GetFilterLockHeroList(arg_42_0, arg_42_1)
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in ipairs(arg_42_1) do
		if iter_42_1 ~= 0 and table.indexof(arg_42_0.outerLockHeroList_, iter_42_1) then
			var_42_0[#var_42_0 + 1] = iter_42_1
		end
	end

	return var_42_0
end

function var_0_0.OnApplyProposalSuccess(arg_43_0)
	ShowTips("RESERVE_PROPOSAL_SELECT_SUCCESS")
	arg_43_0:Back()
end

function var_0_0.OnReserveProposalClickDelete(arg_44_0)
	local var_44_0 = arg_44_0.reserveTemplate_:GetContDataTemplateById(arg_44_0.editContID_):GetName()

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = string.format(GetTips("FORMATION_PLAN_DELETE_CONFIRM"), var_44_0),
		OkCallback = function()
			arg_44_0.sectionProxy_:ResetTeam()
		end
	})
end

function var_0_0.OnReserveProposalClickProposal(arg_46_0, arg_46_1)
	if arg_46_1 == arg_46_0.editContID_ then
		return
	end

	arg_46_0:UpdateEditContData(arg_46_1)
	arg_46_0:RefreshSubView()
	arg_46_0:RefreshReserveUI()
	arg_46_0:RefreshBtnPanel()
	arg_46_0.subViewDic_.additionalView.instance:RefreshSelect(arg_46_0.editContID_)
end

function var_0_0.OnReserveProposalClickRename(arg_47_0, arg_47_1)
	arg_47_0.saveContID_ = arg_47_1

	arg_47_0:GotoRenameView(arg_47_0.saveContID_)
end

function var_0_0.GotoRenameView(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0.reserveTemplate_:GetAttributeTagList(arg_48_1)

	JumpTools.OpenPageByJump("reserveProposalRename", {
		selectAttributeList = var_48_0
	})
end

function var_0_0.OnSectionClickHero(arg_49_0, arg_49_1)
	arg_49_0.sectionProxy_:GotoHeroInfoUI(arg_49_1)
end

function var_0_0.OnChangeHeroTeam(arg_50_0, arg_50_1, arg_50_2)
	arg_50_0.editHeroList_ = clone(arg_50_1)

	arg_50_0:RefreshSwitchList()
	arg_50_0:RefreshBtnPanel()
end

function var_0_0.OnChangeComboSkill(arg_51_0, arg_51_1)
	arg_51_0.editComboSkillID_ = arg_51_1

	arg_51_0:RefreshBtnPanel()
end

function var_0_0.OnInput(arg_52_0, arg_52_1, arg_52_2)
	arg_52_0:SaveName(arg_52_1, arg_52_2)
end

function var_0_0.OnDeleteProposal(arg_53_0, arg_53_1, arg_53_2)
	arg_53_0.reserveTemplate_:DeleteProposal(arg_53_2)
	arg_53_0:UpdateCurSavedProposal()
	arg_53_0:DeleteTargetContID(arg_53_2)
	arg_53_0:UpdateTempProposal()
	arg_53_0:UpdateEditContData(arg_53_0.contIDList_[1])
	arg_53_0:Refresh()
	ShowTips("FORMATION_PLAN_DELETED")
end

function var_0_0.UpdateCurSavedProposal(arg_54_0)
	arg_54_0.curProposalContIDList_ = arg_54_0.reserveTemplate_:GetProposalContIDList()
	arg_54_0.curSavedProposalNum_ = #arg_54_0.curProposalContIDList_
end

function var_0_0.DeleteTargetContID(arg_55_0, arg_55_1)
	local var_55_0 = table.indexof(arg_55_0.contIDList_, arg_55_1)

	table.remove(arg_55_0.contIDList_, var_55_0)

	if #arg_55_0.contIDList_ == 0 then
		arg_55_0.contIDList_[1] = arg_55_0:CreateTempProposal()
	end
end

function var_0_0.UpdateTempProposal(arg_56_0)
	local var_56_0 = arg_56_0.contIDList_[1]

	if arg_56_0.reserveTemplate_:GetContDataTemplateById(var_56_0):GetIsTemp() and var_56_0 > GameSetting.default_formation_num_max.value[1] then
		local var_56_1 = arg_56_0.reserveTemplate_:ConverToValidTempProposalContID(var_56_0)

		arg_56_0.contIDList_[1] = var_56_1
	end
end

function var_0_0.TryAutoApplyProposal(arg_57_0)
	local var_57_0 = false

	if #arg_57_0:GetFilterLockHeroList(arg_57_0.editHeroList_) == 0 and arg_57_0.contIDList_[1] == arg_57_0.editContID_ then
		var_57_0 = true
	end

	if var_57_0 then
		arg_57_0:ApplyProposal()
	end
end

function var_0_0.ApplyProposal(arg_58_0)
	arg_58_0.outerHeroList_ = clone(arg_58_0.editHeroList_)
	arg_58_0.outerTrialList_ = {
		0,
		0,
		0
	}
	arg_58_0.outerComboSkillID_ = arg_58_0.editComboSkillID_
	arg_58_0.outerMimirID_ = arg_58_0.editMimirID_
	arg_58_0.outerChipList_ = clone(arg_58_0.editChipList_)
	arg_58_0.outerCharChipBaseID_ = clone(arg_58_0.editCharChipBaseID_)
	arg_58_0.params_.heroList = clone(arg_58_0.outerHeroList_)
	arg_58_0.params_.trialList = clone(arg_58_0.outerTrialList_)
	arg_58_0.params_.comboSkillID = arg_58_0.outerComboSkillID_
	arg_58_0.params_.mimirID = arg_58_0.outerMimirID_
	arg_58_0.params_.chipList = clone(arg_58_0.outerChipList_)
	arg_58_0.params_.charChipBaseID = clone(arg_58_0.outerCharChipBaseID_)

	arg_58_0.outerSectionProxy_:ApplyReserveProposal(arg_58_0.outerHeroList_, arg_58_0.outerTrialList_, arg_58_0.outerComboSkillID_, arg_58_0.outerMimirID_, arg_58_0.outerChipList_, arg_58_0.outerCharChipBaseID_)
end

function var_0_0.CheckOuterHeroList(arg_59_0)
	local var_59_0 = false

	for iter_59_0, iter_59_1 in ipairs(arg_59_0.outerTrialList_) do
		if iter_59_1 ~= 0 then
			var_59_0 = true
			arg_59_0.outerHeroList_[iter_59_0] = 0
			arg_59_0.outerTrialList_[iter_59_0] = 0
		end
	end

	if var_59_0 then
		for iter_59_2 = 1, 2 do
			for iter_59_3 = iter_59_2 + 1, 3 do
				if arg_59_0.outerHeroList_[iter_59_2] == 0 then
					arg_59_0.outerHeroList_[iter_59_2] = arg_59_0.outerHeroList_[iter_59_3]
					arg_59_0.outerHeroList_[iter_59_3] = 0
					arg_59_0.outerTrialList_[iter_59_2] = arg_59_0.outerTrialList_[iter_59_3]
					arg_59_0.outerTrialList_[iter_59_3] = 0

					break
				end
			end
		end

		local var_59_1 = arg_59_0.outerComboSkillID_

		if var_59_1 == 0 or not ComboSkillTools.IsAllMatch(var_59_1, arg_59_0.outerHeroList_) then
			arg_59_0.outerComboSkillID_ = ComboSkillTools.GetRecommendSkillID(arg_59_0.outerHeroList_, true)
		end
	end
end

function var_0_0.GetSelectHeroViewClass(arg_60_0)
	return arg_60_0.sectionProxy_:GetSelectHeroViewClass()
end

function var_0_0.GetAdditionalViewClass(arg_61_0)
	return arg_61_0.sectionProxy_:GetAdditionalViewClass()
end

function var_0_0.InitSubView(arg_62_0)
	if not arg_62_0.createdSubview_ then
		arg_62_0.createdSubview_ = true

		for iter_62_0, iter_62_1 in pairs(arg_62_0.subViewDic_) do
			local var_62_0 = iter_62_1.go

			iter_62_1.instance = iter_62_1.getClassFunc().New(var_62_0)

			if iter_62_1.initFunc then
				iter_62_1.initFunc()
			end
		end
	end
end

function var_0_0.TryReloadSubView(arg_63_0)
	for iter_63_0, iter_63_1 in pairs(arg_63_0.subViewDic_) do
		if SectionSelectHeroTools.IsDiffViewClass(iter_63_1.instance, iter_63_1.getClassFunc()) then
			iter_63_1.instance = SectionSelectHeroTools.ReloadView(iter_63_1.instance, iter_63_1.getClassFunc())

			if iter_63_1.initFunc then
				iter_63_1.initFunc()
			end
		end
	end
end

function var_0_0.SubViewCallFunc(arg_64_0, arg_64_1, ...)
	for iter_64_0, iter_64_1 in pairs(arg_64_0.subViewDic_) do
		local var_64_0 = iter_64_1.instance

		if var_64_0 and var_64_0[arg_64_1] then
			var_64_0[arg_64_1](var_64_0, ...)
		end
	end
end

return var_0_0
