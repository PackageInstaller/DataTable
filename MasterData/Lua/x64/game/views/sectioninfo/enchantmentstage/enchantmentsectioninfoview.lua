local EnchantmentSectionInfoView = class("EnchantmentSectionInfoView", import("..SectionInfoMultipleBaseView"))

function EnchantmentSectionInfoView:Init()
	EnchantmentSectionInfoView.super.Init(self)
	self.hideDropPanelController_:SetSelectedState("false")
	self.hideBattleAffixController_:SetSelectedState("false")
end

function EnchantmentSectionInfoView:OnClickBtn()
	self:Go("/sectionSelectHero", {
		section = self.stageID_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT,
		multiple = self.multiple_
	})
end

function EnchantmentSectionInfoView:RefreshData()
	self.lock_ = false
	self.lockTips_ = ""
	self.cost_ = BattleEnchantmentStageCfg[self.stageID_].cost
	self.dropLibID_ = BattleEnchantmentStageCfg[self.stageID_].drop_lib_id
	self.isFirstClear_ = true

	EnchantmentSectionInfoView.super.RefreshData(self)
end

function EnchantmentSectionInfoView:RefreshUI()
	EnchantmentSectionInfoView.super.RefreshUI(self)
	self:RefreshBattleAffix()
	SetActive(self.affixInfoTrs_.gameObject, false)
end

function EnchantmentSectionInfoView:AddListeners()
	EnchantmentSectionInfoView.super.AddListeners(self)
	self:AddBtnListener(self.buffAffixBtn_, nil, function()
		self:ShowAffixInfo(self.buffAffixBtn_.transform, self.buff_[1])
	end)
	self:AddBtnListener(self.debuffAffixBtn_, nil, function()
		self:ShowAffixInfo(self.debuffAffixBtn_.transform, self.debuff_[1])
	end)
end

function EnchantmentSectionInfoView:RemoveListeners()
	EnchantmentSectionInfoView.super.RemoveListeners(self)
	self.buffAffixBtn_.onClick:RemoveAllListeners()
	self.debuffAffixBtn_.onClick:RemoveAllListeners()
end

function EnchantmentSectionInfoView:RefreshRewardItem(arg_9_1, arg_9_2)
	local var_9_0

	if self.rewardList_[arg_9_1] then
		var_9_0 = rewardToItemTemplate(self.rewardList_[arg_9_1])
		var_9_0.number = nil

		function var_9_0.clickFun(arg_10_0)
			ShowPopItem(POP_ITEM, arg_10_0)
		end
	end

	arg_9_2:SetData(var_9_0)
end

function EnchantmentSectionInfoView:RefreshStageInfo()
	self.sectionName_.text = GetI18NText(BattleEnchantmentStageCfg[self.stageID_].name)
	self.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, BattleEnchantmentStageCfg[self.stageID_].background_1))
end

function EnchantmentSectionInfoView:RefreshBattleAffix()
	self.buff_ = getHeroAffixs(BattleEnchantmentStageCfg[self.stageID_].affix_type)
	self.debuff_ = BattleEnchantmentStageCfg[self.stageID_].affix_type_in_map == "" and getMosterAffix(BattleEnchantmentStageCfg[self.stageID_].affix_type) or BattleEnchantmentStageCfg[self.stageID_].affix_type_in_map

	if self.buff_ and self.buff_ ~= "" and self.buff_[1] then
		self.buffAffixText_.text = GetI18NText(getAffixName(self.buff_[1]))
		self.buffAffixImg_.sprite = getAffixSprite(self.buff_[1])
	else
		self.buffAffixText_.text = ""
		self.buffAffixImg_.sprite = nil
	end

	if self.debuff_ and self.debuff_ ~= "" and self.debuff_[1] then
		self.debuffAffixText_.text = GetI18NText(getAffixName(self.debuff_[1]))
		self.debuffAffixImg_.sprite = getAffixSprite(self.debuff_[1])
	else
		self.debuffAffixText_.text = ""
		self.debuffAffixImg_.sprite = nil
	end
end

function EnchantmentSectionInfoView:ShowAffixInfo(arg_13_1, arg_13_2)
	self.affixInfoTrs_:SetParent(arg_13_1)

	self.affixInfoTrs_.localPosition = Vector3(0, 0, 0)

	SetActive(self.affixInfoTrs_.gameObject, true)

	if arg_13_2 and arg_13_2 ~= "" then
		self.affixContentText_.text = GetI18NText(getAffixDesc(arg_13_2))
		self.affixTitleText_.text = GetI18NText(getAffixName(arg_13_2))
	else
		self.affixContentText_.text = ""
		self.affixTitleText_.text = ""
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.affixInfoTrs_)

	if self.countdownTimer_ then
		self.countdownTimer_:Stop()

		self.countdownTimer_ = nil
	end

	self.countdownTimer_ = Timer.New(function()
		if self.affixInfoTrs_ and self.affixInfoTrs_.gameObject then
			SetActive(self.affixInfoTrs_.gameObject, false)
		end
	end, 2, 1)

	self.countdownTimer_:Start()
end

function EnchantmentSectionInfoView:OnExit()
	EnchantmentSectionInfoView.super.OnExit(self)

	if self.countdownTimer_ then
		self.countdownTimer_:Stop()

		self.countdownTimer_ = nil
	end
end

return EnchantmentSectionInfoView
