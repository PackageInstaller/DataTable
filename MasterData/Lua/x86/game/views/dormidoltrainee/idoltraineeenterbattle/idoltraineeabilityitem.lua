local IdolTraineeAbilityItem = class("IdolTraineeAbilityItem", ReduxView)

function IdolTraineeAbilityItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function IdolTraineeAbilityItem:SetData(arg_2_1)
	self.value_.text = arg_2_1
end

function IdolTraineeAbilityItem:Dispose()
	IdolTraineeAbilityItem.super.Dispose(self)
end

return IdolTraineeAbilityItem
