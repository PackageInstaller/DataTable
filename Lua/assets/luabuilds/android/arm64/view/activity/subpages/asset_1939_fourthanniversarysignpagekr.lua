local FourthAnniversarySignPageKR = class("FourthAnniversarySignPageKR", import(".TemplatePage.LoginTemplatePage"))

function FourthAnniversarySignPageKR:OnInit()
	self.bg = self._tf:Find("AD")
	self.item = self.bg:Find("item")
	self.items = self.bg:Find("mask/items")
	self.itemList = UIItemList.New(self.items, self.item)
	self.initItems = {}

	return
end

function FourthAnniversarySignPageKR:OnFirstFlush()
	setActive(self.item, false)
	self.itemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_1

			if not table.contains(self.initItems, arg_3_1) then
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
				table.insert(self.initItems, arg_3_1)

				var_3_1 = setActive
			end

			var_3_1(arg_3_2:Find("got"), arg_3_1 < self.nday)
		end

		return
	end)

	return
end

function FourthAnniversarySignPageKR:OnUpdateFlush()
	FourthAnniversarySignPageKR.super.OnUpdateFlush(self)
	eachChild(self.items, function(arg_6_0)
		return
	end)

	return
end

return FourthAnniversarySignPageKR
