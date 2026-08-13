class = var_0_10000

local var_0_0 = "NewYearHotSpringScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "NewYearHotSpringUI"
end

local var_0_2 = 0.85

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.scrollRect = var_1.Find(var_2_0, "ScrollRect")

	local var_2_1 = arg_2_0.scrollRect
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	ScrollRect = var_1_10006
	arg_2_0.scrollContent = var_2_2(var_2_1, var_4(var_1_10006)).content
	_ = var_1

	local var_2_3 = var_1.map

	_ = var_2_1
	arg_2_0.slotTFs = var_2_3(var_2_1.range(4, 13), function(arg_3_0)
		local var_3_0 = arg_2_0.scrollRect
		local var_3_1 = var_1.Find(var_3_0, "Pool")

		return var_1.GetChild(var_3_1, arg_3_0 - 1)
	end)
	_ = var_1
	arg_2_0.slotOriginalPos = var_1.map(arg_2_0.slotTFs, function(arg_4_0)
		return arg_4_0.anchoredPosition
	end)
	Clone = var_1
	arg_2_0.slotShipPos = var_1(arg_2_0.slotOriginalPos)
	table = var_1

	var_1.Foreach(arg_2_0:GetRecordPos(), function(arg_5_0, arg_5_1)
		arg_2_0.slotShipPos[arg_5_0] = arg_5_1

		return
	end)

	_ = var_1

	local var_2_4 = var_1.map

	_ = var_3

	local var_2_5 = var_3.range
	local var_2_6 = arg_2_0.scrollRect

	arg_2_0.poolItems = var_2_4(var_2_5(var_5.Find(var_2_6, "Pool").childCount), function(arg_6_0)
		local var_6_0 = arg_2_0.scrollRect
		local var_6_1 = var_1.Find(var_6_0, "Pool")

		return var_1.GetChild(var_6_1, arg_6_0 - 1)
	end)
	Canvas = var_1

	var_1.ForceUpdateCanvases()

	_ = var_1
	arg_2_0.scrollBGs = var_1.map({
		{
			"1",
			0.5
		},
		{
			"2",
			0.6
		},
		{
			"3",
			var_0_2
		},
		{
			"Pool",
			var_0_2
		},
		{
			"4",
			1
		},
		{
			"5",
			1
		}
	}, function(arg_7_0)
		local var_7_0 = {}
		local var_7_1 = arg_2_0.scrollRect

		var_7_0[1] = var_2.Find(var_7_1, arg_7_0[1])
		var_7_0[2] = arg_7_0[2]
		var_7_0[3] = var_7_0[1].anchoredPosition.x

		local var_7_2 = arg_2_0
		local var_7_3 = var_2.UpdateScrollContent
		local var_7_4 = 0

		unpack = var_2_10006

		var_7_3(var_7_2, var_7_4, var_2_10006(var_7_0))

		return var_7_0
	end)

	local var_2_7 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_7, "Top")
	pg = var_1

	var_1.ViewUtils.SetSortingOrder(arg_2_0._tf, -1001)

	arg_2_0.spineRoles = {}
	Material = var_1

	local var_2_8 = var_1.New

	pg = var_3

	local var_2_9 = var_3.ShaderMgr.GetInstance()

	arg_2_0.washMaterial = var_2_8(var_3.GetShader(var_2_9, "M02/Unlit_Colored_Semitransparent"))

	local var_2_10 = arg_2_0.washMaterial

	var_1.SetFloat(var_2_10, "_Height", 0.5)

	return
end

