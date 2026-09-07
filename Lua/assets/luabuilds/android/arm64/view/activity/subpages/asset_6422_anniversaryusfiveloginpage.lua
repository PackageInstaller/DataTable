local AnniversaryUSFiveLoginPage = class("AnniversaryUSFiveLoginPage", import(".TemplatePage.LoginTemplatePage"))

function AnniversaryUSFiveLoginPage:OnFirstFlush()
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

			local var_2_1 = arg_2_2:Find("day/Text")

			if not IsNil(var_2_1) then
				setText(var_2_1, arg_2_1 < self.nday and i18n("word_status_inEventFinished") or i18n("which_day_2", arg_2_1 + 1))
			end
		end

		return
	end)

	return
end

return AnniversaryUSFiveLoginPage
