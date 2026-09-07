local FuboLoginPage = class("FuboLoginPage", import(".TemplatePage.LoginTemplatePage"))

function FuboLoginPage:OnFirstFlush()
	setActive(self.item, false)
	self.itemList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			local var_2_0 = Drop.Create(self.config.front_drops[arg_2_1 + 1])

			updateDrop(arg_2_2:Find("container/item"), var_2_0)
			onButton(self, arg_2_2, function()
				self:emit(BaseUI.ON_DROP, var_2_0)

				return
			end, SFX_PANEL)

			local var_2_1 = arg_2_2:Find("got")

			arg_2_2:Find("container"):GetComponent(typeof(CanvasGroup)).alpha = arg_2_1 < self.nday and 0.5 or 1

			setActive(var_2_1, arg_2_1 < self.nday)
		end

		return
	end)

	return
end

return FuboLoginPage
