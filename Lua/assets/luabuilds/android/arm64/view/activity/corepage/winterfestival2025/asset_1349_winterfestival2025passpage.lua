local WinterFestival2025PassPage = class("WinterFestival2025PassPage", import("view.activity.CorePage.CoreActivityPage"))

function WinterFestival2025PassPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.items = self.bg:Find("items")
	self.item = self.items:Find("item")
	self.btn = self.bg:Find("btn")
	self.itemList = UIItemList.New(self.items, self.item)
	self.red = self.btn:Find("red")

	return
end

function WinterFestival2025PassPage:OnFirstFlush()
	self.config_client = self.activity:getConfig("config_client")[1]
	self.taskProxy = getProxy(TaskProxy)

	setActive(self.item, false)
	onButton(self, self.btn, function()
		self:emit(ActivityMediator.OPEN_LAYER, Context.New({
			mediator = WinterFestival2025Mediator,
			viewComponent = WinterFestival2025Scene
		}))

		return
	end, SOUND_BACK)
	setText(self.bg:Find("btn/Text"), i18n("winter_battlepass_proceed"))

	if self.coreActivityUI.contextData.openPass then
		triggerButton(self.btn)
	end

	SetActive(self.red, #self.activity:GetHei5UnreceiveAward() > 0)

	return
end

function WinterFestival2025PassPage:OnUpdateFlush()
	self.itemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventInit then
			local var_5_0 = Drop.Create({
				self.config_client[arg_5_1 + 1][1],
				self.config_client[arg_5_1 + 1][2],
				self.config_client[arg_5_1 + 1][3]
			})

			updateDrop(arg_5_2:Find("item"):Find("mask"), var_5_0)
			onButton(self, arg_5_2, function()
				self:emit(BaseUI.ON_DROP, var_5_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.itemList:align(#self.config_client)

	return
end

return WinterFestival2025PassPage
