local SpringFestival2026FuboLoginPage = class("SpringFestival2026FuboLoginPage", import("view.activity.CorePage.CoreActivityPage"))

function SpringFestival2026FuboLoginPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.items = self.bg:Find("items")
	self.item = self.bg:GetChild(0)
	self.itemList = UIItemList.New(self.items, self.item)

	return
end

function SpringFestival2026FuboLoginPage:OnDataSetting()
	self.config = pg.activity_7_day_sign[self.activity:getConfig("config_id")]
	self.Day = #self.config.front_drops

	return
end

function SpringFestival2026FuboLoginPage:OnFirstFlush()
	self.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = Drop.Create(self.config.front_drops[arg_4_1 + 1])

			updateDrop(arg_4_2:Find("container/item"), var_4_0)
			onButton(self, arg_4_2, function()
				self:emit(BaseUI.ON_DROP, var_4_0)

				return
			end, SFX_PANEL)

			local var_4_1 = arg_4_2:Find("got")

			arg_4_2:Find("container"):GetComponent(typeof(CanvasGroup)).alpha = arg_4_1 < self.nday and 0.5 or 1

			setActive(var_4_1, arg_4_1 < self.nday)
		end

		return
	end)

	return
end

function SpringFestival2026FuboLoginPage:OnUpdateFlush()
	self.nday = self.activity.data1

	self.itemList:align(self.Day)

	return
end

return SpringFestival2026FuboLoginPage
