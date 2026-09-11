local ReserveProposalView = class("ReserveProposalView", ReduxView)

function ReserveProposalView:UIName()
	return "Widget/System/Formation/FormationProposalUI"
end

function ReserveProposalView:UIParent()
	return manager.ui.uiMain.transform
end

function ReserveProposalView:Init()
	self:InitUI()
end

function ReserveProposalView:ReserveCameraEnter()
	manager.loadScene:SetSceneActive(SceneConst.SCENE_NAME.reserve, true)
	manager.reserveCamera:SwitchCamera(ReserveCameraConst.CAMERA_TYPE.common, ReserveCameraConst.VIRTUAL_CAMERA.reserveProposal)
end

function ReserveProposalView:InitUI()
	self:BindCfgUI()
	self:InitSubViewCfg()
	self:InitHandler()
end

function ReserveProposalView:InitSubViewCfg()
	self.subViewDic_ = {
		selectHeroView = {
			go = self.selectHeroGo_,
			getClassFunc = handler(self, self.GetSelectHeroViewClass)
		},
		additionalView = {
			go = self.additionalGo_,
			getClassFunc = handler(self, self.GetAdditionalViewClass)
		}
	}
end

function ReserveProposalView:InitHandler()
	self.clickHeroHandler_ = handler(self, self.OnSectionClickHero)
	self.inputHandler_ = handler(self, self.OnInput)
	self.deleteProposalHandler_ = handler(self, self.OnDeleteProposal)
	self.changeHeroTeamHandler_ = handler(self, self.OnChangeHeroTeam)
	self.changeComboSkillHander_ = handler(self, self.OnChangeComboSkill)
end

function ReserveProposalView:OnTop()
	self:UpdateBar()
end

function ReserveProposalView:OnBehind()
	manager.windowBar:HideBar()
end

function ReserveProposalView:OnEnter()
	self:ProcessParams()
	self:ProcessSubView()
	self:AddEventListener()
	self:ResetTempData()
	self:SubViewOnEnter()
	self:Refresh()
end

function ReserveProposalView:OnExit()
	self.params_.lastContIDList = self.contIDList_
	self.params_.lastEditContID = self.editContID_

	self:RemoveAllEventListener()
	self:SubViewOnExit()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
end

function ReserveProposalView:Dispose()
	self:SubViewCallFunc("Dispose")

	for iter_12_0, iter_12_1 in pairs(self.subViewDic_) do
		iter_12_1.go = nil
		iter_12_1.instance = nil
	end

	ReserveProposalView.super.Dispose(self)
end

function ReserveProposalView:AddEventListener()
	self:RegistEventListener(SECTION_CLICK_HERO, self.clickHeroHandler_)
	self:RegistEventListener(INPUT_POP_CLICK_OK, self.inputHandler_)
	self:RegistEventListener(RESERVE_RESET_CONT_DATA, self.deleteProposalHandler_)
	self:RegistEventListener(SECTION_CHANGE_HERO_TEAM, self.changeHeroTeamHandler_)
	self:RegistEventListener(COMBO_SKILL_SELECT, self.changeComboSkillHander_)
end

function ReserveProposalView:ProcessParams()
	self:ProcessBaseParams()
	self:ProcessReserveParams()
	self:ProcessProxyParams()
	self:ProcessProposalParams()
end

function ReserveProposalView:ProcessBaseParams()
	self.stageID_ = self.params_.stage_id
	self.stageType_ = self.params_.stage_type or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
	self.outerSectionProxy_ = self.params_.sectionProxy
end

function ReserveProposalView:ProcessReserveParams()
	self.reserveParams_ = self.reserveParams_ or ReserveParams.New(ReserveConst.RESERVE_TYPE.PROPOSAL, 1)
	self.reserveTemplate_ = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.PROPOSAL)
end

