local ShiningMagicJPLoginPage = class("ShiningMagicJPLoginPage", import("view.activity.CorePage.templatePage.CoreLoginSignTemplatePage"))

function ShiningMagicJPLoginPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.itemGroup = self.bg:Find("bg_item")
	self.item = self.itemGroup:Find("item")
	self.items = self.itemGroup:Find("items")
	self.itemList = UIItemList.New(self.items, self.item)
	self.btnClick = self.bg:Find("btn_get")
	self.red = self.btnClick:Find("red")

	return
end

function ShiningMagicJPLoginPage:OnFirstFlush()
	self.nday = self.activity.data1

	setActive(self.item, false)
	onButton(self, self.btnClick, function()
		if self.activity:readyToAchieve() == false then
			return
		end

		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = self.activity.id
		})

		return
	end, SFX_CONFIRM)
	self.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = {
				type = self.config.front_drops[arg_4_1 + 1][1],
				id = self.config.front_drops[arg_4_1 + 1][2],
				count = self.config.front_drops[arg_4_1 + 1][3]
			}

			updateDrop(arg_4_2:Find("item"), var_4_0)
			onButton(self, arg_4_2, function()
				self:emit(BaseUI.ON_DROP, var_4_0)

				return
			end, SFX_PANEL)
			setActive(arg_4_2:Find("got"), arg_4_1 < self.nday)
		end

		return
	end)

	return
end

function ShiningMagicJPLoginPage:OnUpdateFlush()
	self.nday = self.activity.data1

	local var_6_0 = self.activity:readyToAchieve()

	setActive(self.red, var_6_0)
	setGray(self.btnClick, not var_6_0)
	setText(self.itemGroup:Find("Text"), self.nday .. "/" .. self.Day)
	self.itemList:align(self.Day)

	return
end

return ShiningMagicJPLoginPage
