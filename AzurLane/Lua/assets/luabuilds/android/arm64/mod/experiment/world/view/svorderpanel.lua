class = var_0_10000

local var_0_0 = "SVOrderPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SVOrderPanel"
end

function var_0_1.getBGM(arg_2_0)
	return "echo-loop"
end

function var_0_1.OnLoaded(arg_3_0)
	return
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "adapt/order_list")

	arg_4_0.btnRedeploy = var_2.Find(var_4_1, "redeploy")
	arg_4_0.btnExpansion = var_2:Find("expansion")
	arg_4_0.btnMaintenance = var_2:Find("maintenance")
	arg_4_0.btnFOV = var_2:Find("fov")
	arg_4_0.btnSubmarine = var_2:Find("submarine")
	arg_4_0.btnHelp = var_1:Find("adapt/help")
	onButton = var_3

	local var_4_2 = arg_4_0
	local var_4_3 = arg_4_0.btnHelp

	local function var_4_4()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_5_2.type = var_2_10004
		i18n = var_2_10004
		var_5_2.helps = var_2_10004("world_instruction_help_1")

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10008

	var_3(var_4_2, var_4_3, var_4_4, var_1_10008)

	arg_4_0.btnBack = var_1:Find("adapt/back")
	onButton = var_3

	local var_4_5 = arg_4_0
	local var_4_6 = arg_4_0.btnBack

	local function var_4_7()
		local var_6_0 = arg_4_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10008

	var_3(var_4_5, var_4_6, var_4_7, var_1_10008)

	arg_4_0.rtRing = var_1:Find("bg/ring")
	WSCompass = var_3
	arg_4_0.wsCompass = var_3.New()
	arg_4_0.wsCompass.tf = var_1:Find("bg/ring/compass")
	arg_4_0.wsCompass.pool = arg_4_0.contextData.wsPool

	local var_4_8 = arg_4_0.wsCompass

	var_3.Setup(var_4_8, true)

	arg_4_0.rtMsgbox = var_1:Find("Msgbox")
	setText = var_3

	local var_4_9 = arg_4_0.rtMsgbox
	local var_4_10 = var_5.Find(var_4_9, "window/top/bg/infomation/title")

	i18n = var_6

	var_3(var_4_10, var_6("title_info"))

	setActive = var_3

	var_3(arg_4_0.rtMsgbox, false)

	onButton = var_3

	local var_4_11 = arg_4_0
	local var_4_12 = arg_4_0.rtMsgbox
	local var_4_13 = var_6.Find(var_4_12, "bg")

	local function var_4_14()
		local var_7_0 = arg_4_0

		var_0.HideMsgbox(var_7_0)

		return
	end

	SFX_CANCEL = var_4_12

	var_3(var_4_11, var_4_13, var_4_14, var_4_12)

	onButton = var_3

	local var_4_15 = arg_4_0
	local var_4_16 = arg_4_0.rtMsgbox
	local var_4_17 = var_6.Find(var_4_16, "window/top/btnBack")

	local function var_4_18()
		local var_8_0 = arg_4_0

		var_0.HideMsgbox(var_8_0)

		return
	end

	SFX_CANCEL = var_4_16

	var_3(var_4_15, var_4_17, var_4_18, var_4_16)

	local var_4_19 = arg_4_0.rtMsgbox

	arg_4_0.rtMsgStamina = var_3.Find(var_4_19, "window/top/bg/stamina")
	setText = var_3

	local var_4_20 = arg_4_0.rtMsgStamina
	local var_4_21 = var_5.Find(var_4_20, "name")

	i18n = var_6

	var_3(var_4_21, var_6("world_ap"))

	local var_4_22 = arg_4_0.rtMsgbox

	arg_4_0.rtMsgBase = var_3.Find(var_4_22, "window/msg_panel/base")

	local var_4_23 = arg_4_0.rtMsgbox

	arg_4_0.rtMsgExtra = var_3.Find(var_4_23, "window/msg_panel/extra")

	local var_4_24 = arg_4_0.rtMsgbox

	arg_4_0.rtMsgBtns = var_3.Find(var_4_24, "window/button_container")
	setText = var_3

	local var_4_25 = arg_4_0.rtMsgBtns
	local var_4_26 = var_5.Find(var_4_25, "btn_setting/pic")

	i18n = var_6

	var_3(var_4_26, var_6("msgbox_text_save"))

	setText = var_3

	local var_4_27 = arg_4_0.rtMsgBtns
	local var_4_28 = var_5.Find(var_4_27, "btn_confirm/pic")

	i18n = var_6

	var_3(var_4_28, var_6("text_confirm"))

	setText = var_3

	local var_4_29 = arg_4_0.rtMsgBtns
	local var_4_30 = var_5.Find(var_4_29, "btn_cancel/pic")

	i18n = var_6

	var_3(var_4_30, var_6("text_cancel"))

	onButton = var_3

	local var_4_31 = arg_4_0
	local var_4_32 = arg_4_0.rtMsgBtns
	local var_4_33 = var_6.Find(var_4_32, "btn_cancel")

	local function var_4_34()
		local var_9_0 = arg_4_0

		var_0.HideMsgbox(var_9_0)

		return
	end

	SFX_CANCEL = var_4_32

	var_3(var_4_31, var_4_33, var_4_34, var_4_32)

	return
