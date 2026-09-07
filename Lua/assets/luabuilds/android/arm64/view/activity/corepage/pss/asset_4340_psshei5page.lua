local PSSHei5Page = class("PSSHei5Page", import("view.activity.CorePage.CoreActivityPage"))

function PSSHei5Page:OnInit()
	self.bg = self._tf:Find("AD")
	self.items = self.bg:Find("items")
	self.item = self.items:Find("item")
	self.btn = self.bg:Find("btn")
	self.itemList = UIItemList.New(self.items, self.item)

	return
end

function PSSHei5Page:OnFirstFlush()
	self.config_client = self.activity:getConfig("config_client")[1]
	self.taskProxy = getProxy(TaskProxy)

	setActive(self.item, false)
	onButton(self, self.btn, function()
		self:emit(ActivityMediator.OPEN_LAYER, Context.New({
			mediator = PSSHei5Mediator,
			viewComponent = PSSHei5Scene
		}))

		return
	end, SOUND_BACK)

	return
end

function PSSHei5Page:OnUpdateFlush()
	self.itemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventInit then
			local var_5_0 = Drop.Create({
				self.config_client[arg_5_1 + 1][1],
				self.config_client[arg_5_1 + 1][2],
				self.config_client[arg_5_1 + 1][3]
			})

			updateDrop(arg_5_2:Find("item"), var_5_0)
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

return PSSHei5Page
