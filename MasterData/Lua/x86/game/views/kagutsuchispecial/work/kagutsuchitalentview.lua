local KagutsuchiAffixMainView = class("KagutsuchiAffixMainView", ReduxView)

function KagutsuchiAffixMainView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionWorkUI/JapanRegionWorkTalentUI"
end

function KagutsuchiAffixMainView:UIParent()
	return manager.ui.uiMain.transform
end

function KagutsuchiAffixMainView:Init()
	self.talentIdList_ = KagutsuchiTalentData:GetTalentIdList()

	self:BindCfgUI()
	self:AddUIListener()

	self.upBtnController_ = ControllerUtil.GetController(self.upgradeTrs_, "button")
	self.upTxtController_ = ControllerUtil.GetController(self.upgradeTrs_, "text")

	for iter_3_0 = 1, #self.talentIdList_ do
		local var_3_0 = self[string.format("talent%dBtn_", iter_3_0)]

		if var_3_0 then
			self[string.format("lock%dController_", iter_3_0)] = ControllerUtil.GetController(var_3_0.transform, "lock")
		end
	end

	self.rightLockController_ = ControllerUtil.GetController(self.rightIconTrs_, "lock")
end

function KagutsuchiAffixMainView:AddUIListener()
	for iter_4_0 = 1, #self.talentIdList_ do
		local var_4_0 = self[string.format("talent%dBtn_", iter_4_0)]

		if var_4_0 then
			self:AddBtnListener(var_4_0, nil, function()
				self:SelectItem(iter_4_0)
			end)
		end
	end

	self:AddBtnListener(self.upBtn_, nil, function()
		self:UpgradeTalent()
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		JumpTools.Back()
	end)
end

function KagutsuchiAffixMainView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.currentIndex_ = -1

	self:RefreshUI()
end

function KagutsuchiAffixMainView:OnExit()
	AnimatorTools.Stop()
end

function KagutsuchiAffixMainView:RefreshUI()
	for iter_10_0, iter_10_1 in ipairs(self.talentIdList_) do
		self:RefreshItem(iter_10_0, iter_10_1)

		local var_10_0 = self[string.format("select%dGo_", iter_10_0)]

		if var_10_0 then
			SetActive(var_10_0, false)
		end
	end

	self:SelectItem(1)
	SetActive(self.upEffectGo_, false)
end

function KagutsuchiAffixMainView:RefreshItem(arg_11_1, arg_11_2)
	local var_11_0 = TalentTreeCfg[arg_11_2]
	local var_11_1 = KagutsuchiTalentData:GetTalentLevel(arg_11_2)
	local var_11_2 = var_11_1 == KagutsuchiTalentData:GetTalentMaxLevel(arg_11_2)
	local var_11_3 = KagutsuchiTalentData:IsTalentLocked(arg_11_2)
	local var_11_4 = self[string.format("lock%dGo_", arg_11_1)]

	if var_11_4 then
		SetActive(var_11_4, var_11_3)
	end

	local var_11_5 = self[string.format("select%dGo_", arg_11_1)]

	if var_11_5 then
		SetActive(var_11_5, true)
	end

	local var_11_6 = self[string.format("max%dGo_", arg_11_1)]

	if var_11_6 then
		SetActive(var_11_6, var_11_2)
	end

	local var_11_7 = self[string.format("level%dText_", arg_11_1)]

	if var_11_7 then
		var_11_7.text = (var_11_2 or var_11_3) and "" or string.format("LV.%d", var_11_1)
	end

	local var_11_8 = self[string.format("name%dText_", arg_11_1)]

	if var_11_8 then
		var_11_8.text = getAffixName({
			var_11_0.affix_id,
			1
		})
	end

	self[string.format("lock%dController_", arg_11_1)]:SetSelectedState(var_11_3 and "yes" or "no")

	if self[string.format("talent%dIcon_", arg_11_1)] then
		-- block empty
	end

	self:RefreshRightPanel(arg_11_2, arg_11_1)
end

