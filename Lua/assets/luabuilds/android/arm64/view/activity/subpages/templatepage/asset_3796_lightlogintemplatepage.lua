local LightLoginTemplatePage = class("LightLoginTemplatePage", import("view.base.BaseActivityPage"))

function LightLoginTemplatePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.bar = self.bg:Find("bar")
	self.item = self.bg:Find("item")
	self.items = self.bg:Find("items")
	self.itemList = UIItemList.New(self.items, self.item)

	return
end

function LightLoginTemplatePage:OnDataSetting()
	self.config = pg.activity_7_day_sign[self.activity:getConfig("config_id")]
	self.Day = #self.config.front_drops

	return
end

function LightLoginTemplatePage:OnFirstFlush()
	setActive(self.item, false)
	self.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventInit then
			local var_4_0 = Drop.Create(self.config.front_drops[arg_4_1 + 1])

			updateDrop(arg_4_2:Find("item"), var_4_0)
			onButton(self, arg_4_2, function()
				self:emit(BaseUI.ON_DROP, var_4_0)

				return
			end, SFX_PANEL)
			GetImageSpriteFromAtlasAsync("ui/share/light_login_atlas", "DAY" .. arg_4_1 + 1, arg_4_2:Find("day"), true)
		elseif arg_4_0 == UIItemList.EventUpdate then
			local var_4_1 = arg_4_1 < self.nday

			setActive(arg_4_2:Find("got"), arg_4_1 < self.nday)
			setActive(arg_4_2:Find("get"), var_4_1)
			setActive(arg_4_2:Find("bg"), not var_4_1)
		end

		return
	end)

	return
end

function LightLoginTemplatePage:OnUpdateFlush()
	self.nday = self.activity.data1

	self.itemList:align(self.Day)
	setFillAmount(self.bar, self.nday / self.Day)

	return
end

function LightLoginTemplatePage:OnDestroy()
	clearImageSprite(self.bg)
	removeAllChildren(self.items)

	return
end

return LightLoginTemplatePage
