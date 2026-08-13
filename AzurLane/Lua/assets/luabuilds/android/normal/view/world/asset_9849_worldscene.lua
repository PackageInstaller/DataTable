class = var_0_10000

local var_0_0 = "WorldScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.SceneOp = "WorldScene.SceneOp"
var_0_1.Listeners = {
	onAchievementAchieved = "OnAchievementAchieved",
	onUpdateSubmarineSupport = "OnUpdateSubmarineSupport",
	onSelectFleet = "OnSelectFleet",
	onUpdateEventTips = "OnUpdateEventTips",
	onFleetSelected = "OnFleetSelected",
	onModelSelectMap = "OnModelSelectMap",
	onClearMoveQueue = "ClearMoveQueue",
	onUpdateProgress = "OnUpdateProgress",
	onUpdateScale = "OnUpdateScale",
	onUpdateDaily = "OnUpdateDaily",
	onDisposeMap = "OnDisposeMap",
	onUpdateRound = "OnUpdateRound"
}
var_0_1.optionsPath = {
	"top/adapt/top_chapter/option",
	"top/adapt/top_stage/option"
}

function var_0_1.forceGC(arg_1_0)
	return true
end

function var_0_1.getUIName(arg_2_0)
	return "WorldUI"
end

function var_0_1.getBGM(arg_3_0)
	local var_3_0 = {}
	local var_3_1

	if arg_3_0:GetInMap() == false then
		-- block empty
	else
		table = var_3_1
		var_3_1 = var_3_1.insert

		local var_3_2 = var_3_0

		nowWorld = var_1_10004

		local var_3_3 = var_1_10004()
		local var_3_4 = var_4.GetActiveMap(var_3_3)
		local var_3_5

		if not var_4.GetBGM(var_3_4) then
			var_3_5 = ""
		end

		var_3_1(var_3_2, var_3_5)
	end

	ipairs = var_3_1

	for iter_3_0, iter_3_1 in var_3_1(var_3_0) do
		if iter_3_1 ~= "" then
			return iter_3_1
		end
	end

	return var_0_1.super.getBGM(arg_3_0)
end

function var_0_1.init(arg_4_0)
	pairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(var_0_1.Listeners) do
		arg_4_0[iter_4_0] = function(...)
			var_0_1[iter_4_1](arg_4_0, ...)

			return
		end
	end

	arg_4_0:bind(var_0_1.SceneOp, function(arg_6_0, ...)
		local var_6_0 = arg_4_0

		var_1.Op(var_6_0, ...)

		return
	end)

	pg = var_1

	local var_4_0 = var_1.UIMgr.GetInstance().levelCamera
	local var_4_1 = var_1.GetComponent

	typeof = var_3
	Camera = var_4
	arg_4_0.camera = var_4_1(var_4_0, var_3(var_4))
	pg = var_1
	arg_4_0.rtUIMain = var_1.UIMgr.GetInstance().LevelMain
	setActive = var_1

	var_1(arg_4_0.rtUIMain, false)

	local var_4_2 = arg_4_0.rtUIMain

	arg_4_0.rtGrid = var_1.Find(var_4_2, "LevelGrid")
	setActive = var_1

	var_1(arg_4_0.rtGrid, true)

	local var_4_3 = arg_4_0.rtGrid

	arg_4_0.rtDragLayer = var_1.Find(var_4_3, "DragLayer")

	local var_4_4 = arg_4_0._tf

	arg_4_0.rtEnvBG = var_1.Find(var_4_4, "main/bg")

	local var_4_5 = arg_4_0._tf

	arg_4_0.rtTop = var_1.Find(var_4_5, "top")

	local var_4_6 = arg_4_0.rtTop

	arg_4_0.rtTopAtlas = var_1.Find(var_4_6, "adapt/top_chapter")
	setActive = var_1

	var_1(arg_4_0.rtTopAtlas, false)

	local var_4_7 = arg_4_0.rtTop

	arg_4_0.rtRightAtlas = var_1.Find(var_4_7, "adapt/right_chapter")
	setActive = var_1

	var_1(arg_4_0.rtRightAtlas, false)

	local var_4_8 = arg_4_0.rtTop

	arg_4_0.rtBottomAtlas = var_1.Find(var_4_8, "adapt/bottom_chapter")
	setActive = var_1

	var_1(arg_4_0.rtBottomAtlas, false)

	local var_4_9 = arg_4_0.rtTop

	arg_4_0.rtTransportAtlas = var_1.Find(var_4_9, "transport_chapter")
	setActive = var_1

	var_1(arg_4_0.rtTransportAtlas, false)

	local var_4_10 = arg_4_0.rtTop

	arg_4_0.rtTopMap = var_1.Find(var_4_10, "adapt/top_stage")
	setActive = var_1

	var_1(arg_4_0.rtTopMap, false)

	local var_4_11 = arg_4_0.rtTop

	arg_4_0.rtLeftMap = var_1.Find(var_4_11, "adapt/left_stage")
	setActive = var_1

	var_1(arg_4_0.rtLeftMap, false)

	local var_4_12 = arg_4_0.rtTop

	arg_4_0.rtRightMap = var_1.Find(var_4_12, "adapt/right_stage")
	setActive = var_1

	var_1(arg_4_0.rtRightMap, false)

	local var_4_13 = arg_4_0.rtTop

	arg_4_0.rtOutMap = var_1.Find(var_4_13, "effect_stage")
	setActive = var_1

	var_1(arg_4_0.rtOutMap, false)

	local var_4_14 = arg_4_0.rtTop

	arg_4_0.rtClickStop = var_1.Find(var_4_14, "stop_click")
	onButton = var_1

	local var_4_15 = arg_4_0
	local var_4_16 = arg_4_0.rtClickStop

	var_1(var_4_15, var_3.Find(var_4_16, "long_move"), function()
		if #arg_4_0.moveQueue > 0 then
			pg = var_0

			local var_7_0 = var_0.TipsMgr.GetInstance()
			local var_7_1 = var_0.ShowTips

			i18n = var_2_10002

			var_7_1(var_7_0, var_2_10002("world_fleet_stop"))

			local var_7_2 = arg_4_0

			var_0.ClearMoveQueue(var_7_2)
		end

		return
	end)

	onButton = var_1

	local var_4_17 = arg_4_0
	local var_4_18 = arg_4_0.rtClickStop

	var_1(var_4_17, var_3.Find(var_4_18, "auto_fight"), function()
		nowWorld = var_2_10000

		local var_8_1

		if var_2_10000().isAutoFight then
			pg = var_8_1

			local var_8_0 = var_8_1.TipsMgr.GetInstance()

			var_8_1 = var_8_1.ShowTips
			i18n = var_2_10003

			var_8_1(var_8_0, var_2_10003("autofight_tip_bigworld_stop"))
			var_0:TriggerAutoFight(false)
		else
			assert = var_8_1

			var_8_1(false, "stop clicker shouldn't active")
		end

		return
	end)

	setActive = var_1

	var_1(arg_4_0.rtClickStop, false)

	WorldResource = var_1
	arg_4_0.resAtlas = var_1.New()

	local var_4_19 = arg_4_0.resAtlas
	local var_4_20 = var_1.setParent
	local var_4_21 = arg_4_0.rtTopAtlas

	var_4_20(var_4_19, var_3.Find(var_4_21, "resources"), false)

	WorldResource = var_4_20
	arg_4_0.resMap = var_4_20.New()

	local var_4_22 = arg_4_0.resMap
	local var_4_23 = var_1.setParent
	local var_4_24 = arg_4_0.rtTopMap

	var_4_23(var_4_22, var_3.Find(var_4_24, "resources"), false)

	WSPool = var_4_23
	arg_4_0.wsPool = var_4_23.New()

	local var_4_25 = arg_4_0.wsPool
	local var_4_26 = var_1.Setup
	local var_4_27 = arg_4_0._tf

	var_4_26(var_4_25, var_3.Find(var_4_27, "resources"))

	WSAnim = var_4_26
	arg_4_0.wsAnim = var_4_26.New()

	local var_4_28 = arg_4_0.wsAnim

	var_1.Setup(var_4_28)

	WSTimer = var_1
	arg_4_0.wsTimer = var_1.New()

	local var_4_29 = arg_4_0.wsTimer

	var_1.Setup(var_4_29)

	WSDragProxy = var_1
	arg_4_0.wsDragProxy = var_1.New()
	arg_4_0.wsDragProxy.transform = arg_4_0.rtDragLayer
	arg_4_0.wsDragProxy.wsTimer = arg_4_0.wsTimer

	local var_4_30 = arg_4_0.wsDragProxy

	var_1.Setup(var_4_30, {
		clickCall = function(arg_9_0, arg_9_1)
			local var_9_0 = arg_4_0.svScannerPanel

			if var_2.isShowing(var_9_0) then
				local var_9_1 = arg_4_0
				local var_9_2 = var_2.CheckScannerEnable
				local var_9_3 = arg_4_0
				local var_9_4, var_9_5 = var_9_2(var_9_1, var_4.ScreenPos2MapPos(var_9_3, arg_9_1.position))

				if var_9_4 then
					local var_9_6 = arg_4_0.svScannerPanel

					var_4.ActionInvoke(var_9_6, "DisplayWindow", var_9_4, var_9_5)
				else
					local var_9_7 = arg_4_0.svScannerPanel

					var_4.ActionInvoke(var_9_7, "HideWindow")
				end
			else
				local var_9_8 = arg_4_0
				local var_9_9 = var_2.OnClickMap
				local var_9_10 = arg_4_0

				var_9_9(var_9_8, var_4.ScreenPos2MapPos(var_9_10, arg_9_1.position))
			end

			return
		end,
		longPressCall = function()
			local var_10_0 = arg_4_0
			local var_10_1 = var_0.OnLongPressMap
			local var_10_2 = arg_4_0
			local var_10_3 = var_2.ScreenPos2MapPos

			Vector3 = var_2_10004
			Input = var_2_10005

			local var_10_4 = var_2_10005.mousePosition.x

			Input = var_2_10006

			var_10_1(var_10_0, var_10_3(var_10_2, var_2_10004(var_10_4, var_2_10006.mousePosition.y)))

			return
		end
	})

	WSMapCamera = var_1
	arg_4_0.wsMapCamera = var_1.New()
	arg_4_0.wsMapCamera.camera = arg_4_0.camera

	local var_4_31 = arg_4_0.wsMapCamera

	var_1.Setup(var_4_31)
	arg_4_0:InitSubView()
	arg_4_0:AddWorldListener()

	arg_4_0.moveQueue = {}
	arg_4_0.achievedList = {}
	arg_4_0.mapOps = {}
	arg_4_0.wsCommands = {}
	WSCommand = var_1

	var_1.Bind(arg_4_0)
	arg_4_0:OpOpen()

	return
end

