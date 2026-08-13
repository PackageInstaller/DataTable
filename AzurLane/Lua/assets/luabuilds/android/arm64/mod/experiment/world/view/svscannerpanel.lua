class = var_0_10000

local var_0_0 = "SVScannerPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

var_0_1.ShowView = "SVScannerPanel.ShowView"
var_0_1.HideView = "SVScannerPanel.HideView"
var_0_1.HideGoing = "SVScannerPanel.HideGoing"

function var_0_1.getUIName(arg_1_0)
	return "SVScannerPanel"
end

function var_0_1.getBGM(arg_2_0)
	return "echo-loop"
end

function var_0_1.OnLoaded(arg_3_0)
	return
end

function var_0_1.OnInit(arg_4_0)
	GameObject = var_1_10001

	local var_4_0 = var_1_10001.Find("OverlayCamera")
	local var_4_1 = var_1.GetComponent

	typeof = var_1_10004
	Camera = var_1_10006
	arg_4_0.camera = var_4_1(var_4_0, var_1_10004(var_1_10006))

	local var_4_2 = arg_4_0._tf

	GetOrAddComponent = var_1_10002
	arg_4_0.canvas = var_1_10002(var_4_2, "CanvasGroup")
	arg_4_0.rtExit = var_4_2:Find("adapt/exit")
	arg_4_0.rtPanel = var_4_2:Find("adapt/selected_panel")
	setActive = var_2

	var_2(arg_4_0.rtPanel, false)

	local var_4_3 = arg_4_0.rtPanel

	arg_4_0.rtWindow = var_2.Find(var_4_3, "window")

	local var_4_4 = arg_4_0.rtWindow

	arg_4_0.rtTitle = var_2.Find(var_4_4, "base_info/title")

	local var_4_5 = arg_4_0.rtWindow

	arg_4_0.rtMark = var_2.Find(var_4_5, "base_info/mark")

	local var_4_6 = arg_4_0.rtWindow

	arg_4_0.rtBuffContent = var_2.Find(var_4_6, "base_info/content")

	local var_4_7 = arg_4_0.rtWindow

	arg_4_0.rtMapBuffContent = var_2.Find(var_4_7, "base_info/map_buffs")

	local var_4_8 = arg_4_0.rtWindow

	arg_4_0.rtInfo = var_2.Find(var_4_8, "base_info/info")

	local var_4_9 = arg_4_0.rtWindow

	arg_4_0.rtWeaknessContent = var_2.Find(var_4_9, "weakness_info/content")

	local var_4_10 = arg_4_0.rtWindow

	arg_4_0.rtRadiation = var_2.Find(var_4_10, "radiation_info")
	arg_4_0.rtAnim = var_4_2:Find("adapt/anim")

	local var_4_11 = arg_4_0.rtPanel

	arg_4_0.rtClick = var_2.Find(var_4_11, "click")
	UIItemList = var_2

	local var_4_12 = var_2.New
	local var_4_13 = arg_4_0.rtBuffContent
	local var_4_14 = arg_4_0.rtBuffContent

	arg_4_0.buffUIItemList = var_4_12(var_4_13, var_5.Find(var_4_14, "buff"))

	local var_4_15 = arg_4_0.buffUIItemList

	var_2.make(var_4_15, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			if #arg_4_0.buffList[arg_5_1].config.icon > 0 then
				GetImageSpriteFromAtlasAsync = var_4

				var_4("world/buff/" .. var_3.config.icon, "", arg_5_2:Find("icon"))
			else
				setImageSprite = var_4

				var_4(arg_5_2:Find("icon"), nil)
			end

			setText = var_4

			var_4(arg_5_2:Find("Text"), var_3.config.desc)
		end

		return
	end)

	UIItemList = var_2

	local var_4_16 = var_2.New
	local var_4_17 = arg_4_0.rtMapBuffContent
	local var_4_18 = arg_4_0.rtMapBuffContent

	arg_4_0.mapBuffItemList = var_4_16(var_4_17, var_5.Find(var_4_18, "buff"))

	local var_4_19 = arg_4_0.mapBuffItemList

	var_2.make(var_4_19, function(arg_6_0, arg_6_1, arg_6_2)
		arg_6_1 = arg_6_1 + 1
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			if #arg_4_0.mapBuffList[arg_6_1].config.icon > 0 then
				GetImageSpriteFromAtlasAsync = var_4

				var_4("world/buff/" .. var_3.config.icon, "", arg_6_2:Find("icon"))
			else
				setImageSprite = var_4

				var_4(arg_6_2:Find("icon"), nil)
			end

			setText = var_4

			var_4(arg_6_2:Find("Text"), var_3.config.desc)
		end

		return
	end)

	UIItemList = var_2

	local var_4_20 = var_2.New
	local var_4_21 = arg_4_0.rtWeaknessContent
	local var_4_22 = arg_4_0.rtWeaknessContent

	arg_4_0.weaknessUIItemList = var_4_20(var_4_21, var_5.Find(var_4_22, "buff"))

	local var_4_23 = arg_4_0.weaknessUIItemList

	var_2.make(var_4_23, function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_4_0.weaknessList[arg_7_1]

			setText = var_2_10004

			var_2_10004(arg_7_2:Find("Text"), var_7_0.config.desc)
		end

		return
	end)

	onButton = var_2

	local var_4_24 = arg_4_0
	local var_4_25 = arg_4_0.rtExit

	local function var_4_26()
		local var_8_0 = arg_4_0

		var_0.Hide(var_8_0)

		return
	end

	SFX_UI_CANCEL = var_4_22

	var_2(var_4_24, var_4_25, var_4_26, var_4_22)

	onButton = var_2

	local var_4_27 = arg_4_0
	local var_4_28 = arg_4_0.rtClick
	local var_4_29 = var_5.Find(var_4_28, "enemy")

	local function var_4_30()
		local var_9_0 = arg_4_0

		var_0.Hide(var_9_0, true)

		return
	end

	SFX_CONFIRM = var_4_28

	var_2(var_4_27, var_4_29, var_4_30, var_4_28)

	onButton = var_2

	local var_4_31 = arg_4_0
	local var_4_32 = arg_4_0.rtClick
	local var_4_33 = var_5.Find(var_4_32, "other")

	local function var_4_34()
		local var_10_0 = arg_4_0

		var_0.Hide(var_10_0, true)

		return
	end

	SFX_CONFIRM = var_4_32

	var_2(var_4_31, var_4_33, var_4_34, var_4_32)

	return
