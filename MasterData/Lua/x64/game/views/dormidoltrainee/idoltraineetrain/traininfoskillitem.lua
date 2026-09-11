local TrainInfoSkillItem = class("TrainInfoSkillItem", ReduxView)

function TrainInfoSkillItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.lockController_ = self.mainControllerEx_:GetController("lock")
end

function TrainInfoSkillItem:SetData(arg_2_1, arg_2_2)
	self.name_.text = IdolTraineeSkillCfg[arg_2_1.skill].name
	self.desc_.text = IdolTraineeTools:GetSkillDescString(arg_2_1.skill)
	self.icon_.sprite = IdolTraineeTools:GetSkillIcon(arg_2_1.skill)
	self.typeText_.text = GetTips("IDOL_DANCE_SKILL_TYPE_TIPS_" .. IdolTraineeSkillCfg[arg_2_1.skill].type)

	local var_2_0 = arg_2_1.property or 0

	self.lockText_.text = string.format(GetTips("IDOL_DANCE_SKILL_UNLOCK_TIPS"), arg_2_2, var_2_0)

	if var_2_0 <= arg_2_2 then
		self.lockController_:SetSelectedState("normal")
	else
		self.lockController_:SetSelectedState("lock")
	end
end

function TrainInfoSkillItem:Dispose()
	TrainInfoSkillItem.super.Dispose(self)
end

return TrainInfoSkillItem