function var_0_1.InitSubView(arg_11_0)
	local var_11_0 = arg_11_0._tf

	arg_11_0.rtPanelList = var_1.Find(var_11_0, "panel_list")
	SVOrderPanel = var_1
	arg_11_0.svOrderPanel = var_1.New(arg_11_0.rtPanelList, arg_11_0.event, {
		wsPool = arg_11_0.wsPool
	})
	SVScannerPanel = var_1
	arg_11_0.svScannerPanel = var_1.New(arg_11_0.rtPanelList, arg_11_0.event)

	local var_11_1 = arg_11_0
	local var_11_2 = arg_11_0.bind

	SVScannerPanel = var_3

	var_11_2(var_11_1, var_3.ShowView, function(arg_12_0)
		local var_12_0 = arg_11_0.wsMap

		var_1.ShowScannerMap(var_12_0, true)

		setActive = var_1

		var_1(arg_11_0.wsMap.rtTop, false)

		local var_12_1 = arg_11_0

		var_1.HideMapUI(var_12_1)

		return
	end)

	local var_11_3 = arg_11_0
	local var_11_4 = arg_11_0.bind

	SVScannerPanel = var_3

	var_11_4(var_11_3, var_3.HideView, function(arg_13_0)
		local var_13_0 = arg_11_0.wsMap

		var_1.ShowScannerMap(var_13_0, false)

		setActive = var_1

		var_1(arg_11_0.wsMap.rtTop, true)

		local var_13_1 = arg_11_0

		var_1.DisplayMapUI(var_13_1)

		return
	end)

	local var_11_5 = arg_11_0
	local var_11_6 = arg_11_0.bind

	SVScannerPanel = var_3

	var_11_6(var_11_5, var_3.HideGoing, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_11_0.wsMap

		var_3.ShowScannerMap(var_14_0, false)

		setActive = var_3

		var_3(arg_11_0.wsMap.rtTop, true)

		local var_14_1 = arg_11_0

		var_3.DisplayMapUI(var_14_1)

		local var_14_2 = arg_11_0

		var_3.OnClickCell(var_14_2, arg_14_1, arg_14_2)

		return
	end)

	SVRealmPanel = var_11_6
	arg_11_0.svRealmPanel = var_11_6.New(arg_11_0.rtPanelList, arg_11_0.event)
	SVAchievement = var_1
	arg_11_0.svAchievement = var_1.New(arg_11_0.rtPanelList, arg_11_0.event)

	local var_11_7 = arg_11_0
	local var_11_8 = arg_11_0.bind

	SVAchievement = var_3

	var_11_8(var_11_7, var_3.HideView, function(arg_15_0)
		table = var_2_10001

		var_2_10001.remove(arg_11_0.achievedList, 1)

		local var_15_0

		if not (#arg_11_0.achievedList > 0) or not function()
			local var_16_0 = arg_11_0

			var_0.ShowSubView(var_16_0, "Achievement", arg_11_0.achievedList[1])

			return
		end then
			function var_15_0()
				local var_17_0 = arg_11_0

				var_0.Op(var_17_0, "OpInteractive")

				return
			end
		end

		return var_15_0()
	end)

	SVDebugPanel = var_11_8
	arg_11_0.svDebugPanel = var_11_8.New(arg_11_0.rtPanelList, arg_11_0.event)
	SVFloatPanel = var_1
	arg_11_0.svFloatPanel = var_1.New(arg_11_0.rtTop, arg_11_0.event)

	local var_11_9 = arg_11_0
	local var_11_10 = arg_11_0.bind

	SVFloatPanel = var_3

	var_11_10(var_11_9, var_3.ReturnCall, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_11_0

		var_2.Op(var_18_0, "OpCall", function(arg_19_0)
			arg_19_0()

			nowWorld = var_1

			local var_19_0 = var_1()
			local var_19_1 = var_1.GetActiveEntrance(var_19_0)

			if arg_18_1.id == var_19_1.id then
				local var_19_2 = arg_11_0.wsAtlas

				var_2.UpdateSelect(var_19_2)

				local var_19_3 = arg_11_0.wsAtlas

				var_2.UpdateSelect(var_19_3, arg_18_1)
			else
				local var_19_4 = arg_11_0

				var_2.ClickAtlas(var_19_4, var_19_1)
			end

			return
		end)

		return
	end)

	SVPoisonPanel = var_11_10
	arg_11_0.svPoisonPanel = var_11_10.New(arg_11_0.rtPanelList, arg_11_0.event)
	SVGlobalBuff = var_1
	arg_11_0.svGlobalBuff = var_1.New(arg_11_0.rtPanelList, arg_11_0.event)

	local var_11_11 = arg_11_0
	local var_11_12 = arg_11_0.bind

	SVGlobalBuff = var_3

	var_11_12(var_11_11, var_3.HideView, function(arg_20_0, arg_20_1)
		existCall = var_2_10002

		return var_2_10002(arg_20_1)
	end)

	SVBossProgress = var_11_12
	arg_11_0.svBossProgress = var_11_12.New(arg_11_0.rtPanelList, arg_11_0.event)

	local var_11_13 = arg_11_0
	local var_11_14 = arg_11_0.bind

	SVBossProgress = var_3

	var_11_14(var_11_13, var_3.HideView, function(arg_21_0, arg_21_1)
		existCall = var_2_10002

		return var_2_10002(arg_21_1)
	end)

	SVSalvageResult = var_11_14
	arg_11_0.svSalvageResult = var_11_14.New(arg_11_0.rtPanelList, arg_11_0.event)

	return
end

function var_0_1.didEnter(arg_22_0)
	arg_22_0:OverlayPanel(arg_22_0.rtTop)

	arg_22_0.warningSairen = not arg_22_0.contextData.inSave

	if arg_22_0.contextData.inWorld then
		arg_22_0:Op("OpSetInMap", false, function()
			local var_23_0 = arg_22_0.wsAtlas
			local var_23_1 = var_0.UpdateSelect

			nowWorld = var_2_10002

			local var_23_2 = var_2_10002()

			var_23_1(var_23_0, var_2.GetActiveEntrance(var_23_2))

			return
		end)
	else
		arg_22_0:Op("OpSetInMap", true)
	end

	return
end

function var_0_1.onBackPressed(arg_24_0)
	if arg_24_0.inCutIn then
		return
	else
		local var_24_0 = arg_24_0.svDebugPanel

		if var_1.isShowing(var_24_0) then
			arg_24_0:HideSubView("DebugPanel")
		else
			local var_24_1 = arg_24_0.svAchievement

			if var_1.isShowing(var_24_1) then
				arg_24_0:HideSubView("Achievement")
			else
				local var_24_2 = arg_24_0.svGlobalBuff

				if var_1.isShowing(var_24_2) then
					arg_24_0:HideSubView("GlobalBuff")
				else
					local var_24_3 = arg_24_0.svBossProgress

					if var_1.isShowing(var_24_3) then
						arg_24_0:HideSubView("BossProgress")
					else
						local var_24_4 = arg_24_0.svOrderPanel

						if var_1.isShowing(var_24_4) then
							arg_24_0:HideSubView("OrderPanel")
						else
							local var_24_5 = arg_24_0.svScannerPanel

							if var_1.isShowing(var_24_5) then
								arg_24_0:HideSubView("ScannerPanel")
							else
								local var_24_6 = arg_24_0.svPoisonPanel

								if var_1.isShowing(var_24_6) then
									arg_24_0:HideSubView("PoisonPanel")
								else
									local var_24_7 = arg_24_0.svSalvageResult

									if var_1.isShowing(var_24_7) then
										arg_24_0:HideSubView("SalvageResult")
									else
										if arg_24_0.wsMapLeft then
											isActive = var_1

											if var_1(arg_24_0.wsMapLeft.toggleMask) then
												local var_24_8 = arg_24_0.wsMapLeft

												var_1.HideToggleMask(var_24_8)

												goto label_24_0
											end
										end

										if arg_24_0:GetInMap() then
											triggerButton = var_1

											var_1(arg_24_0.wsMapTop.btnBack)
										else
											triggerButton = var_1

											local var_24_9 = arg_24_0.rtTopAtlas

											var_1(var_2.Find(var_24_9, "back_button"))
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	::label_24_0::

	return
end

function var_0_1.quickExitFunc(arg_25_0)
	arg_25_0:Op("OpCall", function(arg_26_0)
		arg_26_0()

		local var_26_0 = {}

		nowWorld = var_2_10002

		local var_26_1 = var_2_10002()

		if var_2.CheckReset(var_26_1) then
			table = var_2

			var_2.insert(var_26_0, function(arg_27_0)
				pg = var_3_10001

				local var_27_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_27_1 = var_1.ShowMsgBox
				local var_27_2 = {}

				i18n = var_3_10004
				var_27_2.content = var_3_10004("world_recycle_notice")
				var_27_2.onYes = arg_27_0

				var_27_1(var_27_0, var_27_2)

				return
			end)
		end

		seriesAsync = var_2

		var_2(var_26_0, function()
			var_0_1.super.quickExitFunc(arg_25_0)

			return
		end)

		return
	end)

	return
end

function var_0_1.ExitWorld(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = {}

	if not arg_29_2 then
		table = var_1_10004

		var_1_10004.insert(var_29_0, function(arg_30_0)
			pg = var_2_10001

			local var_30_0 = var_2_10001.MsgboxMgr.GetInstance()
			local var_30_1 = var_1.ShowMsgBox
			local var_30_2 = {}

			i18n = var_2_10004
			var_30_2.content = var_2_10004("world_exit_tip")
			var_30_2.onYes = arg_30_0

			function var_30_2.onNo()
				existCall = var_3_10000

				return var_3_10000(arg_29_1)
			end

			var_30_1(var_30_0, var_30_2)

			return
		end)
	end

	if not arg_29_2 then
		nowWorld = var_1_10004

		local var_29_1 = var_1_10004()

		if var_1_10004.CheckReset(var_29_1) then
			table = var_1_10004

			var_1_10004.insert(var_29_0, function(arg_32_0)
				pg = var_2_10001

				local var_32_0 = var_2_10001.MsgboxMgr.GetInstance()
				local var_32_1 = var_1.ShowMsgBox
				local var_32_2 = {}

				i18n = var_2_10004
				var_32_2.content = var_2_10004("world_recycle_notice")
				var_32_2.onYes = arg_32_0

				function var_32_2.onNo()
					existCall = var_3_10000

					return var_3_10000(arg_29_1)
				end

				var_32_1(var_32_0, var_32_2)

				return
			end)
		end
	end

	table = var_1_10004

	var_1_10004.insert(var_29_0, function(arg_34_0)
		local var_34_0 = arg_29_0

		if var_1.GetInMap(var_34_0) then
			local var_34_1 = arg_29_0

			var_1.EaseOutMapUI(var_34_1, arg_34_0)
		else
			local var_34_2 = arg_29_0

			var_1.EaseOutAtlasUI(var_34_2, arg_34_0)
		end

		return
	end)

	seriesAsync = var_4

	var_4(var_29_0, function()
		existCall = var_2_10000

		var_2_10000(arg_29_1)

		local var_35_0 = arg_29_0

		var_0.closeView(var_35_0)

		return
	end)

	return
end

function var_0_1.SaveState(arg_36_0)
	arg_36_0.contextData.inSave = true
	arg_36_0.contextData.inWorld = arg_36_0:GetInMap() == false
	arg_36_0.contextData.inShop = false
	arg_36_0.contextData.inPort = false

	return
end

function var_0_1.willExit(arg_37_0)
	arg_37_0:SaveState()
	arg_37_0:RemoveWorldListener()
	arg_37_0:UnOverlayPanel(arg_37_0.rtTop, arg_37_0._tf)

	local var_37_0 = arg_37_0.svOrderPanel

	var_1.Destroy(var_37_0)

	local var_37_1 = arg_37_0.svScannerPanel

	var_1.Destroy(var_37_1)

	local var_37_2 = arg_37_0.svAchievement

	var_1.Destroy(var_37_2)

	local var_37_3 = arg_37_0.svRealmPanel

	var_1.Destroy(var_37_3)

	local var_37_4 = arg_37_0.svDebugPanel

	var_1.Destroy(var_37_4)

	local var_37_5 = arg_37_0.svFloatPanel

	var_1.Destroy(var_37_5)

	local var_37_6 = arg_37_0.svPoisonPanel

	var_1.Destroy(var_37_6)

	local var_37_7 = arg_37_0.svGlobalBuff

	var_1.Destroy(var_37_7)

	local var_37_8 = arg_37_0.svBossProgress

	var_1.Destroy(var_37_8)
	arg_37_0:DisposeAtlas()
	arg_37_0:DisposeAtlasUI()
	arg_37_0:DisposeMap()
	arg_37_0:DisposeMapUI()

	local var_37_9 = arg_37_0.wsPool

	var_1.Dispose(var_37_9)

	arg_37_0.wsPool = nil

	local var_37_10 = arg_37_0.wsAnim

	var_1.Dispose(var_37_10)

	arg_37_0.wsAnim = nil

	local var_37_11 = arg_37_0.wsTimer

	var_1.Dispose(var_37_11)

	arg_37_0.wsTimer = nil

	local var_37_12 = arg_37_0.wsDragProxy

	var_1.Dispose(var_37_12)

	arg_37_0.wsDragProxy = nil

	local var_37_13 = arg_37_0.wsMapCamera

	var_1.Dispose(var_37_13)

	arg_37_0.wsMapCamera = nil

	local var_37_14 = arg_37_0.resAtlas

	var_1.exit(var_37_14)

	arg_37_0.resAtlas = nil

	local var_37_15 = arg_37_0.resMap

	var_1.exit(var_37_15)

	arg_37_0.resMap = nil

	arg_37_0:VerifyMapOp()
	arg_37_0:OpDispose()

	WSCommand = var_1

	var_1.Unbind(arg_37_0)

	WBank = var_1

	local var_37_16 = var_1
	local var_37_17 = var_1.Recycle

	WorldMapOp = var_3

	var_37_17(var_37_16, var_3)

	return
end

function var_0_1.SetPlayer(arg_38_0, arg_38_1)
	arg_38_0.player = arg_38_1

	local var_38_0 = arg_38_0.resAtlas

	var_2.setPlayer(var_38_0, arg_38_0.player)

	local var_38_1 = arg_38_0.resMap

	var_2.setPlayer(var_38_1, arg_38_0.player)

	return
end

function var_0_1.AddWorldListener(arg_39_0)
	nowWorld = var_1_10001

	local var_39_0 = var_1_10001()
	local var_39_1 = var_1.AddListener

	World = var_1_10004

	var_39_1(var_39_0, var_1_10004.EventUpdateProgress, arg_39_0.onUpdateProgress)

	local var_39_2 = var_1:GetTaskProxy()
	local var_39_3 = var_2.AddListener

	WorldTaskProxy = var_5

	var_39_3(var_39_2, var_5.EventUpdateDailyTaskIds, arg_39_0.onUpdateDaily)

	return
end

function var_0_1.RemoveWorldListener(arg_40_0)
	nowWorld = var_1_10001

	local var_40_0 = var_1_10001()
	local var_40_1 = var_1.RemoveListener

	World = var_1_10004

	var_40_1(var_40_0, var_1_10004.EventUpdateProgress, arg_40_0.onUpdateProgress)

	local var_40_2 = var_1:GetTaskProxy()
	local var_40_3 = var_2.RemoveListener

	WorldTaskProxy = var_5

	var_40_3(var_40_2, var_5.EventUpdateDailyTaskIds, arg_40_0.onUpdateDaily)

	return
end

function var_0_1.SetInMap(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_1 then
		defaultValue = var_1_10003
		arg_41_2 = var_1_10003(arg_41_2, function()
			local var_42_0 = arg_41_0

			var_0.Op(var_42_0, "OpInteractive")

			return
		end)
	end

	if arg_41_0.inMap == arg_41_1 then
		existCall = var_3

		return var_3(arg_41_2)
	end

	local var_41_0 = {}
	local var_41_1 = {}

	arg_41_0:StopAnim()

	if arg_41_0.inMap then
		table = var_5

		var_5.insert(var_41_0, function(arg_43_0)
			local var_43_0 = arg_41_0

			var_1.Op(var_43_0, "OpSwitchOutMap", arg_43_0)

			return
		end)
	elseif arg_41_0.inMap ~= nil then
		table = var_5

		var_5.insert(var_41_0, function(arg_44_0)
			local var_44_0 = arg_41_0

			var_1.Op(var_44_0, "OpSwitchOutWorld", arg_44_0)

			return
		end)
	end

	table = var_5

	var_5.insert(var_41_0, function(arg_45_0)
		local var_45_0 = arg_41_0

		var_1.Op(var_45_0, "OpCall", function(arg_46_0)
			parallelAsync = var_3_10001

			var_3_10001(var_41_1, function()
				arg_46_0()

				return arg_45_0()
			end)

			return
		end)

		return
	end)

	table = var_5

	var_5.insert(var_41_1, function(arg_48_0)
		local var_48_0 = arg_41_0

		var_1.DisplayEnv(var_48_0, arg_48_0)

		return
	end)

	if arg_41_1 then
		table = var_5

		var_5.insert(var_41_1, function(arg_49_0)
			local var_49_0 = arg_41_0
			local var_49_1 = var_1.LoadMap

			nowWorld = var_2_10003

			local var_49_2 = var_2_10003()

			var_49_1(var_49_0, var_3.GetActiveMap(var_49_2), arg_49_0)

			return
		end)

		table = var_5

		var_5.insert(var_41_0, function(arg_50_0)
			local var_50_0 = arg_41_0

			var_1.Op(var_50_0, "OpSwitchInMap", arg_50_0)

			return
		end)
	else
		table = var_5

		var_5.insert(var_41_1, function(arg_51_0)
			local var_51_0 = arg_41_0

			var_1.LoadAtlas(var_51_0, arg_51_0)

			return
		end)

		table = var_5

		var_5.insert(var_41_0, function(arg_52_0)
			local var_52_0 = arg_41_0

			var_1.Op(var_52_0, "OpSwitchInWorld", arg_52_0)

			return
		end)
	end

	table = var_5

	var_5.insert(var_41_0, function(arg_53_0)
		local var_53_0 = arg_41_0

		var_1.PlayBGM(var_53_0)
		arg_53_0()

		return
	end)

	arg_41_0.inMap = arg_41_1
	seriesAsync = var_5

	var_5(var_41_0, arg_41_2)

	return
end

function var_0_1.GetInMap(arg_54_0)
	return arg_54_0.inMap
end

function var_0_1.ShowSubView(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	local var_55_0 = arg_55_0["sv" .. arg_55_1]

	var_4.Load(var_55_0)

	local var_55_1 = var_4
	local var_55_2 = var_4.ActionInvoke
	local var_55_3 = "Setup"

	unpack = var_1_10008

	var_55_2(var_55_1, var_55_3, var_1_10008(arg_55_2 or {}))

	local var_55_4 = var_4
	local var_55_5 = var_4.ActionInvoke
	local var_55_6 = "Show"

	unpack = var_8

	var_55_5(var_55_4, var_55_6, var_8(arg_55_3 or {}))

	return
end

function var_0_1.HideSubView(arg_56_0, arg_56_1, ...)
	local var_56_0 = arg_56_0["sv" .. arg_56_1]

	var_2.ActionInvoke(var_56_0, "Hide", ...)

	return
end

function var_0_1.DisplayAtlasUI(arg_57_0)
	arg_57_0:DisplayAtlasTop()
	arg_57_0:DisplayAtlasRight()
	arg_57_0:DisplayAtlasBottom()
	arg_57_0:UpdateSystemOpen()

	return
end

function var_0_1.HideAtlasUI(arg_58_0)
	arg_58_0:HideAtlasTop()
	arg_58_0:HideAtlasRight()
	arg_58_0:HideAtlasBottom()

	return
end

function var_0_1.EaseInAtlasUI(arg_59_0, arg_59_1)
	arg_59_0:CancelAtlasUITween()

	parallelAsync = var_2

	var_2({
		function(arg_60_0)
			setAnchoredPosition = var_2_10001

			var_2_10001(arg_59_0.rtTopAtlas, {
				y = arg_59_0.rtTopAtlas.rect.height
			})

			local var_60_0 = arg_59_0.wsTimer
			local var_60_1 = var_1.AddTween

			LeanTween = var_3

			local var_60_2 = var_3.moveY
			local var_60_3 = arg_59_0.rtTopAtlas
			local var_60_4 = 0

			WorldConst = var_2_10006

			local var_60_5 = var_60_2(var_60_3, var_60_4, var_2_10006.UIEaseFasterDuration)
			local var_60_6 = var_3.setEase

			LeanTweenType = var_60_4

			local var_60_7 = var_60_6(var_60_5, var_60_4.easeInSine)
			local var_60_8 = var_3.setOnComplete

			System = var_5

			var_60_1(var_60_0, var_60_8(var_60_7, var_5.Action(arg_60_0)).uniqueId)

			return
		end,
		function(arg_61_0)
			setAnchoredPosition = var_2_10001

			var_2_10001(arg_59_0.rtBottomAtlas, {
				y = -arg_59_0.rtBottomAtlas.rect.height
			})

			local var_61_0 = arg_59_0.wsTimer
			local var_61_1 = var_1.AddTween

			LeanTween = var_3

			local var_61_2 = var_3.moveY
			local var_61_3 = arg_59_0.rtBottomAtlas
			local var_61_4 = 0

			WorldConst = var_2_10006

			local var_61_5 = var_61_2(var_61_3, var_61_4, var_2_10006.UIEaseFasterDuration)
			local var_61_6 = var_3.setEase

			LeanTweenType = var_61_4

			local var_61_7 = var_61_6(var_61_5, var_61_4.easeInSine)
			local var_61_8 = var_3.setOnComplete

			System = var_5

			var_61_1(var_61_0, var_61_8(var_61_7, var_5.Action(arg_61_0)).uniqueId)

			return
		end,
		function(arg_62_0)
			setAnchoredPosition = var_2_10001

			var_2_10001(arg_59_0.rtRightAtlas, {
				x = arg_59_0.rtRightAtlas.rect.width
			})

			local var_62_0 = arg_59_0.wsTimer
			local var_62_1 = var_1.AddTween

			LeanTween = var_3

			local var_62_2 = var_3.moveX
			local var_62_3 = arg_59_0.rtRightAtlas
			local var_62_4 = 0

			WorldConst = var_2_10006

			local var_62_5 = var_62_2(var_62_3, var_62_4, var_2_10006.UIEaseFasterDuration)
			local var_62_6 = var_3.setEase

			LeanTweenType = var_62_4

			local var_62_7 = var_62_6(var_62_5, var_62_4.easeInSine)
			local var_62_8 = var_3.setOnComplete

			System = var_5

			var_62_1(var_62_0, var_62_8(var_62_7, var_5.Action(arg_62_0)).uniqueId)

			return
		end
	}, function()
		existCall = var_2_10000

		return var_2_10000(arg_59_1)
	end)

	return
end

function var_0_1.EaseOutAtlasUI(arg_64_0, arg_64_1)
	arg_64_0:CancelAtlasUITween()

	parallelAsync = var_2

	var_2({
		function(arg_65_0)
			setAnchoredPosition = var_2_10001

			var_2_10001(arg_64_0.rtTopAtlas, {
				y = 0
			})

			local var_65_0 = arg_64_0.wsTimer
			local var_65_1 = var_1.AddTween

			LeanTween = var_3

			local var_65_2 = var_3.moveY
			local var_65_3 = arg_64_0.rtTopAtlas
			local var_65_4 = arg_64_0.rtTopAtlas.rect.height

			WorldConst = var_2_10006

			local var_65_5 = var_65_2(var_65_3, var_65_4, var_2_10006.UIEaseFasterDuration)
			local var_65_6 = var_3.setEase

			LeanTweenType = var_65_4

			local var_65_7 = var_65_6(var_65_5, var_65_4.easeOutSine)
			local var_65_8 = var_3.setOnComplete

			System = var_5

			var_65_1(var_65_0, var_65_8(var_65_7, var_5.Action(arg_65_0)).uniqueId)

			return
		end,
		function(arg_66_0)
			setAnchoredPosition = var_2_10001

			var_2_10001(arg_64_0.rtBottomAtlas, {
				y = 0
			})

			local var_66_0 = arg_64_0.wsTimer
			local var_66_1 = var_1.AddTween

			LeanTween = var_3

			local var_66_2 = var_3.moveY
			local var_66_3 = arg_64_0.rtBottomAtlas
			local var_66_4 = -arg_64_0.rtBottomAtlas.rect.height

			WorldConst = var_2_10006

			local var_66_5 = var_66_2(var_66_3, var_66_4, var_2_10006.UIEaseFasterDuration)
			local var_66_6 = var_3.setEase

			LeanTweenType = var_66_4

			local var_66_7 = var_66_6(var_66_5, var_66_4.easeOutSine)
			local var_66_8 = var_3.setOnComplete

			System = var_5

			var_66_1(var_66_0, var_66_8(var_66_7, var_5.Action(arg_66_0)).uniqueId)

			return
		end,
		function(arg_67_0)
			setAnchoredPosition = var_2_10001

			var_2_10001(arg_64_0.rtRightAtlas, {
				x = 0
			})

			local var_67_0 = arg_64_0.wsTimer
			local var_67_1 = var_1.AddTween

			LeanTween = var_3

			local var_67_2 = var_3.moveX
			local var_67_3 = arg_64_0.rtRightAtlas
			local var_67_4 = arg_64_0.rtRightAtlas.rect.width

			WorldConst = var_2_10006

			local var_67_5 = var_67_2(var_67_3, var_67_4, var_2_10006.UIEaseFasterDuration)
			local var_67_6 = var_3.setEase

			LeanTweenType = var_67_4

			local var_67_7 = var_67_6(var_67_5, var_67_4.easeOutSine)
			local var_67_8 = var_3.setOnComplete

			System = var_5

			var_67_1(var_67_0, var_67_8(var_67_7, var_5.Action(arg_67_0)).uniqueId)

			return
		end
	}, function()
		existCall = var_2_10000

		return var_2_10000(arg_64_1)
	end)

	return
end

function var_0_1.CancelAtlasUITween(arg_69_0)
	LeanTween = var_1_10001

	local var_69_0 = var_1_10001.cancel

	go = var_1_10002

	var_69_0(var_1_10002(arg_69_0.rtTransportAtlas))

	LeanTween = var_69_0

	local var_69_1 = var_69_0.cancel

	go = var_2

	var_69_1(var_2(arg_69_0.rtTopAtlas))

	LeanTween = var_69_1

	local var_69_2 = var_69_1.cancel

	go = var_2

	var_69_2(var_2(arg_69_0.rtBottomAtlas))

	LeanTween = var_69_2

	local var_69_3 = var_69_2.cancel

	go = var_2

	var_69_3(var_2(arg_69_0.rtRightAtlas))

	return
end

function var_0_1.DisposeAtlasUI(arg_70_0)
	arg_70_0:HideAtlasUI()
	arg_70_0:DisposeAtlasTransport()
	arg_70_0:DisposeAtlasTop()
	arg_70_0:DisposeAtlasRight()
	arg_70_0:DisposeAtlasBottom()

	return
end

function var_0_1.DisplayAtlas(arg_71_0)
	nowWorld = var_1_10001

	local var_71_0 = var_1_10001()
	local var_71_1 = var_1.GetActiveEntrance(var_71_0)
	local var_71_2 = arg_71_0.wsAtlas

	var_2.SwitchArea(var_71_2, var_71_1:GetAreaId())

	local var_71_3 = arg_71_0.wsAtlas

	var_2.UpdateActiveMark(var_71_3)

	local var_71_4 = arg_71_0.wsAtlas

	var_2.ShowOrHide(var_71_4, true)

	return
end

function var_0_1.HideAtlas(arg_72_0)
	local var_72_0 = arg_72_0.wsAtlas

	var_1.UpdateSelect(var_72_0)

	local var_72_1 = arg_72_0.wsAtlas

	var_1.ShowOrHide(var_72_1, false)

	return
end

function var_0_1.ClickAtlas(arg_73_0, arg_73_1)
	pg = var_1_10002

	local var_73_0 = var_1_10002.CriMgr.GetInstance()
	local var_73_1 = var_2.PlaySoundEffect_V3

	SFX_PANEL = var_1_10004

	var_73_1(var_73_0, var_1_10004)

	local var_73_2 = arg_73_1
	local var_73_3 = arg_73_1.GetAreaId(var_73_2)

	nowWorld = var_73_2

	local var_73_4 = var_73_2()

	if not var_3.CheckAreaUnlock(var_73_4, var_73_3) then
		pg = var_3

		local var_73_5 = var_3.TipsMgr.GetInstance()
		local var_73_6 = var_3.ShowTips

		i18n = var_5

		var_73_6(var_73_5, var_5("area_lock"))

		return
	end

	if arg_73_0.wsAtlas.nowArea then
		local var_73_7 = arg_73_0.wsAtlas

		var_3.UpdateSelect(var_73_7)

		if arg_73_0.wsAtlas.selectEntrance ~= arg_73_1 then
			local var_73_8 = arg_73_0.wsAtlas

			var_3.UpdateSelect(var_73_8, arg_73_1)
		end
	else
		arg_73_0:EnterToModelMap(var_73_3)
	end

	return
end

function var_0_1.LoadAtlas(arg_74_0, arg_74_1)
	local var_74_0 = {}

	if not arg_74_0.wsAtlas then
		table = var_3

		var_3.insert(var_74_0, function(arg_75_0)
			local var_75_0 = arg_74_0
			local var_75_1 = arg_74_0

			var_75_0.wsAtlas = var_2.NewAtlas(var_75_1)

			local var_75_2 = arg_74_0.wsAtlas

			var_1.LoadScene(var_75_2, function()
				local var_76_0 = arg_74_0.wsAtlas
				local var_76_1 = var_0.AddListener

				WSAtlasWorld = var_3_10002

				var_76_1(var_76_0, var_3_10002.EventUpdateselectEntrance, arg_74_0.onModelSelectMap)

				local var_76_2 = arg_74_0.wsAtlas
				local var_76_3 = var_0.UpdateAtlas

				nowWorld = var_2

				local var_76_4 = var_2()

				var_76_3(var_76_2, var_2.GetAtlas(var_76_4))

				return arg_75_0()
			end)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_74_0, arg_74_1)

	return
end

function var_0_1.NewAtlas(arg_77_0)
	WSAtlasWorld = var_1_10001

	local var_77_0 = var_1_10001.New()

	var_77_0.wsTimer = arg_77_0.wsTimer

	function var_77_0.onClickColor(arg_78_0, arg_78_1)
		local var_78_0 = arg_77_0.wsAtlas

		if var_2.CheckIsTweening(var_78_0) then
			return
		end

		local var_78_1 = arg_77_0

		var_2.Op(var_78_1, "OpCall", function(arg_79_0)
			arg_79_0()

			local var_79_0 = arg_77_0

			var_1.ClickAtlas(var_79_0, arg_78_0)

			return
		end)

		return
	end

	var_77_0:Setup()

	return var_77_0
end

function var_0_1.DisposeAtlas(arg_80_0)
	if arg_80_0.wsAtlas then
		arg_80_0:HideAtlas()

		local var_80_0 = arg_80_0.wsAtlas
		local var_80_1 = var_1.RemoveListener

		WSAtlasWorld = var_1_10003

		var_80_1(var_80_0, var_1_10003.EventUpdateselectEntrance, arg_80_0.onModelSelectMap)

		local var_80_2 = arg_80_0.wsAtlas

		var_1.Dispose(var_80_2)

		arg_80_0.wsAtlas = nil
	end

	return
end

function var_0_1.DisplayAtlasTop(arg_81_0)
	local var_81_0

	if not arg_81_0.wsAtlasTop then
		var_81_0 = arg_81_0:NewAtlasTop(arg_81_0.rtTopAtlas)
	end

	arg_81_0.wsAtlasTop = var_81_0
	setActive = var_81_0

	var_81_0(arg_81_0.rtTopAtlas, true)

	setActive = var_81_0

	local var_81_1 = arg_81_0.rtTopAtlas

	var_81_0(var_2.Find(var_81_1, "print/title_world"), true)

	setActive = var_81_0

	local var_81_2 = arg_81_0.rtTopAtlas

	var_81_0(var_2.Find(var_81_2, "print/title_view"), false)

	setActive = var_81_0

	local var_81_3 = arg_81_0.rtTopAtlas
	local var_81_4 = var_2.Find(var_81_3, "sairen_warning")
	local var_81_6

	if arg_81_0.warningSairen then
		nowWorld = var_81_6

		local var_81_5 = var_81_6()

		var_81_6 = #var_81_6.GetAtlas(var_81_5).sairenEntranceList > 0
	end

	var_81_0(var_81_4, var_81_6)

	arg_81_0.warningSairen = false

	return
end

function var_0_1.HideAtlasTop(arg_82_0)
	setActive = var_1_10001

	var_1_10001(arg_82_0.rtTopAtlas, false)

	return
end

function var_0_1.NewAtlasTop(arg_83_0, arg_83_1)
	local var_83_0 = {
		transform = arg_83_1
	}

	onButton = var_1_10003

	local var_83_1 = arg_83_0
	local var_83_2 = arg_83_1:Find("back_button")

	local function var_83_3()
		local var_84_0 = arg_83_0

		var_0.Op(var_84_0, "OpCall", function(arg_85_0)
			arg_85_0()

			local var_85_0 = arg_83_0

			var_1.BackToMap(var_85_0)

			return
		end)

		return
	end

	SFX_CANCEL = var_7

	var_1_10003(var_83_1, var_83_2, var_83_3, var_7)

	return var_83_0
end

function var_0_1.DisposeAtlasTop(arg_86_0)
	arg_86_0.wsAtlasTop = nil

	return
end

function var_0_1.DisplayAtlasRight(arg_87_0)
	local var_87_0

	if not arg_87_0.wsAtlasRight then
		var_87_0 = arg_87_0:NewAtlasRight(arg_87_0.rtRightAtlas)
	end

	arg_87_0.wsAtlasRight = var_87_0

	local var_87_1 = arg_87_0.wsAtlasRight
	local var_87_2 = var_1.SetOverSize
	local var_87_3 = arg_87_0.rtTop

	var_87_2(var_87_1, var_3.Find(var_87_3, "adapt").offsetMax.x)

	setActive = var_87_2

	var_87_2(arg_87_0.rtRightAtlas, true)

	return
end

function var_0_1.HideAtlasRight(arg_88_0)
	setActive = var_1_10001

	var_1_10001(arg_88_0.rtRightAtlas, false)

	return
end

function var_0_1.NewAtlasRight(arg_89_0, arg_89_1, arg_89_2)
	WSAtlasRight = var_1_10003

	local var_89_0 = var_1_10003.New()

	var_89_0.transform = arg_89_1

	var_89_0:Setup()

	onButton = var_4

	local var_89_1 = arg_89_0
	local var_89_2 = var_89_0.btnSettings

	local function var_89_3()
		local var_90_0 = arg_89_0
		local var_90_1 = var_0.Op
		local var_90_2 = "OpOpenScene"

		SCENE = var_2_10003

		local var_90_3 = var_2_10003.SETTINGS
		local var_90_4 = {
			scroll = "world_settings"
		}

		NewSettingsScene = var_2_10005
		var_90_4.page = var_2_10005.PAGE_OPTION

		var_90_1(var_90_0, var_90_2, var_90_3, var_90_4)

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_89_1, var_89_2, var_89_3, var_1_10008)

	onButton = var_4

	local var_89_4 = arg_89_0
	local var_89_5 = var_89_0.btnSwitch

	local function var_89_6()
		local var_91_0 = arg_89_0
		local var_91_1 = var_0.Op
		local var_91_2 = "OpOpenLayer"

		Context = var_2_10003

		local var_91_3 = var_2_10003.New
		local var_91_4 = {}

		WorldSwitchPlanningMediator = var_2_10005
		var_91_4.mediator = var_2_10005
		WorldSwitchPlanningLayer = var_2_10005
		var_91_4.viewComponent = var_2_10005

		var_91_1(var_91_0, var_91_2, var_91_3(var_91_4))

		return
	end

	SFX_CONFIRM = var_1_10008

	var_4(var_89_4, var_89_5, var_89_6, var_1_10008)

	return var_89_0
end

function var_0_1.DisposeAtlasRight(arg_92_0)
	if arg_92_0.wsAtlasRight then
		local var_92_0 = arg_92_0.wsAtlasRight

		var_1.Dispose(var_92_0)

		arg_92_0.wsAtlasRight = nil
	end

	return
end

function var_0_1.DisplayAtlasBottom(arg_93_0)
	local var_93_0

	if not arg_93_0.wsAtlasBottom then
		var_93_0 = arg_93_0:NewAtlasBottom(arg_93_0.rtBottomAtlas)
	end

	arg_93_0.wsAtlasBottom = var_93_0

	local var_93_1 = arg_93_0.wsAtlasBottom
	local var_93_2 = var_1.SetOverSize
	local var_93_3 = arg_93_0.rtTop

	var_93_2(var_93_1, var_3.Find(var_93_3, "adapt").offsetMax.x)

	local var_93_4 = arg_93_0.wsAtlasBottom

	var_1.UpdateScale(var_93_4, 1)

	setActive = var_1

	var_1(arg_93_0.rtBottomAtlas, true)

	setActive = var_1

	local var_93_5 = arg_93_0.wsAtlasBottom.btnDailyTask
	local var_93_6 = var_2.Find(var_93_5, "tip")

	nowWorld = var_93_5

	local var_93_7 = var_93_5()
	local var_93_8 = var_3.GetTaskProxy(var_93_7)

	var_1(var_93_6, var_3.canAcceptDailyTask(var_93_8))

	return
end

function var_0_1.HideAtlasBottom(arg_94_0)
	setActive = var_1_10001

	var_1_10001(arg_94_0.rtBottomAtlas, false)

	return
end

function var_0_1.NewAtlasBottom(arg_95_0, arg_95_1)
	WSAtlasBottom = var_1_10002

	local var_95_0 = var_1_10002.New()

	var_95_0.transform = arg_95_1
	var_95_0.wsTimer = arg_95_0.wsTimer

	var_95_0:Setup()

	CAMERA_MOVE_OPEN = var_95_2

	local var_95_2

	if var_95_2 then
		local var_95_1 = var_95_0

		var_95_2 = var_95_0.AddListener
		WSAtlasBottom = var_1_10005

		var_95_2(var_95_1, var_1_10005.EventUpdateScale, arg_95_0.onUpdateScale)
	end

	onButton = var_95_2

	local var_95_3 = arg_95_0
	local var_95_4 = var_95_0.btnOverview

	local function var_95_5()
		local var_96_0 = arg_95_0.wsAtlas

		if var_0.CheckIsTweening(var_96_0) then
			return
		end

		local var_96_1 = arg_95_0

		var_0.Op(var_96_1, "OpCall", function(arg_97_0)
			local var_97_0 = arg_95_0.wsAtlas

			var_1.LoadModel(var_97_0, function()
				arg_97_0()

				local var_98_0 = arg_95_0

				var_0.ReturnToModelArea(var_98_0)

				return
			end)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10007

	var_95_2(var_95_3, var_95_4, var_95_5, var_1_10007)

	onButton = var_95_2

	local var_95_6 = arg_95_0
	local var_95_7 = var_95_0.btnBoss

	local function var_95_8()
		nowWorld = var_2_10000

		local var_99_0 = var_2_10000()
		local var_99_1 = var_0.GetBossProxy(var_99_0)
		local var_99_3

		if var_0.IsOpen(var_99_1) then
			local var_99_2 = arg_95_0

			var_99_3 = var_99_3.Op
			var_2_10002 = "OpOpenScene"
			SCENE = var_2_10003

			var_99_3(var_99_2, var_2_10002, var_2_10003.WORLDBOSS)
		else
			pg = var_99_3

			local var_99_4 = var_99_3.TipsMgr.GetInstance()
			local var_99_5 = var_0.ShowTips

			i18n = var_2_10002

			var_99_5(var_99_4, var_2_10002("common_activity_end"))
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_95_2(var_95_6, var_95_7, var_95_8, var_1_10007)

	onButton = var_95_2

	local var_95_9 = arg_95_0
	local var_95_10 = var_95_0.btnShop

	local function var_95_11()
		local var_100_0 = arg_95_0
		local var_100_1 = var_0.Op
		local var_100_2 = "OpOpenLayer"

		Context = var_2_10003

		local var_100_3 = var_2_10003.New
		local var_100_4 = {}

		WorldShopMediator = var_2_10005
		var_100_4.mediator = var_2_10005
		WorldShopLayer = var_2_10005
		var_100_4.viewComponent = var_2_10005

		var_100_1(var_100_0, var_100_2, var_100_3(var_100_4))

		return
	end

	SFX_PANEL = var_1_10007

	var_95_2(var_95_9, var_95_10, var_95_11, var_1_10007)

	onButton = var_95_2

	local var_95_12 = arg_95_0
	local var_95_13 = var_95_0.btnCollection

	local function var_95_14()
		local var_101_0 = arg_95_0
		local var_101_1 = var_0.Op
		local var_101_2 = "OpOpenScene"

		SCENE = var_2_10003

		local var_101_3 = var_2_10003.WORLD_COLLECTION
		local var_101_4 = {}

		WorldMediaCollectionScene = var_2_10005
		var_101_4.page = var_2_10005.PAGE_RECORD

		var_101_1(var_101_0, var_101_2, var_101_3, var_101_4)

		return
	end

	SFX_PANEL = var_1_10007

	var_95_2(var_95_12, var_95_13, var_95_14, var_1_10007)

	onButton = var_95_2

	local var_95_15 = arg_95_0
	local var_95_16 = var_95_0.btnDailyTask

	local function var_95_17()
		nowWorld = var_2_10000

		local var_102_0 = var_2_10000()
		local var_102_1 = var_0.IsSystemOpen

		WorldConst = var_2_10003

		if var_102_1(var_102_0, var_2_10003.SystemDailyTask) then
			var_102_0 = var_0
			var_102_0 = var_0.GetTaskProxy(var_102_0)

			var_1.checkDailyTask(var_102_0, function()
				local var_103_0 = arg_95_0
				local var_103_1 = var_0.Op
				local var_103_2 = "OpOpenLayer"

				Context = var_3_10003

				local var_103_3 = var_3_10003.New
				local var_103_4 = {}

				WorldDailyTaskMediator = var_3_10005
				var_103_4.mediator = var_3_10005
				WorldDailyTaskLayer = var_3_10005
				var_103_4.viewComponent = var_3_10005

				var_103_1(var_103_0, var_103_2, var_103_3(var_103_4))

				return
			end)
		else
			pg = var_1

			local var_102_2 = var_1.TipsMgr.GetInstance

			i18n = var_102_0

			var_102_2(var_102_0("world_daily_task_lock"))
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_95_2(var_95_15, var_95_16, var_95_17, var_1_10007)

	return var_95_0
end

function var_0_1.DisposeAtlasBottom(arg_104_0)
	if arg_104_0.wsAtlasBottom then
		local var_104_0 = arg_104_0.wsAtlasBottom

		var_1.Dispose(var_104_0)

		arg_104_0.wsAtlasBottom = nil
	end

	return
end

function var_0_1.DisplayAtlasTransport(arg_105_0)
	local var_105_0

	if not arg_105_0.wsAtlasTransport then
		var_105_0 = arg_105_0:NewAtlasTransport(arg_105_0.rtTransportAtlas)
	end

	arg_105_0.wsAtlasTransport = var_105_0
	setActive = var_105_0

	var_105_0(arg_105_0.rtTransportAtlas, true)

	return
end

function var_0_1.HideAtlasTransport(arg_106_0)
	setActive = var_1_10001

	var_1_10001(arg_106_0.rtTransportAtlas, false)

	return
end

function var_0_1.NewAtlasTransport(arg_107_0, arg_107_1)
	local var_107_0 = {
		transform = arg_107_1,
		btnBack = arg_107_1:Find("adapt/btn_back")
	}

	onButton = var_3

	local var_107_1 = arg_107_0
	local var_107_2 = var_107_0.btnBack

	local function var_107_3()
		assert = var_2_10000

		var_2_10000(arg_107_0.inTransportMode, "this isn't transport mode atlas")

		local var_108_0 = arg_107_0

		var_0.BackToMap(var_108_0)

		return
	end

	SFX_CANCEL = var_1_10007

	var_3(var_107_1, var_107_2, var_107_3, var_1_10007)

	return var_107_0
end

function var_0_1.DisposeAtlasTransport(arg_109_0)
	arg_109_0.wsAtlasTransport = nil

	return
end

function var_0_1.DisplayMapUI(arg_110_0)
	arg_110_0:DisplayMapTop()
	arg_110_0:DisplayMapLeft()
	arg_110_0:DisplayMapRight()
	arg_110_0:DisplayMapOut()
	arg_110_0:UpdateSystemOpen()

	return
end

function var_0_1.HideMapUI(arg_111_0)
	arg_111_0:HideMapTop()
	arg_111_0:HideMapLeft()
	arg_111_0:HideMapRight()
	arg_111_0:HideMapOut()

	return
end

function var_0_1.UpdateMapUI(arg_112_0)
	nowWorld = var_1_10001

	local var_112_0 = var_1_10001()
	local var_112_1 = var_1.GetActiveEntrance(var_112_0)
	local var_112_2 = var_1:GetActiveMap()
	local var_112_3 = arg_112_0.wsMapTop

	var_4.Update(var_112_3, var_112_1, var_112_2)

	local var_112_4 = arg_112_0.wsMapLeft

	var_4.UpdateMap(var_112_4, var_112_2)

	local var_112_5 = arg_112_0.wsMapRight

	var_4.Update(var_112_5, var_112_1, var_112_2)

	local var_112_6 = arg_112_0.wsMapOut

	var_4.UpdateMap(var_112_6, var_112_2)

	return
end

function var_0_1.EaseInMapUI(arg_113_0, arg_113_1)
	arg_113_0:CancelMapUITween()

	parallelAsync = var_2

	var_2({
		function(arg_114_0)
			setAnchoredPosition = var_2_10001

			var_2_10001(arg_113_0.rtTopMap, {
				y = arg_113_0.rtTopMap.rect.height
			})

			local var_114_0 = arg_113_0.wsTimer
			local var_114_1 = var_1.AddTween

			LeanTween = var_3

			local var_114_2 = var_3.moveY
			local var_114_3 = arg_113_0.rtTopMap
			local var_114_4 = 0

			WorldConst = var_2_10006

			local var_114_5 = var_114_2(var_114_3, var_114_4, var_2_10006.UIEaseFasterDuration)
			local var_114_6 = var_3.setEase

			LeanTweenType = var_114_4

			local var_114_7 = var_114_6(var_114_5, var_114_4.easeInSine)
			local var_114_8 = var_3.setOnComplete

			System = var_5

			var_114_1(var_114_0, var_114_8(var_114_7, var_5.Action(arg_114_0)).uniqueId)

			return
		end,
		function(arg_115_0)
			setAnchoredPosition = var_2_10001

			var_2_10001(arg_113_0.rtLeftMap, {
				x = -arg_113_0.rtLeftMap.rect.width
			})

			local var_115_0 = arg_113_0.wsTimer
			local var_115_1 = var_1.AddTween

			LeanTween = var_3

			local var_115_2 = var_3.moveX
			local var_115_3 = arg_113_0.rtLeftMap
			local var_115_4 = 0

			WorldConst = var_2_10006

			local var_115_5 = var_115_2(var_115_3, var_115_4, var_2_10006.UIEaseFasterDuration)
			local var_115_6 = var_3.setEase

			LeanTweenType = var_115_4

			local var_115_7 = var_115_6(var_115_5, var_115_4.easeInSine)
			local var_115_8 = var_3.setOnComplete

			System = var_5

			var_115_1(var_115_0, var_115_8(var_115_7, var_5.Action(arg_115_0)).uniqueId)

			return
		end,
		function(arg_116_0)
			setAnchoredPosition = var_2_10001

			var_2_10001(arg_113_0.rtRightMap, {
				x = arg_113_0.rtRightMap.rect.width
			})

			local var_116_0 = arg_113_0.wsTimer
			local var_116_1 = var_1.AddTween

			LeanTween = var_3

			local var_116_2 = var_3.moveX
			local var_116_3 = arg_113_0.rtRightMap
			local var_116_4 = 0

			WorldConst = var_2_10006

			local var_116_5 = var_116_2(var_116_3, var_116_4, var_2_10006.UIEaseFasterDuration)
			local var_116_6 = var_3.setEase

			LeanTweenType = var_116_4

			local var_116_7 = var_116_6(var_116_5, var_116_4.easeInSine)
			local var_116_8 = var_3.setOnComplete

			System = var_5

			var_116_1(var_116_0, var_116_8(var_116_7, var_5.Action(arg_116_0)).uniqueId)

			return
		end
	}, function()
		existCall = var_2_10000

		return var_2_10000(arg_113_1)
	end)

	return
end

function var_0_1.EaseOutMapUI(arg_118_0, arg_118_1)
	arg_118_0:CancelMapUITween()

	parallelAsync = var_2

	var_2({
		function(arg_119_0)
			setAnchoredPosition = var_2_10001

			var_2_10001(arg_118_0.rtTopMap, {
				y = 0
			})

			local var_119_0 = arg_118_0.wsTimer
			local var_119_1 = var_1.AddTween

			LeanTween = var_3

			local var_119_2 = var_3.moveY
			local var_119_3 = arg_118_0.rtTopMap
			local var_119_4 = arg_118_0.rtTopMap.rect.height

			WorldConst = var_2_10006

			local var_119_5 = var_119_2(var_119_3, var_119_4, var_2_10006.UIEaseFasterDuration)
			local var_119_6 = var_3.setEase

			LeanTweenType = var_119_4

			local var_119_7 = var_119_6(var_119_5, var_119_4.easeOutSine)
			local var_119_8 = var_3.setOnComplete

			System = var_5

			var_119_1(var_119_0, var_119_8(var_119_7, var_5.Action(arg_119_0)).uniqueId)

			return
		end,
		function(arg_120_0)
			setAnchoredPosition = var_2_10001

			var_2_10001(arg_118_0.rtLeftMap, {
				x = 0
			})

			local var_120_0 = arg_118_0.wsTimer
			local var_120_1 = var_1.AddTween

			LeanTween = var_3

			local var_120_2 = var_3.moveX
			local var_120_3 = arg_118_0.rtLeftMap
			local var_120_4 = -arg_118_0.rtLeftMap.rect.width

			WorldConst = var_2_10006

			local var_120_5 = var_120_2(var_120_3, var_120_4, var_2_10006.UIEaseFasterDuration)
			local var_120_6 = var_3.setEase

			LeanTweenType = var_120_4

			local var_120_7 = var_120_6(var_120_5, var_120_4.easeOutSine)
			local var_120_8 = var_3.setOnComplete

			System = var_5

			var_120_1(var_120_0, var_120_8(var_120_7, var_5.Action(arg_120_0)).uniqueId)

			return
		end,
		function(arg_121_0)
			setAnchoredPosition = var_2_10001

			var_2_10001(arg_118_0.rtRightMap, {
				x = 0
			})

			local var_121_0 = arg_118_0.wsTimer
			local var_121_1 = var_1.AddTween

			LeanTween = var_3

			local var_121_2 = var_3.moveX
			local var_121_3 = arg_118_0.rtRightMap
			local var_121_4 = arg_118_0.rtRightMap.rect.width

			WorldConst = var_2_10006

			local var_121_5 = var_121_2(var_121_3, var_121_4, var_2_10006.UIEaseFasterDuration)
			local var_121_6 = var_3.setEase

			LeanTweenType = var_121_4

			local var_121_7 = var_121_6(var_121_5, var_121_4.easeOutSine)
			local var_121_8 = var_3.setOnComplete

			System = var_5

			var_121_1(var_121_0, var_121_8(var_121_7, var_5.Action(arg_121_0)).uniqueId)

			return
		end
	}, function()
		existCall = var_2_10000

		return var_2_10000(arg_118_1)
	end)

	return
end

function var_0_1.CancelMapUITween(arg_123_0)
	LeanTween = var_1_10001

	local var_123_0 = var_1_10001.cancel

	go = var_1_10002

	var_123_0(var_1_10002(arg_123_0.rtTopMap))

	LeanTween = var_123_0

	local var_123_1 = var_123_0.cancel

	go = var_2

	var_123_1(var_2(arg_123_0.rtLeftMap))

	LeanTween = var_123_1

	local var_123_2 = var_123_1.cancel

	go = var_2

	var_123_2(var_2(arg_123_0.rtRightMap))

	return
end

function var_0_1.DisposeMapUI(arg_124_0)
	arg_124_0:DisposeMapTop()
	arg_124_0:DisposeMapLeft()
	arg_124_0:DisposeMapRight()
	arg_124_0:DisposeMapOut()

	return
end

function var_0_1.DisplayMap(arg_125_0)
	setActive = var_1_10001

	var_1_10001(arg_125_0.rtUIMain, true)

	return
end

function var_0_1.HideMap(arg_126_0)
	setActive = var_1_10001

	var_1_10001(arg_126_0.rtUIMain, false)

	return
end

function var_0_1.ShowMargin(arg_127_0, arg_127_1)
	if arg_127_0.wsMap then
		local var_127_0 = arg_127_0.wsMap

		var_2.UpdateTransportDisplay(var_127_0, arg_127_1)
	end

	return
end

function var_0_1.LoadMap(arg_128_0, arg_128_1, arg_128_2)
	assert = var_1_10003

	var_1_10003(arg_128_1, "target map not exist.")

	local var_128_0 = {}

	if not arg_128_1:IsValid() then
		table = var_4

		var_4.insert(var_128_0, function(arg_129_0)
			local var_129_0 = arg_128_0
			local var_129_1 = var_1.emit

			WorldMediator = var_2_10003

			var_129_1(var_129_0, var_2_10003.OnMapReq, arg_128_1.id, arg_129_0)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_128_0, function()
		if arg_128_0.wsMap then
			existCall = var_0

			return var_0(arg_128_2)
		else
			local var_130_0 = arg_128_1
			local var_130_1 = var_0.AddListener

			WorldMap = var_2_10002

			var_130_1(var_130_0, var_2_10002.EventUpdateActive, arg_128_0.onDisposeMap)

			local var_130_2 = arg_128_1
			local var_130_3 = var_0.AddListener

			WorldMap = var_2

			var_130_3(var_130_2, var_2.EventUpdateMoveSpeed, arg_128_0.onClearMoveQueue)

			local var_130_4 = arg_128_0
			local var_130_5 = arg_128_0

			var_130_4.wsMap = var_1.NewMap(var_130_5, arg_128_1)

			local var_130_6 = arg_128_0.wsMap

			var_0.Load(var_130_6, function()
				local var_131_0 = arg_128_0.wsMap.transform

				var_0.SetParent(var_131_0, arg_128_0.rtDragLayer, false)

				setActive = var_0

				var_0(arg_128_0.wsMap.transform, true)

				local var_131_1 = arg_128_0

				var_0.InitMap(var_131_1)

				existCall = var_0

				return var_0(arg_128_2)
			end)
		end

		return
	end)

	return
end

function var_0_1.InitMap(arg_132_0)
	ipairs = var_1_10001

	for iter_132_0, iter_132_1 in var_1_10001(arg_132_0.wsMap.wsMapFleets) do
		onButton = var_1_10006

		local var_132_0 = arg_132_0
		local var_132_1 = iter_132_1.rtRetreat

		local function var_132_2()
			local var_133_0 = arg_132_0

			var_0.Op(var_133_0, "OpReqRetreat", iter_132_1.fleet)

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_132_0, var_132_1, var_132_2, var_1_10010)

		local var_132_3 = iter_132_1

		var_1_10006 = iter_132_1.AddListener
		WSMapFleet = var_132_1

		var_1_10006(var_132_3, var_132_1.EventUpdateSelected, arg_132_0.onFleetSelected)
	end

	local var_132_4 = arg_132_0.wsMap
	local var_132_5 = var_1.AddListener

	WSMap = var_3

	var_132_5(var_132_4, var_3.EventUpdateEventTips, arg_132_0.onUpdateEventTips)

	nowWorld = var_132_5

	local var_132_6 = var_132_5()
	local var_132_7 = var_1.AddListener

	World = var_4

	var_132_7(var_132_6, var_4.EventUpdateSubmarineSupport, arg_132_0.onUpdateSubmarineSupport)

	local var_132_8 = var_1
	local var_132_9 = var_1.AddListener

	World = var_4

	var_132_9(var_132_8, var_4.EventAchieved, arg_132_0.onAchievementAchieved)

	local var_132_10 = arg_132_0.wsMap.map
	local var_132_11 = arg_132_0.wsDragProxy

	var_3.UpdateMap(var_132_11, var_132_10)

	local var_132_12 = arg_132_0.wsDragProxy
	local var_132_13 = var_3.Focus
	local var_132_14 = arg_132_0.wsMap

	var_132_13(var_132_12, var_5.GetFleet(var_132_14).transform.position)

	local var_132_15 = arg_132_0.wsMapCamera

	var_3.UpdateMap(var_132_15, var_132_10)
	arg_132_0:OnUpdateSubmarineSupport()

	return
end

function var_0_1.NewMap(arg_134_0, arg_134_1)
	WSMap = var_1_10002

	local var_134_0 = var_1_10002.New()

	var_134_0.wsPool = arg_134_0.wsPool
	var_134_0.wsTimer = arg_134_0.wsTimer

	local var_134_1 = var_134_0

	var_134_0.Setup(var_134_1, arg_134_1)

	local var_134_2 = arg_134_0.rtGrid

	Vector3 = var_134_1
	var_134_2.localEulerAngles = var_134_1(arg_134_1.theme.angle, 0, 0)

	return var_134_0
end

function var_0_1.DisposeMap(arg_135_0)
	if arg_135_0.wsMap then
		local var_135_0 = arg_135_0.wsTimer

		var_1.ClearInMapTimers(var_135_0)

		local var_135_1 = arg_135_0.wsTimer

		var_1.ClearInMapTweens(var_135_1)
		arg_135_0:HideMap()

		nowWorld = var_1

		local var_135_2 = var_1()
		local var_135_3 = var_1.RemoveListener

		World = var_1_10004

		var_135_3(var_135_2, var_1_10004.EventUpdateSubmarineSupport, arg_135_0.onUpdateSubmarineSupport)

		local var_135_4 = var_1
		local var_135_5 = var_1.RemoveListener

		World = var_4

		var_135_5(var_135_4, var_4.EventAchieved, arg_135_0.onAchievementAchieved)

		local var_135_6 = arg_135_0.wsMap.map
		local var_135_7 = var_2.RemoveListener

		WorldMap = var_5

		var_135_7(var_135_6, var_5.EventUpdateActive, arg_135_0.onDisposeMap)

		local var_135_8 = var_2
		local var_135_9 = var_2.RemoveListener

		WorldMap = var_5

		var_135_9(var_135_8, var_5.EventUpdateMoveSpeed, arg_135_0.onClearMoveQueue)

		local var_135_10 = arg_135_0.wsMap

		var_3.Dispose(var_135_10)

		arg_135_0.wsMap = nil
	end

	return
end

function var_0_1.OnDisposeMap(arg_136_0, arg_136_1, arg_136_2)
	local var_136_0 = false

	WorldMap = var_1_10004

	if arg_136_1 == var_1_10004.EventUpdateActive then
		var_136_0 = not arg_136_2.active
	end

	if var_136_0 then
		arg_136_0:DisposeMap()
	end

	return
end

function var_0_1.DisplayMapTop(arg_137_0)
	local var_137_0

	if not arg_137_0.wsMapTop then
		var_137_0 = arg_137_0:NewMapTop(arg_137_0.rtTopMap)
	end

	arg_137_0.wsMapTop = var_137_0
	setActive = var_137_0

	var_137_0(arg_137_0.rtTopMap, true)

	return
end

function var_0_1.HideMapTop(arg_138_0)
	setActive = var_1_10001

	var_1_10001(arg_138_0.rtTopMap, false)

	return
end

function var_0_1.NewMapTop(arg_139_0, arg_139_1)
	WSMapTop = var_1_10002

	local var_139_0 = var_1_10002.New()

	var_139_0.transform = arg_139_1

	var_139_0:Setup()

	function var_139_0.cmdSkillFunc(arg_140_0)
		local var_140_0 = arg_139_0
		local var_140_1 = var_1.emit

		WorldMediator = var_2_10003

		local var_140_2 = var_2_10003.OnOpenLayer

		Context = var_2_10004

		local var_140_3 = var_2_10004.New
		local var_140_4 = {}

		CommanderSkillMediator = var_2_10006
		var_140_4.mediator = var_2_10006
		CommanderSkillLayer = var_2_10006
		var_140_4.viewComponent = var_2_10006
		var_140_4.data = {
			isWorld = true,
			skill = arg_140_0
		}

		var_140_1(var_140_0, var_140_2, var_140_3(var_140_4))

		return
	end

	function var_139_0.poisonFunc(arg_141_0)
		local var_141_0 = arg_139_0

		var_1.ShowSubView(var_141_0, "PoisonPanel", {
			arg_141_0
		})

		return
	end

	onButton = var_3

	local var_139_1 = arg_139_0
	local var_139_2 = var_139_0.btnBack

	local function var_139_3()
		local var_142_0 = arg_139_0

		var_0.Op(var_142_0, "OpCall", function(arg_143_0)
			local var_143_0 = arg_139_0

			var_1.ExitWorld(var_143_0, arg_143_0)

			return
		end)

		return
	end

	SFX_CANCEL = var_1_10007

	var_3(var_139_1, var_139_2, var_139_3, var_1_10007)

	return var_139_0
end

function var_0_1.DisposeMapTop(arg_144_0)
	if arg_144_0.wsMapTop then
		arg_144_0:HideMapTop()

		local var_144_0 = arg_144_0.wsMapTop

		var_1.Dispose(var_144_0)

		arg_144_0.wsMapTop = nil
	end

	return
end

function var_0_1.DisplayMapLeft(arg_145_0)
	local var_145_0

	if not arg_145_0.wsMapLeft then
		var_145_0 = arg_145_0:NewMapLeft(arg_145_0.rtLeftMap)
	end

	arg_145_0.wsMapLeft = var_145_0
	setActive = var_145_0

	var_145_0(arg_145_0.rtLeftMap, true)

	return
end

function var_0_1.HideMapLeft(arg_146_0)
	setActive = var_1_10001

	var_1_10001(arg_146_0.rtLeftMap, false)

	return
end

function var_0_1.NewMapLeft(arg_147_0, arg_147_1)
	WSMapLeft = var_1_10002

	local var_147_0 = var_1_10002.New()

	var_147_0.transform = arg_147_1

	var_147_0:Setup()

	function var_147_0.onAgonyClick()
		local var_148_0 = arg_147_0
		local var_148_1 = var_0.Op
		local var_148_2 = "OpOpenLayer"

		Context = var_2_10003

		local var_148_3 = var_2_10003.New
		local var_148_4 = {}

		WorldInventoryMediator = var_2_10005
		var_148_4.mediator = var_2_10005
		WorldInventoryLayer = var_2_10005
		var_148_4.viewComponent = var_2_10005

		local var_148_5 = {}

		nowWorld = var_2_10006

		local var_148_6 = var_2_10006()

		var_148_5.currentFleetIndex = var_6.GetActiveMap(var_148_6).findex
		var_148_4.data = var_148_5

		var_148_1(var_148_0, var_148_2, var_148_3(var_148_4))

		return
	end

	function var_147_0.onLongPress(arg_149_0)
		nowWorld = var_2_10001

		local var_149_0 = var_2_10001()
		local var_149_1 = var_1.GetFleet(var_149_0, arg_149_0.fleetId)
		local var_149_2 = var_1.GetShipVOs(var_149_1, true)
		local var_149_3 = arg_147_0
		local var_149_4 = var_3.Op
		local var_149_5 = "OpOpenScene"

		SCENE = var_2_10006

		var_149_4(var_149_3, var_149_5, var_2_10006.SHIPINFO, {
			shipId = arg_149_0.id,
			shipVOs = var_149_2
		})

		return
	end

	function var_147_0.onClickSalvage(arg_150_0)
		local var_150_0 = arg_147_0

		var_1.Op(var_150_0, "OpCall", function(arg_151_0)
			arg_151_0()

			local var_151_0 = arg_147_0

			var_1.ShowSubView(var_151_0, "SalvageResult", {
				arg_150_0
			})

			return
		end)

		return
	end

	local var_147_1 = var_147_0
	local var_147_2 = var_147_0.AddListener

	WSMapLeft = var_1_10005

	var_147_2(var_147_1, var_1_10005.EventSelectFleet, arg_147_0.onSelectFleet)

	return var_147_0
end

function var_0_1.DisposeMapLeft(arg_152_0)
	if arg_152_0.wsMapLeft then
		arg_152_0:HideMapLeft()

		local var_152_0 = arg_152_0.wsMapLeft
		local var_152_1 = var_1.RemoveListener

		WSMapLeft = var_1_10003

		var_152_1(var_152_0, var_1_10003.EventSelectFleet, arg_152_0.onSelectFleet)

		local var_152_2 = arg_152_0.wsMapLeft

		var_1.Dispose(var_152_2)

		arg_152_0.wsMapLeft = nil
	end

	return
end

function var_0_1.DisplayMapRight(arg_153_0)
	local var_153_0

	if not arg_153_0.wsMapRight then
		var_153_0 = arg_153_0:NewMapRight(arg_153_0.rtRightMap)
	end

	arg_153_0.wsMapRight = var_153_0
	setActive = var_153_0

	var_153_0(arg_153_0.rtRightMap, true)
	arg_153_0:UpdateAutoFightDisplay()
	arg_153_0:UpdateAutoSwitchDisplay()

	return
end

function var_0_1.HideMapRight(arg_154_0)
	setActive = var_1_10001

	var_1_10001(arg_154_0.rtRightMap, false)

	return
end

function var_0_1.HideMapRightCompass(arg_155_0)
	return
end

function var_0_1.HideMapRightMemo(arg_156_0)
	return
end

function var_0_1.NewMapRight(arg_157_0, arg_157_1)
	WSMapRight = var_1_10002

	local var_157_0 = var_1_10002.New()

	var_157_0.transform = arg_157_1
	var_157_0.wsPool = arg_157_0.wsPool
	var_157_0.wsTimer = arg_157_0.wsTimer

	var_157_0:Setup()
	var_157_0:OnUpdateInfoBtnTip()
	var_157_0:OnUpdateHelpBtnTip()

	onButton = var_3

	local var_157_1 = arg_157_0
	local var_157_2 = var_157_0.btnOrder

	local function var_157_3()
		local var_158_0 = arg_157_0

		var_0.Op(var_158_0, "OpShowOrderPanel")

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_157_1, var_157_2, var_157_3, var_1_10007)

	onButton = var_3

	local var_157_4 = arg_157_0
	local var_157_5 = var_157_0.btnScan

	local function var_157_6()
		local var_159_0 = arg_157_0

		var_0.Op(var_159_0, "OpShowScannerPanel")

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_157_4, var_157_5, var_157_6, var_1_10007)

	onButton = var_3

	local var_157_7 = arg_157_0
	local var_157_8 = var_157_0.btnDefeat

	local function var_157_9()
		local var_160_0 = var_157_0

		var_0.OnUpdateHelpBtnTip(var_160_0, true)

		local var_160_1 = arg_157_0
		local var_160_2 = var_0.Op
		local var_160_3 = "OpOpenLayer"

		Context = var_2_10003

		local var_160_4 = var_2_10003.New
		local var_160_5 = {}

		WorldHelpMediator = var_2_10005
		var_160_5.mediator = var_2_10005
		WorldHelpLayer = var_2_10005
		var_160_5.viewComponent = var_2_10005
		var_160_5.data = {
			titleId = 4,
			pageId = 5
		}

		var_160_2(var_160_1, var_160_3, var_160_4(var_160_5))

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_157_7, var_157_8, var_157_9, var_1_10007)

	onButton = var_3

	local var_157_10 = arg_157_0
	local var_157_11 = var_157_0.btnDetail

	local function var_157_12()
		local var_161_0 = arg_157_0
		local var_161_1 = var_0.Op
		local var_161_2 = "OpOpenLayer"

		Context = var_2_10003

		local var_161_3 = var_2_10003.New
		local var_161_4 = {}

		WorldDetailMediator = var_2_10005
		var_161_4.mediator = var_2_10005
		WorldDetailLayer = var_2_10005
		var_161_4.viewComponent = var_2_10005

		local var_161_5 = {}

		nowWorld = var_2_10006

		local var_161_6 = var_2_10006()
		local var_161_7 = var_6.GetActiveMap(var_161_6)

		var_161_5.fleetId = var_6.GetFleet(var_161_7).id
		var_161_4.data = var_161_5

		var_161_1(var_161_0, var_161_2, var_161_3(var_161_4))

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_157_10, var_157_11, var_157_12, var_1_10007)

	onButton = var_3

	local var_157_13 = arg_157_0
	local var_157_14 = var_157_0.btnInformation

	local function var_157_15()
		local var_162_0 = arg_157_0
		local var_162_1 = var_0.Op
		local var_162_2 = "OpOpenLayer"

		Context = var_2_10003

		local var_162_3 = var_2_10003.New
		local var_162_4 = {}

		WorldInformationMediator = var_2_10005
		var_162_4.mediator = var_2_10005
		WorldInformationLayer = var_2_10005
		var_162_4.viewComponent = var_2_10005

		local var_162_5 = {}

		nowWorld = var_2_10006

		local var_162_6 = var_2_10006()
		local var_162_7 = var_6.GetActiveMap(var_162_6)

		var_162_5.fleetId = var_6.GetFleet(var_162_7).id
		var_162_4.data = var_162_5

		var_162_1(var_162_0, var_162_2, var_162_3(var_162_4))

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_157_13, var_157_14, var_157_15, var_1_10007)

	onButton = var_3

	local var_157_16 = arg_157_0
	local var_157_17 = var_157_0.btnInventory

	local function var_157_18()
		local var_163_0 = arg_157_0
		local var_163_1 = var_0.Op
		local var_163_2 = "OpOpenLayer"

		Context = var_2_10003

		local var_163_3 = var_2_10003.New
		local var_163_4 = {}

		WorldInventoryMediator = var_2_10005
		var_163_4.mediator = var_2_10005
		WorldInventoryLayer = var_2_10005
		var_163_4.viewComponent = var_2_10005

		local var_163_5 = {}

		nowWorld = var_2_10006

		local var_163_6 = var_2_10006()

		var_163_5.currentFleetIndex = var_6.GetActiveMap(var_163_6).findex
		var_163_4.data = var_163_5

		var_163_1(var_163_0, var_163_2, var_163_3(var_163_4))

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_157_16, var_157_17, var_157_18, var_1_10007)

	onButton = var_3

	local var_157_19 = arg_157_0
	local var_157_20 = var_157_0.btnTransport

	local function var_157_21()
		local var_164_0 = arg_157_0

		var_0.OnClickTransport(var_164_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_157_19, var_157_20, var_157_21, var_1_10007)

	onButton = var_3

	local var_157_22 = arg_157_0
	local var_157_23 = var_157_0.btnPort

	local function var_157_24()
		nowWorld = var_2_10000

		local var_165_0 = var_2_10000()
		local var_165_1 = var_0.GetActiveMap(var_165_0)
		local var_165_2 = var_0.GetFleet(var_165_1)
		local var_165_3 = var_0:GetCell(var_165_2.row, var_165_2.column)

		if var_2.ExistEnemy(var_165_3) then
			pg = var_3

			local var_165_4 = var_3.TipsMgr.GetInstance()
			local var_165_5 = var_3.ShowTips

			i18n = var_5

			var_165_5(var_165_4, var_5("world_port_inbattle"))

			return
		end

		local var_165_6 = arg_157_0

		var_3.Op(var_165_6, "OpReqEnterPort")

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_157_22, var_157_23, var_157_24, var_1_10007)

	onButton = var_3

	local var_157_25 = arg_157_0
	local var_157_26 = var_157_0.btnExit

	local function var_157_27()
		nowWorld = var_2_10000

		local var_166_0 = var_2_10000()
		local var_166_1 = var_0.GetActiveMap(var_166_0)
		local var_166_2 = {}

		if var_166_1:CheckFleetSalvage(true) then
			table = var_2

			var_2.insert(var_166_2, function(arg_167_0)
				pg = var_3_10001

				local var_167_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_167_1 = var_1.ShowMsgBox
				local var_167_2 = {}

				i18n = var_3_10004
				var_167_2.content = var_3_10004("world_catsearch_leavemap")
				var_167_2.onYes = arg_167_0

				var_167_1(var_167_0, var_167_2)

				return
			end)
		end

		seriesAsync = var_2

		var_2(var_166_2, function()
			local var_168_0 = arg_157_0

			var_0.Op(var_168_0, "OpReqJumpOut", var_166_1.gid)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_157_25, var_157_26, var_157_27, var_1_10007)

	onButton = var_3

	local var_157_28 = arg_157_0
	local var_157_29 = var_157_0.btnHelp

	local function var_157_30()
		local var_169_0 = var_157_0

		var_0.OnUpdateHelpBtnTip(var_169_0, true)

		local var_169_1 = arg_157_0
		local var_169_2 = var_0.Op
		local var_169_3 = "OpOpenLayer"

		Context = var_2_10003

		local var_169_4 = var_2_10003.New
		local var_169_5 = {}

		WorldHelpMediator = var_2_10005
		var_169_5.mediator = var_2_10005
		WorldHelpLayer = var_2_10005
		var_169_5.viewComponent = var_2_10005

		var_169_2(var_169_1, var_169_3, var_169_4(var_169_5))

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_157_28, var_157_29, var_157_30, var_1_10007)

	onButton = var_3

	local var_157_31 = arg_157_0
	local var_157_32 = var_157_0.toggleAutoFight
	local var_157_33 = var_5.Find(var_157_32, "off")

	local function var_157_34()
		local var_170_0 = arg_157_0

		var_0.Op(var_170_0, "OpCall", function(arg_171_0)
			arg_171_0()

			local var_171_0 = {}

			PlayerPrefs = var_3_10002

			if var_3_10002.GetInt("first_auto_fight_mark", 0) == 0 then
				table = var_2

				var_2.insert(var_171_0, function(arg_172_0)
					PlayerPrefs = var_4_10001

					var_4_10001.SetInt("first_auto_fight_mark", 1)

					local var_172_0 = arg_157_0
					local var_172_1 = var_1.Op
					local var_172_2 = "OpOpenLayer"

					Context = var_4_10004

					local var_172_3 = var_4_10004.New
					local var_172_4 = {}

					WorldHelpMediator = var_4_10006
					var_172_4.mediator = var_4_10006
					WorldHelpLayer = var_4_10006
					var_172_4.viewComponent = var_4_10006
					var_172_4.data = {
						titleId = 2,
						pageId = 8
					}
					var_172_4.onRemoved = arg_172_0

					var_172_1(var_172_0, var_172_2, var_172_3(var_172_4))

					return
				end)
			end

			nowWorld = var_2

			local var_171_1 = var_2()
			local var_171_2 = var_2.IsSystemOpen

			WorldConst = var_3_10005

			local var_171_5

			if var_171_2(var_171_1, var_3_10005.SystemOrderSubmarine) then
				PlayerPrefs = var_171_5

				if var_171_5.GetInt("world_sub_auto_call", 0) == 1 then
					local var_171_3 = var_2:GetActiveMap()

					if var_171_5.GetConfig(var_171_3, "instruction_available")[1] == 1 and var_2:CanCallSubmarineSupport() and not var_2:IsSubmarineSupporting() then
						local var_171_4 = var_2

						var_171_5 = var_2.CalcOrderCost
						WorldConst = var_5
						var_171_5 = var_171_5(var_171_4, var_5.OpReqSub)
						PlayerPrefs = var_171_4

						if var_171_5 <= var_171_4.GetInt("world_sub_call_line", 0) then
							local var_171_6 = var_2.staminaMgr

							if var_171_5 <= var_4.GetTotalStamina(var_171_6) then
								if 0 < var_171_5 then
									table = var_4

									var_4.insert(var_171_0, function(arg_173_0)
										pg = var_4_10001

										local var_173_0 = var_4_10001.MsgboxMgr.GetInstance()
										local var_173_1 = var_1.ShowMsgBox
										local var_173_2 = {}

										i18n = var_4_10004

										local var_173_3 = "world_instruction_submarine_2"

										setColorStr = var_4_10006

										local var_173_4 = var_171_5

										COLOR_GREEN = var_4_10008
										var_173_2.content = var_4_10004(var_173_3, var_4_10006(var_173_4, var_4_10008))

										function var_173_2.onYes()
											PlayerPrefs = var_5_10000

											local var_174_0 = var_5_10000.SetInt
											local var_174_1 = "autoSubIsAcitve"

											AutoSubCommand = var_5_10002

											local var_174_2 = var_5_10002.GetAutoSubMark

											SYSTEM_WORLD = var_5_10003

											var_174_0(var_174_1 .. var_174_2(var_5_10003), 1)

											local var_174_3 = arg_157_0

											var_0.Op(var_174_3, "OpReqSub", arg_173_0)

											return
										end

										var_173_2.onNo = arg_173_0

										var_173_1(var_173_0, var_173_2)

										return
									end)
								else
									PlayerPrefs = var_4

									local var_171_7 = var_4.SetInt
									local var_171_8 = "autoSubIsAcitve"

									AutoSubCommand = var_6

									local var_171_9 = var_6.GetAutoSubMark

									SYSTEM_WORLD = var_3_10007

									var_171_7(var_171_8 .. var_171_9(var_3_10007), 1)

									table = var_171_7

									var_171_7.insert(var_171_0, function(arg_175_0)
										local var_175_0 = arg_157_0

										var_1.Op(var_175_0, "OpReqSub", arg_175_0)

										return
									end)
								end
							end
						end
					end
				end
			end

			seriesAsync = var_171_5

			var_171_5(var_171_0, function()
				pg = var_4_10000

				local var_176_0 = var_4_10000.TipsMgr.GetInstance()
				local var_176_1 = var_0.ShowTips

				i18n = var_4_10002

				var_176_1(var_176_0, var_4_10002("autofight_tip_bigworld_begin"))

				getProxy = var_176_1
				MetaCharacterProxy = var_176_0

				local var_176_2 = var_176_1(var_176_0)

				var_0.setMetaTacticsInfoOnStart(var_176_2)

				PlayerPrefs = var_0

				var_0.SetInt("world_skip_precombat", 1)

				PlayerPrefs = var_0

				local var_176_3 = var_0.SetInt
				local var_176_4 = "autoBotIsAcitve"

				AutoBotCommand = var_2

				local var_176_5 = var_2.GetAutoBotMark

				SYSTEM_WORLD = var_3

				var_176_3(var_176_4 .. var_176_5(var_3), 1)

				local var_176_6 = var_0

				var_0.TriggerAutoFight(var_176_6, true)

				local var_176_7 = arg_157_0

				var_0.Op(var_176_7, "OpInteractive")

				return
			end)

			return
		end)

		return
	end

	SFX_PANEL = var_7

	var_3(var_157_31, var_157_33, var_157_34, var_7)

	onButton = var_3

	local var_157_35 = arg_157_0
	local var_157_36 = var_157_0.toggleAutoFight
	local var_157_37 = var_5.Find(var_157_36, "on")

	local function var_157_38()
		local var_177_0 = arg_157_0

		var_0.Op(var_177_0, "OpCall", function(arg_178_0)
			arg_178_0()

			nowWorld = var_1

			local var_178_0 = var_1()

			var_1.TriggerAutoFight(var_178_0, false)

			local var_178_1 = arg_157_0

			var_1.Op(var_178_1, "OpInteractive")

			return
		end)

		return
	end

	SFX_PANEL = var_7

	var_3(var_157_35, var_157_37, var_157_38, var_7)

	onButton = var_3

	local var_157_39 = arg_157_0
	local var_157_40 = var_157_0.toggleAutoSwitch
	local var_157_41 = var_5.Find(var_157_40, "off")

	local function var_157_42()
		local var_179_0 = arg_157_0
		local var_179_1 = var_0.Op
		local var_179_2 = "OpOpenLayer"

		Context = var_2_10003

		local var_179_3 = var_2_10003.New
		local var_179_4 = {}

		WorldSwitchPlanningMediator = var_2_10005
		var_179_4.mediator = var_2_10005
		WorldSwitchPlanningLayer = var_2_10005
		var_179_4.viewComponent = var_2_10005

		var_179_1(var_179_0, var_179_2, var_179_3(var_179_4))

		return
	end

	SFX_PANEL = var_7

	var_3(var_157_39, var_157_41, var_157_42, var_7)

	onButton = var_3

	local var_157_43 = arg_157_0
	local var_157_44 = var_157_0.toggleAutoSwitch
	local var_157_45 = var_5.Find(var_157_44, "on")

	local function var_157_46()
		local var_180_0 = arg_157_0

		var_0.Op(var_180_0, "OpCall", function(arg_181_0)
			arg_181_0()

			nowWorld = var_1

			local var_181_0 = var_1()

			var_1.TriggerAutoFight(var_181_0, false)

			local var_181_1 = arg_157_0

			var_1.Op(var_181_1, "OpInteractive")

			return
		end)

		return
	end

	SFX_PANEL = var_7

	var_3(var_157_43, var_157_45, var_157_46, var_7)

	return var_157_0
