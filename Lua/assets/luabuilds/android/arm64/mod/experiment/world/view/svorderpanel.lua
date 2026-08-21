local var_0_0 = class("SVOrderPanel", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "SVOrderPanel"
end

function var_0_0.getBGM(arg_2_0)
	return "echo-loop"
end

function var_0_0.OnLoaded(arg_3_0)
	return
end

function var_0_0.OnInit(arg_4_0)
	local var_4_0 = arg_4_0._tf:Find("adapt/order_list")

	arg_4_0.btnRedeploy = var_4_0:Find("redeploy")
	arg_4_0.btnExpansion = var_4_0:Find("expansion")
	arg_4_0.btnMaintenance = var_4_0:Find("maintenance")
	arg_4_0.btnFOV = var_4_0:Find("fov")
	arg_4_0.btnSubmarine = var_4_0:Find("submarine")
	arg_4_0.btnHelp = arg_4_0._tf:Find("adapt/help")

	onButton(arg_4_0, arg_4_0.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("world_instruction_help_1")
		})

		return
	end, SFX_PANEL)

	arg_4_0.btnBack = arg_4_0._tf:Find("adapt/back")

	onButton(arg_4_0, arg_4_0.btnBack, function()
		arg_4_0:Hide()

		return
	end, SFX_CANCEL)

	arg_4_0.rtRing = arg_4_0._tf:Find("bg/ring")
	arg_4_0.wsCompass = WSCompass.New()
	arg_4_0.wsCompass.tf = arg_4_0._tf:Find("bg/ring/compass")
	arg_4_0.wsCompass.pool = arg_4_0.contextData.wsPool

	arg_4_0.wsCompass:Setup(true)

	arg_4_0.rtMsgbox = arg_4_0._tf:Find("Msgbox")

	setText(arg_4_0.rtMsgbox:Find("window/top/bg/infomation/title"), i18n("title_info"))
	setActive(arg_4_0.rtMsgbox, false)
	onButton(arg_4_0, arg_4_0.rtMsgbox:Find("bg"), function()
		arg_4_0:HideMsgbox()

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0.rtMsgbox:Find("window/top/btnBack"), function()
		arg_4_0:HideMsgbox()

		return
	end, SFX_CANCEL)

	arg_4_0.rtMsgStamina = arg_4_0.rtMsgbox:Find("window/top/bg/stamina")

	setText(arg_4_0.rtMsgStamina:Find("name"), i18n("world_ap"))

	arg_4_0.rtMsgBase = arg_4_0.rtMsgbox:Find("window/msg_panel/base")
	arg_4_0.rtMsgExtra = arg_4_0.rtMsgbox:Find("window/msg_panel/extra")
	arg_4_0.rtMsgBtns = arg_4_0.rtMsgbox:Find("window/button_container")

	setText(arg_4_0.rtMsgBtns:Find("btn_setting/pic"), i18n("msgbox_text_save"))
	setText(arg_4_0.rtMsgBtns:Find("btn_confirm/pic"), i18n("text_confirm"))
	setText(arg_4_0.rtMsgBtns:Find("btn_cancel/pic"), i18n("text_cancel"))
	onButton(arg_4_0, arg_4_0.rtMsgBtns:Find("btn_cancel"), function()
		arg_4_0:HideMsgbox()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.OnDestroy(arg_10_0)
	arg_10_0:ClearBtnTimers()
	arg_10_0.wsCompass:Dispose()

	return
end

function var_0_0.Show(arg_11_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_11_0._tf)
	var_0_0.super.Show(arg_11_0)

	return
end

function var_0_0.Hide(arg_12_0)
	if isActive(arg_12_0.rtMsgbox) then
		arg_12_0:HideMsgbox()
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_12_0._tf, arg_12_0._parentTf)
	arg_12_0:ClearComppass()
	arg_12_0:ClearBtnTimers()
	var_0_0.super.Hide(arg_12_0)

	return
end

