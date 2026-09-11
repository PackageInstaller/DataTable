local HeroSkillPropertyView = class("HeroSkillPropertyView", HeroPageBase)
local var_0_1 = {
	showState = {
		max = "max",
		up = "up",
		notup = "notup",
		none = "none"
	}
}

function HeroSkillPropertyView:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function HeroSkillPropertyView:Init()
	self:BindCfgUI()
	self:CreateCostList()
	self:AddUIListener()

	self.stateController_ = self.controllerexcollection_:GetController("state")
end

function HeroSkillPropertyView:CreateCostList()
	self.costItem = {}

	for iter_3_0 = 1, 4 do
		self.costItem[iter_3_0] = CommonItemView.New(self["costitem" .. iter_3_0 .. "Go_"])
	end

	self.attrItemList = {}

	for iter_3_1 = 1, 4 do
		self.attrItemList[iter_3_1] = HeroSkillAttrItem.New(self["attr" .. iter_3_1 .. "Go_"])
	end
end

function HeroSkillPropertyView:AddUIListener()
	self:AddPressingByTimeListener(self.upbtnBtn_.gameObject, 1.4, 0.2, 0.1, function()
		if not self:isCanUpSkill() or self.level + self.tempAddLevel_ == HeroConst.MAX_SKILL_ATTR_LEVEL then
			self:SendSkillAttrUpgrade()

			return false
		end

		if not self.costEnough then
			self:SendSkillAttrUpgrade()
			ShowTips("ERROR_HERO_NO_SKILL_ENHANCE_UP_MAT")

			return false
		end

		self.tempAddLevel_ = (self.tempAddLevel_ or 0) + 1

		self:SendSkillAttrUpgrade()
		self:RefreshUi()

		return true
	end, handler(self, self.SendSkillAttrUpgrade))
	self:AddBtnListener(self.limitBtn_, nil, function()
		ShowTips("NOTE_SKILL_ATTR_LIMIT")
	end)
	self:AddBtnListener(self.oneKeyUpBtn_, nil, function()
		self:OnOneKeyUpBtn()
	end)
end

function HeroSkillPropertyView:OnOneKeyUpBtn()
	if SkillTools.GetSkillAttrMaxUpLv(self.skillId, self.level) == self.level then
		ShowTips("ERROR_HERO_NO_SKILL_ENHANCE_UP_MAT")
	else
		JumpTools.OpenPageByJump("skillUpTip", {
			isAttr = true,
			proxy = self.heroViewDataProxy,
			heroId = self.heroId,
			skillId = self.skillId
		})
	end
end

function HeroSkillPropertyView:isCanUpSkill()
	if SkillTools.GetIsDodgeSkill(self.skillId) or not self.nextAttrCfg then
		return false
	end

	return true
end

function HeroSkillPropertyView:SendSkillAttrUpgrade()
	if self.tempAddLevel_ and self.tempAddLevel_ > 0 then
		HeroAction.HeroSkillAttrUpgrade(self.heroId, self.skillIndex, self.tempAddLevel_)
	end
end

function HeroSkillPropertyView:OnHeroSkillAttrUpgradeInView(arg_11_1, arg_11_2)
	if isSuccess(arg_11_1.result) then
		ShowTips("SKILL_ATTR_UPGRATE_SUCCESS", string.format("LEVEL\n<size=60>%s</size>", self.level))
		SetActive(self.lvbgGo_, false)
		SetActive(self.lvbgGo_, true)
		self.switchIconAnimator_:Play("Fx_right_huan_change", -1, 0)
	else
		ShowTips(arg_11_1.result)
	end

	self.tempAddLevel_ = 0

	self:RefreshUi()
end

function HeroSkillPropertyView:UpdatePropertyData(arg_12_1, arg_12_2)
	self:InitData(arg_12_1)

	if arg_12_2 then
		self.switchIconAnimator_:Play("Fx_right_huan_change", -1, 0)
	end

	self.skilliconImg_.sprite = getSprite("Atlas/" .. self.heroId, self.realSkillId)

	if SkillTools.GetIsDodgeSkill(self.skillId) then
		self:RefreshAttrList()
		self.stateController_:SetSelectedState(var_0_1.showState.none)
	else
		self:RefreshUi()
	end
end

function HeroSkillPropertyView:InitData(arg_13_1)
	self.skillId = arg_13_1.id
	self.heroId = arg_13_1.heroId
	self.realSkillId = self.heroViewDataProxy:GetRealSkillId(arg_13_1.heroId, arg_13_1.id)
	self.skillIndex = SkillTools.GetSkillIdIndex(arg_13_1.id)
end

function HeroSkillPropertyView:OnEnter(arg_14_1)
	self.heroViewDataProxy = arg_14_1
	self.tempAddLevel_ = 0
end

