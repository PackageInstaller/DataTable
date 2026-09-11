local AdvanceTest4AffixCurSelectItem = class("AdvanceTest4AffixCurSelectItem", ReduxView)

function AdvanceTest4AffixCurSelectItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AdvanceTest4AffixCurSelectItem:Init()
	self:BindCfgUI()

	self.bufftypeController_ = self.affixController_:GetController("category")
end

function AdvanceTest4AffixCurSelectItem:SetData(arg_3_1, arg_3_2, arg_3_3)
	self.icon.sprite = getAffixSprite(ActivityAffixPoolCfg[arg_3_2].affix)

	self.bufftypeController_:SetSelectedIndex(arg_3_3)
end

return AdvanceTest4AffixCurSelectItem
