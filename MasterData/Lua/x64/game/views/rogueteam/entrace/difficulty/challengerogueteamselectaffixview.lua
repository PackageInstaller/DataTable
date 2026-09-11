local ChallengeRogueTeamSelectAffixView = class("ChallengeRogueTeamSelectAffixView", ReduxView)

function ChallengeRogueTeamSelectAffixView:UIName()
	return "Widget/System/Activity_Roulike/RoulikSelectOptionalBuffUI"
end

function ChallengeRogueTeamSelectAffixView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamSelectAffixView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.selectedItemList_ = {}
	self.selectAffixHandler_ = handler(self, self.OnSelectAffix)
	self.onClickAffixHandler_ = handler(self, self.OnClickAffix)
	self.rogueTeamSureBtnView_ = ChallengeRogueTeamButton.New(self.sureBtnGo_, handler(self, self.OnClickBtn))
	self.affixPoolUIList_ = LuaList.New(handler(self, self.IndexPoolItem), self.affixIPoolListGo_, ChallengeRogueTeamSelectAffixItem)
	self.maxMultipleController_ = self.transCon_:GetController("max")
end

function ChallengeRogueTeamSelectAffixView:AddListeners()
	return
end

function ChallengeRogueTeamSelectAffixView:IndexPoolItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.affixGroupData_[arg_5_1], arg_5_1, self.group2SelectAffix_[self.affixGroupData_[arg_5_1].group], self.selectAffixHandler_, self.onClickAffixHandler_)
end

function ChallengeRogueTeamSelectAffixView:IndexItem(arg_6_1, arg_6_2)
	arg_6_2:RefreshData(self.selectAffixList_[arg_6_1].affixId)
end

function ChallengeRogueTeamSelectAffixView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.levelNum_ = self.levelNum_ or 0
	self.selectAffixList_ = self.selectAffixList_ or {}
	self.sendAffixList_ = self.sendAffixList_ or {}
	self.group2SelectAffix_ = self.group2SelectAffix_ or {}
	self.index2Affix_ = self.index2Affix_ or {}
	self.baseScore_ = RogueTeamDifficultyCfg[self.params_.difficulty].score

	self:RefreshAffixData()
	self:RefreshUI()
end

function ChallengeRogueTeamSelectAffixView:RefreshAffixData()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(self.params_.affixPool) do
		if var_8_0[ActivityAffixPoolCfg[iter_8_1].affix[1]] == nil then
			var_8_0[ActivityAffixPoolCfg[iter_8_1].affix[1]] = {}
		end

		table.insert(var_8_0[ActivityAffixPoolCfg[iter_8_1].affix[1]], iter_8_1)
	end

	self.affixGroupData_ = {}

	for iter_8_2, iter_8_3 in pairs(var_8_0) do
		table.insert(self.affixGroupData_, {
			group = iter_8_2,
			affixList = iter_8_3
		})
	end

	table.sort(self.affixGroupData_, function(arg_9_0, arg_9_1)
		return arg_9_0.group < arg_9_1.group
	end)
end

