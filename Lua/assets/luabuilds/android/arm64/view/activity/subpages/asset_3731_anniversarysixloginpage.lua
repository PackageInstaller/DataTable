local AnniversarySixLoginPage = class("AnniversarySixLoginPage", import(".TemplatePage.LoginTemplatePage"))

function AnniversarySixLoginPage:OnFirstFlush()
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
	setActive(self.bg:Find("btn_more"), PLATFORM_CODE == PLATFORM_CH and LuaHelper.GetCHPackageType() == PACKAGE_TYPE_BILI and pg.TimeMgr.GetInstance():inTime(self.activity:getConfig("config_client")[2]))
	onButton(self, self.bg:Find("btn_more"), function()
		Application.OpenURL(self.activity:getConfig("config_client")[1])

		return
	end, SFX_CONFIRM)

	return
end

function AnniversarySixLoginPage:OnUpdateFlush()
	AnniversarySixLoginPage.super.OnUpdateFlush(self)
	setText(self.bg:Find("Text"), self.nday .. "/" .. self.Day)

	return
end

return AnniversarySixLoginPage