function ReserveProposalView:ProcessProxyParams()
	self.sectionProxy_ = self.sectionProxy_ or ReserveProposalSelectHeroProxy.New({
		outerLockHeroList = clone(self.params_.lockHeroList)
	}, self.reserveParams_, HeroConst.HERO_DATA_TYPE.DEFAULT)

	self.sectionProxy_:SetOuterLockHeroList(clone(self.params_.lockHeroList))
end

function ReserveProposalView:ProcessProposalParams()
	if not self.params_.isBack then
		ReserveTools.CleanCacheData(ReserveConst.RESERVE_TYPE.PROPOSAL)
	end

	self:ProcessOuterTeam()
	self:UpdateCurSavedProposal()
	self:InitContIDList()
	self:InitEditContData()
end

function ReserveProposalView:ProcessOuterTeam()
	self.outerHeroList_ = clone(self.params_.heroList)
	self.outerTrialList_ = clone(self.params_.trialList)
	self.outerComboSkillID_ = self.params_.comboSkillID
	self.outerMimirID_ = self.params_.mimirID
	self.outerChipList_ = clone(self.params_.chipList)
	self.outerCharChipBaseID_ = clone(self.params_.charChipBaseID)
	self.outerLockHeroList_ = clone(self.params_.lockHeroList)

	self:CheckOuterHeroList()
end

