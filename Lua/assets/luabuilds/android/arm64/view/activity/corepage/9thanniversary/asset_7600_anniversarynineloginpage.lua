local AnniversaryNineLoginPage = class("AnniversaryNineLoginPage", import("view.activity.CorePage.templatePage.CoreLoginSignTemplatePage"))

function AnniversaryNineLoginPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.itemGroup = self.bg:Find("bg_item")
	self.item = self.itemGroup:Find("item")
	self.items = self.itemGroup:Find("items")
	self.itemList = UIItemList.New(self.items, self.item)
	self.btnMore = self.bg:Find("btn_more")

	return
end

function AnniversaryNineLoginPage:OnFirstFlush()
	setActive(self.item, false)
	self.itemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
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
			setActive(arg_3_2:Find("got"), arg_3_1 < self.nday)
		end

		return
	end)
	onButton(self, self.btnMore, function()
		Application.OpenURL(self.activity:getConfig("config_client")[1])

		return
	end, SFX_CONFIRM)

	return
end

function AnniversaryNineLoginPage:OnUpdateFlush()
	AnniversaryNineLoginPage.super.OnUpdateFlush(self)
	setText(self.itemGroup:Find("Text"), self.nday .. "/" .. self.Day)

	return
end

return AnniversaryNineLoginPage
