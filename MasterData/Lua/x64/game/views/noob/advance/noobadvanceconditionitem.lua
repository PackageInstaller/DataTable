local NoobAdvanceConditionItem = class("NoobAdvanceConditionItem", ReduxView)

function NoobAdvanceConditionItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	SetActive(self.gameObject_, true)
	self:BindCfgUI()

	self.stateController_ = self.controllerExcollection_:GetController("complate")
end

function NoobAdvanceConditionItem:SetData(arg_2_1, arg_2_2, arg_2_3)
	if arg_2_1 == 1 then
		self.stateController_:SetSelectedState(tostring(TaskTools:IsCompletedAllNoobAdvanceTask(arg_2_2)))

		self.descText_.text = GetTips("NOOB_ADVANCE_TASK_CONDITION_COMPLETE")
	else
		local var_2_0 = NoobVersionCfg[ActivityNewbieTools:GetVersionID()].noob_advance_task_open[arg_2_3]

		self.stateController_:SetSelectedState(tostring(var_2_0 <= PlayerData:GetPlayerInfo().userLevel))

		self.descText_.text = string.format(GetTips("NOOB_ADVANCE_TASK_CONDITION_LEVEL"), var_2_0)
	end
end

return NoobAdvanceConditionItem