end

function var_0_1.DisposeMapRight(arg_182_0)
	if arg_182_0.wsMapRight then
		arg_182_0:HideMapRight()

		local var_182_0 = arg_182_0.wsMapRight

		var_1.Dispose(var_182_0)

		arg_182_0.wsMapRight = nil
	end

	return
end

function var_0_1.DisplayMapOut(arg_183_0)
	local var_183_0

	if not arg_183_0.wsMapOut then
		var_183_0 = arg_183_0:NewMapOut(arg_183_0.rtOutMap)
	end

	arg_183_0.wsMapOut = var_183_0
	setActive = var_183_0

	var_183_0(arg_183_0.rtOutMap, true)

	return
end

function var_0_1.HideMapOut(arg_184_0)
	setActive = var_1_10001

	var_1_10001(arg_184_0.rtOutMap, false)

	return
end

function var_0_1.NewMapOut(arg_185_0, arg_185_1)
	WSMapOut = var_1_10002

	local var_185_0 = var_1_10002.New()

	var_185_0.transform = arg_185_1

	var_185_0:Setup()

	return var_185_0
end

function var_0_1.DisposeMapOut(arg_186_0)
	if arg_186_0.wsMapOut then
		arg_186_0:HideMapOut()

		local var_186_0 = arg_186_0.wsMapOut

		var_1.Dispose(var_186_0)

		arg_186_0.wsMapOut = nil
	end

	return