function var_0_0.Setup(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0:Update(arg_13_1, arg_13_2)
	arg_13_0.wsCompass:SetAnchorEulerAngles(arg_13_3)

	return
end

function var_0_0.Update(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.entrance ~= arg_14_1 or arg_14_0.map ~= arg_14_2 or arg_14_0.gid ~= arg_14_2.gid then
		arg_14_0.entrance = arg_14_1
		arg_14_0.map = arg_14_2
		arg_14_0.gid = arg_14_2.gid
	end

	arg_14_0:UpdateCompassMarks()
	arg_14_0:UpdateOrderBtn()

	return
end

function var_0_0.SetButton(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1:Find("type_lock")
	local var_15_1 = arg_15_1:Find("type_unable")
	local var_15_2 = arg_15_1:Find("type_enable")

	setActive(var_15_0, not nowWorld():IsSystemOpen(arg_15_2.system))

	local var_15_4 = var_15_1

	if not isActive(var_15_0) then
		local var_15_5 = arg_15_2.isLock or arg_15_2.timeStamp and arg_15_2.timeStamp > pg.TimeMgr.GetInstance():GetServerTime()

		var_15_3(var_15_4, var_15_5)
		setActive(var_15_2, not isActive(var_15_0) and not isActive(var_15_1))

		if isActive(var_15_0) then
			onButton(arg_15_0, var_15_0, function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_all_1"))

				return
			end, SFX_CONFIRM)
		end

		if isActive(var_15_1) then
			setActive(var_15_1:Find("cost"), arg_15_2.isLock)
			setActive(var_15_1:Find("time"), not arg_15_2.isLock)

			if arg_15_2.isLock then
				setText(var_15_1:Find("cost/Text"), arg_15_2.cost)
				onButton(arg_15_0, var_15_1, arg_15_2.lockFunc, SFX_CONFIRM)
			else
				arg_15_0.timers[var_15_1] = Timer.New(function()
					local var_17_0 = arg_15_2.timeStamp - pg.TimeMgr.GetInstance():GetServerTime()

					if var_17_0 < 0 then
						arg_15_0:UpdateOrderBtn()
					else
						setText(var_15_1:Find("time/Text"), string.format("%d:%02d:%02d", math.floor(var_17_0 / 16), math.floor(var_17_0 % 16 / 60), var_17_0 % 60))
					end

					return
				end, 1, -1)

				arg_15_0.timers[var_15_1].func()
				arg_15_0.timers[var_15_1]:Start()
				onButton(arg_15_0, var_15_1, arg_15_2.timeFunc, SFX_CONFIRM)
			end
		end

		if isActive(var_15_2) then
			setText(var_15_2:Find("cost/Text"), arg_15_2.cost)
			onButton(arg_15_0, var_15_2, arg_15_2.enableFunc, SFX_CONFIRM)
		end

		return
	end
end

function var_0_0.UpdateOrderBtn(arg_18_0)
	arg_18_0:ClearBtnTimers()

	arg_18_0.timers = {}

	local var_18_0 = nowWorld()
	local var_18_1 = arg_18_0.map:GetConfig("instruction_available")
	local var_18_2 = checkExist(arg_18_0.map, {
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
			arg_18_0:Hide()
			arg_18_0:emit(WorldScene.SceneOp, "OpRedeploy")

			return
		end
	}

	arg_18_0:SetButton(arg_18_0.btnRedeploy, var_18_5)
	arg_18_0:SetButton(arg_18_0.btnExpansion, var_18_5)
	setActive(arg_18_0.btnRedeploy, var_18_4 ~= WorldConst.FleetExpansion)
	setActive(arg_18_0.btnExpansion, var_18_4 == WorldConst.FleetExpansion)

	local var_18_6 = arg_18_0
	local var_18_8 = arg_18_0.btnSubmarine
	local var_18_9 = {
		system = WorldConst.SystemOrderSubmarine
	}

	var_18_9.isLock = var_18_1[1] == 0 or not var_18_0:CanCallSubmarineSupport() or var_18_0:IsSubmarineSupporting() and var_18_0:GetSubAidFlag()

	function var_18_9.lockFunc()
		if var_18_1[1] == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_submarine_1"))
		elseif not var_18_0:CanCallSubmarineSupport() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_submarine_4"))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_submarine_3"))
		end

		return
	end

	var_18_9.cost = var_18_0:CalcOrderCost(WorldConst.OpReqSub)

	function var_18_9.enableFunc()
		arg_18_0:ShowMsgbox(WorldConst.OpReqSub)

		return
	end

	var_18_7(var_18_6, var_18_8, var_18_9)
	arg_18_0:SetButton(arg_18_0.btnFOV, {
		system = WorldConst.SystemOrderFOV,
		isLock = var_18_1[2] == 0 or arg_18_0.map.visionFlag,
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
			arg_18_0:ShowMsgbox(WorldConst.OpReqVision)

			return
		end
	})

	local var_18_10 = pg.TimeMgr.GetInstance()

	arg_18_0:SetButton(arg_18_0.btnMaintenance, {
		system = WorldConst.SystemOrderMaintenance,
		isLock = var_18_1[3] == 0,
		lockFunc = function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_submarine_1"))

			return
		end,
		timeStamp = var_18_0:GetReqCDTime(WorldConst.OpReqMaintenance) + pg.gameset.world_instruction_maintenance.description[2],
		timeFunc = function(arg_26_0)
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_supply_2", var_18_10:DescCDTime(var_0 - pg.TimeMgr.GetInstance():GetServerTime())))

			return
		end,
		cost = var_18_0:CalcOrderCost(WorldConst.OpReqMaintenance),
		enableFunc = function()
			arg_18_0:ShowMsgbox(WorldConst.OpReqMaintenance)

			return
		end
	})

	return
end

function var_0_0.ClearBtnTimers(arg_28_0)
	if arg_28_0.timers then
		for iter_28_0, iter_28_1 in pairs(arg_28_0.timers) do
			iter_28_1:Stop()
		end
	end

	arg_28_0.timers = nil

	return
end

function var_0_0.UpdateCompassMarks(arg_29_0)
	arg_29_0.wsCompass:ClearMarks()
	arg_29_0.wsCompass:Update(arg_29_0.entrance, arg_29_0.map)

	return
end

function var_0_0.ClearComppass(arg_30_0)
	arg_30_0.wsCompass.map = nil

	arg_30_0.wsCompass:RemoveCellsListener()

	return
end

function var_0_0.ShowMsgbox(arg_31_0, arg_31_1)
	local var_31_0 = nowWorld()
	local var_31_1 = var_31_0.staminaMgr:GetTotalStamina()

	setText(arg_31_0.rtMsgStamina:Find("Text"), var_31_1)

	local var_31_2 = var_31_0:CalcOrderCost(arg_31_1)
	local var_31_3 = ""
	local var_31_4 = ""
	local var_31_5

	if arg_31_1 == WorldConst.OpReqMaintenance then
		local var_31_7 = "world_instruction_morale_1"
		local var_31_8 = setColorStr(var_31_2, COLOR_GREEN)

		if var_31_2 <= var_31_1 then
			var_31_3 = var_31_6(var_31_7, var_31_8, var_31_9(var_31_10, var_31_11))
			var_31_4 = i18n("world_instruction_morale_4")

			function var_31_5()
				arg_31_0:emit(WorldScene.SceneOp, "OpReqMaintenance", arg_31_0.map:GetFleet().id)

				return
			end

			goto label_31_0

			::label_31_0::

			if arg_31_1 == WorldConst.OpReqSub then
				local var_31_13 = var_31_0:IsSubmarineSupporting() and "world_instruction_submarine_7" or "world_instruction_submarine_2"
				local var_31_14 = setColorStr(var_31_2, COLOR_GREEN)

				if var_31_2 <= var_31_1 then
					var_31_3 = var_31_12(var_31_13, var_31_14, var_31_15(var_31_16, var_31_17))
					var_31_4 = i18n("world_instruction_submarine_8")

					function var_31_5()
						arg_31_0:emit(WorldScene.SceneOp, "OpReqSub")

						return
					end

					goto label_31_0

					if arg_31_1 == WorldConst.OpReqVision then
						local var_31_19 = "world_instruction_detect_1"
						local var_31_20 = setColorStr(var_31_2, COLOR_GREEN)

						if var_31_2 <= var_31_1 then
							do
								var_31_3 = var_31_18(var_31_19, var_31_20, var_31_21(var_31_22, var_31_23))
								var_31_4 = i18n("world_instruction_submarine_8")

								function var_31_5()
									arg_31_0:emit(WorldScene.SceneOp, "OpReqVision")

									return
								end

								if false then
									assert(false, "req error")
								end
							end

							setText(arg_31_0.rtMsgBase:Find("content"), var_31_3)
							setText(arg_31_0.rtMsgBase:Find("other"), var_31_4)
							onButton(arg_31_0, arg_31_0.rtMsgBtns:Find("btn_confirm"), function()
								arg_31_0:Hide()

								if var_31_0.staminaMgr:GetTotalStamina() < var_31_2 then
									var_31_0.staminaMgr:Show()
								else
									var_31_5()
								end

								return
							end, SFX_CONFIRM)
							setActive(arg_31_0.rtMsgExtra, arg_31_1 == WorldConst.OpReqSub)

							if arg_31_1 == WorldConst.OpReqSub then
								setText(arg_31_0.rtMsgExtra:Find("content/text_1"), i18n("world_instruction_submarine_9"))

								local var_31_24 = arg_31_0.rtMsgExtra:Find("content/toggle_area/toggle")

								triggerToggle(var_31_24, PlayerPrefs.GetInt("world_sub_auto_call", 0) == 1)
								onToggle(arg_31_0, var_31_24, function(arg_36_0)
									var_0 = arg_36_0

									arg_31_0:DisplayAutoSetting(true)

									return
								end, SFX_PANEL)

								local var_31_25 = arg_31_0.rtMsgExtra:Find("content/counter")

								setText(var_31_25:Find("number/Text"), (math.clamp(PlayerPrefs.GetInt("world_sub_call_line", 0), 0, pg.gameset.world_instruction_submarine.description[1])))
								pressPersistTrigger(var_31_25:Find("minus"), 0.5, function(arg_37_0)
									if var_0 == 0 then
										arg_37_0()

										return
									end

									var_0 = math.clamp(var_0 - 1, 0, var_0)

									setText(var_31_25:Find("number/Text"), var_0)
									arg_31_0:DisplayAutoSetting(true)

									return
								end, nil, true, true, 0.1, SFX_PANEL)
								pressPersistTrigger(var_31_25:Find("plus"), 0.5, function(arg_38_0)
									if var_0 == var_0 then
										arg_38_0()

										return
									end

									var_0 = math.clamp(var_0 + 1, 0, var_0)

									setText(var_31_25:Find("number/Text"), var_0)
									arg_31_0:DisplayAutoSetting(true)

									return
								end, nil, true, true, 0.1, SFX_PANEL)
								onButton(arg_31_0, arg_31_0.rtMsgBtns:Find("btn_setting"), function()
									isSetting = false

									PlayerPrefs.SetInt("world_sub_auto_call", var_0 and 1 or 0)
									PlayerPrefs.SetInt("world_sub_call_line", var_0)
									arg_31_0:DisplayAutoSetting(false)
									pg.TipsMgr.GetInstance():ShowTips(i18n("world_instruction_submarine_11"))

									return
								end, SFX_PANEL)
							end

							arg_31_0:DisplayAutoSetting(false)
							setActive(arg_31_0.rtMsgbox, true)
							pg.UIMgr.GetInstance():BlurPanel(arg_31_0.rtMsgbox)

							return
						end
					end
				end
			end
		end
	end
end

function var_0_0.HideMsgbox(arg_40_0)
	setActive(arg_40_0.rtMsgbox, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_40_0.rtMsgbox, arg_40_0._tf)

	return
end

function var_0_0.DisplayAutoSetting(arg_41_0, arg_41_1)
	setActive(arg_41_0.rtMsgBtns:Find("btn_confirm"), not arg_41_1)
	setActive(arg_41_0.rtMsgBtns:Find("btn_setting"), arg_41_1)

	return
end

return var_0_0
