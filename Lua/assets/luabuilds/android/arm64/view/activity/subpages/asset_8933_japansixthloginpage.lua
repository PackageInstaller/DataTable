local JapanSixthLoginPage = class("JapanSixthLoginPage", import(".TemplatePage.LoginTemplatePage"))

function JapanSixthLoginPage:OnFirstFlush()
	setActive(self.item, false)
	self.itemList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			local var_2_0 = {
				type = self.config.front_drops[arg_2_1 + 1][1],
				id = self.config.front_drops[arg_2_1 + 1][2],
				count = self.config.front_drops[arg_2_1 + 1][3]
			}

			updateDrop(arg_2_2:Find("item"), var_2_0)
			onButton(self, arg_2_2, function()
				self:emit(BaseUI.ON_DROP, var_2_0)

				return
			end, SFX_PANEL)
			setActive(arg_2_2:Find("got"), arg_2_1 < self.nday)
		end

		return
	end)

	return
end

function JapanSixthLoginPage:OnUpdateFlush()
	JapanSixthLoginPage.super.OnUpdateFlush(self)
	setText(self.bg:Find("Text"), self.nday .. "/" .. self.Day)

	return
end

return JapanSixthLoginPage
