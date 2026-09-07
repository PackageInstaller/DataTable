local Day7LoginPage = class("Day7LoginPage", import("...base.BaseActivityPage"))

function Day7LoginPage:OnInit()
	self.bg = self._tf:Find("bg")
	self.labelDay = self._tf:Find("days")
	self.items = self._tf:Find("items")
	self.item = self._tf:Find("item")

	return
end

function Day7LoginPage:OnDataSetting()
	self.config = pg.activity_7_day_sign[self.activity:getConfig("config_id")]

	return
end

function Day7LoginPage:OnFirstFlush()
	setActive(self.item, false)

	for iter_3_0 = 1, 7 do
		local var_3_0 = cloneTplTo(self.item, self.items)
		local var_3_1 = Drop.Create(self.config.front_drops[iter_3_0])

		updateDrop(var_3_0:Find("item"), var_3_1)
		onButton(self, var_3_0, function()
			self:emit(BaseUI.ON_DROP, var_3_1)

			return
		end, SFX_PANEL)
	end

	return
end

function Day7LoginPage:OnUpdateFlush()
	GetImageSpriteFromAtlasAsync("ui/activityuipage/day7_login_atlas", string.format("0%d", math.max(self.activity.data1, 1)), self.labelDay, true)

	for iter_5_0 = 1, 7 do
		local var_5_0 = self.items:GetChild(iter_5_0 - 1)
		local var_5_1 = iter_5_0 <= self.activity.data1

		GetImageSpriteFromAtlasAsync("ui/activityuipage/day7_login_atlas", string.format("day%d", iter_5_0) .. (iter_5_0 <= self.activity.data1 and "_sel" or ""), var_5_0:Find("day"), true)
		setActive(var_5_0:Find("got"), var_5_1)
	end

	return
end

function Day7LoginPage:OnDestroy()
	clearImageSprite(self.bg)
	removeAllChildren(self.items)

	return
end

return Day7LoginPage