end

function var_0_1.OnUpdateProgress(arg_187_0, arg_187_1, arg_187_2, arg_187_3, arg_187_4)
	arg_187_0:UpdateSystemOpen()

	if arg_187_0.wsMapRight then
		local var_187_0 = arg_187_0.wsMapRight

		var_5.OnUpdateHelpBtnTip(var_187_0)
	end

	return
end

function var_0_1.OnUpdateScale(arg_188_0, arg_188_1, arg_188_2, arg_188_3)
	if arg_188_0.wsAtlas then
		local var_188_0 = arg_188_0.wsAtlasBottom

		if not var_4.CheckIsTweening(var_188_0) then
			local var_188_1 = arg_188_0.wsAtlas

			var_4.UpdateScale(var_188_1, arg_188_3)
		end
	end

	return
end

function var_0_1.OnModelSelectMap(arg_189_0, arg_189_1, arg_189_2, arg_189_3, arg_189_4, arg_189_5)
	if arg_189_3 then
		arg_189_0:ShowSubView("FloatPanel", {
			arg_189_3,
			arg_189_4,
			arg_189_5,
			arg_189_2
		})
	else
		arg_189_0:HideSubView("FloatPanel")
	end

	return
end

function var_0_1.OnUpdateSubmarineSupport(arg_190_0, arg_190_1)
	local var_190_0 = arg_190_0.wsMap

	var_2.UpdateSubmarineSupport(var_190_0)

	if arg_190_0.wsMapLeft then
		local var_190_1 = arg_190_0.wsMapLeft

		var_2.OnUpdateSubmarineSupport(var_190_1)
	end

	return
