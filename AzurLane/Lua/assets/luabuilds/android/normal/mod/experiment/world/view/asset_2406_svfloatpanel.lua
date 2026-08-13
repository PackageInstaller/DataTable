class = var_0_10000

local var_0_0 = "SVFloatPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.ShowView = "SVFloatPanel.ShowView"
var_0_1.HideView = "SVFloatPanel.HideView"
var_0_1.ReturnCall = "SVFloatPanel.ReturnCall"

function var_0_1.getUIName(arg_1_0)
	return "SVFloatPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.rtBasePoint = var_1.Find(var_3_0, "point")

	local var_3_1 = arg_3_0.rtBasePoint

	arg_3_0.rtInfoPanel = var_1.Find(var_3_1, "line/bg")

	local var_3_2 = arg_3_0.rtInfoPanel

	arg_3_0.rtMarking = var_1.Find(var_3_2, "icon/marking")

	local var_3_3 = arg_3_0._tf

	arg_3_0.rtRes = var_1.Find(var_3_3, "res")
	UIItemList = var_1

	local var_3_4 = var_1.New
	local var_3_5 = arg_3_0.rtInfoPanel
	local var_3_6 = var_2.Find(var_3_5, "pressing_award")
	local var_3_7 = arg_3_0.rtInfoPanel

	arg_3_0.awardItemList = var_3_4(var_3_6, var_3.Find(var_3_7, "pressing_award/award_tpl"))

	local var_3_8 = arg_3_0.awardItemList

	var_1.make(var_3_8, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_3_0.awardConfig[arg_4_1 + 1]
			local var_4_1 = {
				type = var_4_0[1],
				id = var_4_0[2],
				count = var_4_0[3]
			}

			updateDrop = var_5

			var_5(arg_4_2:Find("IconTpl"), var_4_1)

			onButton = var_5

			local var_4_2 = arg_3_0
			local var_4_3 = arg_4_2:Find("IconTpl")

			local function var_4_4()
				local var_5_0 = arg_3_0
				local var_5_1 = var_0.emit

				BaseUI = var_3_10002

				var_5_1(var_5_0, var_3_10002.ON_DROP, var_4_1)

				return
			end

			SFX_PANEL = var_9

			var_5(var_4_2, var_4_3, var_4_4, var_9)

			local var_4_5 = arg_3_0.mapList[arg_3_0.destIndex]

			setActive = var_6

			var_6(arg_4_2:Find("is_pressing"), var_4_5.isPressing)

			setActive = var_6

			var_6(arg_4_2:Find("IconTpl"), not var_4_5.isPressing)
		end

		return
	end)

	local var_3_9 = arg_3_0.rtInfoPanel

	arg_3_0.btnBack = var_1.Find(var_3_9, "back")
	onButton = var_1

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.btnBack

	local function var_3_12()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		WorldScene = var_2_10002

		var_6_1(var_6_0, var_2_10002.SceneOp, "OpSetInMap", true)

		return
	end

	SFX_CONFIRM = var_5

	var_1(var_3_10, var_3_11, var_3_12, var_5)

	local var_3_13 = arg_3_0.rtInfoPanel

	arg_3_0.btnEnter = var_1.Find(var_3_13, "enter")
	onButton = var_1

	local var_3_14 = arg_3_0
	local var_3_15 = arg_3_0.btnEnter

	local function var_3_16()
		local var_7_0 = {}
		local var_7_1 = arg_3_0.mapList[arg_3_0.destIndex]

		WorldConst = var_2

		if var_2.HasDangerConfirm(var_7_1.config.entrance_ui) then
			table = var_2

			var_2.insert(var_7_0, function(arg_8_0)
				local var_8_0 = arg_3_0
				local var_8_1 = var_1.emit

				WorldScene = var_3_10003

				var_8_1(var_8_0, var_3_10003.SceneOp, "OpCall", function(arg_9_0)
					arg_9_0()

					pg = var_1

					local var_9_0 = var_1.MsgboxMgr.GetInstance()
					local var_9_1 = var_1.ShowMsgBox
					local var_9_2 = {}

					i18n = var_4_10004
					var_9_2.content = var_4_10004("world_map_dangerous_confirm")
					var_9_2.onYes = arg_8_0

					var_9_1(var_9_0, var_9_2)

					return
				end)

				return
			end)
		end

		seriesAsync = var_2

		var_2(var_7_0, function()
			nowWorld = var_3_10000

			local var_10_0 = var_3_10000().staminaMgr

			if not var_7_1.isCost then
				local var_10_1 = var_7_1.config.enter_cost

				var_3_10003 = var_10_0

				if var_10_1 > var_10_0.GetTotalStamina(var_3_10003) then
					var_10_0:Show()

					goto label_10_0
				end
			end

			do
				local var_10_2 = arg_3_0
				local var_10_3 = var_1.emit

				WorldScene = var_3_10003

				var_10_3(var_10_2, var_3_10003.SceneOp, "OpTransport", arg_3_0.entrance, var_7_1)
			end

			::label_10_0::

			return
		end)

		return
	end

	SFX_CONFIRM = var_5

	var_1(var_3_14, var_3_15, var_3_16, var_5)

	local var_3_17 = arg_3_0.rtInfoPanel

	arg_3_0.btnLock = var_1.Find(var_3_17, "lock")

	local var_3_18 = arg_3_0.rtInfoPanel

	arg_3_0.btnReturn = var_1.Find(var_3_18, "return")
	onButton = var_1

	local var_3_19 = arg_3_0
	local var_3_20 = arg_3_0.btnReturn

	local function var_3_21()
		local var_11_0 = arg_3_0

		var_0.emit(var_11_0, var_0_1.ReturnCall, arg_3_0.entrance)

		return
	end

	SFX_CONFIRM = var_5

	var_1(var_3_19, var_3_20, var_3_21, var_5)

	local var_3_22 = arg_3_0.rtInfoPanel

	arg_3_0.btnSwitch = var_1.Find(var_3_22, "switch")
	onButton = var_1

	local var_3_23 = arg_3_0
	local var_3_24 = arg_3_0.btnSwitch

	local function var_3_25()
		if arg_3_0.isTweening then
			return
		end

		local var_12_0 = arg_3_0

		var_0.ShowToggleMask(var_12_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_3_23, var_3_24, var_3_25, var_5)

	local var_3_26 = arg_3_0._tf

	arg_3_0.rtSelectMask = var_1.Find(var_3_26, "select_mask")
	onButton = var_1

	local var_3_27 = arg_3_0
	local var_3_28 = arg_3_0.rtSelectMask
	local var_3_29 = var_3.Find(var_3_28, "bg")

	local function var_3_30()
		if arg_3_0.isTweening then
			return
		end

		local var_13_0 = arg_3_0

		var_0.HideToggleMask(var_13_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_3_27, var_3_29, var_3_30, var_5)

	local var_3_31 = arg_3_0.rtSelectMask

	arg_3_0.rtMaskMarking = var_1.Find(var_3_31, "marking")

	local var_3_32 = arg_3_0.rtMaskMarking

	arg_3_0.rtToggles = var_1.Find(var_3_32, "toggles")
	UIItemList = var_1

	local var_3_33 = var_1.New
	local var_3_34 = arg_3_0.rtToggles
	local var_3_35 = arg_3_0.rtToggles

	arg_3_0.toggleItemList = var_3_33(var_3_34, var_3.Find(var_3_35, "toggle"))

	local var_3_36 = arg_3_0.toggleItemList

	var_1.make(var_3_36, function(arg_14_0, arg_14_1, arg_14_2)
		arg_14_1 = arg_14_1 + 1
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = arg_3_0.mapList[arg_14_1]

			World = var_2_10004

			local var_14_1, var_14_2 = var_2_10004.ReplacementMapType(arg_3_0.entrance, var_14_0)

			setText = var_6

			var_6(arg_14_2:Find("Text"), var_14_2)

			onToggle = var_6

			local var_14_3 = arg_3_0
			local var_14_4 = arg_14_2

			local function var_14_5(arg_15_0)
				if arg_15_0 then
					local var_15_0 = arg_3_0

					var_1.HideToggleMask(var_15_0)

					arg_3_0.destIndex = arg_14_1

					local var_15_1 = arg_3_0

					var_1.UpdatePanel(var_15_1)
				end

				return
			end

			SFX_PANEL = var_2_10010

			var_6(var_14_3, var_14_4, var_14_5, var_2_10010)

			triggerToggle = var_6

			var_6(arg_14_2, false)
		end

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_16_0)
	return