end

function var_0_1.OnDestroy(arg_10_0)
	arg_10_0:ClearBtnTimers()

	local var_10_0 = arg_10_0.wsCompass

	var_1.Dispose(var_10_0)

	return
end

function var_0_1.Show(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_11_0, arg_11_0._tf)
	var_0_1.super.Show(arg_11_0)

	return
end

function var_0_1.Hide(arg_12_0)
	isActive = var_1_10001

	if var_1_10001(arg_12_0.rtMsgbox) then
		arg_12_0:HideMsgbox()
	end

	pg = var_1

	local var_12_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_12_0, arg_12_0._tf, arg_12_0._parentTf)
	arg_12_0:ClearComppass()
	arg_12_0:ClearBtnTimers()
	var_0_1.super.Hide(arg_12_0)

	return
end

function var_0_1.Setup(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0:Update(arg_13_1, arg_13_2)

	local var_13_0 = arg_13_0.wsCompass

	var_4.SetAnchorEulerAngles(var_13_0, arg_13_3)

	return
end

function var_0_1.Update(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.entrance ~= arg_14_1 or arg_14_0.map ~= arg_14_2 or arg_14_0.gid ~= arg_14_2.gid then
		arg_14_0.entrance = arg_14_1
		arg_14_0.map = arg_14_2
		arg_14_0.gid = arg_14_2.gid
	end

	arg_14_0:UpdateCompassMarks()
	arg_14_0:UpdateOrderBtn()

	return
end

function var_0_1.SetButton(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1:Find("type_lock")
	local var_15_1 = arg_15_1
	local var_15_2 = arg_15_1.Find(var_15_1, "type_unable")
	local var_15_3 = arg_15_1
	local var_15_4 = arg_15_1.Find(var_15_3, "type_enable")

	nowWorld = var_15_1

	local var_15_5 = var_15_1()
	local var_15_6 = var_6.IsSystemOpen(var_15_5, arg_15_2.system)

	setActive = var_15_3

	var_15_3(var_15_0, not var_15_6)

	setActive = var_15_3

	local var_15_7 = var_15_2

	isActive = var_10

	if not var_10(var_15_0) then
		local var_15_8

		if not arg_15_2.isLock and arg_15_2.timeStamp then
			var_15_8 = arg_15_2.timeStamp
			pg = var_1_10011

			local var_15_9 = var_1_10011.TimeMgr.GetInstance()

			if not (var_15_8 > var_11.GetServerTime(var_15_9)) then
				var_15_8 = false
			else
				var_15_8 = true
			end
		end

		var_15_3(var_15_7, var_15_8)

		setActive = var_15_3

		local var_15_10 = var_15_4

		isActive = var_15_8

		local var_15_11

		if not var_15_8(var_15_0) then
			isActive = var_10
			var_15_11 = not var_10(var_15_2)
		else
			var_15_11 = false
		end

		if false then
			var_15_11 = true
		end

		var_15_3(var_15_10, var_15_11)

		isActive = var_15_3

		if var_15_3(var_15_0) then
			onButton = var_7

			local var_15_12 = arg_15_0
			local var_15_13 = var_15_0

			local function var_15_14()
				pg = var_2_10000

				local var_16_0 = var_2_10000.TipsMgr.GetInstance()
				local var_16_1 = var_0.ShowTips

				i18n = var_2_10003

				var_16_1(var_16_0, var_2_10003("world_instruction_all_1"))

				return
			end

			SFX_CONFIRM = var_12

			var_7(var_15_12, var_15_13, var_15_14, var_12)
		end

		isActive = var_7

		local var_15_18

		if var_7(var_15_2) then
			setActive = var_15_18

			var_15_18(var_15_2:Find("cost"), arg_15_2.isLock)

			setActive = var_15_18

			var_15_18(var_15_2:Find("time"), not arg_15_2.isLock)

			if arg_15_2.isLock then
				setText = var_15_18

				var_15_18(var_15_2:Find("cost/Text"), arg_15_2.cost)

				onButton = var_15_18

				local var_15_15 = arg_15_0
				local var_15_16 = var_15_2
				local var_15_17 = arg_15_2.lockFunc

				SFX_CONFIRM = var_12

				var_15_18(var_15_15, var_15_16, var_15_17, var_12)
			else
				var_15_18 = arg_15_0.timers
				Timer = var_15_5
				var_15_18[var_15_2] = var_15_5.New(function()
					local var_17_0 = arg_15_2.timeStamp

					pg = var_2_10001

					local var_17_1 = var_2_10001.TimeMgr.GetInstance()

					if var_17_0 - var_1.GetServerTime(var_17_1) < 0 then
						local var_17_2 = arg_15_0

						var_1.UpdateOrderBtn(var_17_2)
					else
						setText = var_1

						local var_17_3 = var_15_2
						local var_17_4 = var_3.Find(var_17_3, "time/Text")

						string = var_2_10004

						local var_17_5 = var_2_10004.format
						local var_17_6 = "%d:%02d:%02d"

						math = var_2_10007

						local var_17_7 = var_2_10007.floor(var_0 / 16)

						math = var_2_10008

						var_1(var_17_4, var_17_5(var_17_6, var_17_7, var_2_10008.floor(var_0 % 16 / 60), var_0 % 60))
					end

					return
				end, 1, -1)

				arg_15_0.timers[var_15_2].func()

				local var_15_19 = arg_15_0.timers[var_15_2]

				var_15_18.Start(var_15_19)

				onButton = var_15_18

				local var_15_20 = arg_15_0
				local var_15_21 = var_15_2
				local var_15_22 = arg_15_2.timeFunc

				SFX_CONFIRM = var_12

				var_15_18(var_15_20, var_15_21, var_15_22, var_12)
			end
		end

		isActive = var_15_18

		if var_15_18(var_15_4) then
			setText = var_7

			var_7(var_15_4:Find("cost/Text"), arg_15_2.cost)

			onButton = var_7

			local var_15_23 = arg_15_0
			local var_15_24 = var_15_4
			local var_15_25 = arg_15_2.enableFunc

			SFX_CONFIRM = var_12

			var_7(var_15_23, var_15_24, var_15_25, var_12)
		end

		return
	end
end

function var_0_1.UpdateOrderBtn(arg_18_0)
	local var_18_0 = arg_18_0

	arg_18_0.ClearBtnTimers(var_18_0)

	arg_18_0.timers = {}
	nowWorld = var_1

	local var_18_1 = var_1()
	local var_18_2 = arg_18_0.map
	local var_18_3 = var_2.GetConfig(var_18_2, "instruction_available")

	checkExist = var_18_0

	local var_18_4 = var_18_0(arg_18_0.map, {
		"GetPort"
	})
	local var_18_5 = var_18_1:GetRealm()
	local var_18_6 = var_18_1
	local var_18_7 = var_18_1.IsSystemOpen

	WorldConst = var_1_10008

	if var_18_7(var_18_6, var_1_10008.SystemOrderRedeploy) then
		checkExist = var_18_10

		local var_18_8, var_18_10

		if var_18_5 == var_18_10(var_18_4, {
			"GetRealm"
		}) then
			checkExist = var_18_10
			var_18_6 = var_18_4
			var_18_8 = {
				"IsOpen"
			}

			local var_18_9 = {
				var_18_5
			}

			var_1_10012 = var_18_1
			var_18_9[2] = var_18_1.GetProgress(var_1_10012)
			var_18_8[2] = var_18_9

			if var_18_10(var_18_6, var_18_8) then
				var_18_6 = var_18_1
				var_18_10 = var_18_1.BuildFormationIds(var_18_6)
			end
		else
			var_18_10 = false
		end
	end

	if false then
		var_18_10 = true
	end

	local var_18_11 = {}

	WorldConst = var_18_6
	var_18_11.system = var_18_6.SystemOrderRedeploy
	var_18_11.isLock = not var_18_10

	function var_18_11.lockFunc()
		pg = var_2_10000

		local var_19_0 = var_2_10000.TipsMgr.GetInstance()
		local var_19_1 = var_0.ShowTips

		i18n = var_2_10003

		var_19_1(var_19_0, var_2_10003("world_instruction_redeploy_1"))

		return
	end

	local var_18_12 = var_18_1
	local var_18_13 = var_18_1.CalcOrderCost

	WorldConst = var_1_10010
	var_18_11.cost = var_18_13(var_18_12, var_1_10010.OpReqRedeploy)

	function var_18_11.enableFunc(arg_20_0, arg_20_1)
		local var_20_0 = arg_18_0

		var_2.Hide(var_20_0)

		local var_20_1 = arg_18_0
		local var_20_2 = var_2.emit

		WorldScene = var_2_10005

		var_20_2(var_20_1, var_2_10005.SceneOp, "OpRedeploy")

		return
	end

	arg_18_0:SetButton(arg_18_0.btnRedeploy, var_18_11)
	arg_18_0:SetButton(arg_18_0.btnExpansion, var_18_11)

	setActive = var_7

	local var_18_14 = arg_18_0.btnRedeploy

	WorldConst = var_10

	var_7(var_18_14, var_18_10 ~= var_10.FleetExpansion)

	setActive = var_7

	local var_18_15 = arg_18_0.btnExpansion

	WorldConst = var_10

	var_7(var_18_15, var_18_10 == var_10.FleetExpansion)

	local var_18_16 = arg_18_0
	local var_18_17 = arg_18_0.SetButton
	local var_18_18 = arg_18_0.btnSubmarine
	local var_18_19 = {}

	WorldConst = var_1_10012
	var_18_19.system = var_1_10012.SystemOrderSubmarine

	if var_18_3[1] ~= 0 and var_18_1:CanCallSubmarineSupport() then
		if var_18_1:IsSubmarineSupporting() then
			local var_18_20 = var_18_1:GetSubAidFlag()
		end

		if false then
			var_18_20 = false
		end
	else
		var_18_20 = true
	end

	var_18_19.isLock = var_18_20

	function var_18_19.lockFunc()
		if var_18_3[1] == 0 then
			pg = var_0

			local var_21_0 = var_0.TipsMgr.GetInstance()
			local var_21_1 = var_0.ShowTips

			i18n = var_2_10003

			var_21_1(var_21_0, var_2_10003("world_instruction_submarine_1"))
		else
			local var_21_2 = var_18_1
			local var_21_4

			if not var_0.CanCallSubmarineSupport(var_21_2) then
				pg = var_21_4

				local var_21_3 = var_21_4.TipsMgr.GetInstance()

				var_21_4 = var_21_4.ShowTips
				i18n = var_2_10003

				var_21_4(var_21_3, var_2_10003("world_instruction_submarine_4"))
			else
				pg = var_21_4

				local var_21_5 = var_21_4.TipsMgr.GetInstance()
				local var_21_6 = var_0.ShowTips

				i18n = var_2_10003

				var_21_6(var_21_5, var_2_10003("world_instruction_submarine_3"))
			end
		end

		return
	end

	local var_18_21 = var_18_1
	local var_18_22 = var_18_1.CalcOrderCost

	WorldConst = var_1_10015
	var_18_19.cost = var_18_22(var_18_21, var_1_10015.OpReqSub)

	function var_18_19.enableFunc()
		local var_22_0 = arg_18_0
		local var_22_1 = var_0.ShowMsgbox

		WorldConst = var_2_10003

		var_22_1(var_22_0, var_2_10003.OpReqSub)

		return
	end

	var_18_17(var_18_16, var_18_18, var_18_19)

	local var_18_23 = arg_18_0
	local var_18_24 = arg_18_0.SetButton
	local var_18_25 = arg_18_0.btnFOV
	local var_18_26 = {}

	WorldConst = var_12
	var_18_26.system = var_12.SystemOrderFOV
	var_18_26.isLock = var_18_3[2] == 0 or arg_18_0.map.visionFlag

	function var_18_26.lockFunc()
		local var_23_1

		if var_18_3[2] == 0 then
			pg = var_23_1

			local var_23_0 = var_23_1.TipsMgr.GetInstance()

			var_23_1 = var_23_1.ShowTips
			i18n = var_2_10003

			var_23_1(var_23_0, var_2_10003("world_instruction_submarine_1"))
		else
			pg = var_23_1

			local var_23_2 = var_23_1.TipsMgr.GetInstance()
			local var_23_3 = var_0.ShowTips

			i18n = var_2_10003

			var_23_3(var_23_2, var_2_10003("world_instruction_detect_2"))
		end

		return
	end

	local var_18_27 = var_18_1
	local var_18_28 = var_18_1.CalcOrderCost

	WorldConst = var_15
	var_18_26.cost = var_18_28(var_18_27, var_15.OpReqVision)

	function var_18_26.enableFunc()
		local var_24_0 = arg_18_0
		local var_24_1 = var_0.ShowMsgbox

		WorldConst = var_2_10003

		var_24_1(var_24_0, var_2_10003.OpReqVision)

		return
	end

	var_18_24(var_18_23, var_18_25, var_18_26)

	pg = var_18_24

	local var_18_29 = var_18_24.TimeMgr.GetInstance()

	pg = var_18_8

	local var_18_30 = var_18_8.gameset.world_instruction_maintenance.description[2]
	local var_18_31 = var_18_1
	local var_18_32 = var_18_1.GetReqCDTime

	WorldConst = var_12

	local var_18_33 = var_18_32(var_18_31, var_12.OpReqMaintenance) + var_18_30
	local var_18_34 = arg_18_0
	local var_18_35 = arg_18_0.SetButton
	local var_18_36 = arg_18_0.btnMaintenance
	local var_18_37 = {}

	WorldConst = var_15
	var_18_37.system = var_15.SystemOrderMaintenance
	var_18_37.isLock = var_18_3[3] == 0

	function var_18_37.lockFunc()
		pg = var_2_10000

		local var_25_0 = var_2_10000.TipsMgr.GetInstance()
		local var_25_1 = var_0.ShowTips

		i18n = var_2_10003

		var_25_1(var_25_0, var_2_10003("world_instruction_submarine_1"))

		return
	end

	var_18_37.timeStamp = var_18_33

	function var_18_37.timeFunc(arg_26_0)
		pg = var_2_10001

		local var_26_0 = var_2_10001.TipsMgr.GetInstance()
		local var_26_1 = var_1.ShowTips

		i18n = var_2_10004

		local var_26_2 = "world_instruction_supply_2"
		local var_26_3 = var_18_29
		local var_26_4 = var_7.DescCDTime
		local var_26_5 = var_18_33

		pg = var_2_10011

		local var_26_6 = var_2_10011.TimeMgr.GetInstance()

		var_26_1(var_26_0, var_2_10004(var_26_2, var_26_4(var_26_3, var_26_5 - var_11.GetServerTime(var_26_6))))

		return
	end

	local var_18_38 = var_18_1
	local var_18_39 = var_18_1.CalcOrderCost

	WorldConst = var_1_10018
	var_18_37.cost = var_18_39(var_18_38, var_1_10018.OpReqMaintenance)

	function var_18_37.enableFunc()
		local var_27_0 = arg_18_0
		local var_27_1 = var_0.ShowMsgbox

		WorldConst = var_2_10003

		var_27_1(var_27_0, var_2_10003.OpReqMaintenance)

		return
	end

	var_18_35(var_18_34, var_18_36, var_18_37)

	return
end

function var_0_1.ClearBtnTimers(arg_28_0)
	if arg_28_0.timers then
		pairs = var_1

		for iter_28_0, iter_28_1 in var_1(arg_28_0.timers) do
			iter_28_1:Stop()
		end
	end

	arg_28_0.timers = nil

	return
end

function var_0_1.UpdateCompassMarks(arg_29_0)
	local var_29_0 = arg_29_0.wsCompass

	var_1.ClearMarks(var_29_0)

	local var_29_1 = arg_29_0.wsCompass

	var_1.Update(var_29_1, arg_29_0.entrance, arg_29_0.map)

	return
end

function var_0_1.ClearComppass(arg_30_0)
	arg_30_0.wsCompass.map = nil

	local var_30_0 = arg_30_0.wsCompass

	var_1.RemoveCellsListener(var_30_0)

	return
end

function var_0_1.ShowMsgbox(arg_31_0, arg_31_1)
	nowWorld = var_1_10002

	local var_31_0 = var_1_10002().staminaMgr
	local var_31_1 = var_3.GetTotalStamina(var_31_0)

	setText = var_1_10004

	local var_31_2 = arg_31_0.rtMsgStamina

	var_1_10004(var_6.Find(var_31_2, "Text"), var_31_1)

	local var_31_3 = var_2:CalcOrderCost(arg_31_1)
	local var_31_4 = ""
	local var_31_5 = ""
	local var_31_6

	WorldConst = var_31_2

	if arg_31_1 == var_31_2.OpReqMaintenance then
		i18n = var_8

		local var_31_7 = "world_instruction_morale_1"

		setColorStr = var_1_10011

		local var_31_8 = var_31_3

		COLOR_GREEN = var_1_10014
		var_1_10011 = var_1_10011(var_31_8, var_1_10014)
		setColorStr = var_1_10012
		var_1_10014 = var_31_1

		if var_31_3 <= var_31_1 then
			COLOR_GREEN = var_1_10015

			if not var_1_10015 then
				COLOR_RED = var_1_10015
			end

			var_31_4 = var_8(var_31_7, var_1_10011, var_1_10012(var_1_10014, var_1_10015))
			i18n = var_8
			var_31_5 = var_8("world_instruction_morale_4")

			function var_31_6()
				local var_32_0 = arg_31_0
				local var_32_1 = var_0.emit

				WorldScene = var_2_10003

				local var_32_2 = var_2_10003.SceneOp
				local var_32_3 = "OpReqMaintenance"
				local var_32_4 = arg_31_0.map

				var_32_1(var_32_0, var_32_2, var_32_3, var_5.GetFleet(var_32_4).id)

				return
			end

			goto label_31_0

			WorldConst = var_8

			if arg_31_1 == var_8.OpReqSub then
				i18n = var_8
				var_1_10012 = var_2

				local var_31_9 = var_2.IsSubmarineSupporting(var_1_10012) and "world_instruction_submarine_7" or "world_instruction_submarine_2"

				setColorStr = var_1_10011

				local var_31_10 = var_31_3

				COLOR_GREEN = var_1_10014
				var_1_10011 = var_1_10011(var_31_10, var_1_10014)
				setColorStr = var_1_10012
				var_1_10014 = var_31_1

				if var_31_3 <= var_31_1 then
					COLOR_GREEN = var_1_10015

					if not var_1_10015 then
						COLOR_RED = var_1_10015
					end

					var_31_4 = var_8(var_31_9, var_1_10011, var_1_10012(var_1_10014, var_1_10015))
					i18n = var_8
					var_31_5 = var_8("world_instruction_submarine_8")

					function var_31_6()
						local var_33_0 = arg_31_0
						local var_33_1 = var_0.emit

						WorldScene = var_2_10003

						var_33_1(var_33_0, var_2_10003.SceneOp, "OpReqSub")

						return
					end

					goto label_31_0

					WorldConst = var_8

					if arg_31_1 == var_8.OpReqVision then
						i18n = var_8

						local var_31_11 = "world_instruction_detect_1"

						setColorStr = var_1_10011

						local var_31_12 = var_31_3

						COLOR_GREEN = var_1_10014

						local var_31_13 = var_1_10011(var_31_12, var_1_10014)

						setColorStr = var_1_10012

						local var_31_14 = var_31_1

						if var_31_3 <= var_31_1 then
							COLOR_GREEN = var_1_10015

							if not var_1_10015 then
								COLOR_RED = var_1_10015
							end

							var_31_4 = var_8(var_31_11, var_31_13, var_1_10012(var_31_14, var_1_10015))
							i18n = var_8
							var_31_5 = var_8("world_instruction_submarine_8")

							function var_31_6()
								local var_34_0 = arg_31_0
								local var_34_1 = var_0.emit

								WorldScene = var_2_10003

								var_34_1(var_34_0, var_2_10003.SceneOp, "OpReqVision")

								return
							end

							if false then
								assert = var_8

								var_8(false, "req error")
							end

							::label_31_0::

							setText = var_8

							local var_31_15 = arg_31_0.rtMsgBase

							var_8(var_10.Find(var_31_15, "content"), var_31_4)

							setText = var_8

							local var_31_16 = arg_31_0.rtMsgBase

							var_8(var_10.Find(var_31_16, "other"), var_31_5)

							onButton = var_8

							local var_31_17 = arg_31_0
							local var_31_18 = arg_31_0.rtMsgBtns
							local var_31_19 = var_11.Find(var_31_18, "btn_confirm")

							local function var_31_20()
								local var_35_0 = arg_31_0

								var_0.Hide(var_35_0)

								local var_35_1 = var_0.staminaMgr

								if var_0.GetTotalStamina(var_35_1) < var_31_3 then
									local var_35_2 = var_0.staminaMgr

									var_0.Show(var_35_2)
								else
									var_31_6()
								end

								return
							end

							SFX_CONFIRM = var_31_18

							var_8(var_31_17, var_31_19, var_31_20, var_31_18)

							setActive = var_8

							local var_31_21 = arg_31_0.rtMsgExtra

							WorldConst = var_31_19

							var_8(var_31_21, arg_31_1 == var_31_19.OpReqSub)

							WorldConst = var_8

							if arg_31_1 == var_8.OpReqSub then
								setText = var_8

								local var_31_22 = arg_31_0.rtMsgExtra
								local var_31_23 = var_10.Find(var_31_22, "content/text_1")

								i18n = var_11

								var_8(var_31_23, var_11("world_instruction_submarine_9"))

								local var_31_24 = arg_31_0.rtMsgExtra
								local var_31_25 = var_8.Find(var_31_24, "content/toggle_area/toggle")

								PlayerPrefs = var_9

								local var_31_26 = var_9.GetInt("world_sub_auto_call", 0) == 1

								triggerToggle = var_31_24

								var_31_24(var_31_25, var_31_26)

								onToggle = var_31_24

								local var_31_27 = arg_31_0
								local var_31_28 = var_31_25

								local function var_31_29(arg_36_0)
									var_31_26 = arg_36_0

									local var_36_0 = arg_31_0

									var_1.DisplayAutoSetting(var_36_0, true)

									return
								end

								SFX_PANEL = var_1_10015

								var_31_24(var_31_27, var_31_28, var_31_29, var_1_10015)

								pg = var_31_24

								local var_31_30 = var_31_24.gameset.world_instruction_submarine.description[1]

								math = var_11

								local var_31_31 = var_11.clamp

								PlayerPrefs = var_31_28

								local var_31_32 = var_31_31(var_31_28.GetInt("world_sub_call_line", 0), 0, var_31_30)
								local var_31_33 = arg_31_0.rtMsgExtra
								local var_31_34 = var_12.Find(var_31_33, "content/counter")

								setText = var_13

								var_13(var_31_34:Find("number/Text"), var_31_32)

								pressPersistTrigger = var_13

								local var_31_35 = var_31_34:Find("minus")
								local var_31_36 = 0.5

								local function var_31_37(arg_37_0)
									if var_31_32 == 0 then
										arg_37_0()

										return
									end

									math = var_1
									var_31_32 = var_1.clamp(var_31_32 - 1, 0, var_31_30)
									setText = var_1

									local var_37_0 = var_31_34

									var_1(var_3.Find(var_37_0, "number/Text"), var_31_32)

									local var_37_1 = arg_31_0

									var_1.DisplayAutoSetting(var_37_1, true)

									return
								end

								local var_31_38
								local var_31_39 = true
								local var_31_40 = true
								local var_31_41 = 0.1

								SFX_PANEL = var_1_10022

								var_13(var_31_35, var_31_36, var_31_37, var_31_38, var_31_39, var_31_40, var_31_41, var_1_10022)

								pressPersistTrigger = var_13

								local var_31_42 = var_31_34:Find("plus")
								local var_31_43 = 0.5

								local function var_31_44(arg_38_0)
									if var_31_32 == var_31_30 then
										arg_38_0()

										return
									end

									math = var_1
									var_31_32 = var_1.clamp(var_31_32 + 1, 0, var_31_30)
									setText = var_1

									local var_38_0 = var_31_34

									var_1(var_3.Find(var_38_0, "number/Text"), var_31_32)

									local var_38_1 = arg_31_0

									var_1.DisplayAutoSetting(var_38_1, true)

									return
								end

								local var_31_45
								local var_31_46 = true
								local var_31_47 = true
								local var_31_48 = 0.1

								SFX_PANEL = var_1_10022

								var_13(var_31_42, var_31_43, var_31_44, var_31_45, var_31_46, var_31_47, var_31_48, var_1_10022)

								onButton = var_13

								local var_31_49 = arg_31_0
								local var_31_50 = arg_31_0.rtMsgBtns
								local var_31_51 = var_16.Find(var_31_50, "btn_setting")

								local function var_31_52()
									local var_39_0 = false

									PlayerPrefs = isSetting

									var_0.SetInt("world_sub_auto_call", var_31_26 and 1 or 0)

									PlayerPrefs = var_0

									var_0.SetInt("world_sub_call_line", var_31_32)

									local var_39_1 = arg_31_0

									var_0.DisplayAutoSetting(var_39_1, false)

									pg = var_0

									local var_39_2 = var_0.TipsMgr.GetInstance()
									local var_39_3 = var_0.ShowTips

									i18n = var_3

									var_39_3(var_39_2, var_3("world_instruction_submarine_11"))

									return
								end

								SFX_PANEL = var_31_50

								var_13(var_31_49, var_31_51, var_31_52, var_31_50)
							end

							arg_31_0:DisplayAutoSetting(false)

							setActive = var_8

							var_8(arg_31_0.rtMsgbox, true)

							pg = var_8

							local var_31_53 = var_8.UIMgr.GetInstance()

							var_8.BlurPanel(var_31_53, arg_31_0.rtMsgbox)

							return
						end
					end
				end
			end
		end
	end
end

function var_0_1.HideMsgbox(arg_40_0)
	setActive = var_1_10001

	var_1_10001(arg_40_0.rtMsgbox, false)

	pg = var_1_10001

	local var_40_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_40_0, arg_40_0.rtMsgbox, arg_40_0._tf)

	return
end

function var_0_1.DisplayAutoSetting(arg_41_0, arg_41_1)
	setActive = var_1_10002

	local var_41_0 = arg_41_0.rtMsgBtns

	var_1_10002(var_4.Find(var_41_0, "btn_confirm"), not arg_41_1)

	setActive = var_1_10002

	local var_41_1 = arg_41_0.rtMsgBtns

	var_1_10002(var_4.Find(var_41_1, "btn_setting"), arg_41_1)

	return
end

return var_0_1