end

function var_0_1.OnUpdateDaily(arg_191_0)
	if arg_191_0.wsAtlasBottom then
		setActive = var_1

		local var_191_0 = arg_191_0.wsAtlasBottom.btnDailyTask
		local var_191_1 = var_2.Find(var_191_0, "tip")

		nowWorld = var_191_0

		local var_191_2 = var_191_0()
		local var_191_3 = var_3.GetTaskProxy(var_191_2)

		var_1(var_191_1, var_3.canAcceptDailyTask(var_191_3))
	end

	return
end

function var_0_1.OnFleetSelected(arg_192_0, arg_192_1, arg_192_2)
	if arg_192_2.selected then
		local var_192_0 = arg_192_0.wsDragProxy
		local var_192_1 = var_3.Focus
		local var_192_2 = arg_192_2.transform.position
		local var_192_3

		LeanTweenType = var_1_10007

		var_192_1(var_192_0, var_192_2, var_192_3, var_1_10007.easeInOutSine)
	end

	return
end

function var_0_1.OnSelectFleet(arg_193_0, arg_193_1, arg_193_2, arg_193_3)
	nowWorld = var_1_10004

	local var_193_0 = var_1_10004()
	local var_193_1 = var_4.GetActiveMap(var_193_0)

	if arg_193_3 == var_4.GetFleet(var_193_1) then
		arg_193_0:Op("OpMoveCamera", 0, 0.1)
	else
		arg_193_0:Op("OpReqSwitchFleet", arg_193_3)
	end

	return
end

function var_0_1.OnClickCell(arg_194_0, arg_194_1, arg_194_2)
	nowWorld = var_1_10003

	local var_194_0 = var_1_10003()
	local var_194_1 = var_3.GetActiveMap(var_194_0)
	local var_194_2 = var_3.GetFleet(var_194_1)
	local var_194_3 = var_3:GetCell(arg_194_1, arg_194_2)

	if var_3:FindFleet(var_194_3.row, var_194_3.column) and var_6 ~= var_194_2 then
		arg_194_0:Op("OpReqSwitchFleet", var_6)
	elseif var_3:CheckInteractive() then
		arg_194_0:Op("OpInteractive", true)
	else
		if var_3:IsSign(arg_194_1, arg_194_2) then
			ManhattonDist = var_7

			if var_7({
				row = var_194_2.row,
				column = var_194_2.column
			}, {
				row = var_194_3.row,
				column = var_194_3.column
			}) <= 1 then
				arg_194_0:Op("OpTriggerSign", var_194_2, var_194_3:GetEventAttachment(), function()
					local var_195_0 = arg_194_0

					var_0.Op(var_195_0, "OpInteractive")

					return
				end)

				goto label_194_0
			end
		end

		if var_3:CanLongMove(var_194_2) then
			arg_194_0:Op("OpLongMoveFleet", var_194_2, var_194_3.row, var_194_3.column)
		else
			arg_194_0:Op("OpReqMoveFleet", var_194_2, var_194_3.row, var_194_3.column)
		end
	end

	::label_194_0::

	return
end

