local RedPocketShipPage = class("RedPocketShipPage", import("...base.BaseActivityPage"))
local var_0_1 = 7
local var_0_2 = {
	[0] = 705.6,
	807.608,
	897.5893,
	987.5705,
	1077.552,
	1167.533,
	1257.514,
	1387.6
}

function RedPocketShipPage:OnInit()
	self.bg = self._tf:Find("bg")
	self.tip = self._tf:Find("tip")
	self.btn = self._tf:Find("btn")
	self.mainAward = self._tf:Find("main_award")
	self.subAward = self._tf:Find("sub_award")
	self.itemIcon = self._tf:Find("icon")
	self.slider = self._tf:Find("slider")
	self.uilist = UIItemList.New(self.subAward, self.subAward:Find("1"))

	return
end

function RedPocketShipPage:OnFirstFlush()
	local var_2_0 = self.activity

	onButton(self, self.tip, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.metalgearsub_help_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.btn, function()
		self:emit(ActivityMediator.GO_SUBMARINE_RUN, var_2_0:getConfig("config_client").stage_ids[math.min(self.progess + 1, self.maxday)])

		return
	end, SFX_PANEL)

	local var_2_1 = Drop.Create(self.activity:getConfig("config_client")[2])

	onButton(self, self.mainAward, function()
		self:emit(BaseUI.ON_DROP, var_2_1)

		return
	end, SFX_PANEL)

	local var_2_2 = self.activity:getConfig("config_client")[1]
	local var_2_3 = {
		type = var_2_2[1],
		id = var_2_2[2],
		count = var_2_2[3]
	}

	onButton(self, self.itemIcon, function()
		self:emit(BaseUI.ON_DROP, var_2_3)

		return
	end, SFX_PANEL)
	self.uilist:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			if LeanTween.isTweening(arg_7_2) then
				LeanTween.cancel(arg_7_2)
			end

			if arg_7_1 < self.progess then
				setImageAlpha(arg_7_2, 1)
			else
				LeanTween.alpha(arg_7_2, 1, 1):setFrom(0.4):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()
			end
		elseif arg_7_0 == UIItemList.EventExcess and LeanTween.isTweening(arg_7_2) then
			LeanTween.cancel(arg_7_2)
		end

		return
	end)

	return
end

function RedPocketShipPage:OnUpdateFlush()
	local var_8_0 = pg.TimeMgr.GetInstance()

	self.progess = math.min(self.activity.data2, var_0_1)
	self.maxday = math.min(var_8_0:DiffDay(self.activity.data1, var_8_0:GetServerTime()) + 1, var_0_1)

	self.uilist:align(math.min(self.maxday, var_0_1 - 1))
	setSlider(self.slider, var_0_2[0], var_0_2[var_0_1], var_0_2[self.progess])
	setActive(findTF(self.mainAward, "dis"), not self.activity.data4 or self.activity.data4 == 0)
	setActive(findTF(self.mainAward, "dis/lock"), self.maxday < var_0_1)
	setActive(findTF(self.mainAward, "get"), self.activity.data4 > 0)

	if self.activity.data4 == 0 and self.progess >= var_0_1 then
		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 3,
			activity_id = self.activity.id
		})
	elseif defaultValue(self.activity.data2_list[1], 0) > 0 or defaultValue(self.activity.data2_list[2], 0) > 0 then
		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 2,
			activity_id = self.activity.id
		})
	end

	return
end

function RedPocketShipPage:OnDestroy()
	clearImageSprite(self.bg)

	return
end

return RedPocketShipPage
