local Match3Page = class("Match3Page", import("...base.BaseActivityPage"))

function Match3Page:OnInit()
	self.bg = self._tf:Find("AD")
	self.item = self.bg:Find("item")
	self.items = self.bg:Find("items")
	self.goBtn = self.bg:Find("go")
	self.itemList = UIItemList.New(self.items, self.item)

	return
end

function Match3Page:OnDataSetting()
	self.drop = self.activity:getConfig("config_client").drop
	self.id = self.activity:getConfig("config_client").gameId
	self.day = #self.drop

	return
end

function Match3Page:OnFirstFlush()
	setActive(self.item, false)

	local var_3_0 = getProxy(MiniGameProxy):GetHubByHubId(self.activity:getConfig("config_id"))

	setActive(self.item, false)
	self.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventInit then
			local var_4_0 = {
				type = self.drop[arg_4_1 + 1][1],
				id = self.drop[arg_4_1 + 1][2],
				count = self.drop[arg_4_1 + 1][3]
			}

			updateDrop(arg_4_2:Find("item"), var_4_0)
			onButton(self, arg_4_2, function()
				self:emit(BaseUI.ON_DROP, var_4_0)

				return
			end, SFX_PANEL)
		elseif arg_4_0 == UIItemList.EventUpdate then
			local var_4_1 = arg_4_2:Find("mask")

			setActive(arg_4_2:Find("got"), arg_4_1 < var_3_0.usedtime)
			setActive(var_4_1, arg_4_1 >= var_3_0.usedtime + var_3_0.count)
		end

		return
	end)
	self.itemList:align(self.day)
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, self.id)

		return
	end)

	return
end

function Match3Page:OnUpdateFlush()
	self.itemList:align(self.day)

	return
end

function Match3Page:OnDestroy()
	return
end

return Match3Page
