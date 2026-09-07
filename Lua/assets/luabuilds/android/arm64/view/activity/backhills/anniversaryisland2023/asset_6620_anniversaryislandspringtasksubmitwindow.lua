local AnniversaryIslandSpringTaskSubmitWindow = class("AnniversaryIslandSpringTaskSubmitWindow", import("view.base.BaseUI"))

function AnniversaryIslandSpringTaskSubmitWindow:getUIName()
	return "AnniversaryIslandSpringTaskSubmitWindow"
end

function AnniversaryIslandSpringTaskSubmitWindow:init()
	setText(self._tf:Find("Content/Tips"), i18n("sub_item_warning"))

	return
end

function AnniversaryIslandSpringTaskSubmitWindow:didEnter()
	onButton(self, self._tf:Find("BG"), function()
		self:onBackPressed()

		return
	end)
	onButton(self, self._tf:Find("Content/Cancel"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("Content/Submit"), function()
		self:emit(AnniversaryIslandSpringTask2023Mediator.SUBMIT_TASK)

		return
	end, SFX_CONFIRM)

	local var_3_0 = {
		{
			type = tonumber(self.contextData.task:getConfig("target_id")),
			id = tonumber(self.contextData.task:getConfig("target_id_2")),
			count = self.contextData.task:getConfig("target_num")
		}
	}

	UIItemList.StaticAlign(self._tf:Find("Content/Icons"), self._tf:Find("Content/Icons"):GetChild(0), #var_3_0, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_7_0 = var_3_0[arg_7_1 + 1]

		updateDrop(arg_7_2:Find("Mask/IconTpl"), var_3_0[arg_7_1 + 1])
		onButton(self, arg_7_2, function()
			if var_7_0.type == DROP_TYPE_WORKBENCH_DROP then
				self:emit(WorkBenchItemDetailMediator.SHOW_DETAIL, WorkBenchItem.New({
					configId = var_7_0.id,
					count = var_7_0.count
				}))
			else
				self:emit(BaseUI.ON_DROP, var_7_0)
			end

			return
		end)

		return
	end)

	return
end

function AnniversaryIslandSpringTaskSubmitWindow:willExit()
	return
end

return AnniversaryIslandSpringTaskSubmitWindow
