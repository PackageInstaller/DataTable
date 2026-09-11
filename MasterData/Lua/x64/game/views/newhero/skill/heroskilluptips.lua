local HeroSkillUpTips = class("HeroSkillUpTips", ReduxView)

function HeroSkillUpTips:UIName()
	return "Widget/System/Hero_skill/HeroSkillPopUI"
end

function HeroSkillUpTips:UIParent()
	return manager.ui.uiPop.transform
end

function HeroSkillUpTips:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroSkillUpTips:InitUI()
	self:BindCfgUI()

	self.costItemList = {}
	self.titleController = self.transCon_:GetController("title")
	self.btnController = self.transCon_:GetController("btnState")
	self.stateController = self.stateCon_:GetController("state")
	self.jumpController = self.jumpCon_:GetController("jump")
end

function HeroSkillUpTips:AddUIListener()
	self:AddBtnListener(self.fullscreenBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.btn_noBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.btn_yesBtn_, nil, function()
		if self.isAttr then
			HeroAction.HeroSkillAttrUpgrade(self.heroId, SkillTools.GetSkillIdIndex(self.skillId), self.targetLevel - self.nowLv)
		else
			HeroAction.HeroSkillUpgrade(self.heroId, self.skillId, self.targetLevel - self.nowLv)
		end

		JumpTools.Back()
	end)
	self:AddBtnListener(self.subBtn_, nil, function()
		self.slider_.value = self.targetLevel - 1
	end)
	self:AddBtnListener(self.addBtn_, nil, function()
		self.slider_.value = self.targetLevel + 1
	end)
	self:AddBtnListener(self.goUpgradeBtn_, nil, function()
		JumpTools.OpenPageByJump("/heroUpgrade", {
			heroId = self.heroId,
			proxy = self.heroViewDataProxy
		})
	end)
end

function HeroSkillUpTips:OnEnter()
	self:InitData()

	if self.nowLv < self.maxLevel then
		self:RefreshState((self:CheckMaxUpLv(self.skillId, self.targetLevel)))
		self:RefreshUI()
	end
end

function HeroSkillUpTips:OnTop()
	if self.nowLv >= self.maxLevel then
		JumpTools.Back()
	end
end

function HeroSkillUpTips:InitData()
	self.heroViewDataProxy = self.params_.proxy
	self.skillId = self.params_.skillId
	self.heroId = self.params_.heroId
	self.isAttr = self.params_.isAttr or false
	self.skillIndex = SkillTools.GetSkillIdIndex(self.skillId)

	if self.isAttr then
		self.nowLv = self.heroViewDataProxy:GetSkillAttrLv(self.heroId, self.skillIndex) or self.heroViewDataProxy:GetSkillLv(self.heroId, self.skillId)
	end

	self.maxUpLv = self.isAttr and SkillTools.GetSkillAttrMaxUpLv(self.skillId, self.nowLv) or SkillTools.GetSkillMaxUpLv(self.skillId, self.nowLv)
	self.minLevel = self.nowLv + 1

	if self.isAttr then
		self.maxLevel = HeroConst.MAX_SKILL_ATTR_LEVEL or HeroConst.MAX_SKILL_LEVEL
	end

	self.targetLevel = math.max(self.minLevel, self.maxUpLv)

	self:InitSlider()
end

function HeroSkillUpTips:InitSlider()
	self.slider_.minValue = self.nowLv
	self.slider_.maxValue = self.maxLevel
	self.slider_.value = self.targetLevel

	if self.maxLevel - self.nowLv <= 1 then
		self.subBtn_.interactable = false
		self.addBtn_.interactable = false
	else
		self.subBtn_.interactable = self.targetLevel > self.minLevel
		self.addBtn_.interactable = self.targetLevel < self.maxLevel
	end

	self.slider_.onValueChanged:AddListener(function(arg_16_0)
		self.subBtn_.interactable = arg_16_0 > self.minLevel
		self.addBtn_.interactable = arg_16_0 < self.maxLevel

		if arg_16_0 < self.minLevel then
			self.slider_.value = self.minLevel
		else
			self:OnTargetLevelChange(arg_16_0)
		end
	end)
end

function HeroSkillUpTips:RefreshUI()
	self.leftLvTxt_.text = self.nowLv
	self.rightLvTxt_.text = self.targetLevel

	self.titleController:SetSelectedState(tostring(self.isAttr))

	for iter_17_0, iter_17_1 in pairs(self.costItemList or {}) do
		iter_17_1.gameObject_:SetActive(false)
	end

	self:CaculateMaterial()

	for iter_17_2, iter_17_3 in pairs(self.costDataList) do
		local var_17_0 = self.costItemList[iter_17_2]

		if not self.costItemList[iter_17_2] then
			var_17_0 = self:CreateCostItem()
			self.costItemList[iter_17_2] = var_17_0
		end

		var_17_0.gameObject_:SetActive(true)

		local var_17_1 = clone(ItemTemplateData)

		var_17_1.id = iter_17_3.id

		function var_17_1:clickFun()
			ShowPopItem(POP_SOURCE_ITEM, {
				self.id,
				self.number
			})
		end

		local var_17_2 = ItemTools.getItemNum(iter_17_3.id)

		var_17_0:SetData(var_17_1)
		var_17_0:RefreshBottomText({
			var_17_2,
			iter_17_3.num
		})
		var_17_0:RefreshBottomRightText(true)
	end