function ReserveProposalView:InitContIDList()
	if self.params_.lastContIDList then
		self.contIDList_ = self.params_.lastContIDList
	else
		local var_20_0 = {}

		var_20_0[1] = self:GetCurUseProposalContID() or self:CreateTempProposal()

		for iter_20_0, iter_20_1 in ipairs(self.curProposalContIDList_) do
			if iter_20_1 ~= var_20_0[1] then
				var_20_0[#var_20_0 + 1] = iter_20_1
			end
		end

		self.contIDList_ = var_20_0
	end
end

function ReserveProposalView:GetCurUseProposalContID()
	local var_21_0

	for iter_21_0, iter_21_1 in ipairs(self.curProposalContIDList_) do
		if SectionSelectHeroTools.IsReserveProposalEqual(iter_21_1, self.outerHeroList_, self.outerComboSkillID_, self.outerMimirID_, self.outerChipList_, nil, self.outerCharChipBaseID_) then
			var_21_0 = iter_21_1

			break
		end
	end

	return var_21_0
end

function ReserveProposalView:CreateTempProposal()
	local var_22_0 = self.reserveTemplate_:GreateTempContID()

	ReserveTools.SetTeam(ReserveParams.New(ReserveConst.RESERVE_TYPE.PROPOSAL, var_22_0), self.outerHeroList_, {
		0,
		0,
		0
	}, self.outerComboSkillID_, self.outerMimirID_, self.outerChipList_, self.outerCharChipBaseID_)

	return var_22_0
end

function ReserveProposalView:InitEditContData()
	self:UpdateEditContData(self.params_.lastEditContID and self.params_.lastEditContID or self.contIDList_[1])
end

function ReserveProposalView:UpdateEditContData(arg_24_1)
	self.editContID_ = arg_24_1
	self.reserveParams_.contID = arg_24_1
	self.editHeroList_ = self.sectionProxy_:GetHeroTeam()
	self.editTrialList_ = {
		0,
		0,
		0
	}
	self.editComboSkillID_ = self.sectionProxy_:GetComboSkillID()
	self.editMimirID_, self.editChipList_ = self.sectionProxy_:GetMimirData()
	self.editCharChipBaseID_ = self.sectionProxy_:GetCharChipBaseID()
end

function ReserveProposalView:ProcessSubView()
	self:InitSubView()
	self:TryReloadSubView()
	self:ProcessSubViewParams()
end

function ReserveProposalView:ProcessSubViewParams()
	self:SubViewCallFunc("SetProxy", self.sectionProxy_)
end

function ReserveProposalView:SubViewOnEnter()
	self:SubViewCallFunc("OnEnter")
end

function ReserveProposalView:OnExit()
	self.params_.lastContIDList = self.contIDList_
	self.params_.lastEditContID = self.editContID_

	self:RemoveAllEventListener()
	self:SubViewOnExit()
	manager.windowBar:HideBar()
	manager.loadScene:SetSceneActive(SceneConst.SCENE_NAME.reserve, false)
end

function ReserveProposalView:SubViewOnExit()
	self:SubViewCallFunc("OnExit")
end

function ReserveProposalView:UpdateBar()
	self.sectionProxy_:UpdateBar()
end

function ReserveProposalView:ResetTempData()
	self.subViewDic_.selectHeroView.instance:ResetTempData()
end

function ReserveProposalView:Refresh()
	self:RefreshSubView()
	self:RefreshReserveUI()
	self:RefreshSwitchList()
	self:RefreshBtnPanel()
end

function ReserveProposalView:RefreshSubView()
	self:SubViewCallFunc("Refresh")
end

function ReserveProposalView:RefreshReserveUI()
	self.subViewDic_.selectHeroView.instance:SetContID(self.editContID_)
end

function ReserveProposalView:RefreshBtnPanel()
	self.subViewDic_.additionalView.instance:RefreshBtnPanel(self.editContID_, self.outerHeroList_, self.outerComboSkillID_, self.outerMimirID_, self.outerChipList_, self.outerCharChipBaseID_)
end

function ReserveProposalView:RefreshSwitchList()
	self.subViewDic_.additionalView.instance:RefreshSwitchList(self.contIDList_, self.editContID_, self.curSavedProposalNum_)
end

function ReserveProposalView:SaveProposal()
	ReserveAction.SaveReserveProposal(self.saveContID_, handler(self, self.OnSaveProposal))
end

function ReserveProposalView:SaveName(arg_38_1, arg_38_2)
	ReserveAction.RenameReserveProposal(self.saveContID_, arg_38_1, arg_38_2, handler(self, self.OnSaveProposal))
end

function ReserveProposalView:OnSaveProposal()
	if self.saveContID_ == self.editContID_ then
		self:TryAutoApplyProposal()
	end

	ShowTips("FORMATION_PLAN_SAVED")
	manager.notify:Invoke(INPUT_POP_BACK)
	self:UpdateCurSavedProposal()
	self:RefreshSwitchList()
	self:RefreshBtnPanel()
end

function ReserveProposalView:OnReserveProposalClickSave()
	local var_40_0 = self.reserveTemplate_:GetContDataTemplateById(self.editContID_)

	if var_40_0:GetIsTemp() and GameSetting.default_formation_num_max.value[1] == #self.curProposalContIDList_ then
		ShowTips("RESERVE_PROPOSAL_SAVE_LIMIT")

		return
	end

	if self.editHeroList_[1] == 0 then
		ShowTips("TEAM_SET_NEEDED")

		return
	end

	for iter_40_0, iter_40_1 in ipairs(self.curProposalContIDList_) do
		if iter_40_1 ~= self.editContID_ and SectionSelectHeroTools.IsReserveProposalEqual(iter_40_1, self.editHeroList_, self.editComboSkillID_, self.editMimirID_, self.editChipList_, true, self.editCharChipBaseID_) then
			ShowTips("RESERVE_PROPOSAL_SAME")

			return
		end
	end

	self.saveContID_ = self.editContID_

	if var_40_0:GetName() == "" then
		self:GotoRenameView(self.saveContID_)
	else
		self:SaveProposal()
	end
end

function ReserveProposalView:OnReserveProposalClickApply()
	local var_41_0 = self:GetFilterLockHeroList(self.editHeroList_)

	if #var_41_0 > 0 then
		JumpTools.OpenPageByJump("filterLockHero", {
			heroIDList = var_41_0,
			type = SectionSelectHeroConst.DISPLAY_FILTER_LOCK_HERO_TYPE.PROPOSAL
		})

		return
	end

	self:ApplyProposal()
	self:OnApplyProposalSuccess()
end

function ReserveProposalView:GetFilterLockHeroList(arg_42_1)
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in ipairs(arg_42_1) do
		if iter_42_1 ~= 0 and table.indexof(self.outerLockHeroList_, iter_42_1) then
			var_42_0[#var_42_0 + 1] = iter_42_1
		end
	end

	return var_42_0
end

function ReserveProposalView:OnApplyProposalSuccess()
	ShowTips("RESERVE_PROPOSAL_SELECT_SUCCESS")
	self:Back()
end

function ReserveProposalView:OnReserveProposalClickDelete()
	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = string.format(GetTips("FORMATION_PLAN_DELETE_CONFIRM"), (self.reserveTemplate_:GetContDataTemplateById(self.editContID_):GetName())),
		OkCallback = function()
			self.sectionProxy_:ResetTeam()
		end
	})