function HeroSkillPropertyView:RefreshUi()
	local var_15_0 = self.heroViewDataProxy:GetSkillAttrLv(self.heroId, self.skillIndex) + self.tempAddLevel_

	self.level = var_15_0
	self.attrCfg = SkillTools.GetSkillAttrCfg(self.heroId, self.skillIndex, var_15_0)
	self.nextAttrCfg = SkillTools.GetSkillAttrCfg(self.heroId, self.skillIndex, var_15_0 + 1)

	self:RefreshCost()
	self:RefreshAttrList()
	self:UpdateUpStateController()

	self.lvNowText_.text = self.level
	self.lvLaterText_.text = self.level + 1
	self.sliderSlr_.value = self.heroViewDataProxy:GetSkillAtrrProgressValue(self.heroId, self.skillIndex, self.level)
end

function HeroSkillPropertyView:UpdateUpStateController()
	if not self.heroViewDataProxy:CheckIsSelf() then
		self.stateController_:SetSelectedState(var_0_1.showState.none)

		return
	end

	if self:RefreshCondition() then
		self.stateController_:SetSelectedState(var_0_1.showState.notup)
	elseif not self.nextAttrCfg then
		self.stateController_:SetSelectedState(var_0_1.showState.max)
	else
		self.stateController_:SetSelectedState(var_0_1.showState.up)
	end
end

function HeroSkillPropertyView:RefreshCondition()
	local var_17_1 = self.heroViewDataProxy:GetHeroData(self.heroId)
	local var_17_2 = self.heroViewDataProxy:GetSkillLv(self.heroId, self.skillId)
	local var_17_3 = false

	if var_17_2 < HeroConst.MAX_SKILL_LEVEL then
		self.conditiondescireText_.text = GetTips("NOTE_SKILL_ATTR_LIMIT")
		self.conditionvalueText_.text = string.format("%s/%s", var_17_2, HeroConst.MAX_SKILL_LEVEL)
		var_17_3 = true
	end

	return var_17_3
end

function HeroSkillPropertyView:RefreshCost()
	if self.nextAttrCfg then
		self.costCfg = self.nextAttrCfg.cost or nil
	end

	self.costEnough = true

	for iter_18_0 = 1, 4 do
		if self.costCfg and self.costCfg[iter_18_0] then
			self.costItem[iter_18_0].gameObject_:SetActive(true)

			local var_18_0 = ItemTools.getItemNum(self.costCfg[iter_18_0][1])
			local var_18_1 = clone(ItemTemplateData)

			var_18_1.id = self.costCfg[iter_18_0][1]
			var_18_1.number = self.costCfg[iter_18_0][2]

			function var_18_1:clickFun()
				ShowPopItem(POP_SOURCE_ITEM, {
					self.id,
					self.number
				})
			end

			self.costItem[iter_18_0]:SetData(var_18_1)
			self.costItem[iter_18_0]:RefreshBottomText({
				var_18_0,
				self.costCfg[iter_18_0][2]
			})
			self.costItem[iter_18_0]:RefreshBottomRightText(true)

			if var_18_0 < self.costCfg[iter_18_0][2] then
				self.costEnough = false
			end
		else
			self.costItem[iter_18_0].gameObject_:SetActive(false)
		end
	end
end

function HeroSkillPropertyView:RefreshAttrList()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in pairs((self:GetAttrDataList(self:GetAttrDataList({}, true), false))) do
		table.insert(var_20_0, iter_20_1)
	end

	table.sort(var_20_0, function(arg_21_0, arg_21_1)
		return arg_21_0.attrType < arg_21_1.attrType
	end)

	for iter_20_2, iter_20_3 in pairs(self.attrItemList) do
		if var_20_0[iter_20_2] then
			SetActive(iter_20_3.gameObject_, true)
			iter_20_3:RefreshUI(var_20_0[iter_20_2], self.heroViewDataProxy:CheckIsSelf())
		else
			SetActive(iter_20_3.gameObject_, false)
		end
	end
end

function HeroSkillPropertyView:GetAttrDataList(arg_22_1, arg_22_2)
	local var_22_0 = arg_22_2 and self.attrCfg or self.nextAttrCfg

	if var_22_0 then
		for iter_22_0, iter_22_1 in pairs(var_22_0.attr) do
			if not arg_22_1[iter_22_1[1]] then
				arg_22_1[iter_22_1[1]] = {}
				arg_22_1[iter_22_1[1]].nowValue = 0
				arg_22_1[iter_22_1[1]].nextValue = 0
				arg_22_1[iter_22_1[1]].attrType = iter_22_1[1]
			end

			if arg_22_2 then
				arg_22_1[iter_22_1[1]].nowValue = iter_22_1[2]
			else
				arg_22_1[iter_22_1[1]].nextValue = iter_22_1[2]
			end
		end
	end

	return arg_22_1
end

function HeroSkillPropertyView:Dispose()
	for iter_23_0, iter_23_1 in pairs(self.attrItemList or {}) do
		if iter_23_1 then
			iter_23_1:Dispose()
		end
	end

	for iter_23_2, iter_23_3 in pairs(self.costItem or {}) do
		if iter_23_3 then
			iter_23_3:Dispose()
		end
	end

	HeroSkillPropertyView.super.Dispose(self)
end

return HeroSkillPropertyView
