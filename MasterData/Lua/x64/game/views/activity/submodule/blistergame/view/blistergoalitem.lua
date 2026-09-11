local BlisterGoalItem = class("BlisterGoalItem", ReduxView)

function BlisterGoalItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.starController_ = self.ndnum01Controllerexcollection_:GetController("star")
end

function BlisterGoalItem:SetData(arg_2_1, arg_2_2)
	self.starController_:SetSelectedState(arg_2_1 and "on" or "off")

	self.textmeettermsText_.text = string.format(GetTips("BLISTER_TASK_DES1"), arg_2_2)
end

function BlisterGoalItem:Dispose()
	BlisterGoalItem.super.Dispose(self)
end

return BlisterGoalItem
