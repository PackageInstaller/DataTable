local SVOrderPanel = class("SVOrderPanel", import("view.base.BaseSubView"))

function SVOrderPanel:getUIName()
	return "SVOrderPanel"
end

function SVOrderPanel:getBGM()
	return "echo-loop"
end

function SVOrderPanel:OnLoaded()
	return
end

function SVOrderPanel:OnInit()
	local var_4_0 = self._tf:Find("adapt/order_list")

	self.btnRedeploy = var_4_0:Find("redeploy")
	self.btnExpansion = var_4_0:Find("expansion")
	self.btnMaintenance = var_4_0:Find("maintenance")
	self.btnFOV = var_4_0:Find("fov")
	self.btnSubmarine = var_4_0:Find("submarine")
	self.btnHelp = self._tf:Find("adapt/help")

	onButton(self, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("world_instruction_help_1")
		})

		return
	end, SFX_PANEL)

	self.btnBack = self._tf:Find("adapt/back")

	onButton(self, self.btnBack, function()
		self:Hide()

		return
	end, SFX_CANCEL)

	self.rtRing = self._tf:Find("bg/ring")
	self.wsCompass = WSCompass.New()
	self.wsCompass.tf = self._tf:Find("bg/ring/compass")
	self.wsCompass.pool = self.contextData.wsPool

	self.wsCompass:Setup(true)

	self.rtMsgbox = self._tf:Find("Msgbox")

	setText(self.rtMsgbox:Find("window/top/bg/infomation/title"), i18n("title_info"))
	setActive(self.rtMsgbox, false)
	onButton(self, self.rtMsgbox:Find("bg"), function()
		self:HideMsgbox()

		return
	end, SFX_CANCEL)
	onButton(self, self.rtMsgbox:Find("window/top/btnBack"), function()
		self:HideMsgbox()

		return
	end, SFX_CANCEL)

	self.rtMsgStamina = self.rtMsgbox:Find("window/top/bg/stamina")

	setText(self.rtMsgStamina:Find("name"), i18n("world_ap"))

	self.rtMsgBase = self.rtMsgbox:Find("window/msg_panel/base")
	self.rtMsgExtra = self.rtMsgbox:Find("window/msg_panel/extra")
	self.rtMsgBtns = self.rtMsgbox:Find("window/button_container")

	setText(self.rtMsgBtns:Find("btn_setting/pic"), i18n("msgbox_text_save"))
	setText(self.rtMsgBtns:Find("btn_confirm/pic"), i18n("text_confirm"))
	setText(self.rtMsgBtns:Find("btn_cancel/pic"), i18n("text_cancel"))
	onButton(self, self.rtMsgBtns:Find("btn_cancel"), function()
		self:HideMsgbox()

		return
	end, SFX_CANCEL)

	return
end

function SVOrderPanel:OnDestroy()
	self:ClearBtnTimers()
	self.wsCompass:Dispose()

	return
end

function SVOrderPanel:Show()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	SVOrderPanel.super.Show(self)

	return
end

function SVOrderPanel:Hide()
	if isActive(self.rtMsgbox) then
		self:HideMsgbox()
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	self:ClearComppass()
	self:ClearBtnTimers()
	SVOrderPanel.super.Hide(self)

	return
end

function SVOrderPanel:Setup(arg_13_1, arg_13_2, arg_13_3)
	self:Update(arg_13_1, arg_13_2)
	self.wsCompass:SetAnchorEulerAngles(arg_13_3)

	return
end

function SVOrderPanel:Update(arg_14_1, arg_14_2)
	if self.entrance ~= arg_14_1 or self.map ~= arg_14_2 or self.gid ~= arg_14_2.gid then
		self.entrance = arg_14_1
		self.map = arg_14_2
		self.gid = arg_14_2.gid
	end

	self:UpdateCompassMarks()
	self:UpdateOrderBtn()

	return
end

