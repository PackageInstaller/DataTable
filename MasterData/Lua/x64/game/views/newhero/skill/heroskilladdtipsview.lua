local HeroSkillAddTipsView = class("HeroSkillAddTipsView", ReduxView)
local var_0_1 = {
	[HeroConst.HERO_SKILL_ADD_TYPE.WEAPONMODULE] = 1,
	[HeroConst.HERO_SKILL_ADD_TYPE.ASTROLABE] = 2,
	[HeroConst.HERO_SKILL_ADD_TYPE.WEAPONSERVANT] = 3,
	[HeroConst.HERO_SKILL_ADD_TYPE.ATTRIBUTE] = 4
}
local var_0_2 = {
	empty = "empty",
	noEmpty = "noEmpty"
}

function HeroSkillAddTipsView:UIName()
	return "Widget/System/Hero_skill/HeroSkillTipUI"
end

function HeroSkillAddTipsView:UIParent()
	return manager.ui.uiPop.transform
end

function HeroSkillAddTipsView:Init()
	self:InitUI()
	self:AddUIListener()
	self:SetInfoIsShow(false)
end

function HeroSkillAddTipsView:InitUI()
	self:BindCfgUI()

	self.emptyController = self.controllerexcollection_:GetController("empty")
	self.textItemList = {}
end

function HeroSkillAddTipsView:OnEnter()
	self.backBtnCallback = self.params_.backBtnCallback

	self:RefreshUi(self.params_)
end

function HeroSkillAddTipsView:OnHeroSkillAddViewUpdate(arg_6_1)
	self:RefreshUi(arg_6_1)
end

function HeroSkillAddTipsView:RefreshUi(arg_7_1)
	self.showType = arg_7_1.showType
	self.showTextList = arg_7_1.showTextList
	self.heroId = arg_7_1.heroId

	self:SetDataAndShow(self.showType, self.showTextList)
end

function HeroSkillAddTipsView:SetBackBtnCallback(arg_8_1)
	self.backBtnCallback = arg_8_1
end

function HeroSkillAddTipsView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:SetInfoIsShow(false)

		if self.backBtnCallback then
			self.backBtnCallback()
		end

		JumpTools.Back()
	end)
	self:AddBtnListener(self.gobtnBtn_, nil, function()
		self:OnGoBtn()
	end)
end

function HeroSkillAddTipsView:OnGoBtn()
	if self.showType == HeroConst.HERO_SKILL_ADD_TYPE.WEAPONSERVANT then
		if self.params_.dataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
			JumpTools.GoToSystem("/polyhedronHero", {
				isEnter = true,
				pageIndex = 3,
				hid = self.heroId,
				type = HeroConst.HERO_DATA_TYPE.POLYHEDRON
			})
		else
			JumpTools.GoToSystem("/newHero", {
				isEnter = true,
				pageIndex = 3,
				hid = self.heroId,
				type = HeroConst.HERO_DATA_TYPE.DEFAULT
			})
		end
	elseif self.showType == HeroConst.HERO_SKILL_ADD_TYPE.WEAPONMODULE then
		JumpTools.Back()
		JumpTools.OpenPageByJump("/weaponModuleView", {
			heroID = self.heroId
		})
	elseif self.showType == HeroConst.HERO_SKILL_ADD_TYPE.ASTROLABE then
		if self.params_.dataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
			JumpTools.GoToSystem("/polyhedronHero", {
				isEnter = true,
				pageIndex = 6,
				hid = self.heroId,
				type = HeroConst.HERO_DATA_TYPE.POLYHEDRON
			})
		else
			JumpTools.GoToSystem("/newHero", {
				isEnter = true,
				pageIndex = 6,
				hid = self.heroId,
				type = HeroConst.HERO_DATA_TYPE.DEFAULT
			})
		end
	elseif self.showType == HeroConst.HERO_SKILL_ADD_TYPE.ATTRIBUTE then
		local var_12_0 = gameContext:GetOpenPageHandler("skillView")

		if var_12_0 then
			JumpTools.Back()
			var_12_0:ChangeTab(2)
		end
	end
end

function HeroSkillAddTipsView:SetInfoIsShow(arg_13_1)
	self.isShow_ = arg_13_1

	if not self.timer_ then
		self.timer_ = Timer.New(function()
			SetActive(self.gameObject_, self.isShow_)

			self.timer_ = nil
		end, 0.034, 1)

		self.timer_:Start()
	end
end

function HeroSkillAddTipsView:CreateItem(arg_15_1)
	local var_15_0 = HeroSkillAddTipsItem.New((GameObject.Instantiate(self.skillitemGo_, self.contentTrs_)))

	self.textItemList[arg_15_1] = var_15_0

	return var_15_0
end

function HeroSkillAddTipsView:SetDataAndShow(arg_16_1, arg_16_2)
	self:SetInfoIsShow(true)

	for iter_16_0, iter_16_1 in pairs(arg_16_2) do
		if not self.textItemList[iter_16_0] then
			-- block empty
		end

		self:CreateItem(iter_16_0):RefreshUI(iter_16_1)
	end

	for iter_16_2 = #arg_16_2 + 1, #self.textItemList do
		if self.textItemList[iter_16_2] then
			SetActive(self.textItemList[iter_16_2].gameObject_, false)
		end
	end

	if var_0_1[arg_16_1] then
		self.titleText_.text = GetTips("Skill_Effect" .. var_0_1[arg_16_1])
	end

	self.emptyController:SetSelectedState((#arg_16_2 > 0 or nil) and (var_0_2.noEmpty or var_0_2.empty))
end

function HeroSkillAddTipsView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function HeroSkillAddTipsView:Dispose()
	for iter_18_0, iter_18_1 in pairs(self.textItemList) do
		iter_18_1:Dispose()
	end

	HeroSkillAddTipsView.super.Dispose(self)
end

return HeroSkillAddTipsView
