local MatrixSelectAffixItem = class("MatrixSelectAffixItem", ReduxView)

function MatrixSelectAffixItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
	self:AddUIListener()
end

function MatrixSelectAffixItem:initUI()
	self:BindCfgUI()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
end

function MatrixSelectAffixItem:AddUIListener()
	self:AddBtnListener(self.m_clickBtn, nil, function()
		if self.clickFunc then
			self.clickFunc(self.id)
		end
	end)
end

function MatrixSelectAffixItem:Refresh(arg_5_1, arg_5_2)
	self.id = arg_5_1

	self.selectController_:SetSelectedIndex(arg_5_2)

	self.m_name.text = ({
		"Ⅰ",
		"Ⅱ",
		"Ⅲ",
		"Ⅳ",
		"Ⅴ",
		"Ⅵ",
		"Ⅶ",
		"Ⅷ",
		"Ⅸ"
	})[ActivityAffixPoolCfg[self.id].affix[2]]
	self.m_icon.sprite = getAffixSprite(ActivityAffixPoolCfg[self.id].affix)
end

function MatrixSelectAffixItem:RegistCallBack(arg_6_1)
	self.clickFunc = arg_6_1
end

return MatrixSelectAffixItem