function var_0_1.OnClickTransport(arg_196_0)
	local var_196_0 = arg_196_0.svScannerPanel

	if var_1.isShowing(var_196_0) then
		return
	end

	arg_196_0:Op("OpCall", function(arg_197_0)
		arg_197_0()

		local var_197_0 = arg_196_0

		var_1.QueryTransport(var_197_0, function()
			local var_198_0 = arg_196_0

			var_0.EnterTransportWorld(var_198_0)

			return
		end)

		return
	end)

	return
end

function var_0_1.QueryTransport(arg_199_0, arg_199_1)
	nowWorld = var_1_10002

	local var_199_0 = var_1_10002()
	local var_199_1 = var_2.GetActiveMap(var_199_0)
	local var_199_2 = {}
	local var_199_3 = var_2
	local var_199_4 = var_2.IsSystemOpen

	WorldConst = var_1_10007

	if not var_199_4(var_199_3, var_1_10007.SystemOutMap) then
		pg = var_5

		local var_199_5 = var_5.TipsMgr.GetInstance()
		local var_199_6 = var_5.ShowTips

		i18n = var_7

		var_199_6(var_199_5, var_7("word_systemClose"))

		return
	end

	local var_199_7 = var_199_1

	if var_199_1.CheckAttachmentTransport(var_199_7) == "story" then
		pg = var_199_7

		local var_199_8 = var_199_7.gameset.world_transfer_eventstory.description[1]

		table = var_7

		var_7.insert(var_199_2, function(arg_200_0)
			local var_200_0 = arg_199_0

			var_1.OpRaw(var_200_0, "OpStory", var_199_8, true, true, false, function(arg_201_0)
				if arg_201_0 == 1 then
					arg_200_0()
				end

				return
			end)

			return
		end)
	end

	if var_2:IsSubmarineSupporting() then
		local var_199_9 = var_199_1:GetSubmarineFleet()

		if var_6.GetAmmo(var_199_9) > 0 then
			table = var_6

			var_6.insert(var_199_2, function(arg_202_0)
				pg = var_2_10001

				local var_202_0 = var_2_10001.MsgboxMgr.GetInstance()
				local var_202_1 = var_1.ShowMsgBox
				local var_202_2 = {}

				i18n = var_2_10004
				var_202_2.content = var_2_10004("world_instruction_submarine_6")
				var_202_2.onYes = arg_202_0

				var_202_1(var_202_0, var_202_2)

				return
			end)
		end
	end

	local var_199_10 = var_199_1

	if var_199_1.CheckFleetSalvage(var_199_10, true) then
		table = var_6

		var_6.insert(var_199_2, function(arg_203_0)
			pg = var_2_10001

			local var_203_0 = var_2_10001.MsgboxMgr.GetInstance()
			local var_203_1 = var_1.ShowMsgBox
			local var_203_2 = {}

			i18n = var_2_10004
			var_203_2.content = var_2_10004("world_catsearch_leavemap")
			var_203_2.onYes = arg_203_0

			var_203_1(var_203_0, var_203_2)

			return
		end)
	end

	local var_199_11

	ipairs = var_199_10

	for iter_199_0, iter_199_1 in var_199_10(var_199_1:GetNormalFleets()) do
		ipairs = var_1_10012

		for iter_199_2, iter_199_3 in var_1_10012(iter_199_1:GetCarries()) do
			if iter_199_3.config.out_story ~= "" then
				var_199_11 = iter_199_3.config.out_story
			end
		end
	end

	if var_199_11 then
		table = var_7

		var_7.insert(var_199_2, function(arg_204_0)
			local var_204_0 = arg_199_0

			var_1.OpRaw(var_204_0, "OpStory", var_199_11, true, true, false, function(arg_205_0)
				if arg_205_0 == 1 then
					arg_204_0()
				end

				return
			end)

			return
		end)
	end

	local var_199_12, var_199_13 = var_199_1:CkeckTransport()

	if not var_199_12 then
		table = var_9

		var_9.insert(var_199_2, function(arg_206_0)
			pg = var_2_10001

			local var_206_0 = var_2_10001.MsgboxMgr.GetInstance()

			var_1.ShowMsgBox(var_206_0, {
				content = var_199_13,
				onYes = arg_206_0
			})

			return
		end)
	end

	seriesAsync = var_9

	var_9(var_199_2, function()
		return arg_199_1(var_199_12)
	end)

	return
end

function var_0_1.OnUpdateEventTips(arg_208_0, arg_208_1, arg_208_2)
	if arg_208_0.wsMapRight then
		local var_208_0 = arg_208_0.wsMapRight

		var_3.OnUpdateEventTips(var_208_0)
	end

	if arg_208_0.wsMapTop then
		local var_208_1 = arg_208_0.wsMapTop

		var_3.OnUpdatePoison(var_208_1)
	end

	return
end

function var_0_1.OnClickMap(arg_209_0, arg_209_1, arg_209_2)
	pg = var_1_10003

	local var_209_0 = var_1_10003.CriMgr.GetInstance()
	local var_209_1 = var_3.PlaySoundEffect_V3

	SFX_PANEL = var_1_10005

	var_209_1(var_209_0, var_1_10005)

	local var_209_2 = arg_209_0.wsMap.map.top
	local var_209_3 = var_3.bottom
	local var_209_4 = var_3.left
	local var_209_5 = var_3.right

	if arg_209_1 < var_209_2 or var_209_3 < arg_209_1 or arg_209_2 < var_209_4 or var_209_5 < arg_209_2 then
		arg_209_0:OnClickTransport()
	else
		arg_209_0:OnClickCell(arg_209_1, arg_209_2)
	end

	return
end

function var_0_1.CheckScannerEnable(arg_210_0, arg_210_1, arg_210_2)
	nowWorld = var_1_10003

	local var_210_0 = var_1_10003()
	local var_210_1 = var_3.IsSystemOpen

	WorldConst = var_1_10005

	if var_210_1(var_210_0, var_1_10005.SystemScanner) then
		local var_210_2 = arg_210_0.wsMap.map

		if var_3.GetCell(var_210_2, arg_210_1, arg_210_2) and var_4:GetInFOV() and not var_4:InFog() and var_4:GetScannerAttachment() then
			local var_210_3 = arg_210_0.wsMap
			local var_210_4 = var_6.GetCell(var_210_3, arg_210_1, arg_210_2).rtAttachments.position
			local var_210_5 = var_5
			local var_210_6 = arg_210_0.camera
			local var_210_7 = var_8.WorldToScreenPoint(var_210_6, var_210_4)

			return
		end
	end

	return
end

function var_0_1.OnLongPressMap(arg_211_0, arg_211_1, arg_211_2)
	local var_211_0 = arg_211_0.svScannerPanel

	if not var_3.isShowing(var_211_0) then
		local var_211_1, var_211_2 = arg_211_0:CheckScannerEnable(arg_211_1, arg_211_2)

		if var_211_1 then
			arg_211_0:Op("OpShowScannerPanel", var_211_1, var_211_2)
		end
	end

	return
end

function var_0_1.OnAchievementAchieved(arg_212_0, arg_212_1, arg_212_2, arg_212_3, arg_212_4)
	if arg_212_3 then
		ipairs = var_1_10005

		for iter_212_0, iter_212_1 in var_1_10005(arg_212_3) do
			pg = var_1_10010

			local var_212_0 = var_1_10010.TipsMgr.GetInstance()

			var_1_10010.ShowTips(var_212_0, iter_212_1)
		end
	end

	if arg_212_4 then
		nowWorld = var_1_10005

		local var_212_2

		if var_1_10005().isAutoFight then
			local var_212_1 = var_5

			var_212_2 = var_5.AddAutoInfo

			local var_212_3 = "message"

			i18n = iter_212_1

			var_212_2(var_212_1, var_212_3, iter_212_1("autofight_discovery", arg_212_4.config.target_desc))
		else
			table = var_212_2

			var_212_2.insert(arg_212_0.achievedList, {
				arg_212_4,
				arg_212_0.wsMapRight.btnInformation.position
			})
		end
	end

	return
end

function var_0_1.DoAnim(arg_213_0, arg_213_1, arg_213_2)
	local var_213_0 = arg_213_0.wsAnim

	if not var_3.GetAnim(var_213_0, arg_213_1) then
		var_3:SetAnim(arg_213_1, arg_213_0:NewUIAnim(arg_213_1))
	end

	local var_213_1 = var_3:GetAnim(arg_213_1)

	var_4.Play(var_213_1, arg_213_2)

	return
end

function var_0_1.NewUIAnim(arg_214_0, arg_214_1)
	UIAnim = var_1_10002

	local var_214_0 = var_1_10002.New()

	var_2.Setup(var_214_0, arg_214_1)

	local var_214_1 = var_2
	local var_214_2 = var_2.AddListener

	UIAnim = var_5

	var_214_2(var_214_1, var_5.EventLoaded, function()
		local var_215_0 = var_0.transform

		var_0.SetParent(var_215_0, arg_214_0.rtTop, false)

		return
	end)
	var_2:Load()

	return var_2
end

function var_0_1.DoStrikeAnim(arg_216_0, arg_216_1, arg_216_2, arg_216_3)
	local var_216_0 = arg_216_0.wsAnim

	if not var_4.GetAnim(var_216_0, arg_216_1) then
		var_4:SetAnim(arg_216_1, arg_216_0:NewStrikeAnim(arg_216_1, arg_216_2))
	else
		local var_216_1 = var_4:GetAnim(arg_216_1)

		var_5.ReloadShip(var_216_1, arg_216_2)
	end

	local var_216_2 = var_4:GetAnim(arg_216_1)

	var_5.Play(var_216_2, arg_216_3)

	return
end

function var_0_1.NewStrikeAnim(arg_217_0, arg_217_1, arg_217_2)
	UIStrikeAnim = var_1_10003

	local var_217_0 = var_1_10003.New()

	var_3.Setup(var_217_0, arg_217_1, arg_217_2)

	local var_217_1 = var_3
	local var_217_2 = var_3.AddListener

	UIStrikeAnim = var_6

	var_217_2(var_217_1, var_6.EventLoaded, function()
		local var_218_0 = var_0.transform

		var_0.SetParent(var_218_0, arg_217_0.rtTop, false)

		return
	end)
	var_3:Load()

	return var_3
end

function var_0_1.StopAnim(arg_219_0)
	local var_219_0 = arg_219_0.wsAnim

	var_1.Stop(var_219_0)

	return
end

function var_0_1.UpdateSystemOpen(arg_220_0)
	nowWorld = var_1_10001

	local var_220_0 = var_1_10001()
	local var_220_1

	if arg_220_0:GetInMap() then
		var_220_1 = var_220_0:GetActiveMap()

		local var_220_2 = arg_220_0.wsMapLeft
		local var_220_3 = var_220_0
		local var_220_4 = var_220_0.IsSystemOpen

		WorldConst = var_1_10006
		var_220_2.onAgonyClickEnabled = var_220_4(var_220_3, var_1_10006.SystemInventory)
		setActive = var_220_2

		local var_220_5 = arg_220_0.wsMapRight.btnInventory

		var_1_10006 = var_220_0

		local var_220_6 = var_220_0.IsSystemOpen

		WorldConst = var_1_10007

		var_220_2(var_220_5, var_220_6(var_1_10006, var_1_10007.SystemInventory))

		setActive = var_220_2

		local var_220_7 = arg_220_0.wsMapRight.btnTransport

		var_1_10006 = var_220_0

		local var_220_8 = var_220_0.IsSystemOpen

		WorldConst = var_7

		var_220_2(var_220_7, var_220_8(var_1_10006, var_7.SystemOutMap))

		setActive = var_220_2

		local var_220_9 = arg_220_0.wsMapRight.btnDetail

		var_1_10006 = var_220_0

		local var_220_10 = var_220_0.IsSystemOpen

		WorldConst = var_7

		var_220_2(var_220_9, var_220_10(var_1_10006, var_7.SystemFleetDetail))

		setActive = var_220_2

		local var_220_11 = arg_220_0.wsMapRight.rtCompassPanel

		var_1_10006 = var_220_0

		local var_220_12 = var_220_0.IsSystemOpen

		WorldConst = var_7

		var_220_2(var_220_11, var_220_12(var_1_10006, var_7.SystemCompass))

		setActive = var_220_2

		local var_220_13 = arg_220_0.wsMapRight.toggleAutoFight

		var_1_10006 = var_220_1

		var_220_2(var_220_13, var_220_1.CanAutoFight(var_1_10006))

		setActive = var_220_2

		local var_220_14 = arg_220_0.wsMapRight.toggleAutoSwitch

		var_1_10006 = var_220_0

		local var_220_15 = var_220_0.IsSystemOpen

		WorldConst = var_7

		var_220_2(var_220_14, var_220_15(var_1_10006, var_7.SystemAutoSwitch))
	else
		setActive = var_220_1

		local var_220_16 = arg_220_0.wsAtlasBottom.btnBoss
		local var_220_17 = var_220_0
		local var_220_18 = var_220_0.IsSystemOpen

		WorldConst = var_1_10006

		var_220_1(var_220_16, var_220_18(var_220_17, var_1_10006.SystemWorldBoss))

		local var_220_19 = var_220_0:GetBossProxy()

		var_220_1 = var_220_1.NeedTip(var_220_19)

		local var_220_20 = var_220_0:GetBossProxy()
		local var_220_21 = var_3.ExistSelfBoss(var_220_20)

		WorldBossConst = var_220_20

		local var_220_22 = var_220_20.CanUnlockCurrBoss()
		local var_220_23 = not var_220_21 and not var_220_22

		setActive = var_1_10006

		local var_220_24 = arg_220_0.wsAtlasBottom.btnBoss
		local var_220_25 = var_7.Find(var_220_24, "tip")

		if not var_220_1 and not var_220_22 then
			::label_220_1::

			WorldBossConst = var_220_24
			var_220_24 = var_220_24.AnyArchivesBossCanGetAward()
		end

		var_1_10006(var_220_25, var_220_24)

		setActive = var_1_10006

		local var_220_26 = arg_220_0.wsAtlasBottom.btnBoss

		var_1_10006(var_7.Find(var_220_26, "sel"), not var_220_23)

		local var_220_27 = arg_220_0.rtTopAtlas

		var_1_10006 = var_1_10006.Find(var_220_27, "reset_coutdown")
		onButton = var_220_27

		local var_220_28 = arg_220_0
		local var_220_29 = var_1_10006

		local function var_220_30()
			pg = var_2_10000

			local var_221_0 = var_2_10000.MsgboxMgr.GetInstance()
			local var_221_1 = var_0.ShowMsgBox
			local var_221_2 = {}

			MSGBOX_TYPE_HELP = var_2_10003
			var_221_2.type = var_2_10003
			i18n = var_2_10003
			var_221_2.helps = var_2_10003("world_reset_tip")

			var_221_1(var_221_0, var_221_2)

			return
		end

		SFX_PANEL = var_1_10011

		var_220_27(var_220_28, var_220_29, var_220_30, var_1_10011)

		local var_220_31 = var_220_0
		local var_220_32 = var_220_0.IsSystemOpen

		WorldConst = var_220_29

		local var_220_33

		if var_220_32(var_220_31, var_220_29.SystemResetCountDown) then
			var_220_31 = var_220_0
			var_220_33 = var_220_0.CheckResetProgress(var_220_31)
		end

		setActive = var_220_31

		var_220_31(var_1_10006, var_220_33)

		if var_220_33 then
			local var_220_34 = var_220_0

			var_220_31 = var_220_0.GetResetWaitingTime(var_220_34)
			math = var_220_34

			local var_220_35 = var_220_34.floor(var_220_31 / 0)

			if 0 < var_220_35 then
				setText = var_10
				var_1_10012 = var_1_10006

				local var_220_36 = var_1_10006.Find(var_1_10012, "Text")

				i18n = var_1_10012

				local var_220_37 = "world_reset_1"

				string = var_1_10014

				var_10(var_220_36, var_1_10012(var_220_37, var_1_10014.format("  %d  ", var_220_35)))
			elseif var_220_35 == 0 then
				setText = var_10
				var_1_10012 = var_1_10006

				local var_220_38 = var_1_10006.Find(var_1_10012, "Text")

				i18n = var_1_10012

				local var_220_39 = "world_reset_2"

				string = var_1_10014

				var_10(var_220_38, var_1_10012(var_220_39, var_1_10014.format("  %d  ", 0)))
			elseif var_220_35 < 0 then
				setText = var_10
				var_1_10012 = var_1_10006

				local var_220_40 = var_1_10006.Find(var_1_10012, "Text")

				i18n = var_1_10012

				var_10(var_220_40, var_1_10012("world_reset_3"))
			end
		end

		setActive = var_220_31

		local var_220_41 = arg_220_0.wsAtlasBottom.btnShop
		local var_220_42 = var_220_0
		local var_220_43 = var_220_0.IsSystemOpen

		WorldConst = var_1_10012

		var_220_31(var_220_41, var_220_43(var_220_42, var_1_10012.SystemResetShop))

		setActive = var_220_31

		local var_220_44 = arg_220_0.wsAtlasBottom.btnDailyTask
		local var_220_45 = var_9.Find(var_220_44, "mask")
		local var_220_46 = var_220_0
		local var_220_47 = var_220_0.IsSystemOpen

		WorldConst = var_12

		var_220_31(var_220_45, not var_220_47(var_220_46, var_12.SystemDailyTask))

		setActive = var_220_31

		local var_220_48 = arg_220_0.wsAtlasRight.btnSwitch
		local var_220_49 = var_220_0
		local var_220_50 = var_220_0.IsSystemOpen

		WorldConst = var_12

		var_220_31(var_220_48, var_220_50(var_220_49, var_12.SystemAutoSwitch))
	end

	setActive = var_220_1

	local var_220_51 = arg_220_0.resAtlas._tf
	local var_220_52 = var_220_0
	local var_220_53 = var_220_0.IsSystemOpen

	WorldConst = var_1_10006

	var_220_1(var_220_51, var_220_53(var_220_52, var_1_10006.SystemResource))

	setActive = var_220_1

	local var_220_54 = arg_220_0.resMap._tf
	local var_220_55 = var_220_0
	local var_220_56 = var_220_0.IsSystemOpen

	WorldConst = var_6

	var_220_1(var_220_54, var_220_56(var_220_55, var_6.SystemResource))

	return
end

function var_0_1.EnterToModelMap(arg_222_0, arg_222_1)
	local var_222_0 = {}

	table = var_1_10003

	var_1_10003.insert(var_222_0, function(arg_223_0)
		setActive = var_2_10001

		local var_223_0 = arg_222_0.rtTopAtlas

		var_2_10001(var_2.Find(var_223_0, "print/title_world"), true)

		setActive = var_2_10001

		local var_223_1 = arg_222_0.rtTopAtlas

		var_2_10001(var_2.Find(var_223_1, "print/title_view"), false)

		local var_223_2 = arg_222_0.wsAtlasBottom

		var_1.UpdateScale(var_223_2, 1, true, arg_223_0)

		return
	end)

	table = var_3

	var_3.insert(var_222_0, function(arg_224_0)
		local var_224_0 = arg_222_0.wsAtlas

		var_1.SwitchArea(var_224_0, arg_222_1, true, arg_224_0)

		return
	end)

	parallelAsync = var_3

	var_3(var_222_0, function()
		nowWorld = var_2_10000

		local var_225_0 = var_2_10000()
		local var_225_1 = var_0.GetAtlas(var_225_0)
		local var_225_2 = var_0.GetActiveEntrance(var_225_1)

		if arg_222_1 == var_225_2:GetAreaId() then
			local var_225_3 = arg_222_0.wsAtlas

			var_1.UpdateSelect(var_225_3, var_225_2)
		end

		return
	end)

	return
end

