local NewFrameTemplatePage = class("NewFrameTemplatePage", import("view.base.BaseActivityPage"))

function NewFrameTemplatePage:OnInit()
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
	self.cur = self._tf:Find("AD/switcher/phase2/Image/step")
	self.target = self._tf:Find("AD/switcher/phase2/Image/progress")
	self.gotTag = self._tf:Find("AD/switcher/phase2/Image/got")

	return
end

function NewFrameTemplatePage:OnDataSetting()
	self.avatarConfig = pg.activity_event_avatarframe[self.activity:getConfig("config_id")]

	if self.avatarConfig.start_time == "stop" then
		self.timeStamp = nil
	else
		self.timeStamp = pg.TimeMgr.GetInstance():parseTimeFromConfig(self.avatarConfig.start_time)
	end

	return
end

function NewFrameTemplatePage:OnFirstFlush()
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK)

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = self.activity.id
		})

		return
	end, SFX_PANEL)
	onToggle(self, self.switchBtn, function(arg_6_0)
		if self.isSwitching then
			return
		end

		self:Switch(arg_6_0)

		return
	end, SFX_PANEL)

	self.inPhase2 = self.timeStamp and pg.TimeMgr.GetInstance():GetServerTime() - self.timeStamp > 0

	triggerToggle(self.switchBtn, self.inPhase2)

	if not IsNil(self.gotTag:Find("Text")) then
		setText(self.gotTag:Find("Text"), i18n("avatarframe_got"))
	end

	return
end

function NewFrameTemplatePage:OnUpdateFlush()
	local var_7_0 = self.activity.data1
	local var_7_1 = self.avatarConfig.target

	var_7_0 = self.avatarConfig.target < self.activity.data1 and var_7_1 or var_7_0

	local var_7_2 = var_7_0 / var_7_1

	setText(self.cur, var_7_0 / var_7_1 >= 1 and var_7_0 or var_7_0)
	setText(self.target, "/" .. var_7_1)
	setFillAmount(self.bar, var_7_2)

	local var_7_3 = var_7_1 <= var_7_0
	local var_7_4 = self.activity.data2 >= 1

	setActive(self.battleBtn, self.inPhase2 and not var_7_3)
	setActive(self.getBtn, self.inPhase2 and not var_7_4 and var_7_3)
	setActive(self.gotBtn, self.inPhase2 and var_7_4)
	setActive(self.gotTag, self.inPhase2 and var_7_4)
	setActive(self.cur, not var_7_4)
	setActive(self.target, not var_7_4)

	return
end

function NewFrameTemplatePage:Switch(arg_8_1)
	self.isSwitching = true

	setToggleEnabled(self.switchBtn, false)

	local var_8_0
	local var_8_1

	if arg_8_1 then
		var_8_1 = self.phases[2]
		var_8_0 = self.phases[1]
	else
		var_8_1 = self.phases[1]
		var_8_0 = self.phases[2]
	end

	local var_8_2 = GetOrAddComponent(var_8_0, typeof(CanvasGroup))

	var_8_1:SetAsLastSibling()
	setActive(var_8_0:Find("Image"), false)
	LeanTween.moveLocal(go(var_8_0), var_8_1.localPosition, 0.4):setOnComplete(System.Action(function()
		setActive(var_8_0:Find("label"), true)

		return
	end))
	LeanTween.value(go(var_8_0), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_10_0)
		var_8_2.alpha = arg_10_0

		return
	end))
	setActive(var_8_1:Find("Image"), true)

	local var_8_3 = GetOrAddComponent(var_8_1, typeof(CanvasGroup))

	LeanTween.value(go(var_8_1), 0, 1, 0.4):setOnUpdate(System.Action_float(function(arg_11_0)
		var_8_3.alpha = arg_11_0

		return
	end))
	setActive(var_8_1:Find("label"), false)
	LeanTween.moveLocal(go(var_8_1), var_8_0.localPosition, 0.4):setOnComplete(System.Action(function()
		self.isSwitching = nil

		setToggleEnabled(self.switchBtn, true)

		return
	end))

	return
end

return NewFrameTemplatePage