end

function var_0_1.OnDestroy(arg_11_0)
	return
end

function var_0_1.Show(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:emit(var_0_1.ShowView)

	if arg_12_1 then
		arg_12_0:DisplayWindow(arg_12_1, arg_12_2)
	else
		arg_12_0:HideWindow()
	end

	local var_12_0 = arg_12_0.wsDragProxy

	function var_12_0.onDragFunction()
		isActive = var_2_10000

		if var_2_10000(arg_12_0.rtPanel) then
			local var_13_0 = arg_12_0

			var_0.HideWindow(var_13_0)
		end

		return
	end

	pg = var_12_0

	local var_12_1 = var_12_0.UIMgr.GetInstance()

	var_3.OverlayPanel(var_12_1, arg_12_0._tf)

	setActive = var_3

	var_3(arg_12_0._tf, true)
	arg_12_0:EaseInOut(true)
	var_0_1.super.Show(arg_12_0)

	return
end

function var_0_1.Hide(arg_14_0, arg_14_1)
	LeanTween = var_1_10002

	if var_1_10002.isTweening(arg_14_0.alphaLT) then
		return
	end

	local var_14_0 = {}

	if not arg_14_1 then
		table = var_1_10003

		var_1_10003.insert(var_14_0, function(arg_15_0)
			local var_15_0 = arg_14_0

			var_1.EaseInOut(var_15_0, false, arg_15_0)

			return
		end)
	end

	seriesAsync = var_1_10003

	var_1_10003(var_14_0, function()
		local var_16_0 = arg_14_0.wsDragProxy

		var_16_0.onDragFunction = nil
		pg = var_16_0

		local var_16_1 = var_16_0.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_16_1, arg_14_0._tf, arg_14_0._parentTf)

		if arg_14_1 then
			local var_16_2 = arg_14_0

			var_0.emit(var_16_2, var_0_1.HideGoing, arg_14_0.attachment.row, arg_14_0.attachment.column)
		else
			local var_16_3 = arg_14_0

			var_0.emit(var_16_3, var_0_1.HideView)
		end

		var_0_1.super.Hide(arg_14_0)

		return
	end)

	return