function SVOrderPanel:SetButton(arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1:Find("type_lock")
	local var_15_1 = arg_15_1:Find("type_unable")
	local var_15_2 = arg_15_1:Find("type_enable")

	setActive(var_15_0, not nowWorld():IsSystemOpen(arg_15_2.system))

	local var_15_3 = setActive
	local var_15_4 = var_15_1

	var_15_3(var_15_4, (not isActive(var_15_0) or nil) and (arg_15_2.isLock or arg_15_2.timeStamp and arg_15_2.timeStamp > pg.TimeMgr.GetInstance():GetServerTime()))
	setActive(var_15_2, not isActive(var_15_0) and not isActive(var_15_1))

	if isActive(var_15_0) then
		onButton(self, var_15_0, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_all_1"))

			return
		end, SFX_CONFIRM)
	end

	if isActive(var_15_1) then
		setActive(var_15_1:Find("cost"), arg_15_2.isLock)
		setActive(var_15_1:Find("time"), not arg_15_2.isLock)

		if arg_15_2.isLock then
			setText(var_15_1:Find("cost/Text"), arg_15_2.cost)
			onButton(self, var_15_1, arg_15_2.lockFunc, SFX_CONFIRM)
		else
			self.timers[var_15_1] = Timer.New(function()
				local var_17_0 = arg_15_2.timeStamp - pg.TimeMgr.GetInstance():GetServerTime()

				if var_17_0 < 0 then
					self:UpdateOrderBtn()
				else
					setText(var_15_1:Find("time/Text"), string.format("%d:%02d:%02d", math.floor(var_17_0 / 16), math.floor(var_17_0 % 16 / 60), var_17_0 % 60))
				end

				return
			end, 1, -1)

			self.timers[var_15_1].func()
			self.timers[var_15_1]:Start()
			onButton(self, var_15_1, arg_15_2.timeFunc, SFX_CONFIRM)
		end
	end

	if isActive(var_15_2) then
		setText(var_15_2:Find("cost/Text"), arg_15_2.cost)
		onButton(self, var_15_2, arg_15_2.enableFunc, SFX_CONFIRM)
	end

	return
end

function SVOrderPanel:UpdateOrderBtn()
	self:ClearBtnTimers()

	self.timers = {}

	local var_18_0 = nowWorld()
	local var_18_1 = self.map:GetConfig("instruction_available")
	local var_18_2 = checkExist(self.map, {
		"GetPort"
	})
	local var_18_3 = var_18_0:GetRealm()
	local var_18_4 = var_18_0:IsSystemOpen(WorldConst.SystemOrderRedeploy) and var_18_3 == checkExist(var_18_2, {
		"GetRealm"
	}) and checkExist(var_18_2, {
		"IsOpen",
		{
			var_18_3,
			var_18_0:GetProgress()
		}
	}) and var_18_0:BuildFormationIds()
	local var_18_5 = {
		system = WorldConst.SystemOrderRedeploy,
		isLock = not var_18_4,
		lockFunc = function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_redeploy_1"))

			return
		end,
		cost = var_18_0:CalcOrderCost(WorldConst.OpReqRedeploy),
		enableFunc = function(arg_20_0, arg_20_1)
			self:Hide()
			self:emit(WorldScene.SceneOp, "OpRedeploy")

			return
		end
	}

	self:SetButton(self.btnRedeploy, var_18_5)
	self:SetButton(self.btnExpansion, var_18_5)
	setActive(self.btnRedeploy, var_18_4 ~= WorldConst.FleetExpansion)
	setActive(self.btnExpansion, var_18_4 == WorldConst.FleetExpansion)

	local var_18_6 = self.btnSubmarine
	local var_18_7 = {
		system = WorldConst.SystemOrderSubmarine
	}

	var_18_7.isLock = var_18_1[1] == 0 or not var_18_0:CanCallSubmarineSupport() or var_18_0:IsSubmarineSupporting() and var_18_0:GetSubAidFlag()

	function var_18_7.lockFunc()
		if var_18_1[1] == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_submarine_1"))
		elseif not var_18_0:CanCallSubmarineSupport() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_submarine_4"))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_submarine_3"))
		end

		return
	end

	var_18_7.cost = var_18_0:CalcOrderCost(WorldConst.OpReqSub)

	function var_18_7.enableFunc()
		self:ShowMsgbox(WorldConst.OpReqSub)

		return
	end

	self:SetButton(var_18_6, var_18_7)
	self:SetButton(self.btnFOV, {
		system = WorldConst.SystemOrderFOV,
		isLock = var_18_1[2] == 0 or self.map.visionFlag,
		lockFunc = function()
			if var_18_1[2] == 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_submarine_1"))
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_detect_2"))
			end

			return
		end,
		cost = var_18_0:CalcOrderCost(WorldConst.OpReqVision),
		enableFunc = function()
			self:ShowMsgbox(WorldConst.OpReqVision)

			return
		end
	})

	local var_18_8 = pg.TimeMgr.GetInstance()
	local var_18_9 = var_18_0:GetReqCDTime(WorldConst.OpReqMaintenance) + pg.gameset.world_instruction_maintenance.description[2]

	self:SetButton(self.btnMaintenance, {
		system = WorldConst.SystemOrderMaintenance,
		isLock = var_18_1[3] == 0,
		lockFunc = function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_submarine_1"))

			return
		end,
		timeStamp = var_18_9,
		timeFunc = function(arg_26_0)
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_supply_2", var_18_8:DescCDTime(var_18_9 - pg.TimeMgr.GetInstance():GetServerTime())))

			return
		end,
		cost = var_18_0:CalcOrderCost(WorldConst.OpReqMaintenance),
		enableFunc = function()
			self:ShowMsgbox(WorldConst.OpReqMaintenance)

			return
		end
	})

	return
