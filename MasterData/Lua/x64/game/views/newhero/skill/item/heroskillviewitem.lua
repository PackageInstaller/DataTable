local HeroSkillViewItem = class("HeroSkillViewItem", ReduxView)
local var_0_1 = {
	selectState = {
		select = "true",
		name = "selectState",
		normal = "false"
	},
	upState = {
		up = "true",
		name = "upState",
		normal = "false"
	},
	nameAddState = {
		name = "nameAdd",
		add = "true",
		normal = "false"
	}
}

function HeroSkillViewItem:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:InitUI()
	self:Init()
	self:InitController()
end

function HeroSkillViewItem:Init()
	return
end

function HeroSkillViewItem:InitController()
	self.selectController_ = self.controllerEx_:GetController(var_0_1.selectState.name)
	self.upController_ = self.controllerEx_:GetController(var_0_1.upState.name)
	self.addController_ = self.controllerEx_:GetController(var_0_1.nameAddState.name)
end

function HeroSkillViewItem:InitUI()
	self:BindCfgUI()
	self:AddBtnListener(nil, nil, "OnClick")
end

function HeroSkillViewItem:RefreshData(arg_5_1, arg_5_2)
	self.info = arg_5_1

	if self.upController_ then
		if not self.heroViewDataProxy:CheckIsSelf() then
			self.upController_:SetSelectedState(var_0_1.upState.normal)
		else
			local var_5_0 = arg_5_1.isCanStarUp or arg_5_1.isCanAttrUp

			if arg_5_2 and arg_5_2 == 1 then
				var_5_0 = arg_5_1.isCanStarUp
			elseif arg_5_2 and arg_5_2 == 2 then
				local var_5_1

				if arg_5_1.isCanAttrUp then
					var_5_1 = var_0_1.upState.up or var_0_1.upState.normal
				end
			end

			self.upController_:SetSelectedState(var_5_1)
		end
	end

	if self.selectController_ then
		self:UpdateSelectState(self.handler_.selectSkillId == arg_5_1.id)
	end

	self:RefreshUI(arg_5_1)
end

function HeroSkillViewItem:UpdateSelectState(arg_6_1)
	if self.selectController_ then
		self.selectController_:SetSelectedState((arg_6_1 or nil) and (var_0_1.selectState.select or var_0_1.selectState.normal))
	end
end

function HeroSkillViewItem:SetProxy(arg_7_1)
	self.heroViewDataProxy = arg_7_1
end

function HeroSkillViewItem:RefreshUI(arg_8_1)
	if arg_8_1 then
		local var_8_0 = self.heroViewDataProxy:GetRealSkillId(arg_8_1.heroId, arg_8_1.id)
		local var_8_1 = table.indexof(HeroCfg[arg_8_1.heroId].skills, arg_8_1.id)

		self.skilliconImg_.sprite = getSprite("Atlas/" .. arg_8_1.heroId, var_8_0)
		self.nameText_.text = HeroCfg[arg_8_1.heroId].skill_subhead[var_8_1]

		self:RefreshLv(arg_8_1)

		if self.sliderSlr_ then
			self.sliderSlr_.value = self.heroViewDataProxy:GetSkillAtrrProgressValue(arg_8_1.heroId, var_8_1)
		end
	end
end

function HeroSkillViewItem:SetShowAdd(arg_9_1)
	self.showAdd_ = arg_9_1
end

function HeroSkillViewItem:RefreshLv(arg_10_1)
	if self.lvText_ then
		local var_10_1 = self.heroViewDataProxy:GetSkillLv(arg_10_1.heroId, arg_10_1.id) + (arg_10_1.tempAddLevel or 0)
		local var_10_2 = arg_10_1.addEquipSkillLv or 0

		if self.showAdd_ then
			self.lvText_.text = (var_10_2 > 0 or arg_10_1.addSkillLv > 0) and string.format("%d<color=#E78300>+%d</color>", var_10_1, arg_10_1.addSkillLv + var_10_2) or string.format("%d", var_10_1)
		elseif var_10_2 > 0 or arg_10_1.addSkillLv > 0 then
			self.lvText_.text = string.format("<color=#E78300>%d</color>", var_10_1 + arg_10_1.addSkillLv + var_10_2)
		end

		self.lvText_.text = string.format("%d", var_10_1 + arg_10_1.addSkillLv + var_10_2)

		self.addController_:SetSelectedState((var_10_2 > 0 or nil) and (var_0_1.nameAddState.add or var_0_1.nameAddState.normal))
	end
end

function HeroSkillViewItem:RegistCallBack(arg_11_1)
	self.clickFunc = arg_11_1
end

function HeroSkillViewItem:OnClick()
	if self.clickFunc then
		self.clickFunc(self.info)
	end
end

function HeroSkillViewItem:SetAniState(arg_13_1)
	if self.animator_ then
		self.animator_.enabled = arg_13_1
	end
end

function HeroSkillViewItem:Dispose()
	self:RemoveAllListeners()
	HeroSkillViewItem.super.Dispose(self)
end

return HeroSkillViewItem
