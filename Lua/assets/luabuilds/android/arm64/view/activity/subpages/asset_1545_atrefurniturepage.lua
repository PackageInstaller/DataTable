local AtreFurniturePage = class("AtreFurniturePage", import(".TemplatePage.LoginTemplatePage"))

function AtreFurniturePage:OnInit()
	AtreFurniturePage.super.OnInit(self)

	self.dayText = self._tf:Find("AD/DayText")

	return
end

function AtreFurniturePage:OnFirstFlush()
	setActive(self.item, false)
	self.itemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventInit then
			local var_3_0 = {
				type = self.config.front_drops[arg_3_1 + 1][1],
				id = self.config.front_drops[arg_3_1 + 1][2],
				count = self.config.front_drops[arg_3_1 + 1][3]
			}

			updateDrop(arg_3_2:Find("item"), var_3_0)
			onButton(self, arg_3_2, function()
				self:emit(BaseUI.ON_DROP, var_3_0)

				return
			end, SFX_PANEL)
		elseif arg_3_0 == UIItemList.EventUpdate then
			setActive(arg_3_2:Find("got"), arg_3_1 < self.nday)
		end

		return
	end)

	return
end

function AtreFurniturePage:OnUpdateFlush()
	AtreFurniturePage.super.OnUpdateFlush(self)
	setText(self.dayText, string.format("%02d", self.nday))

	return
end

return AtreFurniturePage
