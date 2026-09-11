local SectionTargetItem = class("SectionTargetItem", ReduxView)

function SectionTargetItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.controllerEx_ = self.controllerEx_:GetController("clear")
end

function SectionTargetItem:Refresh(arg_2_1, arg_2_2)
	if arg_2_1 then
		self.controllerEx_:SetSelectedState("state1")
	else
		self.controllerEx_:SetSelectedState("state0")
	end

	if arg_2_2 then
		self.targetText_.text = BattleInstance.GetStarMissionText(arg_2_2[1], arg_2_2[2], arg_2_2[3])

		SetActive(self.gameObject_, true)
	else
		SetActive(self.gameObject_, false)
	end
end

return SectionTargetItem