end

function var_0_1.Setup(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.map = arg_17_1
	arg_17_0.wsDragProxy = arg_17_2

	return
end

function var_0_1.DisplayWindow(arg_18_0, arg_18_1, arg_18_2)
	isActive = var_1_10003

	if var_1_10003(arg_18_0.rtPanel) and arg_18_0.attachment == arg_18_1 then
		arg_18_0:HideWindow()
	else
		arg_18_0:Update(arg_18_1)

		local var_18_0 = arg_18_0.rtPanel
		local var_18_1 = arg_18_0.camera

		var_18_0.position = var_4.ScreenToWorldPoint(var_18_1, arg_18_2)

		local var_18_2 = arg_18_0.rtPanel

		Vector3 = var_4
		var_18_2.anchoredPosition3D = var_4.New(arg_18_0.rtPanel.anchoredPosition.x, arg_18_0.rtPanel.anchoredPosition.y, 0)
		arg_18_0.rtAnim.anchoredPosition = arg_18_0.rtPanel.anchoredPosition

		local var_18_3 = arg_18_0.rtWindow

		Vector2 = var_4
		var_18_3.anchorMin = var_4.New(arg_18_0.rtPanel.anchoredPosition.x > 0 and 0 or 1, arg_18_0.rtPanel.anchoredPosition.y > 0 and 1 or 0)
		arg_18_0.rtWindow.anchorMax = arg_18_0.rtWindow.anchorMin

		local var_18_4 = arg_18_0.rtWindow

		Vector2 = var_4
		var_18_4.pivot = var_4.New(arg_18_0.rtPanel.anchoredPosition.x > 0 and 1 or 0, arg_18_0.rtPanel.anchoredPosition.y > 0 and 1 or 0)

		local var_18_5 = arg_18_0.rtWindow

		Vector2 = var_4
		var_18_5.anchoredPosition = var_4.zero

		local var_18_6 = arg_18_0.rtClick

		Vector2 = var_4
		var_18_6.anchorMin = var_4.New(arg_18_0.rtPanel.anchoredPosition.x > 0 and 1 or 0, 0)
		arg_18_0.rtClick.anchorMax = arg_18_0.rtClick.anchorMin

		local var_18_7 = arg_18_0.rtWindow

		Vector2 = var_4
		var_18_7.anchoredPosition = var_4.zero
		WorldMapAttachment = var_18_7

		local var_18_8

		if not var_18_7.IsEnemyType(arg_18_1.type) then
			var_18_8 = arg_18_1:GetSpEventType()
			WorldMapAttachment = var_4
			var_18_8 = var_18_8 == var_4.SpEventEnemy
		end

		setActive = var_4

		local var_18_9 = arg_18_0.rtClick

		var_4(var_6.Find(var_18_9, "enemy"), var_18_8)

		setActive = var_4

		local var_18_10 = arg_18_0.rtClick

		var_4(var_6.Find(var_18_10, "other"), not var_18_8)

		setActive = var_4

		var_4(arg_18_0.rtPanel, true)
	end

	return
end

function var_0_1.HideWindow(arg_19_0)
	setAnchoredPosition = var_1_10001

	local var_19_0 = arg_19_0.rtAnim

	Vector2 = var_1_10004

	var_1_10001(var_19_0, var_1_10004.zero)

	setActive = var_1_10001

	var_1_10001(arg_19_0.rtPanel, false)

	return
end

function var_0_1.EaseInOut(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_0.alphaLT then
		LeanTween = var_3

		var_3.cancel(arg_20_0.alphaLT)
	end

	local var_20_0 = arg_20_0.canvas

	var_20_0.alpha = arg_20_1 and 0 or 1
	LeanTween = var_20_0

	local var_20_1 = var_20_0.alphaCanvas(arg_20_0.canvas, arg_20_1 and 1 or 0, 1)
	local var_20_2 = var_3.setOnComplete

	System = var_6
	arg_20_0.alphaLT = var_20_2(var_20_1, var_6.Action(arg_20_2 or function()
		return
	end)).uniqueId

	return
end

function var_0_1.Update(arg_22_0, arg_22_1)
	if arg_22_0.attachment ~= arg_22_1 then
		arg_22_0.attachment = arg_22_1

		arg_22_0:OnUpdate()
	end

	return
end

function var_0_1.OnUpdate(arg_23_0)
	local var_23_0 = arg_23_0.map
	local var_23_1 = arg_23_0.attachment
	local var_23_2 = arg_23_0.rtTitle
	local var_23_3 = var_3.Find(var_23_2, "Text")
	local var_23_4 = {}
	local var_23_5 = {}
	local var_23_6 = false
	local var_23_7 = false
	local var_23_8

	if not var_23_1.config.name then
		var_23_8 = ""
	end

	WorldMapAttachment = var_1_10009

	local var_23_10

	if var_1_10009.IsEnemyType(var_23_1.type) then
		var_23_6 = true
		var_23_7 = false
		var_23_4 = var_23_1:GetBuffList()

		local var_23_9 = var_23_0

		var_23_10 = var_23_0.GetBuffList
		WorldMap = var_1_10012
		var_23_5 = var_23_10(var_23_9, var_1_10012.FactionEnemy, var_23_1)
		var_23_10 = var_23_1.config.difficulty
		ys = var_1_10010

		if var_23_10 == var_1_10010.Battle.BattleConst.Difficulty.WORLD then
			var_23_10 = var_23_8
			var_1_10010 = " LV."
			WorldConst = var_23_9
			var_23_8 = var_23_10 .. var_1_10010 .. var_23_9.WorldLevelCorrect(var_23_0.config.expedition_level, var_23_1.config.type)
		else
			var_23_8 = var_23_8 .. " LV." .. var_23_1.config.level
		end

		goto label_23_0
	end

	var_23_10 = var_23_1.type
	WorldMapAttachment = var_1_10010

	if var_23_10 == var_1_10010.TypeEvent then
		var_23_4 = var_23_1:GetBuffList()

		local var_23_11 = var_23_0

		var_23_10 = var_23_0.GetBuffList
		WorldMap = var_1_10012
		var_23_5 = var_23_10(var_23_11, var_1_10012.FactionEnemy, var_23_1)

		if var_23_1.config.is_scanevent == 1 or var_23_10 == 3 then
			var_23_6 = var_23_10 == 3
			var_23_7 = true
			setActive = var_10

			local var_23_12 = arg_23_0.rtInfo

			var_10(var_12.Find(var_23_12, "Image"), false)

			setText = var_10

			local var_23_13 = arg_23_0.rtInfo

			var_10(var_12.Find(var_23_13, "Text"), var_23_1.config.scan_desc)
		elseif var_23_10 == 2 or var_23_10 == 4 then
			var_23_6 = var_23_10 == 4
			var_23_7 = true
			setActive = var_10

			local var_23_14 = arg_23_0.rtInfo

			var_10(var_12.Find(var_23_14, "Image"), true)

			GetImageSpriteFromAtlasAsync = var_10

			local var_23_15 = "icondesc/" .. var_23_1.config.icon
			local var_23_16 = ""
			local var_23_17 = arg_23_0.rtInfo

			var_10(var_23_15, var_23_16, var_14.Find(var_23_17, "Image"))

			setText = var_10

			local var_23_18 = arg_23_0.rtInfo

			var_10(var_12.Find(var_23_18, "Text"), var_23_1.config.scan_desc)
		end

		goto label_23_0
	end

	var_23_10 = var_23_1.type
	WorldMapAttachment = var_10

	if var_23_10 == var_10.TypeTrap then
		var_23_6 = true
		var_23_7 = true
		setActive = var_23_10

		local var_23_19 = arg_23_0.rtInfo

		var_23_10(var_11.Find(var_23_19, "Image"), true)

		WorldBuff = var_23_10
		var_23_10 = var_23_10.GetTemplate(var_23_1.config.buff_id)
		GetImageSpriteFromAtlasAsync = var_10

		local var_23_20 = "world/buff/" .. var_23_10.icon
		local var_23_21 = ""
		local var_23_22 = arg_23_0.rtInfo

		var_10(var_23_20, var_23_21, var_14.Find(var_23_22, "Image"))

		setText = var_10

		local var_23_23 = arg_23_0.rtInfo

		var_10(var_12.Find(var_23_23, "Text"), var_23_1.config.desc)

		goto label_23_0
	end

	var_23_10 = var_23_1.type
	WorldMapAttachment = var_10

	if var_23_10 == var_10.TypePort then
		var_23_10 = var_23_1.config.port_camp

		if 0 < var_23_10 then
			nowWorld = var_10

			do
				local var_23_24 = var_10()

				if var_23_10 == var_10.GetRealm(var_23_24) then
					var_23_6 = false
				else
					var_23_6 = true
				end

				var_23_7 = true
				setActive = var_10

				local var_23_25 = arg_23_0.rtInfo

				var_10(var_12.Find(var_23_25, "Image"), false)

				setText = var_10

				local var_23_26 = arg_23_0.rtInfo

				var_10(var_12.Find(var_23_26, "Text"), var_23_1.config.scan_desc)
			end

			::label_23_0::

			setText = var_23_10

			var_23_10(var_23_3, var_23_8)

			local var_23_27 = var_23_1:GetWeaknessBuffId()

			arg_23_0.buffList = {}
			arg_23_0.weaknessList = {}
			ipairs = var_10

			for iter_23_0, iter_23_1 in var_10(var_23_4) do
				if iter_23_1.id == var_23_27 then
					table = var_15

					var_15.insert(arg_23_0.weaknessList, iter_23_1)
				else
					table = var_15

					var_15.insert(arg_23_0.buffList, iter_23_1)
				end
			end

			local var_23_28 = arg_23_0.buffUIItemList

			var_10.align(var_23_28, #arg_23_0.buffList)

			local var_23_29 = arg_23_0.weaknessUIItemList

			var_10.align(var_23_29, #arg_23_0.weaknessList)

			arg_23_0.mapBuffList = var_23_5

			local var_23_30 = arg_23_0.mapBuffItemList

			var_10.align(var_23_30, #arg_23_0.mapBuffList)

			setActive = var_10

			var_10(arg_23_0.rtInfo, var_23_7)

			setActive = var_10

			var_10(arg_23_0.rtMark, var_23_7 and var_23_6)

			setActive = var_10

			local var_23_31 = arg_23_0.rtTitle

			var_10(var_12.Find(var_23_31, "red"), var_23_6)

			setActive = var_10

			local var_23_32 = arg_23_0.rtTitle

			var_10(var_12.Find(var_23_32, "yellow"), not var_23_6)

			local var_23_33 = var_23_1:GetRadiationBuffs()

			setActive = var_11

			var_11(arg_23_0.rtRadiation, #var_23_33 > 0)

			if #var_23_33 > 0 then
				unpack = var_11

				local var_23_34, var_23_35, var_23_36 = var_11(var_23_33[1])

				GetImageSpriteFromAtlasAsync = var_14

				local var_23_37 = "world/mapbuff/"

				pg = var_1_10017

				local var_23_38 = var_23_37 .. var_1_10017.world_SLGbuff_data[var_23_35].icon
				local var_23_39 = ""
				local var_23_40 = arg_23_0.rtRadiation

				var_14(var_23_38, var_23_39, var_18.Find(var_23_40, "info/map_buff/Image"))

				setText = var_14

				local var_23_41 = arg_23_0.rtRadiation
				local var_23_42 = var_16.Find(var_23_41, "info/Text")

				i18n = var_23_39

				var_14(var_23_42, var_23_39("world_mapbuff_tip"))
			end

			return
		end
	end
end

return var_0_1