end

function ReserveProposalView:OnReserveProposalClickProposal(arg_46_1)
	if arg_46_1 == self.editContID_ then
		return
	end

	self:UpdateEditContData(arg_46_1)
	self:RefreshSubView()
	self:RefreshReserveUI()
	self:RefreshBtnPanel()
	self.subViewDic_.additionalView.instance:RefreshSelect(self.editContID_)
end

function ReserveProposalView:OnReserveProposalClickRename(arg_47_1)
	self.saveContID_ = arg_47_1

	self:GotoRenameView(self.saveContID_)
end

function ReserveProposalView:GotoRenameView(arg_48_1)
	JumpTools.OpenPageByJump("reserveProposalRename", {
		selectAttributeList = self.reserveTemplate_:GetAttributeTagList(arg_48_1)
	})
end

function ReserveProposalView:OnSectionClickHero(arg_49_1)
	self.sectionProxy_:GotoHeroInfoUI(arg_49_1)
end

function ReserveProposalView:OnChangeHeroTeam(arg_50_1, arg_50_2)
	self.editHeroList_ = clone(arg_50_1)

	self:RefreshSwitchList()
	self:RefreshBtnPanel()
end

function ReserveProposalView:OnChangeComboSkill(arg_51_1)
	self.editComboSkillID_ = arg_51_1

	self:RefreshBtnPanel()
end

function ReserveProposalView:OnInput(arg_52_1, arg_52_2)
	self:SaveName(arg_52_1, arg_52_2)
end

function ReserveProposalView:OnDeleteProposal(arg_53_1, arg_53_2)
	self.reserveTemplate_:DeleteProposal(arg_53_2)
	self:UpdateCurSavedProposal()
	self:DeleteTargetContID(arg_53_2)
	self:UpdateTempProposal()
	self:UpdateEditContData(self.contIDList_[1])
	self:Refresh()
	ShowTips("FORMATION_PLAN_DELETED")
end

function ReserveProposalView:UpdateCurSavedProposal()
	self.curProposalContIDList_ = self.reserveTemplate_:GetProposalContIDList()
	self.curSavedProposalNum_ = #self.curProposalContIDList_
end

function ReserveProposalView:DeleteTargetContID(arg_55_1)
	table.remove(self.contIDList_, (table.indexof(self.contIDList_, arg_55_1)))

	if #self.contIDList_ == 0 then
		self.contIDList_[1] = self:CreateTempProposal()
	end
end

function ReserveProposalView:UpdateTempProposal()
	if self.reserveTemplate_:GetContDataTemplateById(self.contIDList_[1]):GetIsTemp() and self.contIDList_[1] > GameSetting.default_formation_num_max.value[1] then
		self.contIDList_[1] = self.reserveTemplate_:ConverToValidTempProposalContID(self.contIDList_[1])
	end
end

