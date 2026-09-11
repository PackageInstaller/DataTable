local SkinDrawProbabilityItem = class("SkinDrawProbabilityItem", ReduxView)

function SkinDrawProbabilityItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function SkinDrawProbabilityItem:RefreshData(arg_2_1)
	self:Show(true)
end

function SkinDrawProbabilityItem:Show(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

return SkinDrawProbabilityItem
