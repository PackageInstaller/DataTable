local CoreLoginSignTemplatePage = class("CoreLoginSignTemplatePage", import("view.activity.CorePage.CoreActivityPage"))

function CoreLoginSignTemplatePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.item = self.bg:Find("item")
	self.items = self.bg:Find("items")
	self.itemList = UIItemList.New(self.items, self.item)

	return
end

function CoreLoginSignTemplatePage:OnDataSetting()
	self.config = pg.activity_7_day_sign[self.activity:getConfig("config_id")]
	self.Day = #self.config.front_drops

	return
end

function CoreLoginSignTemplatePage:OnFirstFlush()
	setActive(self.item, false)
	self.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = Drop.Create(self.config.front_drops[arg_4_1 + 1])

			updateDrop(arg_4_2:Find("item"), var_4_0)
			onButton(self, arg_4_2, function()
				self:emit(BaseUI.ON_DROP, var_4_0)

				return
			end, SFX_PANEL)
			setActive(arg_4_2:Find("got"), arg_4_1 < self.nday)
			setText(arg_4_2:Find("day/Text"), arg_4_1 < self.nday and i18n("word_status_inEventFinished") or i18n("which_day_2", arg_4_1 + 1))
		end

		return
	end)

	return
end

function CoreLoginSignTemplatePage:OnUpdateFlush()
	self.nday = self.activity.data1

	self.itemList:align(self.Day)

	return
end

function CoreLoginSignTemplatePage:OnDestroy()
	removeAllChildren(self.items)

	return
end

return CoreLoginSignTemplatePage
