local GoldMinerSectionTargetItem = class("GoldMinerSectionTargetItem", ReduxView)

function GoldMinerSectionTargetItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.controllerEx_ = self.controllerEx_:GetController("clear")
end

function GoldMinerSectionTargetItem:Refresh(arg_2_1, arg_2_2, arg_2_3)
	if arg_2_1 then
		self.controllerEx_:SetSelectedState("state1")
	else
		self.controllerEx_:SetSelectedState("state0")
	end

	if arg_2_2 then
		self.needText_.text = arg_2_3
		self.targetText_.text = string.format(GetTips("GOLDMINER_STAGE_POINT_NEED"), arg_2_2)

		SetActive(self.gameObject_, true)
	else
		SetActive(self.gameObject_, false)
	end
end

return GoldMinerSectionTargetItem