function ReserveProposalView:TryAutoApplyProposal()
	if #self:GetFilterLockHeroList(self.editHeroList_) == 0 and self.contIDList_[1] == self.editContID_ then
		self:ApplyProposal()
	end
end

function ReserveProposalView:ApplyProposal()
	self.outerHeroList_ = clone(self.editHeroList_)
	self.outerTrialList_ = {
		0,
		0,
		0
	}
	self.outerComboSkillID_ = self.editComboSkillID_
	self.outerMimirID_ = self.editMimirID_
	self.outerChipList_ = clone(self.editChipList_)
	self.outerCharChipBaseID_ = clone(self.editCharChipBaseID_)
	self.params_.heroList = clone(self.outerHeroList_)
	self.params_.trialList = clone(self.outerTrialList_)
	self.params_.comboSkillID = self.outerComboSkillID_
	self.params_.mimirID = self.outerMimirID_
	self.params_.chipList = clone(self.outerChipList_)
	self.params_.charChipBaseID = clone(self.outerCharChipBaseID_)

	self.outerSectionProxy_:ApplyReserveProposal(self.outerHeroList_, self.outerTrialList_, self.outerComboSkillID_, self.outerMimirID_, self.outerChipList_, self.outerCharChipBaseID_)
end

function ReserveProposalView:CheckOuterHeroList()
	local var_59_0 = false

	for iter_59_0, iter_59_1 in ipairs(self.outerTrialList_) do
		if iter_59_1 ~= 0 then
			var_59_0 = true
			self.outerHeroList_[iter_59_0] = 0
			self.outerTrialList_[iter_59_0] = 0
		end
	end

	if var_59_0 then
		for iter_59_2 = 1, 2 do
			for iter_59_3 = iter_59_2 + 1, 3 do
				if self.outerHeroList_[iter_59_2] == 0 then
					self.outerHeroList_[iter_59_2] = self.outerHeroList_[iter_59_3]
					self.outerHeroList_[iter_59_3] = 0
					self.outerTrialList_[iter_59_2] = self.outerTrialList_[iter_59_3]
					self.outerTrialList_[iter_59_3] = 0

					break
				end
			end
		end

		if self.outerComboSkillID_ == 0 or not ComboSkillTools.IsAllMatch(self.outerComboSkillID_, self.outerHeroList_) then
			self.outerComboSkillID_ = ComboSkillTools.GetRecommendSkillID(self.outerHeroList_, true)
		end
	end
end

function ReserveProposalView:GetSelectHeroViewClass()
	return self.sectionProxy_:GetSelectHeroViewClass()
end

function ReserveProposalView:GetAdditionalViewClass()
	return self.sectionProxy_:GetAdditionalViewClass()
end

function ReserveProposalView:InitSubView()
	if not self.createdSubview_ then
		self.createdSubview_ = true

		for iter_62_0, iter_62_1 in pairs(self.subViewDic_) do
			iter_62_1.instance = iter_62_1.getClassFunc().New(iter_62_1.go)

			if iter_62_1.initFunc then
				iter_62_1.initFunc()
			end
		end
	end
end

function ReserveProposalView:TryReloadSubView()
	for iter_63_0, iter_63_1 in pairs(self.subViewDic_) do
		if SectionSelectHeroTools.IsDiffViewClass(iter_63_1.instance, iter_63_1.getClassFunc()) then
			iter_63_1.instance = SectionSelectHeroTools.ReloadView(iter_63_1.instance, iter_63_1.getClassFunc())

			if iter_63_1.initFunc then
				iter_63_1.initFunc()
			end
		end
	end
end

function ReserveProposalView:SubViewCallFunc(arg_64_1, ...)
	for iter_64_0, iter_64_1 in pairs(self.subViewDic_) do
		if iter_64_1.instance and iter_64_1.instance[arg_64_1] then
			iter_64_1.instance[arg_64_1](iter_64_1.instance, ...)
		end
	end
end

return ReserveProposalView