end

function var_0_1.Show(arg_17_0)
	setActive = var_1_10001

	var_1_10001(arg_17_0._tf, true)

	return
end

function var_0_1.Hide(arg_18_0)
	setActive = var_1_10001

	var_1_10001(arg_18_0._tf, false)

	return
end

function var_0_1.Setup(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	arg_19_0.entrance = arg_19_1

	local var_19_0 = arg_19_4
	local var_19_1 = arg_19_4.GetMapScreenPos

	Vector2 = var_1_10007

	local var_19_2 = var_19_1(var_19_0, var_1_10007(arg_19_1.config.area_pos[1], arg_19_1.config.area_pos[2]))

	setAnchoredPosition = var_19_0

	local var_19_3 = arg_19_0.rtBasePoint
	local var_19_4 = arg_19_0._tf
	local var_19_5 = var_8.InverseTransformPoint

	GameObject = var_1_10010

	local var_19_6 = var_1_10010.Find("OverlayCamera")
	local var_19_7 = var_10.GetComponent

	typeof = var_1_10012
	Camera = var_1_10013

	local var_19_8 = var_19_7(var_19_6, var_1_10012(var_1_10013))

	var_19_0(var_19_3, var_19_5(var_19_4, var_10.ScreenToWorldPoint(var_19_8, var_19_2)))

	nowWorld = var_19_0

	local var_19_9 = var_19_0()

	arg_19_0.mapList = var_6.EntranceToReplacementMapList(var_19_9, arg_19_1)

	local function var_19_10()
		if arg_19_2 then
			ipairs = var_0

			for iter_20_0, iter_20_1 in var_0(arg_19_0.mapList) do
				if iter_20_1.id == arg_19_2 then
					return iter_20_0
				end
			end
		end

		if arg_19_3 then
			ipairs = var_0

			for iter_20_2, iter_20_3 in var_0(arg_19_3) do
				ipairs = var_2_10005

				for iter_20_4, iter_20_5 in var_2_10005(arg_19_0.mapList) do
					World = var_2_10010

					if iter_20_3 == var_2_10010.ReplacementMapType(arg_19_1, iter_20_5) then
						return iter_20_4
					end
				end
			end
		end

		if arg_19_1.active then
			ipairs = var_0

			for iter_20_6, iter_20_7 in var_0(arg_19_0.mapList) do
				if iter_20_7.active then
					return iter_20_6
				end
			end
		end

		return 1
	end

	local var_19_11 = arg_19_0.toggleItemList

	var_7.align(var_19_11, #arg_19_0.mapList)

	triggerToggle = var_7

	local var_19_12 = arg_19_0.rtToggles

	var_7(var_8.GetChild(var_19_12, var_19_10() - 1), true)

	return
end

function var_0_1.setColorfulImage(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	defaultValue = var_1_10004
	arg_21_3 = var_1_10004(arg_21_3, true)
	setImageSprite = var_4

	local var_21_0 = arg_21_1

	getImageSprite = var_6

	local var_21_1 = arg_21_0.rtRes

	var_4(var_21_0, var_6(var_7.Find(var_21_1, arg_21_1.name .. "/" .. arg_21_2)), arg_21_3)

	return
end

function var_0_1.UpdatePanel(arg_22_0)
	nowWorld = var_1_10001

	local var_22_0 = var_1_10001()
	local var_22_1 = arg_22_0.mapList[arg_22_0.destIndex]

	World = var_3

	local var_22_2, var_22_3 = var_3.ReplacementMapType(arg_22_0.entrance, var_22_1)
	local var_22_4

	if var_22_2 == "complete_chapter" then
		var_22_4 = "safe"
	else
		WorldConst = var_22_4
		var_22_4 = var_22_4.GetMapIconState(var_22_1.config.entrance_ui)
	end

	local var_22_5 = var_22_1:IsMapOpen()

	arg_22_0:setColorfulImage(arg_22_0.rtBasePoint, var_22_4)
	arg_22_0:setColorfulImage(arg_22_0.rtInfoPanel, var_22_4, false)

	GetSpriteFromAtlas = var_7

	local var_22_6 = var_7("world/mapicon/" .. var_22_1.config.entrance_mapicon, "")

	setImageSprite = var_8

	local var_22_7 = arg_22_0.rtInfoPanel

	var_8(var_9.Find(var_22_7, "icon"), var_22_6)
	arg_22_0:setColorfulImage(arg_22_0.btnBack, var_22_4)
	arg_22_0:setColorfulImage(arg_22_0.btnEnter, var_22_4)
	arg_22_0:setColorfulImage(arg_22_0.rtMarking, var_22_4)

	local var_22_8 = arg_22_0
	local var_22_9 = arg_22_0.setColorfulImage
	local var_22_10 = arg_22_0.rtMarking

	var_22_9(var_22_8, var_10.Find(var_22_10, "mark_bg"), var_22_4)
	arg_22_0:setColorfulImage(arg_22_0.rtMaskMarking, var_22_4)

	local var_22_11 = arg_22_0
	local var_22_12 = arg_22_0.setColorfulImage
	local var_22_13 = arg_22_0.rtMaskMarking

	var_22_12(var_22_11, var_10.Find(var_22_13, "mark_bg"), var_22_4)

	setText = var_22_12

	local var_22_14 = arg_22_0.rtMarking

	var_22_12(var_9.Find(var_22_14, "Text"), var_22_3)

	setText = var_22_12

	local var_22_15 = arg_22_0.rtMaskMarking

	var_22_12(var_9.Find(var_22_15, "Text"), var_22_3)

	setActive = var_22_12

	local var_22_16 = arg_22_0.rtInfoPanel

	var_22_12(var_9.Find(var_22_16, "sairen"), var_22_2 == "sairen_chapter")

	setText = var_22_12

	local var_22_17 = arg_22_0.rtInfoPanel
	local var_22_18 = var_9.Find(var_22_17, "sairen/Text")

	i18n = var_22_17

	var_22_12(var_22_18, var_22_17("area_yaosai_2"))

	setText = var_22_12

	local var_22_19 = arg_22_0.rtInfoPanel
	local var_22_20 = var_9.Find(var_22_19, "danger_text")
	local var_22_21

	if not var_22_5 or not var_22_1:GetDanger() then
		var_22_21 = "?"
	end

	var_22_12(var_22_20, var_22_21)

	changeToScrollText = var_22_12

	local var_22_22 = arg_22_0.rtInfoPanel
	local var_22_23 = var_9.Find(var_22_22, "title/name")
	local var_22_24 = var_22_1

	var_22_12(var_22_23, var_22_1.GetName(var_22_24, arg_22_0.entrance))

	local var_22_25, var_22_26, var_22_27 = var_22_0:CountAchievements(arg_22_0.entrance)

	setText = var_22_24

	local var_22_28 = arg_22_0.rtInfoPanel

	var_22_24(var_12.Find(var_22_28, "title/achievement/number"), var_22_25 + var_22_26 .. "/" .. var_22_27)

	local var_22_29 = var_22_0
	local var_22_30 = var_22_0.GetPressingAward(var_22_29, var_22_1.id)

	setActive = var_22_29

	local var_22_31 = arg_22_0.rtInfoPanel

	var_22_29(var_13.Find(var_22_31, "pressing_award"), var_22_30 and var_22_30.flag)

	if var_22_30 and var_22_30.flag then
		pg = var_12
		arg_22_0.awardConfig = var_12.world_event_complete[var_22_30.id].tips_icon

		local var_22_32 = arg_22_0.awardItemList

		var_13.align(var_22_32, #arg_22_0.awardConfig)
	end

	arg_22_0:UpdateCost()

	nowWorld = var_12

	local var_22_33 = var_12()
	local var_22_34 = var_12.GetAtlas(var_22_33)
	local var_22_35 = var_12.GetActiveMap(var_22_34)
	local var_22_36, var_22_37 = var_13.CkeckTransport(var_22_35)
	local var_22_38 = false

	setActive = var_1_10017

	var_1_10017(arg_22_0.btnBack, not var_22_38 and var_12:GetActiveEntrance() == arg_22_0.entrance and var_13 == var_22_1)

	if not var_22_38 then
		isActive = var_1_10017
		var_22_38 = var_1_10017(arg_22_0.btnBack)
	end

	setActive = var_1_10017

	var_1_10017(arg_22_0.btnEnter, not var_22_38 and var_22_36 and var_22_5 and var_12.transportDic[arg_22_0.entrance.id])

	if not var_22_38 then
		isActive = var_1_10017
		var_22_38 = var_1_10017(arg_22_0.btnEnter)
	end

	setText = var_1_10017

	local var_22_39 = arg_22_0.btnLock
	local var_22_40 = var_18.Find(var_22_39, "Text")

	if var_22_5 then
		i18n = var_22_39

		if not var_22_39("world_map_locked_border") then
			i18n = var_22_39
			var_22_39 = var_22_39("world_map_locked_stage")
		end

		var_1_10017(var_22_40, var_22_39)

		setActive = var_1_10017

		var_1_10017(arg_22_0.btnLock, not var_22_38 and var_22_36)

		if not var_22_38 then
			isActive = var_1_10017
			var_22_38 = var_1_10017(arg_22_0.btnLock)
		end

		setActive = var_1_10017

		var_1_10017(arg_22_0.btnReturn, not var_22_38)

		if not var_22_38 then
			isActive = var_1_10017

			local var_22_41 = var_1_10017(arg_22_0.btnReturn)
		end

		return
	end
end

function var_0_1.UpdateCost(arg_23_0)
	local var_23_0 = arg_23_0.mapList[arg_23_0.destIndex]
	local var_23_1 = arg_23_0.btnEnter
	local var_23_2 = var_2.Find(var_23_1, "cost")

	setActive = var_23_1

	var_23_1(var_23_2, not var_23_0.isCost)

	nowWorld = var_23_1

	local var_23_3 = var_23_1().staminaMgr
	local var_23_4 = var_3.GetTotalStamina(var_23_3)
	local var_23_5 = var_23_0.config.enter_cost

	setText = var_5

	local var_23_6 = var_23_2
	local var_23_7 = var_23_2.Find(var_23_6, "Text")

	setColorStr = var_23_6

	local var_23_8 = var_23_4

	if var_23_4 < var_23_5 then
		COLOR_RED = var_1_10009

		if not var_1_10009 then
			COLOR_GREEN = var_1_10009
		end

		var_5(var_23_7, var_23_6(var_23_8, var_1_10009) .. "/" .. var_23_5)

		return
	end
end

function var_0_1.ShowToggleMask(arg_24_0)
	arg_24_0.isTweening = true
	setActive = var_1

	var_1(arg_24_0.rtMarking, false)

	setActive = var_1

	var_1(arg_24_0.rtSelectMask, true)

	setActive = var_1

	var_1(arg_24_0.rtToggles, false)

	local var_24_0 = arg_24_0.rtMaskMarking

	var_24_0.position = arg_24_0.rtMarking.position
	LeanTween = var_24_0

	local var_24_1 = var_24_0.moveY(arg_24_0.rtMaskMarking, arg_24_0.rtMaskMarking.anchoredPosition.y + 22, 0.2)
	local var_24_2 = var_1.setOnComplete

	System = var_3

	var_24_2(var_24_1, var_3.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_24_0.rtToggles, true)

		arg_24_0.isTweening = false

		return
	end))

	setActive = var_24_2

	var_24_2(arg_24_0.btnSwitch, false)

	return
end

function var_0_1.HideToggleMask(arg_26_0)
	arg_26_0.isTweening = true
	setActive = var_1

	var_1(arg_26_0.rtToggles, false)

	local var_26_0 = arg_26_0.rtMaskMarking

	var_26_0.position = arg_26_0.rtMarking.position
	setAnchoredPosition = var_26_0

	var_26_0(arg_26_0.rtMaskMarking, {
		y = arg_26_0.rtMaskMarking.anchoredPosition.y + 22
	})

	LeanTween = var_26_0

	local var_26_1 = var_26_0.moveY(arg_26_0.rtMaskMarking, arg_26_0.rtMaskMarking.anchoredPosition.y - 22, 0.2)
	local var_26_2 = var_1.setOnComplete

	System = var_3

	var_26_2(var_26_1, var_3.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_26_0.rtSelectMask, false)

		setActive = var_2_10000

		var_2_10000(arg_26_0.rtMarking, true)

		local var_27_0 = arg_26_0

		var_27_0.isTweening = false
		setActive = var_27_0

		var_27_0(arg_26_0.btnSwitch, #arg_26_0.mapList > 1)

		return
	end))

	return
end

return var_0_1
