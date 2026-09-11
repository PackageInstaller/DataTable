local AdvanceTest4AffixSelectItem = class("AdvanceTest4AffixSelectItem", ReduxView)

function AdvanceTest4AffixSelectItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AdvanceTest4AffixSelectItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdvanceTest4AffixSelectItem:InitUI()
	self:BindCfgUI()

	self.selController_ = self.controller:GetController("sel")
	self.lockController_ = self.controller:GetController("lock")
	self.bufftypeController_ = self.controller:GetController("bufftype")
	self.showtoogleController_ = self.controller:GetController("showtoogle")
	self.showTipsController_ = self.controller:GetController("showTips")
	self.pointbgController_ = self.controller:GetController("pointbg")
end

function AdvanceTest4AffixSelectItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc then
			self.clickFunc(self.index, self.state, self.buff_id)
		end
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		ShowTips("CORE_VERIFICATION_CL_BUFF_TIPS_2")
	end)
	self:AddBtnListener(self.selectBtn_, nil, function()
		if self.selectFunc then
			self.selectFunc(self.index, self.state)
		end
	end)
end

function AdvanceTest4AffixSelectItem:RefreshUI(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	self.index = arg_8_1
	self.state = arg_8_3
	self.buff_id = arg_8_2[1]
	self.point = arg_8_2[2]

	self.showtoogleController_:SetSelectedIndex(1)
	self.bufftypeController_:SetSelectedIndex(arg_8_3)

	self.affixData = ActivityAffixPoolCfg[self.buff_id].affix
	self.name.text = getAffixName(self.affixData)
	self.icon.sprite = getAffixSprite(self.affixData)

	if self.state == 1 then
		self.limitText_.text = ActivityAffixPoolCfg[self.buff_id].point
		self.limitText_2.text = ActivityAffixPoolCfg[self.buff_id].point

		self.pointbgController_:SetSelectedIndex(1)

		self.buffText_.text = "+" .. ActivityAffixPoolCfg[self.buff_id].point * 10 .. "%"
	else
		self.limitText_.text = ActivityAffixPoolCfg[self.buff_id].point
		self.limitText_2.text = ActivityAffixPoolCfg[self.buff_id].point

		self.pointbgController_:SetSelectedIndex(0)
	end

	if arg_8_4 then
		self.selController_:SetSelectedIndex(1)
	else
		self.selController_:SetSelectedIndex(0)
	end

	if arg_8_5 then
		self.showTipsController_:SetSelectedIndex(1)
	else
		self.showTipsController_:SetSelectedIndex(0)
	end
end

function AdvanceTest4AffixSelectItem:RefreshLock()
	self.lockController_:SetSelectedIndex(0)
end

function AdvanceTest4AffixSelectItem:RegisterClickListener(arg_10_1)
	self.clickFunc = arg_10_1
end

function AdvanceTest4AffixSelectItem:RegisterSelectListener(arg_11_1)
	self.selectFunc = arg_11_1
end

return AdvanceTest4AffixSelectItem