end

function HeroSkillUpTips:CreateCostItem()
	return CommonItemView.New((GameObject.Instantiate(self.commonitemGo_, self.rewardpanelTrs_)))
end

function HeroSkillUpTips:OnTargetLevelChange(arg_20_1)
	if self.targetLevel == arg_20_1 then
		return
	end

	self.targetLevel = arg_20_1

	self:RefreshState((self:CheckMaxUpLv(self.skillId, arg_20_1)))
	self:RefreshUI()
end

function HeroSkillUpTips:CheckMaxUpLv(arg_21_1, arg_21_2)
	local var_21_0 = HeroData:GetHeroData((SkillTools.GetMainHeroId(arg_21_1)))
	local var_21_1 = SkillTools.GetSkillIdIndex(arg_21_1)
	local var_21_2 = {}
	local var_21_3 = {}

	for iter_21_0 = self.nowLv + 1, arg_21_2 do
		local var_21_4

		if self.isAttr then
			local var_21_5 = SkillTools.GetSkillAttrCfg(var_21_0.id, var_21_1, iter_21_0)

			var_21_4 = var_21_5 and var_21_5.cost or nil
		else
			var_21_4 = SkillCfg[iter_21_0 - 1]["skill_cost" .. var_21_1]

			if SkillCfg[iter_21_0 - 1]["skill_limit" .. var_21_1] > var_21_0.break_level then
				var_21_2.heroUpgradeLack = true
				var_21_2.needUpgradeTimes = SkillCfg[iter_21_0 - 1]["skill_limit" .. var_21_1]
				var_21_2.nowUpgradeTimes = var_21_0.break_level
			end
		end

		for iter_21_1, iter_21_2 in pairs(var_21_4) do
			local var_21_6 = var_21_3[iter_21_2[1]]

			if not var_21_3[iter_21_2[1]] then
				var_21_6 = ItemTools.getItemNum(iter_21_2[1])
				var_21_3[iter_21_2[1]] = var_21_6
			end

			if var_21_6 < iter_21_2[2] then
				var_21_2.materialLack = true

				break
			end

			var_21_3[iter_21_2[1]] = var_21_3[iter_21_2[1]] - iter_21_2[2]
		end

		if var_21_2.materialLack then
			break
		end
	end

	return var_21_2
end

function HeroSkillUpTips:RefreshState(arg_22_1)
	local var_22_0 = not arg_22_1.heroUpgradeLack and not arg_22_1.materialLack

	self.jumpController:SetSelectedState(arg_22_1.heroUpgradeLack and "show" or "hide")
	self.stateController:SetSelectedState(var_22_0 and "normal" or "lack")

	if arg_22_1.heroUpgradeLack then
		self.conditionText_.text = string.format(GetTips("NOTE_SKILL_LIMIT"), arg_22_1.needUpgradeTimes) .. string.format("(%s/%s)", arg_22_1.nowUpgradeTimes, arg_22_1.needUpgradeTimes)
	elseif arg_22_1.materialLack then
		self.conditionText_.text = self.isAttr and GetTips("ERROR_HERO_NO_SKILL_ENHANCE_UP_MAT") or GetTips("ERROR_HERO_NO_SKILL_UP_MAT")
	elseif var_22_0 then
		self.stateController:SetSelectedState("normal")

		self.middleText_.text = string.format(GetTips("LEVELUP_DIFF"), self.targetLevel - self.nowLv)
	end

	self.btnController:SetSelectedState(tostring(var_22_0))
end

function HeroSkillUpTips:CaculateMaterial()
	self.costDataList = {}

	for iter_23_0, iter_23_1 in pairs(self.isAttr and SkillTools.GetSkillAttrUpCostNum(self.skillId, self.heroId, self.nowLv, self.targetLevel - self.nowLv) or SkillTools.GetSkillUpCostNum(self.skillId, self.nowLv, self.targetLevel - self.nowLv)) do
		table.insert(self.costDataList, {
			id = iter_23_0,
			num = iter_23_1
		})
	end
end

function HeroSkillUpTips:OnExit()
	self.slider_.onValueChanged:RemoveAllListeners()
end

function HeroSkillUpTips:Dispose()
	for iter_25_0, iter_25_1 in pairs(self.costItemList or {}) do
		if iter_25_1 then
			iter_25_1:Dispose()
		end
	end

	HeroSkillUpTips.super.Dispose(self)
end

return HeroSkillUpTips
