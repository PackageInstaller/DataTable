local DALptPage = class("DALptPage", import("view.activity.CorePage.CorePageNewPtTemplatePage"))

function DALptPage:UpdateAward(arg_1_1, arg_1_2)
	local var_1_0 = self.awardList[arg_1_1 + 1].drop

	updateDrop(arg_1_2:Find("icon"), self.awardList[arg_1_1 + 1].drop)
	setText(arg_1_2:Find("pt"), self.awardList[arg_1_1 + 1].target)

	local var_1_1 = arg_1_1 + 1 <= self.ptData:GetLevel()
	local var_1_2 = not var_1_1 and arg_1_1 + 1 <= self.ptData:GetMaxAvailableTargetIndex()
	local var_1_3 = not var_1_1 and not var_1_2

	setActive(arg_1_2:Find("got"), var_1_1)
	setActive(arg_1_2:Find("get"), var_1_2)
	setActive(arg_1_2:Find("lock"), not var_1_3)
	setActive(arg_1_2:Find("lock/lock"), var_1_3)
	onButton(self, arg_1_2, function()
		self:emit(BaseUI.ON_DROP, var_1_0)

		return
	end, SFX_PANEL)

	return
end

return DALptPage