function var_0_1.SetActivity(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.activity

	arg_8_0.activity = arg_8_1

	if not var_8_0 then
		return
	end

	table = var_1_10003

	var_1_10003.Foreach(var_8_0:GetShipIds(), function(arg_9_0, arg_9_1)
		if arg_9_1 > 0 then
			local var_9_0 = arg_8_1
			local var_9_1

			if not var_2.GetShipIds(var_9_0)[arg_9_0] then
				var_9_1 = 0
			end

			if var_9_1 == 0 then
				local var_9_2 = arg_8_0.slotShipPos

				Clone = var_9_0
				var_9_2[arg_9_0] = var_9_0(arg_8_0.slotOriginalPos[arg_9_0])
			end
		end

		return
	end)

	return
end

function var_0_1.didEnter(arg_10_0)
	onButton = var_1_10001

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0._tf
	local var_10_2 = var_4.Find(var_10_1, "Top/Back")

	local function var_10_3()
		local var_11_0 = arg_10_0

		var_0.closeView(var_11_0)

		return
	end

	SOUND_BACK = var_10_1

	var_1_10001(var_10_0, var_10_2, var_10_3, var_10_1)

	onButton = var_1_10001

	local var_10_4 = arg_10_0
	local var_10_5 = arg_10_0._tf
	local var_10_6 = var_4.Find(var_10_5, "Top/Help")

	local function var_10_7()
		pg = var_2_10000

		local var_12_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_12_1 = var_0.ShowMsgBox
		local var_12_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_12_2.type = var_2_10004
		pg = var_2_10004
		var_12_2.helps = var_2_10004.gametip.hotspring_help.tip

		var_12_1(var_12_0, var_12_2)

		return
	end

	SFX_PANEL = var_10_5

	var_1_10001(var_10_4, var_10_6, var_10_7, var_10_5)

	onButton = var_1_10001

	local var_10_8 = arg_10_0
	local var_10_9 = arg_10_0._tf
	local var_10_10 = var_4.Find(var_10_9, "Top/Manage")

	local function var_10_11()
		local var_13_0 = arg_10_0
		local var_13_1 = var_0.emit

		NewYearHotSpringMediator = var_2_10003

		var_13_1(var_13_0, var_2_10003.OPEN_INFO)

		return
	end

	SFX_PANEL = var_10_9

	var_1_10001(var_10_8, var_10_10, var_10_11, var_10_9)

	string = var_1_10001

	local var_10_12 = var_1_10001.split

	i18n = var_10_8

	local var_10_13 = var_10_12(var_10_8("hotspring_buff"), "|")

	assert = var_1_10002

	var_1_10002(var_10_13)

	onButton = var_1_10002

	local var_10_14 = arg_10_0
	local var_10_15 = arg_10_0._tf
	local var_10_16 = var_5.Find(var_10_15, "Top/Buff")

	local function var_10_17()
		pg = var_2_10000

		local var_14_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_14_1 = var_0.ShowMsgBox
		local var_14_2 = {
			hideIconBG = true
		}

		MSGBOX_TYPE_DROP_ITEM = var_2_10004
		var_14_2.type = var_2_10004
		var_14_2.iconPath = {
			"UI/NewYearHotSpringUI_atlas",
			"buff_hotspring"
		}
		var_14_2.name = var_10_13[1]
		var_14_2.content = var_10_13[2]

		var_14_1(var_14_0, var_14_2)

		return
	end

	SFX_PANEL = var_10_15

	var_1_10002(var_10_14, var_10_16, var_10_17, var_10_15)

	onScroll = var_1_10002

	var_1_10002(arg_10_0, arg_10_0.scrollRect, function(arg_15_0)
		_ = var_2_10001

		var_2_10001.each(arg_10_0.scrollBGs, function(arg_16_0)
			local var_16_0 = arg_10_0
			local var_16_1 = var_1.UpdateScrollContent
			local var_16_2 = arg_10_0.scrollContent.anchoredPosition.x

			unpack = var_3_10005

			var_16_1(var_16_0, var_16_2, var_3_10005(arg_16_0))

			return
		end)

		return
	end)
	arg_10_0:InitSlots()
	arg_10_0:UpdateView()

	FrameTimer = var_2
	arg_10_0.timer = var_2.New(function()
		_ = var_2_10000

		local var_17_0 = var_2_10000.map

		_ = var_2_10002

		local var_17_1 = var_2_10002.range
		local var_17_2 = arg_10_0.scrollRect
		local var_17_3 = var_17_0(var_17_1(var_4.Find(var_17_2, "Pool").childCount), function(arg_18_0)
			local var_18_0 = arg_10_0.scrollRect
			local var_18_1 = var_1.Find(var_18_0, "Pool")

			return var_1.GetChild(var_18_1, arg_18_0 - 1)
		end)

		mergeSort = var_2_10001

		var_2_10001(var_17_3, function(arg_19_0, arg_19_1)
			return arg_19_0.anchoredPosition.y >= arg_19_1.anchoredPosition.y
		end)

		table = var_2_10001

		var_2_10001.Foreach(var_17_3, function(arg_20_0, arg_20_1)
			arg_20_1:SetSiblingIndex(arg_20_0 - 1)

			return
		end)

		return
	end, 1, -1)

	local var_10_18 = arg_10_0.timer

	var_2.Start(var_10_18)

	onNextTick = var_2

	var_2(function()
		local var_21_0 = arg_10_0.activity

		if var_0.GetSlotCount(var_21_0) + 1 <= #arg_10_0.slotTFs then
			local var_21_1 = arg_10_0.scrollRect.rect.width
			local var_21_2 = arg_10_0.scrollContent.rect.width
			local var_21_3 = arg_10_0.scrollRect
			local var_21_4 = var_3.Find(var_21_3, "Pool").anchoredPosition.x + arg_10_0.slotTFs[var_0].anchoredPosition.x + var_3.rect.width * 0.5

			math = var_6

			local var_21_5 = var_6.clamp((var_21_4 - var_21_1 * 0.5) / var_0_2, 0, var_21_2 - var_21_1)

			setAnchoredPosition = var_2_10007

			var_2_10007(arg_10_0.scrollContent, {
				x = var_21_5
			})

			_ = var_2_10007

			var_2_10007.each(arg_10_0.scrollBGs, function(arg_22_0)
				local var_22_0 = arg_10_0
				local var_22_1 = var_1.UpdateScrollContent
				local var_22_2 = -var_21_5

				unpack = var_3_10005

				var_22_1(var_22_0, var_22_2, var_3_10005(arg_22_0))

				return
			end)
		end

		return
	end)
	arg_10_0:OverlayPanel(arg_10_0.top)

	return
end

function var_0_1.UpdateScrollContent(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	arg_23_1 = arg_23_1 * arg_23_3
	setAnchoredPosition = var_1_10005

	var_1_10005(arg_23_2, {
		x = arg_23_1 + arg_23_4
	})

	return
end

function var_0_1.InitSlots(arg_24_0)
	arg_24_0:CleanSpines()

	table = var_1

	var_1.Foreach(arg_24_0.slotTFs, function(arg_25_0, arg_25_1)
		onButton = var_2_10002

		local var_25_0 = arg_24_0
		local var_25_1 = arg_25_1
		local var_25_2 = arg_25_1.Find(var_25_1, "Usable")

		local function var_25_3()
			local var_26_0 = arg_24_0
			local var_26_1 = var_0.emit

			NewYearHotSpringMediator = var_3_10003

			var_26_1(var_26_0, var_3_10003.UNLOCK_SLOT, arg_24_0.activity.id)

			return
		end

		SFX_PANEL = var_25_1

		var_2_10002(var_25_0, var_25_2, var_25_3, var_25_1)

		local function var_25_4()
			local var_27_0 = arg_24_0.activity
			local var_27_1

			if not var_0.GetShipIds(var_27_0)[arg_25_0] then
				var_27_1 = 0
			end

			local var_27_3

			if 0 < var_27_1 then
				getProxy = var_1
				BayProxy = var_3_10003

				local var_27_2 = var_1(var_3_10003)

				var_27_3 = var_1.RawGetShipById(var_27_2, var_27_1)
			else
				var_27_3 = false
			end

			if false then
				var_27_3 = true
			end

			local var_27_4 = arg_24_0
			local var_27_5 = var_2.emit

			NewYearHotSpringMediator = var_3_10005

			var_27_5(var_27_4, var_3_10005.OPEN_CHUANWU, arg_25_0, var_27_3)

			return
		end

		onButton = var_2_10003

		local var_25_5 = arg_24_0
		local var_25_6 = arg_25_1
		local var_25_7 = arg_25_1.Find(var_25_6, "Enter")
		local var_25_8 = var_25_4

		SFX_PANEL = var_25_6

		var_2_10003(var_25_5, var_25_7, var_25_8, var_25_6)

		onButton = var_2_10003

		local var_25_9 = arg_24_0
		local var_25_10 = arg_25_1
		local var_25_11 = arg_25_1.Find(var_25_10, "Ship/Click")

		local function var_25_12()
			if arg_24_0._modelDrag then
				return
			end

			var_25_4()

			return
		end

		SFX_PANEL = var_25_10

		var_2_10003(var_25_9, var_25_11, var_25_12, var_25_10)

		pg = var_2_10003

		local var_25_13 = var_2_10003.UIMgr.GetInstance().uiCamera
		local var_25_14 = var_3.GetComponent

		typeof = var_25_11
		Camera = var_25_10

		local var_25_15 = var_25_14(var_25_13, var_25_11(var_25_10))
		local var_25_16 = arg_24_0.scrollRect
		local var_25_17 = var_4.Find(var_25_16, "Pool")

		GetComponent = var_25_13

		local var_25_18 = var_25_13(arg_25_1:Find("Ship/Click"), "EventTriggerListener")

		var_5.AddBeginDragFunc(var_25_18, function()
			if arg_24_0._modelDrag then
				return
			end

			arg_24_0._modelDrag = arg_25_1
			arg_24_0._currentDragDelegate = var_0

			local var_29_0 = arg_24_0

			var_29_0._lastDragBeginPosition = arg_25_1.anchoredPosition
			setParent = var_29_0

			var_29_0(arg_25_1, arg_24_0._tf)

			local var_29_1 = arg_24_0.spineRoles[arg_25_0]

			var_0.RevertMaterial(var_29_1)
			var_0:SetAction("tuozhuai")

			setActive = var_1

			local var_29_2 = arg_25_1

			var_1(var_3.Find(var_29_2, "wenquan_bowen"), false)

			pg = var_1

			local var_29_3 = var_1.CriMgr.GetInstance()
			local var_29_4 = var_1.PlaySoundEffect_V3

			SFX_UI_HOME_DRAG = var_4

			var_29_4(var_29_3, var_4)

			return
		end)
		var_5:AddDragFunc(function(arg_30_0, arg_30_1)
			if arg_24_0._modelDrag ~= arg_25_1 then
				return
			end

			LuaHelper = var_2

			local var_30_0 = var_2.ScreenToLocal(arg_24_0._tf, arg_30_1.position, var_25_15)

			arg_25_1.anchoredPosition = var_30_0

			return
		end)
		var_5:AddDragEndFunc(function(arg_31_0, arg_31_1)
			if arg_24_0._modelDrag ~= arg_25_1 then
				return
			end

			arg_24_0._modelDrag = false

			local var_31_0 = arg_24_0._forceDropCharacter

			arg_24_0._forceDropCharacter = nil
			arg_24_0._currentDragDelegate = nil

			local var_31_1 = arg_24_0.spineRoles[arg_25_0]

			setParent = var_4

			var_4(arg_25_1, var_25_17, true)

			local function var_31_2()
				if arg_24_0._lastDragBeginPosition ~= nil then
					arg_25_1.anchoredPosition = arg_24_0._lastDragBeginPosition
				end

				return
			end

			if var_31_0 then
				var_31_2()

				return
			end

			local var_31_3 = var_25_17.rect.center

			Vector2 = var_7
			var_5.center = var_31_3 + var_7.New(-var_5.size.x * 0.5)

			local var_31_4 = arg_25_1.anchoredPosition
			local var_31_5 = var_5

			if not var_5.Contains(var_31_5, var_31_4) then
				Vector2 = var_7

				local var_31_6 = var_7.Min

				Vector2 = var_31_5
				var_31_4 = var_31_6(var_31_5.Max(var_31_4, var_5.min), var_5.max)
				arg_25_1.anchoredPosition = var_31_4
			end

			arg_24_0.slotShipPos[arg_25_0] = var_31_4

			local var_31_7 = arg_24_0

			var_7.SetSpineWash(var_31_7, var_31_1)

			setActive = var_7

			local var_31_8 = arg_25_1

			var_7(var_9.Find(var_31_8, "wenquan_bowen"), true)

			pg = var_7

			local var_31_9 = var_7.CriMgr.GetInstance()
			local var_31_10 = var_7.PlaySoundEffect_V3

			SFX_UI_HOME_PUT = var_10

			var_31_10(var_31_9, var_10)

			return
		end)

		return
	end)

	return
end

function var_0_1.UpdateView(arg_33_0)
	arg_33_0:UpdateSlots()

	setText = var_1

	local var_33_0 = arg_33_0.top
	local var_33_1 = var_3.Find(var_33_0, "Ticket/Text")
	local var_33_2 = arg_33_0.activity

	var_1(var_33_1, var_4.GetCoins(var_33_2))

	return
end

function var_0_1.UpdateSlots(arg_34_0)
	arg_34_0:CleanSpines()

	table = var_1

	var_1.Foreach(arg_34_0.slotTFs, function(arg_35_0, arg_35_1)
		local var_35_0 = arg_34_0

		var_2.UpdateSlot(var_35_0, arg_35_0, arg_35_1)

		return
	end)

	return
end

function var_0_1.RectContainsRect(arg_36_0, arg_36_1)
	local var_36_0

	if arg_36_0:Contains(arg_36_1.min) then
		var_36_0 = arg_36_0:Contains(arg_36_1.max)
	end

	return var_36_0
end

function var_0_1.UpdateSlot(arg_37_0, arg_37_1, arg_37_2)
	math = var_1_10003

	local var_37_0 = var_1_10003.clamp
	local var_37_1 = arg_37_0.activity
	local var_37_2 = var_37_0(arg_37_1 - var_5.GetSlotCount(var_37_1), 0, 2)

	setActive = var_1_10004

	var_1_10004(arg_37_2:Find("Lock"), var_37_2 == 2)

	setActive = var_1_10004

	local var_37_3 = arg_37_2

	var_1_10004(arg_37_2.Find(var_37_3, "Usable"), var_37_2 == 1)

	local var_37_4 = arg_37_0.activity
	local var_37_5

	if not var_4.GetShipIds(var_37_4)[arg_37_1] then
		var_37_5 = 0
	end

	local var_37_6 = var_37_2 == 0
	local var_37_7

	if 0 < var_37_5 then
		getProxy = var_6
		BayProxy = var_37_3
		var_37_3 = var_6(var_37_3)
		var_37_7 = var_6.RawGetShipById(var_37_3, var_37_5)
	else
		var_37_7 = false
	end

	if false then
		var_37_7 = true
	end

	local var_37_8 = arg_37_2
	local var_37_9 = arg_37_2.Find(var_37_8, "Ship")

	setActive = var_37_3

	var_37_3(arg_37_2:Find("Enter"), var_37_6 and not var_37_7)

	setActive = var_37_3

	var_37_3(var_37_9, var_37_6 and var_37_7 and true)

	local var_37_10

	if not var_37_7 or not arg_37_0.slotShipPos then
		var_37_10 = arg_37_0.slotOriginalPos
	end

	local var_37_11 = var_37_10[arg_37_1]

	setAnchoredPosition = var_37_8

	var_37_8(arg_37_2, var_37_11)

	if var_37_7 then
		SpineRole = var_37_8

		local var_37_12 = var_37_8.New()

		var_9.SetData(var_37_12, var_37_7:getPrefab())
		arg_37_0:LoadingOn()
		var_9:Load(function()
			local var_38_0 = var_0
			local var_38_1 = var_0.SetParent
			local var_38_2 = var_37_9

			var_38_1(var_38_0, var_3.Find(var_38_2, "Model"))

			local var_38_3 = arg_37_0

			var_0.SetSpineWash(var_38_3, var_0)

			local var_38_4 = arg_37_0

			var_0.LoadingOff(var_38_4)

			return
		end, true)

		arg_37_0.spineRoles[arg_37_1] = var_9
	end

	return
end

function var_0_1.SetSpineWash(arg_39_0, arg_39_1)
	arg_39_1:SetAction("wash")

	local var_39_0 = arg_39_1
	local var_39_1 = arg_39_1.ChangeMaterial

	Object = var_5

	var_39_1(var_39_0, var_5.Instantiate(arg_39_0.washMaterial))

	local var_39_2 = arg_39_1:GetRoleModel().transform.position.y
	local var_39_3 = arg_39_1:GetSkeletonGraphic().material

	var_3.SetFloat(var_39_3, "_PositionY", var_39_2 + 1.5)

	return
end

function var_0_1.CleanSpines(arg_40_0)
	arg_40_0:ForceDropChar()

	table = var_1

	var_1.Foreach(arg_40_0.spineRoles, function(arg_41_0, arg_41_1)
		arg_41_1:Dispose()

		return
	end)

	arg_40_0.spineRoles = {}

	return
end

function var_0_1.ForceDropChar(arg_42_0)
	if arg_42_0._currentDragDelegate then
		arg_42_0._forceDropCharacter = true
		LuaHelper = var_1

		var_1.triggerEndDrag(arg_42_0._currentDragDelegate)
	end

	return
end

function var_0_1.GetRecordPos(arg_43_0)
	PlayerPrefs = var_1_10001

	local var_43_0 = var_1_10001.GetString("hotspring_ship_pos", "")

	_ = var_1_10002

	local var_43_1 = var_1_10002.map

	string = var_4

	local var_43_2 = var_43_1(var_4.split(var_43_0, ";"), function(arg_44_0)
		tonumber = var_2_10001

		return var_2_10001(arg_44_0)
	end)
	local var_43_3 = {}

	for iter_43_0 = 1, #var_43_2, 2 do
		table = var_1_10008
		var_1_10008 = var_1_10008.insert

		local var_43_4 = var_43_3

		Vector2 = var_1_10011

		var_1_10008(var_43_4, var_1_10011.New(var_43_2[iter_43_0], var_43_2[iter_43_0 + 1]))
	end

	return var_43_3
end

function var_0_1.RecordPos(arg_45_0, arg_45_1)
	if not arg_45_1 then
		return
	end

	table = var_1_10002

	local var_45_0 = var_1_10002.concat

	_ = var_1_10004

	local var_45_1 = var_45_0(var_1_10004.reduce(arg_45_1, {}, function(arg_46_0, arg_46_1)
		table = var_2_10002

		var_2_10002.insert(arg_46_0, arg_46_1.x)

		table = var_2

		var_2.insert(arg_46_0, arg_46_1.y)

		return arg_46_0
	end), ";")

	PlayerPrefs = var_1_10003

	var_1_10003.SetString("hotspring_ship_pos", var_45_1)

	return
end

function var_0_1.LoadingOn(arg_47_0)
	if arg_47_0.animating then
		return
	end

	arg_47_0.animating = true
	pg = var_1

	local var_47_0 = var_1.UIMgr.GetInstance()

	var_1.LoadingOn(var_47_0, false)

	return
end

function var_0_1.LoadingOff(arg_48_0)
	if not arg_48_0.animating then
		return
	end

	pg = var_1

	local var_48_0 = var_1.UIMgr.GetInstance()

	var_1.LoadingOff(var_48_0)

	arg_48_0.animating = false

	return
end

function var_0_1.willExit(arg_49_0)
	arg_49_0:UnOverlayPanel(arg_49_0.top, arg_49_0._tf)

	Object = var_1

	var_1.Destroy(arg_49_0.washMaterial)
	arg_49_0:RecordPos(arg_49_0.slotShipPos)
	arg_49_0:CleanSpines()

	local var_49_0 = arg_49_0.timer

	var_1.Stop(var_49_0)
	arg_49_0:LoadingOff()

	return
end

return var_0_1
