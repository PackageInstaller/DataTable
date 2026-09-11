local SoloChallengeAffixView = class("SoloChallengeAffixView", ReduxView)

function SoloChallengeAffixView:UIName()
	return "UI/VersionUI/SummerUI/SummerSoloChallengeAffixViewnewUI"
end

function SoloChallengeAffixView:UIParent()
	return manager.ui.uiMain.transform
end

function SoloChallengeAffixView:Init()
	self.selectHandler_ = handler(self, self.OnSelectAffix)

	self:InitUI()
	self:AddUIListener()

	self.buttonController_ = ControllerUtil.GetController(self.transform_, "buttonState")
	self.list_ = LuaList.New(handler(self, self.IndexItem), self.scrollView_, SoloChallengeAffixItem)
end

function SoloChallengeAffixView:InitUI()
	self:BindCfgUI()
end

function SoloChallengeAffixView:OnEnter()
	manager.windowBar:HideBar()

	self.activityID_ = self.params_.activityID
	self.affixList_ = ActivitySoloChallengeCfg[self.activityID_].affix_pool
	self.ownAffixID_ = self.params_.affixID
	self.ownPos_ = self.params_.pos
	self.stageID_ = self.params_.stageID
	self.maxAffixCount_ = SoloChallengeData:GetMaxAffixCount(self.activityID_)
	self.selectedAffixID_ = 0
	self.selected_ = false

	self.list_:StartScroll(#self.affixList_)
	self:RefreshUI()
end

function SoloChallengeAffixView:IndexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(self.activityID_, self.affixList_[arg_6_1], self.toggleGroup_)
	arg_6_2:SetState(SoloChallengeData:GetAffixState(self.activityID_, self.affixList_[arg_6_1]))
	arg_6_2:RegistSelectCallBack(self.selectHandler_)

	local var_6_0 = false

	if (self.ownAffixID_ == self.affixList_[arg_6_1] or self.ownAffixID_ == 0 and arg_6_2.stageID_ == -1) and not self.selected_ then
		var_6_0 = true
		self.selected_ = true
		self.selectedAffixID_ = self.affixList_[arg_6_1]

		self:RefreshAffixDesc()
	end

	arg_6_2:SetSelect(var_6_0)
end

function SoloChallengeAffixView:AddUIListener()
	self:AddBtnListener(self.equipBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if self.ownAffixID_ == 0 then
			self:EquipAffix(self.activityID_, self.stageID_, self.ownPos_, self.selectedAffixID_, self.newPos_)

			self.ownAffixID_ = self.selectedAffixID_
		else
			local var_8_0 = SoloChallengeData:GetNextEquipPos(self.activityID_, self.stageID_)

			if var_8_0 ~= -1 then
				self:EquipAffix(self.activityID_, self.stageID_, var_8_0, self.selectedAffixID_, self.newPos_)
			end
		end
	end)
	self:AddBtnListener(self.dischargeBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if self.ownAffixID_ == self.selectedAffixID_ then
			self.ownAffixID_ = 0
		end

		SoloChallengeTools.DischargeAffix(self.activityID_, self.selectedAffixID_)
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function SoloChallengeAffixView:RefreshUI()
	self:RefreshAffixCountText()
	self:RefreshIcon()
	self:RefreshAffixDesc()
	self:RefreshBtnState()
end

function SoloChallengeAffixView:RefreshIcon()
	if self.selectedAffixID_ ~= 0 then
		self.icon_.sprite = getAffixSprite(ActivityAffixPoolCfg[self.selectedAffixID_].affix)
	end
end

function SoloChallengeAffixView:EquipAffix(arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	if arg_13_5 ~= -1 then
		SoloChallengeTools.DischargeAffix(arg_13_1, arg_13_4)
		SoloChallengeTools.EquipAffix(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	else
		SoloChallengeTools.EquipAffix(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	end
end

function SoloChallengeAffixView:OnSoloChallengeAffixRefresh(arg_14_1)
	self:RefreshAffixCountText()
	self:RefreshAffixState(arg_14_1)
	self:RefreshBtnState()
	self:SelectAffix(arg_14_1)
end

function SoloChallengeAffixView:SelectAffix(arg_15_1)
	self.list_:GetItemByIndex((table.keyof(self.affixList_, arg_15_1))):SetSelect(true)
end

function SoloChallengeAffixView:OnSelectAffix(arg_16_1, arg_16_2)
	self.selectedAffixID_ = arg_16_1
	self.newPos_ = arg_16_2

	self:RefreshUI()
end

function SoloChallengeAffixView:RefreshBtnState()
	local var_17_0 = SoloChallengeData:CanEquipAffix(self.activityID_, self.stageID_)

	if self.selectedAffixID_ ~= 0 and (self.ownAffixID_ == self.selectedAffixID_ or SoloChallengeData:GetAffixState(self.activityID_, self.selectedAffixID_).stageID == self.stageID_) then
		self.buttonController_:SetSelectedState("discharge")
	elseif self.ownAffixID_ == 0 or var_17_0 then
		self.buttonController_:SetSelectedState("equip")

		self.equipBtn_.interactable = true
	elseif not var_17_0 then
		self.buttonController_:SetSelectedState("equip")

		self.equipBtn_.interactable = false
	end
end

function SoloChallengeAffixView:RefreshAffixCountText()
	self.affixCountText_.text = string.format("%d/%d", SoloChallengeData:GetAffixCount(self.activityID_, self.stageID_), self.maxAffixCount_)
end

function SoloChallengeAffixView:RefreshAffixDesc()
	if self.selectedAffixID_ ~= 0 then
		self.affixDescText_.text = getAffixDesc(ActivityAffixPoolCfg[self.selectedAffixID_].affix)
		self.affixNameText_.text = getAffixName(ActivityAffixPoolCfg[self.selectedAffixID_].affix)
	end
end

function SoloChallengeAffixView:RefreshAffixState(arg_20_1)
	local var_20_0 = table.keyof(self.affixList_, arg_20_1)

	if var_20_0 then
		self.list_:GetItemByIndex(var_20_0):SetState(SoloChallengeData:GetAffixState(self.activityID_, arg_20_1))
	end
end

function SoloChallengeAffixView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	self.selectHandler_ = nil
	self.buttonController_ = nil

	SoloChallengeAffixView.super.Dispose(self)
end

function SoloChallengeAffixView:OnReverTeamData()
	self.list_:StartScroll(#self.affixList_)
	self:RefreshUI()
end

return SoloChallengeAffixView
