local LanternRiddlesView = class("LanternRiddlesView")

function LanternRiddlesView:Ctor(arg_1_1)
	self.controller = arg_1_1

	pg.DelegateInfo.New(self)

	return
end

function LanternRiddlesView:SetUI(arg_2_1)
	self._tf = arg_2_1
	self.questioneTFs = {}

	for iter_2_0, iter_2_1 in ipairs(pg.activity_event_question.all) do
		self.questioneTFs[iter_2_1] = self._tf:Find("labels/label" .. iter_2_0)
	end

	self.mainPanel = self._tf:Find("main")
	self.day = self._tf:Find("time/Text"):GetComponent(typeof(Text))
	self.mainPanel:Find("frame/time"):GetComponent(typeof(Text)).text = i18n("LanternRiddle_wait_time_tip")

	setActive(self.mainPanel, false)
	onButton(self, self.mainPanel, function()
		self:HideMainPanel()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("back"), function()
		self.controller:ExitGame()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("back/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.lanternRiddles_gametip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("option"), function()
		self.controller:ExitGameAndGoHome()

		return
	end, SFX_PANEL)

	return
end

function LanternRiddlesView:UpdateDay(arg_7_1)
	self.day.text = math.min(arg_7_1, 7)

	return
end

function LanternRiddlesView:InitLanternRiddles(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_0 = iter_8_1.isUnlock

		onButton(self, self.questioneTFs[iter_8_1.id], function()
			if not var_8_0 then
				return
			end

			self:ShowMainPanel(iter_8_1)

			return
		end, SFX_PANEL)
		setActive(self.questioneTFs[iter_8_1.id]:Find("finish"), iter_8_1.isFinish)

		if LeanTween.isTweening(go(self.questioneTFs[iter_8_1.id])) then
			LeanTween.cancel(go(self.questioneTFs[iter_8_1.id]))
		end

		local var_8_1 = self.questioneTFs[iter_8_1.id]:Find("image")

		if iter_8_1.isUnlock and not iter_8_1.isFinish then
			LeanTween.rotateZ(go(self.questioneTFs[iter_8_1.id]), 10, 2):setLoopPingPong(0):setFrom(0)
		end

		setActive(var_8_1, iter_8_1.isUnlock)
	end

	return
end

function LanternRiddlesView:RefreshLanterRiddles(arg_10_1)
	self:InitLanternRiddles(arg_10_1)

	return
end

function LanternRiddlesView:ShowMainPanel(arg_11_1)
	pg.UIMgr.GetInstance():BlurPanel(self.mainPanel)
	setActive(self.mainPanel, true)
	setActive(self.mainPanel:Find("frame/label_game"), arg_11_1.type == 2)
	setActive(self.mainPanel:Find("frame/label_his"), arg_11_1.type == 1)
	setText(self.mainPanel:Find("frame/Text"), arg_11_1.text)
	self:UpdateMainPanelTime()

	local var_11_0 = self.mainPanel:Find("frame/answers")

	for iter_11_0 = 1, 4 do
		local var_11_1 = arg_11_1.answers[iter_11_0][2]
		local var_11_2 = var_11_0:GetChild(iter_11_0 - 1)

		setText(var_11_2:Find("Text"), arg_11_1.answers[iter_11_0][1])
		setActive(var_11_2:Find("right"), arg_11_1.isFinish and iter_11_0 == arg_11_1.rightIndex)
		setActive(var_11_2:Find("false"), arg_11_1.answers[iter_11_0][2])
		onButton(self, var_11_2, function()
			if arg_11_1.isFinish then
				return
			end

			if var_11_1 then
				return
			end

			if pg.TimeMgr.GetInstance():GetServerTime() < self.controller:GetLockTime() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("lanternRiddles_wait_for_reanswer"))

				return
			end

			self.controller:SelectAnswer(arg_11_1.id, iter_11_0)

			return
		end, SFX_PANEL)
	end

	return
end

function LanternRiddlesView:UpdateMainPanelTime()
	self:RemoveTimer()

	local var_13_0 = pg.TimeMgr.GetInstance():GetServerTime() <= self.controller:GetLockTime()

	setActive(self.mainPanel:Find("frame/time"), var_13_0)

	if var_13_0 then
		self:AddTimer()
	end

	return
end

function LanternRiddlesView:OnUpdateAnswer(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = self.mainPanel:Find("frame/answers"):GetChild(arg_14_2 - 1)

	setActive(var_14_0:Find("right"), arg_14_3)
	setActive(var_14_0:Find("false"), not arg_14_3)

	if not arg_14_3 then
		self:UpdateMainPanelTime()
		pg.TipsMgr.GetInstance():ShowTips(i18n("lanternRiddles_answer_is_wrong"))
	else
		pg.TipsMgr.GetInstance():ShowTips(i18n("lanternRiddles_answer_is_right"))
		setActive(self.questioneTFs[arg_14_1.id]:Find("finish"), arg_14_1.isFinish)

		if LeanTween.isTweening(go(self.questioneTFs[arg_14_1.id])) then
			LeanTween.cancel(go(self.questioneTFs[arg_14_1.id]))
		end
	end

	return
end

function LanternRiddlesView:HideMainPanel()
	self:RemoveTimer()
	setActive(self.mainPanel, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.mainPanel, self._tf)

	return
end

function LanternRiddlesView:AddTimer()
	local var_16_0 = self.controller:GetLockTime()
	local var_16_1 = self.mainPanel:Find("frame/time/Text"):GetComponent(typeof(Text))

	self.timer = Timer.New(function()
		local var_17_0 = var_16_0 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_17_0 <= 0 then
			self:RemoveTimer()
			setActive(self.mainPanel:Find("frame/time"), false)
		else
			var_16_1.text = pg.TimeMgr.GetInstance():DescCDTime(var_17_0)
		end

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function LanternRiddlesView:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function LanternRiddlesView:Dispose()
	self:RemoveTimer()
	self:HideMainPanel()
	pg.DelegateInfo.Dispose(self)

	return
end

return LanternRiddlesView
