local ChargeAwardPage = class("ChargeAwardPage", import("...base.BaseActivityPage"))

function ChargeAwardPage:OnInit()
	self.bg = self._tf:Find("bg")
	self.charge = self._tf:Find("charge")
	self.take = self._tf:Find("take")
	self.finish = self._tf:Find("finish")

	return
end

function ChargeAwardPage:OnDataSetting()
	return
end

function ChargeAwardPage:OnFirstFlush()
	onButton(self, self.charge, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CHARGE, {
			wrap = ChargeScene.TYPE_DIAMOND
		})

		return
	end)
	onButton(self, self.take, function()
		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = self.activity.id
		})

		return
	end)

	return
end

function ChargeAwardPage:OnUpdateFlush()
	setActive(self.charge, self.activity.data2 == 0 and self.activity.data1 == 0)
	setButtonEnabled(self.take, self.activity.data2 == 0)
	setActive(self.take, self.activity.data1 > 0)
	setActive(self.finish, self.activity.data2 == 1)

	return
end

function ChargeAwardPage:OnDestroy()
	clearImageSprite(self.bg)

	return
end

return ChargeAwardPage