function KagutsuchiAffixMainView:RefreshRightPanel(arg_12_1, arg_12_2)
	local var_12_0 = TalentTreeCfg[arg_12_1]

	self.rightNameText_.text = getAffixName({
		TalentTreeCfg[arg_12_1].affix_id,
		1
	})

	local var_12_1 = KagutsuchiTalentData:IsTalentMaxLevel(arg_12_1)
	local var_12_2 = KagutsuchiTalentData:CanUpgrade(arg_12_1)
	local var_12_3 = KagutsuchiTalentData:IsTalentLocked(arg_12_1)
	local var_12_4 = KagutsuchiTalentData:GetTalentLevel(arg_12_1)

	if var_12_3 then
		var_12_4 = 1
	end

	self.rightLockController_:SetSelectedState(var_12_3 and "yes" or "no")

	local var_12_5 = self[string.format("talent%dIcon_", arg_12_2)]

	if var_12_5 then
		self.rightIcon_.sprite = var_12_5.sprite
	end

	SetActive(self.rightLockGo_, var_12_3)
	SetActive(self.rightLevelGo_, not var_12_3)
	SetActive(self.rightMaxGo_, var_12_1)

	if var_12_1 then
		SetActive(self.rightLevelGo_, false)
	else
		self.rightLevelText_.text = string.format("LV.%d", var_12_4)
	end

	self.rightDescText_.text = getAffixDesc({
		var_12_0.affix_id,
		var_12_4
	})

	if var_12_1 or var_12_3 then
		SetActive(self.rightNextGo_, false)
	else
		self.rightNextDescText_.text = getAffixDesc({
			var_12_0.affix_id,
			var_12_4 + 1
		})

		SetActive(self.rightNextGo_, true)
	end

	self:RefreshCondition(arg_12_1, var_12_3 and var_12_4 or var_12_4 + 1)

	if var_12_2 then
		self.upBtnController_:SetSelectedState("yellow")
		self.upTxtController_:SetSelectedState(var_12_3 and "unlock" or "upgrade")
	elseif var_12_3 then
		self.upBtnController_:SetSelectedState("gray")
		self.upTxtController_:SetSelectedState("unlock")
	elseif var_12_1 then
		self.upBtnController_:SetSelectedState("black")
		self.upTxtController_:SetSelectedState("max")
	else
		self.upBtnController_:SetSelectedState("gray")
		self.upTxtController_:SetSelectedState(var_12_3 and "unlock" or "upgrade")
	end
end

function KagutsuchiAffixMainView:RefreshCondition(arg_13_1, arg_13_2)
	local var_13_0 = KagutsuchiTalentData:CanUpgrade(arg_13_1)

	if KagutsuchiTalentData:IsTalentMaxLevel(arg_13_1) then
		SetActive(self.unlockGo_, false)

		return
	end

	SetActive(self.unlockGo_, true)

	local var_13_1 = ConditionCfg[KagutsuchiTalentData:GetTalentConditionId(arg_13_1, arg_13_2)]
	local var_13_2 = var_13_1.params

	if var_13_1.type == 1020 then
		local var_13_3 = HeroConst.Hero_Star
		local var_13_4 = HeroData:GetHeroData(var_13_2[1])

		self.rightConditionText_.text = var_13_1.desc
		self.rightProgressText_.text = string.format("(%s/%s)", var_13_4.unlock == 0 and "-" or var_13_3[math.floor(var_13_4.star / 100)], var_13_3[var_13_2[2]])
	elseif var_13_1.type == 2510 then
		self.rightConditionText_.text = string.format(var_13_1.desc, var_13_2[1])
		self.rightProgressText_.text = string.format("(%d/%d)", KagutsuchiWorkData:GetTotalCoins(), var_13_2[1])
	end

	SetActive(self.rightCanUpGo_, var_13_0)
end

function KagutsuchiAffixMainView:SelectItem(arg_14_1)
	if self.currentIndex_ == arg_14_1 then
		return
	end

	local var_14_0 = self.talentIdList_[arg_14_1]

	if self.currentIndex_ then
		local var_14_1 = self[string.format("select%dGo_", self.currentIndex_)]

		if var_14_1 then
			SetActive(var_14_1, false)
		end
	end

	self.currentIndex_ = arg_14_1

	self:RefreshItem(arg_14_1, var_14_0)
end

function KagutsuchiAffixMainView:UpgradeTalent()
	if not KagutsuchiTalentData:CanUpgrade(self.talentIdList_[self.currentIndex_]) then
		if KagutsuchiTalentData:IsTalentLocked(self.talentIdList_[self.currentIndex_]) then
			ShowTips(string.format(GetTips("NO_REACH_UNLOCK")))
		else
			ShowTips(string.format(GetTips("DORM_CANTEEN_CANT_LEVEL_UP")))
		end

		return
	end

	KagutsuchiTalentAction:UpgradeTalent(self.talentIdList_[self.currentIndex_], handler(self, self.OnUpgradeTalent))
end

function KagutsuchiAffixMainView:OnUpgradeTalent(arg_16_1, arg_16_2)
	self:RefreshItem(self.currentIndex_, arg_16_2.talent_id)
	SetActive(self.upEffectGo_, true)
	AnimatorTools.PlayAnimationWithCallback(self.upgradeAni_, "JapanRegionWorkTalentUI_saoguang", function()
		SetActive(self.upEffectGo_, false)
	end)
end

return KagutsuchiAffixMainView
