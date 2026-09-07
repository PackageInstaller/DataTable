local WudaoLoginPage = class("WudaoLoginPage", import("...base.BaseActivityPage"))

function WudaoLoginPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.labelDay = self._tf:Find("days")
	self.items = self._tf:Find("items")
	self.item = self._tf:Find("item")

	return
end

function WudaoLoginPage:OnDataSetting()
	self.config = pg.activity_7_day_sign[self.activity:getConfig("config_id")]

	return
end

function WudaoLoginPage:OnFirstFlush()
	setActive(self.item, false)

	for iter_3_0 = 1, 8 do
		local var_3_0 = cloneTplTo(self.item, self.items:Find("layout"))
		local var_3_1 = {
			type = self.config.front_drops[iter_3_0][1],
			id = self.config.front_drops[iter_3_0][2],
			count = self.config.front_drops[iter_3_0][3]
		}

		updateDrop(var_3_0:Find("item"), var_3_1)
		onButton(self, var_3_0, function()
			self:emit(BaseUI.ON_DROP, var_3_1)

			return
		end, SFX_PANEL)
	end

	return
end

function WudaoLoginPage:OnUpdateFlush()
	for iter_5_0 = 1, 8 do
		local var_5_0 = self.items:Find("layout"):GetChild(iter_5_0 - 1)
		local var_5_1 = iter_5_0 <= self.activity.data1

		GetImageSpriteFromAtlasAsync("ui/activityuipage/wudaologinpage_atlas", string.format("number%d", iter_5_0), var_5_0:Find("day"), true)
		setActive(var_5_0:Find("got"), var_5_1)
	end

	return
end

function WudaoLoginPage:OnDestroy()
	clearImageSprite(self.bg)
	removeAllChildren(self.items)

	return
end

return WudaoLoginPage