end

function SVOrderPanel:ClearBtnTimers()
	if self.timers then
		for iter_28_0, iter_28_1 in pairs(self.timers) do
			iter_28_1:Stop()
		end
	end

	self.timers = nil

	return
end

function SVOrderPanel:UpdateCompassMarks()
	self.wsCompass:ClearMarks()
	self.wsCompass:Update(self.entrance, self.map)

	return
end

function SVOrderPanel:ClearComppass()
	self.wsCompass.map = nil

	self.wsCompass:RemoveCellsListener()

	return
end

function SVOrderPanel:ShowMsgbox(arg_31_1)
	local var_31_0 = nowWorld()
	local var_31_1 = var_31_0.staminaMgr:GetTotalStamina()

	setText(self.rtMsgStamina:Find("Text"), var_31_1)

	local var_31_2 = var_31_0:CalcOrderCost(arg_31_1)
	local var_31_3 = ""
	local var_31_4 = ""
	local var_31_5

	if arg_31_1 == WorldConst.OpReqMaintenance then
		var_31_3 = i18n("world_instruction_morale_1", setColorStr(var_31_2, COLOR_GREEN), setColorStr(var_31_1, (var_31_2 <= var_31_1 or nil) and (COLOR_GREEN or COLOR_RED)))
		var_31_4 = i18n("world_instruction_morale_4")

		function var_31_5()
			self:emit(WorldScene.SceneOp, "OpReqMaintenance", self.map:GetFleet().id)

			return
		end
	elseif arg_31_1 == WorldConst.OpReqSub then
		var_31_3 = i18n(var_31_0:IsSubmarineSupporting() and "world_instruction_submarine_7" or "world_instruction_submarine_2", setColorStr(var_31_2, COLOR_GREEN), setColorStr(var_31_1, (var_31_2 <= var_31_1 or nil) and (COLOR_GREEN or COLOR_RED)))
		var_31_4 = i18n("world_instruction_submarine_8")

		function var_31_5()
			self:emit(WorldScene.SceneOp, "OpReqSub")

			return
		end
	elseif arg_31_1 == WorldConst.OpReqVision then
		var_31_3 = i18n("world_instruction_detect_1", setColorStr(var_31_2, COLOR_GREEN), setColorStr(var_31_1, (var_31_2 <= var_31_1 or nil) and (COLOR_GREEN or COLOR_RED)))
		var_31_4 = i18n("world_instruction_submarine_8")

		function var_31_5()
			self:emit(WorldScene.SceneOp, "OpReqVision")

			return
		end
	else
		assert(false, "req error")
	end

	setText(self.rtMsgBase:Find("content"), var_31_3)
	setText(self.rtMsgBase:Find("other"), var_31_4)
	onButton(self, self.rtMsgBtns:Find("btn_confirm"), function()
		self:Hide()

		if var_31_0.staminaMgr:GetTotalStamina() < var_31_2 then
			var_31_0.staminaMgr:Show()
		else
			var_31_5()
		end

		return
	end, SFX_CONFIRM)
	setActive(self.rtMsgExtra, arg_31_1 == WorldConst.OpReqSub)

	if arg_31_1 == WorldConst.OpReqSub then
		setText(self.rtMsgExtra:Find("content/text_1"), i18n("world_instruction_submarine_9"))

		local var_31_12 = self.rtMsgExtra:Find("content/toggle_area/toggle")
		local var_31_13 = PlayerPrefs.GetInt("world_sub_auto_call", 0) == 1

		triggerToggle(var_31_12, var_31_13)
		onToggle(self, var_31_12, function(arg_36_0)
			var_31_13 = arg_36_0

			self:DisplayAutoSetting(true)

			return
		end, SFX_PANEL)

		local var_31_14 = pg.gameset.world_instruction_submarine.description[1]
		local var_31_15 = math.clamp(PlayerPrefs.GetInt("world_sub_call_line", 0), 0, pg.gameset.world_instruction_submarine.description[1])
		local var_31_16 = self.rtMsgExtra:Find("content/counter")

		setText(var_31_16:Find("number/Text"), var_31_15)
		pressPersistTrigger(var_31_16:Find("minus"), 0.5, function(arg_37_0)
			if var_31_15 == 0 then
				arg_37_0()

				return
			end

			var_31_15 = math.clamp(var_31_15 - 1, 0, var_31_14)

			setText(var_31_16:Find("number/Text"), var_31_15)
			self:DisplayAutoSetting(true)

			return
		end, nil, true, true, 0.1, SFX_PANEL)
		pressPersistTrigger(var_31_16:Find("plus"), 0.5, function(arg_38_0)
			if var_31_15 == var_31_14 then
				arg_38_0()

				return
			end

			var_31_15 = math.clamp(var_31_15 + 1, 0, var_31_14)

			setText(var_31_16:Find("number/Text"), var_31_15)
			self:DisplayAutoSetting(true)

			return
		end, nil, true, true, 0.1, SFX_PANEL)
		onButton(self, self.rtMsgBtns:Find("btn_setting"), function()
			isSetting = false

			PlayerPrefs.SetInt("world_sub_auto_call", var_31_13 and 1 or 0)
			PlayerPrefs.SetInt("world_sub_call_line", var_31_15)
			self:DisplayAutoSetting(false)
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_submarine_11"))

			return
		end, SFX_PANEL)
	end

	self:DisplayAutoSetting(false)
	setActive(self.rtMsgbox, true)
	pg.UIMgr.GetInstance():BlurPanel(self.rtMsgbox)

	return
end

function SVOrderPanel:HideMsgbox()
	setActive(self.rtMsgbox, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.rtMsgbox, self._tf)

	return
end

function SVOrderPanel:DisplayAutoSetting(arg_41_1)
	setActive(self.rtMsgBtns:Find("btn_confirm"), not arg_41_1)
	setActive(self.rtMsgBtns:Find("btn_setting"), arg_41_1)

	return
end

return SVOrderPanel
