local FrameTemplatePage = class("FrameTemplatePage", import("view.base.BaseActivityPage"))

function FrameTemplatePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.battleBtn = self.bg:Find("battle_btn")
	self.getBtn = self.bg:Find("get_btn")
	self.gotBtn = self.bg:Find("got_btn")
	self.switchBtn = self._tf:Find("AD/switch_btn")
	self.phases = {
		self._tf:Find("AD/switcher/phase1"),
		self._tf:Find("AD/switcher/phase2")
	}
	self.bar = self._tf:Find("AD/switcher/phase2/Image/barContent/bar")
	self.step = self._tf:Find("AD/switcher/phase2/Image/step")
	self.progress = self._tf:Find("AD/switcher/phase2/Image/progress")

	return
end

function FrameTemplatePage:OnDataSetting()
	if self.ptData then
		self.ptData:Update(self.activity)
	else
		self.ptData = ActivityPtData.New(self.activity)
	end

	return
end

function FrameTemplatePage:OnFirstFlush()
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
			page = "activity"
		})

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		local var_5_0 = {}
		local var_5_1 = self.ptData:GetAward()

		if var_5_1.type == DROP_TYPE_RESOURCE and var_5_1.id == PlayerConst.ResGold and getProxy(PlayerProxy):getData():GoldMax(var_5_1.count) then
			table.insert(var_5_0, function(arg_6_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("gold_max_tip_title") .. i18n("award_max_warning"),
					onYes = arg_6_0
				})

				return
			end)
		end

		seriesAsync(var_5_0, function()
			local var_7_0, var_7_1 = self.ptData:GetResProgress()

			self:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = self.ptData:GetId(),
				arg1 = var_7_1
			})

			return
		end)

		return
	end, SFX_PANEL)
	onToggle(self, self.switchBtn, function(arg_8_0)
		if self.isSwitching then
			return
		end

		self.inPhase2 = arg_8_0

		self:Switch(arg_8_0)

		return
	end, SFX_PANEL)

	local var_3_0 = pg.TimeMgr.GetInstance():inTime((self.activity:getConfig("config_client")))

	setActive(self.battleBtn, var_3_0)

	self.inPhase2 = var_3_0

	if var_3_0 then
		triggerToggle(self.switchBtn, true)
	end

	return
end

function FrameTemplatePage:OnUpdateFlush()
	setActive(self.getBtn, (self.ptData:CanGetAward()))
	setActive(self.gotBtn, not self.ptData:CanGetNextAward())

	local var_9_0, var_9_1, var_9_2 = self.ptData:GetResProgress()

	setText(self.step, var_9_2 >= 1 and setColorStr(var_9_0, COLOR_GREEN) or var_9_0)
	setText(self.progress, "/" .. var_9_1)
	setFillAmount(self.bar, var_9_0 / var_9_1)
	self:UpdateAwardGot()

	return
end

function FrameTemplatePage:Switch(arg_10_1)
	self.isSwitching = true

	local var_10_0 = GetOrAddComponent(self.phases[1], typeof(CanvasGroup))

	self.phases[2]:SetAsLastSibling()
	setActive(self.phases[1]:Find("Image"), false)
	LeanTween.moveLocal(go(self.phases[1]), self.phases[2].localPosition, 0.4):setOnComplete(System.Action(function()
		setActive(self.phases[1]:Find("label"), true)

		return
	end))
	LeanTween.value(go(self.phases[1]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_12_0)
		var_10_0.alpha = arg_12_0

		return
	end))
	setActive(self.phases[2]:Find("Image"), true)

	local var_10_1 = GetOrAddComponent(self.phases[2], typeof(CanvasGroup))

	LeanTween.value(go(self.phases[2]), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_13_0)
		var_10_1.alpha = arg_13_0

		return
	end))
	setActive(self.phases[2]:Find("label"), false)
	LeanTween.moveLocal(go(self.phases[2]), self.phases[1].localPosition, 0.4):setOnComplete(System.Action(function()
		self.isSwitching = nil
		self.phases[1], self.phases[2] = self.phases[2], self.phases[1]

		return
	end))
	self:UpdateAwardGot()

	return
end

function FrameTemplatePage:UpdateAwardGot()
	local var_15_0 = not self.ptData:CanGetNextAward() and self.inPhase2

	setActive(self.bg:Find("switcher/phase2/got"), var_15_0)

	if var_15_0 then
		setActive(self.battleBtn, false)
	end

	return
end

function FrameTemplatePage:OnDestroy()
	return
end

return FrameTemplatePage