function ChallengeRogueTeamSelectAffixView:RefreshUI()
	self.selectGroup_ = 1

	self.affixPoolUIList_:StartScroll(#self.affixGroupData_)

	self.tipsText_.text = GetTips("ROUGE_TEAM_OPTIONAL_HARD_TIPS")

	if self.selectAffixList_ and #self.selectAffixList_ > 0 then
		for iter_10_0 = 1, #self.selectAffixList_ do
			self.selectedItemList_[iter_10_0]:SetActive(true)
		end
	end

	self:RefreshSelectUI()
end

function ChallengeRogueTeamSelectAffixView:OnSelectAffix(arg_11_1)
	slef.affixPoolUIList_:ScrollToIndex(arg_11_1, true, true)
end

function ChallengeRogueTeamSelectAffixView:OnClickAffix(arg_12_1, arg_12_2, arg_12_3)
	self.selectedAffixId_ = arg_12_2

	self:RefreshSelectedList(arg_12_1, arg_12_2)
	self:RefreshSelectUI()
end

function ChallengeRogueTeamSelectAffixView:RefreshSelectedList(arg_13_1, arg_13_2)
	local var_13_0 = false
	local var_13_1 = false
	local var_13_2

	for iter_13_0, iter_13_1 in ipairs(self.selectAffixList_) do
		if iter_13_1.group == arg_13_1 then
			var_13_0 = true

			if arg_13_2 ~= iter_13_1.affixId then
				iter_13_1.affixId = arg_13_2
				self.sendAffixList_[iter_13_0] = arg_13_2
				self.group2SelectAffix_[arg_13_1] = arg_13_2
				var_13_1 = true

				break
			end

			var_13_2 = iter_13_0
			self.group2SelectAffix_[arg_13_1] = nil

			break
		end
	end

	if not var_13_0 then
		table.insert(self.selectAffixList_, 1, {
			group = arg_13_1,
			affixId = arg_13_2
		})
		table.insert(self.sendAffixList_, 1, arg_13_2)

		self.group2SelectAffix_[arg_13_1] = arg_13_2

		for iter_13_2 = 1, #self.selectAffixList_ do
			self.index2Affix_[iter_13_2] = arg_13_2
		end

		var_13_1 = true
	elseif var_13_2 ~= nil then
		table.remove(self.selectAffixList_, var_13_2)
		table.remove(self.sendAffixList_, var_13_2)
	end

	self:RefreshSelectAffixItem(var_13_1, arg_13_1, arg_13_2)
end

function ChallengeRogueTeamSelectAffixView:RefreshSelectAffixItem(arg_14_1, arg_14_2, arg_14_3)
	if arg_14_1 then
		local var_14_0
		local var_14_1

		for iter_14_0, iter_14_1 in ipairs(self.selectedItemList_) do
			if iter_14_1.groupId_ == arg_14_2 then
				var_14_0 = iter_14_1

				break
			elseif not iter_14_1:IsActive() then
				var_14_1 = var_14_1 or iter_14_1
			end
		end

		var_14_0 = var_14_0 or var_14_1

		if not var_14_0 then
			var_14_0 = ChallengeRogueTeamSelectedBigItem.New(Object.Instantiate(self.selectedItemGo_, self.selectAffixListTrans_, false))

			table.insert(self.selectedItemList_, var_14_0)
		end

		var_14_0:RefreshData(arg_14_2, arg_14_3)

		if not var_14_0:IsActive() then
			self.selectAffixListTrans_.anchoredPosition = Vector2.zero

			var_14_0.transform_:SetAsFirstSibling()
			var_14_0:SetActive(true)
		end

		var_14_0:PlayAnim()
	else
		for iter_14_2, iter_14_3 in ipairs(self.selectedItemList_) do
			if iter_14_3.affixId_ == arg_14_3 then
				iter_14_3:SetActive(false)

				break
			end
		end
	end
end

function ChallengeRogueTeamSelectAffixView:RefreshSelectUI()
	self.levelNum_ = 0

	local var_15_1 = ChallengeRogueTeamConst.OPTIONAL_AFFIX_MAX_MULTIPLE

	for iter_15_0, iter_15_1 in ipairs(self.selectAffixList_) do
		self.levelNum_ = self.levelNum_ + ActivityAffixPoolCfg[iter_15_1.affixId].point
	end

	self.levelText_.text = self.levelNum_

	local var_15_2 = self.baseScore_ + self.levelNum_ * ChallengeRogueTeamConst.OPTIONAL_AFFIX_MULTIPLE

	self.multipleText_.text = math.min(self.baseScore_ + self.levelNum_ * ChallengeRogueTeamConst.OPTIONAL_AFFIX_MULTIPLE, var_15_1) .. "%"

	self.maxMultipleController_:SetSelectedState(tostring(var_15_1 <= var_15_2))
end

function ChallengeRogueTeamSelectAffixView:OnClickBtn()
	if self.levelNum_ < 0 then
		ShowTips("ROUGE_TEAM_OPTIONAL_HARD_ERROR")

		return
	end

	if self.params_.clickFunc then
		self.enterFormation_ = true

		ChallengeRogueTeamData:SetOptionalAffix(self.levelNum_, self.sendAffixList_)
		self.params_.clickFunc()
	end
end

function ChallengeRogueTeamSelectAffixView:OnExit()
	for iter_17_0, iter_17_1 in pairs(self.selectedItemList_) do
		iter_17_1:SetActive(false)
	end

	if not self.enterFormation_ then
		self.levelNum_ = 0
		self.selectAffixList_ = {}
		self.sendAffixList_ = {}
		self.group2SelectAffix_ = {}
		self.index2Affix_ = {}
	else
		self.enterFormation_ = false
	end

	manager.windowBar:HideBar()
end

function ChallengeRogueTeamSelectAffixView:Dispose()
	self.selectAffixHandler_ = nil
	self.onClickAffixHandler_ = nil

	if self.affixPoolUIList_ then
		self.affixPoolUIList_:Dispose()

		self.affixPoolUIList_ = nil
	end

	if self.selectedItemList_ then
		for iter_18_0, iter_18_1 in pairs(self.selectedItemList_) do
			iter_18_1:Dispose()
		end

		self.selectedItemList_ = nil
	end

	ChallengeRogueTeamSelectAffixView.super.Dispose(self)
end

return ChallengeRogueTeamSelectAffixView
