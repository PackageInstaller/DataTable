local SitanliLoginPage = class("SitanliLoginPage", import(".TemplatePage.LoginTemplatePage"))

function SitanliLoginPage:OnDataSetting()
	self.config = pg.activity_7_day_sign[self.activity:getConfig("config_id")]
	self.Day = 14

	return
end

function SitanliLoginPage:OnFirstFlush()
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

return SitanliLoginPage
