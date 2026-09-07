local MonopolyPtPage = class("MonopolyPtPage", import("...base.BaseActivityPage"))

function MonopolyPtPage:OnInit()
	onToggle(self, findTF(self._tf, "AD/toggle/1"), function()
		self:changeToggle(1)

		return
	end, SFX_CONFIRM)
	onToggle(self, findTF(self._tf, "AD/toggle/2"), function()
		self:changeToggle(2)

		return
	end, SFX_CONFIRM)
	onToggle(self, findTF(self._tf, "AD/toggle/3"), function()
		self:changeToggle(3)

		return
	end, SFX_CONFIRM)
	triggerToggle(findTF(self._tf, "AD/toggle/1"), true)
	onButton(self, findTF(self._tf, "AD/btnShop"), function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SHOP)

		return
	end, SFX_CONFIRM)
	onButton(self, findTF(self._tf, "AD/btnGo"), function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.MONOPOLY_PT, {
			config_id = self.activity.id
		})

		return
	end, SFX_CONFIRM)

	return
end

function MonopolyPtPage:changeToggle(arg_7_1)
	for iter_7_0 = 1, 3 do
		setActive(findTF(self._tf, "AD/toggle/" .. iter_7_0 .. "/on/desc"), iter_7_0 == arg_7_1)
	end

	return
end

function MonopolyPtPage:OnFirstFlush()
	if self.ptData then
		self.ptData:Update(self.activity)
	else
		self.ptData = ActivityPtData.New(self.activity)
	end

	return
end

function MonopolyPtPage:OnUpdateFlush()
	if self.ptData then
		self.ptData:Update(self.activity)
	else
		self.ptData = ActivityPtData.New(self.activity)
	end

	local var_9_0, var_9_1, var_9_2 = self.ptData:GetLevelProgress()
	local var_9_3, var_9_4, var_9_5 = self.ptData:GetResProgress()
	local var_9_6 = self.ptData:GetLevel()
	local var_9_7 = math.floor(var_9_3 / 500) - var_9_6

	if 20 - var_9_6 < var_9_7 then
		var_9_7 = 20 - var_9_6
	end

	if 20 - var_9_6 == 0 then
		setActive(findTF(self._tf, "AD/clear"), true)
	else
		setActive(findTF(self._tf, "AD/clear"), false)
	end

	setActive(findTF(self._tf, "AD/count"), var_9_7 > 0)
	setText(findTF(self._tf, "AD/count/txt"), var_9_7)

	return
end

return MonopolyPtPage
