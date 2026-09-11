local SectionStageInfoView = class("SectionStageInfoView", ReduxView)

function SectionStageInfoView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Show(true)
	self:BindCfgUI()
end

function SectionStageInfoView:SetData(arg_2_1)
	self.icon_.sprite = HeroTools.GetSkillAttributeIcon(arg_2_1)
end

function SectionStageInfoView:Show(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

return SectionStageInfoView
