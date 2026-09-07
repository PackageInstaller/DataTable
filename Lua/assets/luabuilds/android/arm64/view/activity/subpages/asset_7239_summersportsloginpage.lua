local SummerSportsLoginPage = class("SummerSportsLoginPage", import(".TemplatePage.LoginTemplatePage"))

function SummerSportsLoginPage:OnFirstFlush()
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

function SummerSportsLoginPage:OnDestroy()
	return
end

return SummerSportsLoginPage