function var_0_1.ReturnToModelArea(arg_226_0)
	local var_226_0 = arg_226_0.wsAtlas

	var_1.UpdateSelect(var_226_0)

	local var_226_1 = {}

	table = var_226_0

	var_226_0.insert(var_226_1, function(arg_227_0)
		setActive = var_2_10001

		local var_227_0 = arg_226_0.rtTopAtlas

		var_2_10001(var_2.Find(var_227_0, "print/title_world"), false)

		setActive = var_2_10001

		local var_227_1 = arg_226_0.rtTopAtlas

		var_2_10001(var_2.Find(var_227_1, "print/title_view"), true)

		local var_227_2 = arg_226_0.wsAtlasBottom

		var_1.UpdateScale(var_227_2, 0, true, arg_227_0)

		return
	end)

	table = var_2

	var_2.insert(var_226_1, function(arg_228_0)
		local var_228_0 = arg_226_0.wsAtlas

		var_1.SwitchArea(var_228_0, nil, true, arg_228_0)

		return
	end)

	parallelAsync = var_2

	var_2(var_226_1, function()
		return
	end)

	return
end

function var_0_1.EnterTransportWorld(arg_230_0, arg_230_1)
	nowWorld = var_1_10002

	local var_230_0 = var_1_10002()

	arg_230_1 = arg_230_1 or {
		entrance = var_230_0:GetActiveEntrance()
	}

	local var_230_1 = {}

	if arg_230_0:GetInMap() then
		table = var_4

		var_4.insert(var_230_1, function(arg_231_0)
			local var_231_0 = arg_230_0

			var_1.Op(var_231_0, "OpSetInMap", false, arg_231_0)

			return
		end)
	elseif not arg_230_0.wsAtlas.nowArea then
		table = var_4

		var_4.insert(var_230_1, function(arg_232_0)
			local var_232_0 = arg_230_0.wsAtlas
			local var_232_1 = var_1.SwitchArea
			local var_232_2 = arg_230_1.entrance

			var_232_1(var_232_0, var_3.GetAreaId(var_232_2), false, arg_232_0)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_230_1, function()
		local var_233_0 = arg_230_0.wsAtlas

		var_0.UpdateSelect(var_233_0)

		local var_233_1 = arg_230_0.wsAtlas

		var_0.UpdateSelect(var_233_1, arg_230_1.entrance, arg_230_1.mapId, arg_230_1.mapTypes)

		local var_233_2 = arg_230_0.wsAtlas
		local var_233_3 = var_0.DisplayTransport
		local var_233_4

		if not arg_230_0.contextData.displayTransDic then
			var_233_4 = {}
		end

		var_233_3(var_233_2, var_233_4, function()
			local var_234_0 = arg_230_0.contextData

			Clone = var_3_10001

			local var_234_1 = var_230_0

			var_234_0.displayTransDic = var_3_10001(var_2.GetAtlas(var_234_1).transportDic)

			return
		end)

		return
	end)

	return
end

function var_0_1.BackToMap(arg_235_0)
	local var_235_0 = arg_235_0.wsAtlas

	if var_1.CheckIsTweening(var_235_0) then
		return
	end

	arg_235_0:Op("OpSetInMap", true)

	return
end

function var_0_1.DisplayEnv(arg_236_0, arg_236_1)
	checkExist = var_1_10002
	nowWorld = var_1_10003

	local var_236_0 = var_1_10003()
	local var_236_1

	if not var_1_10002(var_3.GetActiveMap(var_236_0), {
		"config"
	}, {
		"map_bg"
	}, {
		1
	}) then
		var_236_1 = "model_bg"
	end

	local var_236_2 = {}
	local var_236_3 = arg_236_0.rtEnvBG
	local var_236_4 = var_4.GetComponent

	typeof = var_6
	Image = var_1_10007

	if var_236_4(var_236_3, var_6(var_1_10007)).sprite.name ~= var_236_1 then
		table = var_4

		var_4.insert(var_236_2, function(arg_237_0)
			GetSpriteFromAtlasAsync = var_2_10001

			var_2_10001("world/map/" .. var_236_1, var_236_1, function(arg_238_0)
				setImageSprite = var_3_10001

				var_3_10001(arg_236_0.rtEnvBG, arg_238_0)

				return arg_237_0()
			end)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_236_2, arg_236_1)

	return
end

function var_0_1.ScreenPos2MapPos(arg_239_0, arg_239_1)
	local var_239_0 = arg_239_0.wsMap.map
	local var_239_1 = arg_239_0.camera
	local var_239_2 = var_4.ScreenPointToRay(var_239_1, arg_239_1)

	Plane = var_239_1

	local var_239_3 = var_239_1.New
	local var_239_4 = var_2.rtQuads.forward

	Vector3 = var_1_10007

	local var_239_5 = var_239_3(var_239_4, -var_1_10007.Dot(var_2.rtQuads.position, var_2.rtQuads.forward))
	local var_239_6, var_239_7 = var_5.Raycast(var_239_5, var_239_2)

	if var_239_6 then
		local var_239_8 = var_239_2:GetPoint(var_239_7)
		local var_239_9 = var_2.rtQuads
		local var_239_10 = var_9.InverseTransformPoint(var_239_9, var_239_8)
		local var_239_11 = var_239_0.theme
		local var_239_12 = var_10.X2Column(var_239_11, var_239_10.x)
		local var_239_13 = var_239_0.theme

		return var_11.Y2Row(var_239_13, var_239_10.y), var_239_12
	end

	return
end

function var_0_1.BuildCutInAnim(arg_240_0, arg_240_1, arg_240_2)
	local var_240_0 = arg_240_0.rtPanelList

	arg_240_0.tfAnim = var_3.Find(var_240_0, arg_240_1 .. "(Clone)")

	local var_240_1 = {}

	if not arg_240_0.tfAnim then
		table = var_4

		var_4.insert(var_240_1, function(arg_241_0)
			PoolMgr = var_2_10001

			local var_241_0 = var_2_10001.GetInstance()

			var_1.GetUI(var_241_0, arg_240_1, true, function(arg_242_0)
				local var_242_0 = arg_242_0

				arg_242_0.SetActive(var_242_0, false)

				local var_242_1 = arg_240_0

				tf = var_242_0
				var_242_1.tfAnim = var_242_0(arg_242_0)

				local var_242_2 = arg_240_0.tfAnim

				var_1.SetParent(var_242_2, arg_240_0.rtPanelList, false)

				return arg_241_0()
			end)

			return
		end)
	end

	table = var_4

	var_4.insert(var_240_1, function(arg_243_0)
		arg_240_0.inCutIn = true

		local var_243_0 = arg_240_0.tfAnim
		local var_243_1 = var_1.GetComponent(var_243_0, "DftAniEvent")

		var_1.SetEndEvent(var_243_1, function(arg_244_0)
			IsNil = var_3_10001

			if not var_3_10001(arg_240_0.tfAnim) then
				arg_240_0.inCutIn = false

				local var_244_0 = arg_240_0

				var_1.UnOverlayPanel(var_244_0, arg_240_0.tfAnim, arg_240_0.rtPanelList)

				setActive = var_1

				var_1(arg_240_0.tfAnim, false)

				return arg_243_0()
			end

			return
		end)

		local var_243_2 = arg_240_0

		var_1.OverlayPanel(var_243_2, arg_240_0.tfAnim)

		setActive = var_1

		var_1(arg_240_0.tfAnim, true)

		return
	end)

	seriesAsync = var_4

	var_4(var_240_1, function()
		existCall = var_2_10000

		return var_2_10000(arg_240_2)
	end)

	return
end

function var_0_1.PlaySound(arg_246_0, arg_246_1, arg_246_2)
	if arg_246_0.cueName then
		pg = var_3

		local var_246_0 = var_3.CriMgr.GetInstance()

		var_3.StopSE_V3(var_246_0)

		arg_246_0.cueName = nil
	end

	pg = var_3

	local var_246_1 = var_3.CriMgr.GetInstance()

	var_3.PlaySE_V3(var_246_1, arg_246_1, function()
		arg_246_0.cueName = nil

		return
	end)

	existCall = var_3

	return var_3(arg_246_2)
end

function var_0_1.ChangeTopRaycasts(arg_248_0, arg_248_1)
	GetOrAddComponent = var_1_10002

	local var_248_0 = arg_248_0.rtTop

	typeof = var_1_10004
	CanvasGroup = var_1_10005

	local var_248_1 = var_1_10002(var_248_0, var_1_10004(var_1_10005))

	tobool = var_248_0
	var_248_1.blocksRaycasts = var_248_0(arg_248_1)

	return
end

function var_0_1.DoTopBlock(arg_249_0, arg_249_1)
	arg_249_0:ChangeTopRaycasts(false)

	return function(...)
		local var_250_0 = arg_249_0

		var_0.ChangeTopRaycasts(var_250_0, true)

		existCall = var_0

		return var_0(arg_249_1, ...)
	end
end

function var_0_1.SetMoveQueue(arg_251_0, arg_251_1)
	arg_251_0:ReContinueMoveQueue()

	arg_251_0.moveQueue = arg_251_1

	return
end

function var_0_1.ClearMoveQueue(arg_252_0)
	arg_252_0:DisplayMoveStopClick(false)

	arg_252_0.moveQueueInteractive = true

	if #arg_252_0.moveQueue > 0 then
		arg_252_0.moveQueue = {}
	end

	arg_252_0:ShowFleetMoveTurn(false)

	return
end

function var_0_1.DoQueueMove(arg_253_0, arg_253_1)
	assert = var_1_10002

	var_1_10002(#arg_253_0.moveQueue > 0, "without move queue")
	arg_253_0:DisplayMoveStopClick(true)

	nowWorld = var_2

	local var_253_0 = var_2()
	local var_253_1 = var_2.GetActiveMap(var_253_0)

	_ = var_253_0

	local var_253_2 = var_253_0.detect(arg_253_0.moveQueue, function(arg_254_0)
		return arg_254_0.stay
	end)

	if #arg_253_0.moveQueue == 1 and var_253_1:IsSign(var_253_2.row, var_253_2.column) then
		arg_253_0:ClearMoveQueue()

		local var_253_3 = var_253_1:GetCell(var_253_2.row, var_253_2.column)

		arg_253_0:Op("OpTriggerSign", arg_253_1, var_253_3:GetEventAttachment(), function()
			local var_255_0 = arg_253_0

			var_0.Op(var_255_0, "OpInteractive")

			return
		end)
	else
		arg_253_0:ReContinueMoveQueue()
		arg_253_0:ShowFleetMoveTurn(true)
		arg_253_0:Op("OpReqMoveFleet", arg_253_1, var_253_2.row, var_253_2.column)
	end

	return
end

function var_0_1.CheckMoveQueue(arg_256_0, arg_256_1)
	if #arg_256_0.moveQueue < #arg_256_1 or #arg_256_1 == 0 then
		arg_256_0:ClearMoveQueue()
	else
		local var_256_0 = arg_256_1[#arg_256_1]

		if arg_256_0.moveQueue[#arg_256_1].row ~= var_256_0.row or arg_256_0.moveQueue[#arg_256_1].column ~= var_256_0.column then
			arg_256_0:ClearMoveQueue()
		else
			for iter_256_0 = 1, #arg_256_1 do
				table = var_1_10007

				var_1_10007.remove(arg_256_0.moveQueue, 1)
			end

			if #arg_256_0.moveQueue == 0 then
				arg_256_0:ResetLostMoveQueueCount()

				arg_256_0.moveQueueInteractive = true
			end
		end
	end

	return
end

function var_0_1.InteractiveMoveQueue(arg_257_0)
	if arg_257_0.moveQueueInteractive then
		arg_257_0:ClearMoveQueue()
	else
		arg_257_0:DisplayMoveStopClick(false)

		arg_257_0.moveQueueInteractive = true
	end

	return
end

function var_0_1.ReContinueMoveQueue(arg_258_0)
	arg_258_0.moveQueueInteractive = false

	return
end

function var_0_1.CheckLostMoveQueueCount(arg_259_0)
	defaultValue = var_1_10001
	arg_259_0.lostMoveQueueCount = var_1_10001(arg_259_0.lostMoveQueueCount, 0) + 1

	local var_259_0 = arg_259_0.lostMoveQueueCount

	WorldConst = var_2

	return var_259_0 > var_2.AutoFightLoopCountLimit
end

function var_0_1.ResetLostMoveQueueCount(arg_260_0, arg_260_1)
	if arg_260_1 then
		arg_260_0.inLoopAutoFight = true
	end

	arg_260_0.lostMoveQueueCount = 0

	return
end

function var_0_1.DisplayMoveStopClick(arg_261_0, arg_261_1)
	setActive = var_1_10002

	var_1_10002(arg_261_0.rtClickStop, arg_261_1)

	if arg_261_1 then
		nowWorld = var_1_10002

		local var_261_0 = var_1_10002().isAutoFight

		setActive = var_3

		local var_261_1 = arg_261_0.rtClickStop

		var_3(var_4.Find(var_261_1, "long_move"), not var_261_0)

		setActive = var_3

		local var_261_2 = arg_261_0.rtClickStop

		var_3(var_4.Find(var_261_2, "auto_fight"), var_261_0)
	end

	return
end

function var_0_1.ShowFleetMoveTurn(arg_262_0, arg_262_1)
	if arg_262_0.wsMap then
		if arg_262_1 then
			local var_262_0 = arg_262_0.wsMap
			local var_262_1 = var_2.GetFleet(var_262_0)

			var_2.PlusMoveTurn(var_262_1)
		else
			local var_262_2 = arg_262_0.wsMap
			local var_262_3 = var_2.GetFleet(var_262_2)

			var_2.ClearMoveTurn(var_262_3)
		end
	end

	return
end

function var_0_1.GetAllPessingAward(arg_263_0, arg_263_1)
	nowWorld = var_1_10002

	local var_263_0 = var_1_10002()
	local var_263_1 = var_2.GetAtlas(var_263_0)
	local var_263_2 = {}

	pairs = var_1_10005

	for iter_263_0, iter_263_1 in var_1_10005(var_2.pressingAwardDic) do
		if iter_263_1.flag then
			var_2:FlagMapPressingAward(iter_263_0)
			var_263_1:MarkMapTransport(iter_263_0)

			pg = var_10
			var_1_10012 = #var_10.world_event_complete[iter_263_1.id].event_reward_slgbuff

			if 0 < var_1_10012 then
				var_1_10012 = var_11[1]
				defaultValue = var_13
				var_263_2[var_1_10012] = var_13(var_263_2[var_11[1]], 0) + var_11[2]
			end
		end
	end

	local var_263_3

	if not var_2:GetActiveMap().visionFlag then
		var_263_3 = var_2

		if var_2.IsMapVisioned(var_263_3, var_5.id) then
			var_263_3 = var_5

			var_5.UpdateVisionFlag(var_263_3, true)
		end
	end

	if arg_263_0.wsAtlas then
		var_263_3 = arg_263_0.wsAtlas

		var_6.OnUpdatePressingAward(var_263_3)
	end

	local var_263_4 = {}

	pairs = var_263_3

	for iter_263_2, iter_263_3 in var_263_3(var_263_2) do
		table = var_1_10012

		var_1_10012.insert(var_263_4, function(arg_264_0)
			local var_264_0 = {
				id = iter_263_2,
				floor = iter_263_3
			}
			local var_264_1 = var_0
			local var_264_2 = var_2.GetGlobalBuff(var_264_1, iter_263_2)

			var_264_0.before = var_2.GetFloor(var_264_2)

			local var_264_3 = arg_263_0

			var_2.ShowSubView(var_264_3, "GlobalBuff", {
				var_264_0,
				arg_264_0
			})

			return
		end)

		table = var_1_10012

		var_1_10012.insert(var_263_4, function(arg_265_0)
			local var_265_0 = var_0

			var_1.AddGlobalBuff(var_265_0, iter_263_2, iter_263_3)
			arg_265_0()

			return
		end)
	end

	seriesAsync = var_7

	var_7(var_263_4, function()
		existCall = var_2_10000

		return var_2_10000(arg_263_1)
	end)

	return
end

function var_0_1.CheckGuideSLG(arg_267_0, arg_267_1, arg_267_2)
	nowWorld = var_1_10003

	local var_267_0 = var_1_10003()
	local var_267_1 = {}

	table = var_1_10005

	var_1_10005.insert(var_267_1, {
		"WorldG007",
		function()
			local var_268_0 = arg_267_1

			if var_0.GetPort(var_268_0) and not var_0:IsTempPort() then
				local var_268_1 = arg_267_1
				local var_268_2 = var_1.GetFleet(var_268_1)
				local var_268_3 = arg_267_1
				local var_268_4 = var_2.GetCell(var_268_3, var_268_2.row, var_268_2.column)

				return not var_2.ExistEnemy(var_268_4)
			end

			return
		end
	})

	table = var_5

	var_5.insert(var_267_1, {
		"WorldG111",
		function()
			local var_269_0 = arg_267_1

			return var_0.canExit(var_269_0)
		end
	})

	table = var_5

	var_5.insert(var_267_1, {
		"WorldG112",
		function()
			local var_270_0 = var_267_0
			local var_270_1

			if var_0.GetActiveEntrance(var_270_0).becomeSairen then
				var_270_1 = var_0:GetSairenMapId() == arg_267_1.id
			end

			return var_270_1
		end
	})

	table = var_5

	var_5.insert(var_267_1, {
		"WorldG124",
		function()
			local var_271_0 = var_267_0
			local var_271_1 = var_0.IsSystemOpen

			WorldConst = var_2_10002

			if var_271_1(var_271_0, var_2_10002.SystemOrderSubmarine) then
				local var_271_2 = arg_267_1
				local var_271_4

				if var_0.GetConfig(var_271_2, "instruction_available")[1] ~= 0 then
					local var_271_3 = var_267_0

					var_271_4 = var_0.CanCallSubmarineSupport(var_271_3)
				else
					var_271_4 = false
				end
			end

			if false then
				var_271_4 = true
			end

			return var_271_4
		end
	})

	table = var_5

	var_5.insert(var_267_1, {
		"WorldG162",
		function()
			_ = var_2_10000

			local var_272_0 = var_2_10000.any
			local var_272_1 = arg_267_1

			return var_272_0(var_1.GetNormalFleets(var_272_1), function(arg_273_0)
				_ = var_3_10001

				return var_3_10001.any(arg_273_0:GetShips(true), function(arg_274_0)
					return arg_274_0:IsBroken()
				end)
			end)
		end
	})

	table = var_5

	var_5.insert(var_267_1, {
		"WorldG163",
		function()
			local var_275_0 = var_267_0
			local var_275_1 = var_0.GetTaskProxy(var_275_0)
			local var_275_2 = var_0.getDoingTaskVOs(var_275_1)

			underscore = var_275_1

			return var_275_1.any(var_275_2, function(arg_276_0)
				return not arg_276_0:IsAutoSubmit() and arg_276_0:isFinished()
			end)
		end
	})

	table = var_5

	var_5.insert(var_267_1, {
		"WorldG164",
		function()
			local var_277_0 = arg_267_1

			return var_0.CheckFleetSalvage(var_277_0, true)
		end
	})

	table = var_5

	var_5.insert(var_267_1, {
		"WorldG181",
		function()
			local var_278_0 = var_267_0
			local var_278_1 = var_0.GetInventoryProxy(var_278_0)

			return var_0.GetItemCount(var_278_1, 102) > 0
		end
	})

	table = var_5

	var_5.insert(var_267_1, {
		"WorldG191",
		function()
			WorldBossConst = var_2_10000

			local var_279_1

			if var_2_10000.CanUnlockCurrBoss() then
				nowWorld = var_279_1

				local var_279_0 = var_279_1()

				var_279_1 = var_279_1.IsSystemOpen
				WorldConst = var_2_10002
				var_279_1 = var_279_1(var_279_0, var_2_10002.SystemWorldBoss)
			end

			return var_279_1
		end
	})

	_ = var_5

	local var_267_2 = var_5.filter
	local var_267_3 = arg_267_1
	local var_267_4 = arg_267_1.FindAttachments

	WorldMapAttachment = var_8

	local var_267_5 = var_267_2(var_267_4(var_267_3, var_8.TypeEvent), function(arg_280_0)
		return arg_280_0:IsAlive()
	end)

	ipairs = var_6
	pg = var_7

	for iter_267_0, iter_267_1 in var_6(var_7.gameset.world_guide_event.description) do
		table = var_1_10011

		var_1_10011.insert(var_267_1, {
			iter_267_1[2],
			function()
				_ = var_2_10000

				return var_2_10000.any(var_267_5, function(arg_282_0)
					return arg_282_0.id == iter_267_1[1]
				end)
			end
		})
	end

	pg = var_6

	local var_267_6 = var_6.NewStoryMgr.GetInstance()

	ipairs = var_7

	for iter_267_2, iter_267_3 in var_7(var_267_1) do
		if not var_267_6:IsPlayed(iter_267_3[1]) and iter_267_3[2]() then
			WorldGuider = var_12

			local var_267_7 = var_12.GetInstance()

			var_12.PlayGuide(var_267_7, iter_267_3[1])

			return true
		end
	end

	return false
end

function var_0_1.CheckEventForMsg(arg_283_0, arg_283_1)
	pg = var_1_10002

	local var_283_0 = var_1_10002.SystemOpenMgr.GetInstance()
	local var_283_1

	if var_2.isOpenSystem(var_283_0, arg_283_0.player.level, "EventMediator") then
		getProxy = var_283_1
		EventProxy = var_283_0
		var_283_1 = var_283_1(var_283_0).eventForMsg
	end

	return var_283_1
end

function var_0_1.OpenPortLayer(arg_284_0, arg_284_1)
	local var_284_0 = arg_284_0
	local var_284_1 = arg_284_0.Op
	local var_284_2 = "OpOpenLayer"

	Context = var_1_10005

	local var_284_3 = var_1_10005.New
	local var_284_4 = {}

	WorldPortMediator = var_1_10007
	var_284_4.mediator = var_1_10007
	WorldPortLayer = var_1_10007
	var_284_4.viewComponent = var_1_10007
	var_284_4.data = arg_284_1

	var_284_1(var_284_0, var_284_2, var_284_3(var_284_4))

	return
end

function var_0_1.ShowTransportMarkOverview(arg_285_0, arg_285_1, arg_285_2)
	nowWorld = var_1_10003

	local var_285_0 = var_1_10003()
	local var_285_1 = var_3.GetActiveMap(var_285_0)

	if var_3.CheckFleetSalvage(var_285_1, true) then
		arg_285_0:Op("OpShowMarkOverview", arg_285_1, function()
			pg = var_2_10000

			local var_286_0 = var_2_10000.NewStoryMgr.GetInstance()
			local var_286_1 = var_0.Play

			pg = var_2_10002

			var_286_1(var_286_0, var_2_10002.gameset.world_catsearch_special.description[1], arg_285_2, true)

			return
		end)
	else
		arg_285_0:Op("OpShowMarkOverview", arg_285_1, arg_285_2)
	end

	return
end

function var_0_1.UpdateAutoFightDisplay(arg_287_0)
	arg_287_0:ClearMoveQueue()

	nowWorld = var_1

	local var_287_0 = var_1().isAutoFight

	if arg_287_0.wsMapRight then
		setActive = var_2

		local var_287_1 = arg_287_0.wsMapRight.toggleAutoFight

		var_2(var_3.Find(var_287_1, "off"), not var_287_0)

		setActive = var_2

		local var_287_2 = arg_287_0.wsMapRight.toggleAutoFight

		var_2(var_3.Find(var_287_2, "on"), var_287_0)

		setActive = var_2

		var_2(arg_287_0.wsMapRight.toggleSkipPrecombat, not var_287_0)

		triggerToggle = var_2

		local var_287_3 = arg_287_0.wsMapRight.toggleSkipPrecombat

		PlayerPrefs = var_4

		var_2(var_287_3, var_4.GetInt("world_skip_precombat", 0) == 1)
	end

	return
end

function var_0_1.UpdateAutoSwitchDisplay(arg_288_0)
	nowWorld = var_1_10001

	local var_288_0 = var_1_10001().isAutoSwitch

	if arg_288_0.wsMapRight then
		setActive = var_2

		local var_288_1 = arg_288_0.wsMapRight.toggleAutoSwitch

		var_2(var_3.Find(var_288_1, "off"), not var_288_0)

		setActive = var_2

		local var_288_2 = arg_288_0.wsMapRight.toggleAutoSwitch

		var_2(var_3.Find(var_288_2, "on"), var_288_0)
	end

	return
end

function var_0_1.GuideShowScannerEvent(arg_289_0, arg_289_1)
	assert = var_1_10002

	local var_289_0 = arg_289_0.svScannerPanel

	var_1_10002(var_3.isShowing(var_289_0), "scanner mode is closed")

	local var_289_1 = arg_289_0.wsMap.map
	local var_289_2 = var_2.FindAttachments

	WorldMapAttachment = var_4

	local var_289_3 = var_289_2(var_289_1, var_4.TypeEvent, arg_289_1)

	assert = var_289_1

	var_289_1(#var_289_3 == 1, "event number error: " .. #var_289_3)

	local var_289_4, var_289_5 = arg_289_0:CheckScannerEnable(var_289_3[1].row, var_289_3[1].column)

	assert = var_5

	var_5(var_289_4, "without scanner attachment")

	local var_289_6 = arg_289_0.svScannerPanel

	var_5.ActionInvoke(var_289_6, "DisplayWindow", var_289_4, var_289_5)

	return
end

function var_0_1.DisplayAwards(arg_290_0, arg_290_1, arg_290_2, arg_290_3)
	local var_290_0 = {}
	local var_290_1 = {}

	ipairs = var_1_10006

	for iter_290_0, iter_290_1 in var_1_10006(arg_290_1) do
		local var_290_2 = iter_290_1.type

		DROP_TYPE_WORLD_COLLECTION = var_1_10012

		if var_290_2 == var_1_10012 then
			table = var_290_2

			var_290_2.insert(var_290_1, iter_290_1)
		else
			table = var_290_2

			var_290_2.insert(var_290_0, iter_290_1)
		end
	end

	seriesAsync = var_6

	var_6({
		function(arg_291_0)
			if #var_290_0 == 0 then
				return arg_291_0()
			end

			arg_290_2.items = var_290_0
			arg_290_2.removeFunc = arg_291_0

			local var_291_0 = arg_290_0
			local var_291_1 = var_1.emit

			BaseUI = var_2_10003

			var_291_1(var_291_0, var_2_10003.ON_WORLD_ACHIEVE, arg_290_2)

			return
		end,
		function(arg_292_0)
			if not var_290_1[1] then
				arg_292_0()

				return
			end

			assert = var_2_10002
			WorldCollectionProxy = var_2_10003

			local var_292_0 = var_2_10003.GetCollectionType(var_1.id)

			WorldCollectionProxy = var_4

			local var_292_1 = var_292_0 == var_4.WorldCollectionType.FILE

			string = var_4

			var_2_10002(var_292_1, var_4.format("collection drop type error#%d", var_1.id))

			local var_292_2 = arg_290_0
			local var_292_3 = var_2.emit

			WorldMediator = var_4

			local var_292_4 = var_4.OnOpenLayer

			Context = var_5

			local var_292_5 = var_5.New
			local var_292_6 = {}

			WorldMediaCollectionFilePreviewMediator = var_2_10007
			var_292_6.mediator = var_2_10007
			WorldMediaCollectionFilePreviewLayer = var_2_10007
			var_292_6.viewComponent = var_2_10007
			var_292_6.data = {
				collectionId = var_1.id
			}
			var_292_6.onRemoved = arg_292_0

			var_292_3(var_292_2, var_292_4, var_292_5(var_292_6))

			return
		end
	}, arg_290_3)

	return
end

function var_0_1.DisplayPhaseAction(arg_293_0, arg_293_1)
	local var_293_0 = {}

	::label_293_0::

	local var_293_1 = #arg_293_1

	if 0 < var_293_1 then
		repeat
			nowWorld = var_293_1
			var_293_1 = var_293_1()
			table = var_293_2

			local var_293_2 = var_293_2.remove(arg_293_1, 1)

			table = var_5

			var_5.insert(var_293_0, function(arg_294_0)
				if var_293_2.anim then
					local var_294_0 = arg_293_0

					var_1.BuildCutInAnim(var_294_0, var_293_2.anim, arg_294_0)
				elseif var_293_2.story then
					if var_293_1.isAutoFight then
						arg_294_0()
					else
						pg = var_1

						local var_294_1 = var_1.NewStoryMgr.GetInstance()

						var_1.Play(var_294_1, var_293_2.story, arg_294_0, true)
					end
				elseif var_293_2.drops then
					if var_293_1.isAutoFight then
						local var_294_2 = var_293_1

						var_1.AddAutoInfo(var_294_2, "drops", var_293_2.drops)
						arg_294_0()
					else
						local var_294_3 = arg_293_0

						var_1.DisplayAwards(var_294_3, var_293_2.drops, {}, arg_294_0)
					end
				end

				return
			end)

			goto label_293_0
		until true
	end

	seriesAsync = var_293_1

	var_293_1(var_293_0, function()
		local var_295_0 = arg_293_0

		var_0.Op(var_295_0, "OpInteractive")

		return
	end)

	return
end

function var_0_1.StartAutoSwitch(arg_296_0)
	nowWorld = var_1_10001

	local var_296_0 = var_1_10001()
	local var_296_1 = var_1.GetActiveEntrance(var_296_0)
	local var_296_2 = var_1
	local var_296_3 = var_1.GetActiveMap(var_296_2)

	PlayerPrefs = var_296_2

	local var_296_4 = var_296_2.GetInt("auto_switch_mode", 0)

	WorldSwitchPlanningLayer = var_5

	if var_296_4 == var_5.MODE_SAFE then
		PlayerPrefs = var_296_4

		if var_296_4.GetString("auto_switch_difficult_safe", "only") == "only" then
			World = var_296_4

			if var_296_4.ReplacementMapType(var_296_1, var_296_3) ~= "complete_chapter" then
				pg = var_296_4

				local var_296_5 = var_296_4.TipsMgr.GetInstance()

				var_296_4 = var_296_4.ShowTips
				i18n = var_6

				var_296_4(var_296_5, var_6("world_automode_start_tip3"))

				do return end

				goto label_296_0
			end
		end
	end

	PlayerPrefs = var_296_4

	do
		local var_296_6 = var_296_4.GetInt("auto_switch_mode", 0)

		WorldSwitchPlanningLayer = var_5

		if var_296_6 == var_5.MODE_TREASURE and not var_1:GetGobalFlag("treasure_flag") then
			pg = var_4

			local var_296_7 = var_4.TipsMgr.GetInstance()

			var_4.ShowTips(var_296_7, "without auto switch flag")

			return
		end
	end

	::label_296_0::

	arg_296_0:QueryTransport(function(arg_297_0)
		if not arg_297_0 then
			PlayerPrefs = var_2_10001
			var_2_10001 = var_2_10001.GetInt("auto_switch_mode", 0)
			WorldSwitchPlanningLayer = var_2_10002

			if var_2_10001 == var_2_10002.MODE_TREASURE then
				World = var_2_10001

				if var_2_10001.ReplacementMapType(var_296_1, var_296_3) == "teasure_chapter" then
					pg = var_2_10001
					var_2_10002 = var_2_10001.TipsMgr.GetInstance()
					var_2_10001 = var_2_10001.ShowTips
					i18n = var_3

					var_2_10001(var_2_10002, var_3("world_automode_start_tip5"))

					goto label_297_0
				end
			end

			pg = var_2_10001
			var_2_10002 = var_2_10001.TipsMgr.GetInstance()
			var_2_10001 = var_2_10001.ShowTips
			i18n = var_3

			var_2_10001(var_2_10002, var_3("world_automode_start_tip4"))
		else
			getProxy = var_2_10001
			MetaCharacterProxy = var_2_10002

			local var_297_0 = var_2_10001(var_2_10002)

			var_1.setMetaTacticsInfoOnStart(var_297_0)

			PlayerPrefs = var_1

			var_1.SetInt("world_skip_precombat", 1)

			PlayerPrefs = var_1

			local var_297_1 = var_1.SetInt
			local var_297_2 = "autoBotIsAcitve"

			AutoBotCommand = var_3

			local var_297_3 = var_3.GetAutoBotMark

			SYSTEM_WORLD = var_2_10004

			var_297_1(var_297_2 .. var_297_3(var_2_10004), 1)

			local var_297_4 = arg_296_0

			var_1.Op(var_297_4, "OpAutoSwitchMap")
		end

		::label_297_0::

		return
	end)

	return
end

function var_0_1.MoveAndOpenLayer(arg_298_0, arg_298_1)
	local var_298_0 = {}

	table = var_1_10003

	var_1_10003.insert(var_298_0, function(arg_299_0)
		local var_299_0 = arg_298_0

		var_1.Op(var_299_0, "OpSetInMap", arg_298_1.inMap, arg_299_0)

		return
	end)

	seriesAsync = var_3

	var_3(var_298_0, function()
		local var_300_0 = arg_298_0

		var_0.Op(var_300_0, "OpOpenLayer", arg_298_1.context)

		return
	end)

	return
end

function var_0_1.GetDepth(arg_301_0)
	return #arg_301_0.wsCommands
end

function var_0_1.GetCommand(arg_302_0, arg_302_1)
	return arg_302_0.wsCommands[arg_302_1 or arg_302_0:GetDepth()]
end

function var_0_1.Op(arg_303_0, arg_303_1, ...)
	local var_303_0 = arg_303_0:GetCommand()

	var_2.Op(var_303_0, arg_303_1, ...)

	return
end

function var_0_1.OpRaw(arg_304_0, arg_304_1, ...)
	local var_304_0 = arg_304_0:GetCommand()

	var_2.OpRaw(var_304_0, arg_304_1, ...)

	return
end

function var_0_1.OpOpen(arg_305_0)
	local var_305_0 = arg_305_0
	local var_305_1 = arg_305_0.GetDepth(var_305_0)

	WorldConst = var_305_0

	var_305_0.Print("open operation stack: " .. var_305_1 + 1)

	table = var_2

	local var_305_2 = var_2.insert
	local var_305_3 = arg_305_0.wsCommands

	WSCommand = var_4

	var_305_2(var_305_3, var_4.New(var_305_1 + 1))

	return
end

function var_0_1.OpClose(arg_306_0)
	local var_306_0 = arg_306_0
	local var_306_1 = arg_306_0.GetDepth(var_306_0)

	assert = var_306_0

	var_306_0(var_306_1 > 0)

	WorldConst = var_306_0

	var_306_0.Print("close operation stack: " .. var_306_1)

	local var_306_2 = arg_306_0.wsCommands[var_306_1]

	var_2.Dispose(var_306_2)

	table = var_3

	var_3.remove(arg_306_0.wsCommands, var_306_1)

	return
end

function var_0_1.OpClear(arg_307_0)
	ipairs = var_1_10001

	for iter_307_0, iter_307_1 in var_1_10001(arg_307_0.wsCommands) do
		iter_307_1:OpClear()
	end

	return
end

function var_0_1.OpDispose(arg_308_0)
	ipairs = var_1_10001

	for iter_308_0, iter_308_1 in var_1_10001(arg_308_0.wsCommands) do
		iter_308_1:Dispose()
	end

	arg_308_0.wsCommands = nil

	return
end

function var_0_1.NewMapOp(arg_309_0, arg_309_1)
	WBank = var_1_10002

	local var_309_0 = var_1_10002
	local var_309_1 = var_1_10002.Fetch

	WorldMapOp = var_1_10004

	local var_309_2 = var_309_1(var_309_0, var_1_10004)

	var_309_2.depth = arg_309_0:GetDepth()
	pairs = var_3

	for iter_309_0, iter_309_1 in var_3(arg_309_1) do
		var_309_2[iter_309_0] = iter_309_1
	end

	return var_309_2
end

function var_0_1.RegistMapOp(arg_310_0, arg_310_1)
	assert = var_1_10002

	var_1_10002(arg_310_1, "mapOp can not be nil.")

	assert = var_1_10002
	table = var_3

	var_1_10002(not var_3.contains(arg_310_0.mapOps, arg_310_1), "repeated registered mapOp.")

	table = var_1_10002

	var_1_10002.insert(arg_310_0.mapOps, arg_310_1)
	arg_310_1:AddCallbackWhenApplied(function()
		for iter_311_0 = #arg_310_0.mapOps, 1, -1 do
			if arg_310_0.mapOps[iter_311_0] == arg_310_1 then
				table = var_4

				var_4.remove(arg_310_0.mapOps, iter_311_0)
			end
		end

		return
	end)

	return
end

function var_0_1.VerifyMapOp(arg_312_0)
	for iter_312_0 = #arg_312_0.mapOps, 1, -1 do
		table = var_1_10005

		if not var_1_10005.remove(arg_312_0.mapOps, iter_312_0).applied then
			var_1_10005:Apply()
		end
	end

	arg_312_0:OpClear()

	return
end

function var_0_1.GetCompassGridPos(arg_313_0, arg_313_1, arg_313_2, arg_313_3)
	WorldGuider = var_1_10004

	local var_313_0 = var_1_10004.GetInstance()
	local var_313_1 = var_4.SetTempGridPos
	local var_313_2 = arg_313_0.wsMapRight.wsCompass

	var_313_1(var_313_0, var_6.GetMarkPosition(var_313_2, arg_313_1, arg_313_2), arg_313_3)

	return
end

function var_0_1.GetEntranceTrackMark(arg_314_0, arg_314_1, arg_314_2)
	WorldGuider = var_1_10003

	local var_314_0 = var_1_10003.GetInstance()
	local var_314_1 = var_3.SetTempGridPos
	local var_314_2 = arg_314_0.wsMapRight.wsCompass

	var_314_1(var_314_0, var_5.GetEntranceTrackMark(var_314_2, arg_314_1), arg_314_2)

	return
end

function var_0_1.GetSlgTilePos(arg_315_0, arg_315_1, arg_315_2, arg_315_3)
	WorldGuider = var_1_10004

	local var_315_0 = var_1_10004.GetInstance()
	local var_315_1 = var_4.SetTempGridPos2
	local var_315_2 = arg_315_0.wsMap
	local var_315_3 = var_6.GetCell(var_315_2, arg_315_1, arg_315_2)

	var_315_1(var_315_0, var_6.GetWorldPos(var_315_3), arg_315_3)

	return
end

function var_0_1.GetScannerPos(arg_316_0, arg_316_1)
	local var_316_0 = arg_316_0.svScannerPanel.rtPanel.transform
	local var_316_1 = arg_316_0.svScannerPanel.rtWindow.transform

	Vector3 = var_1_10004

	local var_316_2 = var_1_10004.New(var_316_1.localPosition.x + var_316_1.rect.width * (0.5 - var_316_1.pivot.x), var_316_1.localPosition.y + var_316_1.rect.height * (0.5 - var_316_1.pivot.y), 0)
	local var_316_3 = var_316_0
	local var_316_4 = var_316_0.TransformPoint(var_316_3, var_316_2)

	WorldGuider = var_316_3

	local var_316_5 = var_316_3.GetInstance()

	var_6.SetTempGridPos(var_316_5, var_316_4, arg_316_1)

	return
end

function var_0_1.GuideSelectModelMap(arg_317_0, arg_317_1)
	nowWorld = var_1_10002

	local var_317_0 = var_1_10002()
	local var_317_1 = var_2.GetEntrance(var_317_0, arg_317_1)

	assert = var_317_0

	var_317_0(arg_317_0.wsAtlas, "didn't enter the world map mode")
	arg_317_0:ClickAtlas(var_317_1)

	return
end

return var_0_1
