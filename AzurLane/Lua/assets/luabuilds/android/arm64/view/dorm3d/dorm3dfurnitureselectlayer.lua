class = var_0_10000

local var_0_0 = "Dorm3dFurnitureSelectLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dFurnitureSelectUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.zoneList = var_1.Find(var_2_0, "ZoneList")
	setActive = var_1

	var_1(arg_2_0.zoneList, false)

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "Right/Panel/Container/Furnitures")
	local var_2_3 = var_1.Find(var_2_2, "Scroll/Content")

	arg_2_0.furnitureScroll = var_2.GetComponent(var_2_3, "LScrollRect")
	arg_2_0.furnitureEmpty = var_1:Find("Empty")

	local var_2_4 = arg_2_0._tf

	arg_2_0.lableTrans = var_2.Find(var_2_4, "Main/Label")
	setActive = var_2

	var_2(arg_2_0.lableTrans, false)

	local var_2_5 = arg_2_0.furnitureScroll.prefabItem.transform

	setText = var_2_1

	local var_2_6 = var_2_5:Find("Unfit/Icon/Text")

	i18n = var_1_10006

	var_2_1(var_2_6, var_1_10006("dorm3d_furniture_unfit"))

	setText = var_2_1

	local var_2_7 = var_2_5:Find("Lack/Icon/Text")

	i18n = var_6

	var_2_1(var_2_7, var_6("ryza_tip_control_buff_not_obtain"))

	return
end

function var_0_1.SetSceneRoot(arg_3_0, arg_3_1)
	arg_3_0.scene = arg_3_1

	return
end

function var_0_1.SetRoom(arg_4_0, arg_4_1)
	arg_4_0.room = arg_4_1:clone()

	return
end

function var_0_1.didEnter(arg_5_0)
	local var_5_0 = arg_5_0.room

	arg_5_0.allZones = var_1.GetFurnitureZones(var_5_0)
	_ = var_2
	arg_5_0.globalZones = var_2.select(arg_5_0.allZones, function(arg_6_0)
		return arg_6_0:IsGlobal()
	end)
	_ = var_2
	arg_5_0.normalZones = var_2.select(arg_5_0.allZones, function(arg_7_0)
		return not arg_7_0:IsGlobal()
	end)

	local var_5_1 = arg_5_0.normalZones

	arg_5_0.zoneIndex = 1

	local var_5_2 = arg_5_0.scene

	if var_3.GetAttachedFurnitureName(var_5_2) then
		table = var_4

		var_4.Ipairs(var_5_1, function(arg_8_0, arg_8_1)
			if arg_8_1:GetWatchCameraName() == var_0 then
				arg_5_0.zoneIndex = arg_8_0
			end

			return
		end)
	end

	onButton = var_4

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0._tf
	local var_5_5 = var_7.Find(var_5_4, "Right/Panel/Container/Zone/ZoneContainer/Switch")

	local function var_5_6()
		setActive = var_2_10000

		var_2_10000(arg_5_0.zoneList, true)

		return
	end

	SFX_PANEL = var_5_4

	var_4(var_5_3, var_5_5, var_5_6, var_5_4)

	setActive = var_4

	local var_5_7 = arg_5_0._tf

	var_4(var_6.Find(var_5_7, "Right/Panel/Container/Zone/ZoneContainer/Switch/New"), false)

	onButton = var_4

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.zoneList

	var_4(var_5_8, var_7.Find(var_5_9, "Mask"), function()
		setActive = var_2_10000

		var_2_10000(arg_5_0.zoneList, false)

		return
	end)

	onButton = var_4

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0._tf

	var_4(var_5_10, var_7.Find(var_5_11, "Top/Back"), function()
		local var_11_0 = arg_5_0

		var_0.onBackPressed(var_11_0)

		return
	end)

	onButton = var_4

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0._tf
	local var_5_14 = var_7.Find(var_5_13, "Right/Save")

	local function var_5_15()
		local var_12_0 = arg_5_0

		var_0.ShowReplaceWindow(var_12_0)

		return
	end

	SFX_PANEL = var_5_13

	var_4(var_5_12, var_5_14, var_5_15, var_5_13)

	local function var_5_16(arg_13_0)
		local var_13_0 = arg_5_0._tf
		local var_13_1 = var_1.Find(var_13_0, "Right/Popup")
		local var_13_2 = var_1.GetComponent

		typeof = var_4
		Image = var_2_10006
		var_13_2(var_13_1, var_4(var_2_10006)).raycastTarget = not arg_13_0

		local var_13_3 = arg_5_0._tf
		local var_13_4 = var_1.Find(var_13_3, "Right/Collapse")
		local var_13_5 = var_1.GetComponent

		typeof = var_4
		Image = var_2_10006

		local var_13_6 = var_13_5(var_13_4, var_4(var_2_10006))

		var_13_6.raycastTarget = arg_13_0

		if arg_13_0 then
			quickPlayAnimation = var_13_6

			var_13_6(arg_5_0._tf, "anim_dorm3d_furniture_in")
		else
			quickPlayAnimation = var_13_6

			var_13_6(arg_5_0._tf, "anim_dorm3d_furniture_hide")
		end

		return
	end

	local var_5_17 = arg_5_0._tf
	local var_5_18 = var_5.Find(var_5_17, "Right/Popup")
	local var_5_19 = var_5.GetComponent

	typeof = var_8
	Image = var_10
	var_5_19(var_5_18, var_8(var_10)).raycastTarget = false

	local var_5_20 = arg_5_0._tf
	local var_5_21 = var_5.Find(var_5_20, "Right/Collapse")
	local var_5_22 = var_5.GetComponent

	typeof = var_8
	Image = var_10

	local var_5_23 = var_5_22(var_5_21, var_8(var_10))

	var_5_23.raycastTarget = true
	onButton = var_5_23

	local var_5_24 = arg_5_0
	local var_5_25 = arg_5_0._tf
	local var_5_26 = var_8.Find(var_5_25, "Right/Popup")

	local function var_5_27()
		var_5_16(true)

		return
	end

	SFX_PANEL = var_5_25

	var_5_23(var_5_24, var_5_26, var_5_27, var_5_25)

	onButton = var_5_23

	local var_5_28 = arg_5_0
	local var_5_29 = arg_5_0._tf
	local var_5_30 = var_8.Find(var_5_29, "Right/Collapse")

	local function var_5_31()
		var_5_16(false)

		return
	end

	SFX_PANEL = var_5_29

	var_5_23(var_5_28, var_5_30, var_5_31, var_5_29)

	onButton = var_5_23

	local var_5_32 = arg_5_0
	local var_5_33 = arg_5_0._tf
	local var_5_34 = var_8.Find(var_5_33, "Right/Auto")

	local function var_5_35()
		local var_16_0 = arg_5_0

		var_0.AutoReplaceFurniture(var_16_0)

		return
	end

	SFX_PANEL = var_5_33

	var_5_23(var_5_32, var_5_34, var_5_35, var_5_33)

	onButton = var_5_23

	var_5_23(arg_5_0, arg_5_0.lableTrans, function()
		local var_17_0 = arg_5_0

		var_0.CleanSlot(var_17_0)

		return
	end, "ui-dorm_furniture_removal")

	arg_5_0.furnitureItems = {}

	function arg_5_0.furnitureScroll.onUpdateItem(arg_18_0, arg_18_1)
		arg_18_0 = arg_18_0 + 1
		arg_5_0.furnitureItems[arg_18_0] = arg_18_1

		local var_18_0 = arg_5_0

		var_2.UpdateViewFurnitureItem(var_18_0, arg_18_0)

		return
	end

	function arg_5_0.furnitureScroll.onReturnItem(arg_19_0, arg_19_1)
		if arg_5_0.exited then
			return
		end

		arg_19_0 = arg_19_0 + 1
		arg_5_0.furnitureItems[arg_19_0] = nil

		return
	end

	arg_5_0.replaceFurnitures = {}

	arg_5_0:UpdateDataZone()
	arg_5_0:InitViewZoneList()
	arg_5_0:InitViewTypeList()

	local var_5_36 = arg_5_0.scene

	var_5.EnterFurnitureWatchMode(var_5_36)

	local var_5_37 = arg_5_0.scene

	var_5.SwitchFurnitureZone(var_5_37, arg_5_0.normalZones[arg_5_0.zoneIndex])

	onNextTick = var_5

	var_5(function()
		arg_5_0.furnitureScroll.enabled = true

		local var_20_0 = arg_5_0

		var_0.UpdateView(var_20_0)

		return
	end)

	UpdateBeat = var_5
	arg_5_0.updateHandler = var_5:CreateListener(function()
		xpcall = var_2_10000

		var_2_10000(function()
			local var_22_0 = arg_5_0

			var_0.Update(var_22_0)

			return
		end, function(...)
			errorMsg = var_3_10000
			debug = var_3_10002

			var_3_10000(var_3_10002.traceback(...))

			return
		end)

		return
	end)
	UpdateBeat = var_5

	var_5:AddListener(arg_5_0.updateHandler)

	return
end

function var_0_1.Update(arg_24_0)
	if arg_24_0.labelSettings then
		local var_24_0 = arg_24_0.scene
		local var_24_1 = var_1.GetSlotByID(var_24_0, arg_24_0.labelSettings.slotId)
		local var_24_2 = arg_24_0.scene
		local var_24_3 = var_2.GetScreenPosition(var_24_2, var_24_1.position)
		local var_24_4 = arg_24_0.scene
		local var_24_5 = var_3.GetLocalPosition(var_24_4, var_24_3, arg_24_0.lableTrans.parent)

		setLocalPosition = var_24_2

		var_24_2(arg_24_0.lableTrans, var_24_5)
	end

	return
end

function var_0_1.UpdateDataZone(arg_25_0)
	local var_25_0 = arg_25_0.normalZones[arg_25_0.zoneIndex]
	local var_25_1 = {
		var_25_0
	}

	unpack = var_1_10003
	var_25_1[2] = var_1_10003(arg_25_0.globalZones)
	_ = var_3

	local var_25_2 = var_3.reduce(var_25_1, {}, function(arg_26_0, arg_26_1)
		table = var_2_10002

		var_2_10002.insertto(arg_26_0, arg_26_1:GetSlots())

		return arg_26_0
	end)
	local var_25_3 = {}

	_ = var_5

	var_5.each(var_25_2, function(arg_27_0)
		var_25_3[arg_27_0:GetType()] = true

		return
	end)

	Dorm3dFurniture = var_5
	var_25_3[var_5.TYPE.SPECIAL] = nil
	_ = var_5
	arg_25_0.activeFurnitureTypes = var_5.keys(var_25_3)
	_ = var_5

	local var_25_4 = var_5.any
	local var_25_5 = arg_25_0

	if var_25_4(arg_25_0.GetDisplayFurnitures(var_25_5, nil), function(arg_28_0)
		local var_28_0 = arg_28_0.template

		return var_1.IsSpecial(var_28_0)
	end) then
		table = var_6

		local var_25_6 = var_6.insert
		local var_25_7 = arg_25_0.activeFurnitureTypes

		Dorm3dFurniture = var_25_5

		var_25_6(var_25_7, var_25_5.TYPE.SPECIAL)
	end

	var_25_0:SortTypes(arg_25_0.activeFurnitureTypes)

	arg_25_0.furnitureType = arg_25_0.activeFurnitureTypes[1]

	arg_25_0:ResetSelectSetting()
	arg_25_0:UpdateDataDisplayFurnitures()
	arg_25_0:FilterDataFurnitures()

	return
end

function var_0_1.ResetSelectSetting(arg_29_0)
	arg_29_0.selectFurnitureId = nil
	arg_29_0.selectSlotId = nil

	return
end

function var_0_1.GetDisplayFurnitures(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.room
	local var_30_1 = arg_30_0.normalZones[arg_30_0.zoneIndex]
	local var_30_2 = {
		var_30_1
	}

	unpack = var_1_10005
	var_30_2[2] = var_1_10005(arg_30_0.globalZones)
	_ = var_5

	local var_30_3 = var_5.reduce(var_30_2, {}, function(arg_31_0, arg_31_1)
		table = var_2_10002

		var_2_10002.insertto(arg_31_0, arg_31_1:GetSlots())

		return arg_31_0
	end)
	local var_30_4 = var_30_0:GetFurnitureIDList()
	local var_30_5 = var_30_0:GetFurnitures()
	local var_30_6 = {}
	local var_30_7 = {}

	_ = var_1_10010

	var_1_10010.each(var_30_4, function(arg_32_0)
		Dorm3dFurniture = var_2_10001

		local var_32_0 = var_2_10001.New({
			configId = arg_32_0
		})

		if arg_30_1 and var_32_0:GetType() ~= arg_30_1 then
			return
		end

		_ = var_2

		if not var_2.any(var_30_3, function(arg_33_0)
			return arg_33_0:CanUseFurniture(var_32_0)
		end) then
			return
		end

		table = var_2

		var_2.insert(var_30_7, {
			useable = 0,
			count = 0,
			id = arg_32_0,
			template = var_32_0
		})

		var_30_6[arg_32_0] = #var_30_7

		return
	end)

	_ = var_10

	var_10.each(var_30_5, function(arg_34_0)
		if arg_30_1 and arg_34_0:GetType() ~= arg_30_1 then
			return
		end

		_ = var_1

		if not var_1.any(var_30_3, function(arg_35_0)
			return arg_35_0:CanUseFurniture(arg_34_0)
		end) then
			return
		end

		local var_34_0 = arg_34_0:GetConfigID()

		var_2.count = var_30_7[var_30_6[var_34_0]].count + 1

		if arg_34_0:GetSlotID() == 0 then
			var_2.useable = var_2.useable + 1
		end

		Dorm3dFurniture = var_3
		var_2.viewedFlag = var_3.GetViewedFlag(var_34_0) ~= 0

		return
	end)

	_ = var_10

	return (var_10.filter(var_30_7, function(arg_36_0)
		local var_36_1

		if not (arg_36_0.count > 0) then
			local var_36_0 = arg_36_0.template

			var_36_1 = var_1.InShopTime(var_36_0)

			if false then
				var_36_1 = false
			end
		else
			var_36_1 = true
		end

		return var_36_1
	end))
end

function var_0_1.UpdateDataDisplayFurnitures(arg_37_0)
	local var_37_0 = arg_37_0.furnitureType

	Dorm3dFurniture = var_1_10002

	if var_37_0 == var_1_10002.TYPE.SPECIAL then
		_ = var_37_0
		arg_37_0.displayFurnitures = var_37_0.filter(arg_37_0:GetDisplayFurnitures(nil), function(arg_38_0)
			local var_38_0 = arg_38_0.template

			return var_1.IsSpecial(var_38_0)
		end)
	else
		arg_37_0.displayFurnitures = arg_37_0:GetDisplayFurnitures(arg_37_0.furnitureType)
	end

	return
end

function var_0_1.FilterDataFurnitures(arg_39_0)
	local var_39_0 = {
		function(arg_40_0)
			return arg_40_0.useable > 0 and 0 or 1
		end,
		function(arg_41_0)
			local var_41_0 = arg_41_0.template

			return -var_1.GetRarity(var_41_0)
		end,
		function(arg_42_0)
			local var_42_0 = arg_42_0.template

			return -var_1.GetTargetSlotID(var_42_0)
		end,
		function(arg_43_0)
			return -arg_43_0.id
		end
	}

	table = var_2

	local var_39_1 = var_2.sort
	local var_39_2 = arg_39_0.displayFurnitures

	CompareFuncs = var_1_10005

	var_39_1(var_39_2, var_1_10005(var_39_0))

	return
end

function var_0_1.InitViewZoneList(arg_44_0)
	local var_44_0 = arg_44_0.normalZones

	UIItemList = var_1_10002

	local var_44_1 = var_1_10002.StaticAlign
	local var_44_2 = arg_44_0.zoneList
	local var_44_3 = var_4.Find(var_44_2, "List")
	local var_44_4 = arg_44_0.zoneList
	local var_44_5 = var_5.Find(var_44_4, "List")

	var_44_1(var_44_3, var_5.GetChild(var_44_5, 0), #var_44_0, function(arg_45_0, arg_45_1, arg_45_2)
		UIItemList = var_2_10003

		if arg_45_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_45_1 = arg_45_1 + 1

		local var_45_0 = var_44_0[arg_45_1]

		arg_45_2.name = var_3.GetWatchCameraName(var_45_0)
		setText = var_4

		local var_45_1 = arg_45_2:Find("Name")
		local var_45_2 = var_3

		var_4(var_45_1, var_3.GetName(var_45_2))

		onButton = var_4

		local var_45_3 = arg_44_0
		local var_45_4 = arg_45_2

		local function var_45_5()
			arg_44_0.zoneIndex = arg_45_1

			local var_46_0 = arg_44_0

			var_0.UpdateDataZone(var_46_0)

			local var_46_1 = arg_44_0.scene

			var_0.SwitchFurnitureZone(var_46_1, var_0)

			local var_46_2 = arg_44_0

			var_0.InitViewTypeList(var_46_2)

			local var_46_3 = arg_44_0

			var_0.UpdateView(var_46_3)

			quickPlayAnimation = var_0

			var_0(arg_44_0._tf, "anim_dorm3d_furniture_change")

			setActive = var_0

			var_0(arg_44_0.zoneList, false)

			return
		end

		SFX_PANEL = var_45_2

		var_4(var_45_3, var_45_4, var_45_5, var_45_2)

		setActive = var_4

		var_4(arg_45_2:Find("Line"), arg_45_1 < #var_44_0)

		setActive = var_4

		var_4(arg_45_2:Find("New"), false)

		return
	end)

	return
end

function var_0_1.InitViewTypeList(arg_47_0)
	UIItemList = var_1_10001

	local var_47_0 = var_1_10001.StaticAlign
	local var_47_1 = arg_47_0._tf
	local var_47_2 = var_3.Find(var_47_1, "Right/Panel/Container/Types")
	local var_47_3 = arg_47_0._tf
	local var_47_4 = var_4.Find(var_47_3, "Right/Panel/Container/Types")

	var_47_0(var_47_2, var_4.GetChild(var_47_4, 0), #arg_47_0.activeFurnitureTypes, function(arg_48_0, arg_48_1, arg_48_2)
		UIItemList = var_2_10003

		if arg_48_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_48_1 = arg_48_1 + 1

		local var_48_0 = arg_47_0.activeFurnitureTypes[arg_48_1]

		setText = var_2_10004

		local var_48_1 = arg_48_2:Find("Name")

		i18n = var_2_10007
		Dorm3dFurniture = var_9

		var_2_10004(var_48_1, var_2_10007(var_9.TYPE2NAME[var_48_0]))

		onButton = var_2_10004

		local var_48_2 = arg_47_0
		local var_48_3 = arg_48_2

		local function var_48_4()
			if arg_47_0.furnitureType == var_48_0 then
				return
			end

			arg_47_0.furnitureType = var_48_0

			local var_49_0 = arg_47_0

			var_0.ResetSelectSetting(var_49_0)

			local var_49_1 = arg_47_0

			var_0.UpdateDataDisplayFurnitures(var_49_1)

			local var_49_2 = arg_47_0

			var_0.FilterDataFurnitures(var_49_2)

			local var_49_3 = arg_47_0

			var_0.UpdateView(var_49_3)

			quickPlayAnimation = var_0

			var_0(arg_47_0._tf, "anim_dorm3d_furniture_change")

			setActive = var_0

			var_0(arg_47_0.zoneList, false)

			return
		end

		SFX_PANEL = var_9

		var_2_10004(var_48_2, var_48_3, var_48_4, var_9)

		return
	end)

	return
end

function var_0_1.UpdateView(arg_50_0)
	local var_50_0 = arg_50_0.normalZones[arg_50_0.zoneIndex]

	setText = var_1_10003

	local var_50_1 = arg_50_0._tf

	var_1_10003(var_5.Find(var_50_1, "Right/Panel/Container/Zone/ZoneContainer/Name"), var_50_0:GetName())

	UIItemList = var_1_10003

	local var_50_2 = var_1_10003.StaticAlign
	local var_50_3 = arg_50_0.zoneList
	local var_50_4 = var_5.Find(var_50_3, "List")
	local var_50_5 = arg_50_0.zoneList
	local var_50_6 = var_6.Find(var_50_5, "List")

	var_50_2(var_50_4, var_6.GetChild(var_50_6, 0), #var_1, function(arg_51_0, arg_51_1, arg_51_2)
		UIItemList = var_2_10003

		if arg_51_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_51_1 = arg_51_1 + 1

		local var_51_0 = arg_51_2:Find("Name")
		local var_51_1 = var_3.GetComponent

		typeof = var_6
		Text = var_2_10008

		local var_51_2 = var_51_1(var_51_0, var_6(var_2_10008)).color

		if arg_50_0.zoneIndex == arg_51_1 then
			Color = var_51_3

			local var_51_3

			if not var_51_3.NewHex("39bfff") then
				Color = var_51_3
				var_51_3 = var_51_3.white
			end

			var_51_3.a = var_51_2.a
			setTextColor = var_5

			var_5(arg_51_2:Find("Name"), var_51_3)

			setActive = var_5

			var_5(arg_51_2:Find("New"), false)

			return
		end
	end)

	local var_50_7 = arg_50_0.room
	local var_50_8 = var_3.GetFurnitures(var_50_7)

	;(function()
		local var_52_0 = false

		table = var_2_10001

		var_2_10001.Ipairs(arg_50_0.normalZones, function(arg_53_0, arg_53_1)
			local var_53_0 = false

			if arg_53_1 ~= var_50_0 then
				_ = var_3
				var_53_0 = var_3.any(arg_53_1:GetSlots(), function(arg_54_0)
					_ = var_4_10001

					return var_4_10001.any(var_50_8, function(arg_55_0)
						local var_55_0 = arg_54_0

						if not var_1.CanUseFurniture(var_55_0, arg_55_0) then
							return
						end

						Dorm3dFurniture = var_1

						return var_1.GetViewedFlag(arg_55_0:GetConfigID()) == 0
					end)
				end)
			end

			setActive = var_3

			local var_53_1 = arg_50_0.zoneList
			local var_53_2 = var_5.Find(var_53_1, "List")
			local var_53_3 = var_5.GetChild(var_53_2, arg_53_0 - 1)

			var_3(var_5.Find(var_53_3, "New"), var_53_0)

			local var_53_4

			if not var_52_0 then
				var_53_4 = var_53_0
			end

			var_52_0 = var_53_4

			return
		end)

		setActive = var_1

		local var_52_1 = arg_50_0._tf

		var_1(var_3.Find(var_52_1, "Right/Panel/Container/Zone/ZoneContainer/Switch/New"), var_52_0)

		return
	end)()

	setActive = var_5

	local var_50_9 = arg_50_0._tf

	var_5(var_7.Find(var_50_9, "Right/Panel/Container/Types"), #arg_50_0.activeFurnitureTypes > 1)

	UIItemList = var_5

	local var_50_10 = var_5.StaticAlign
	local var_50_11 = arg_50_0._tf
	local var_50_12 = var_7.Find(var_50_11, "Right/Panel/Container/Types")
	local var_50_13 = arg_50_0._tf
	local var_50_14 = var_8.Find(var_50_13, "Right/Panel/Container/Types")

	var_50_10(var_50_12, var_8.GetChild(var_50_14, 0), #arg_50_0.activeFurnitureTypes, function(arg_56_0, arg_56_1, arg_56_2)
		UIItemList = var_2_10003

		if arg_56_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_56_1 = arg_56_1 + 1

		local var_56_0 = arg_50_0.activeFurnitureTypes[arg_56_1]

		setActive = var_2_10004

		var_2_10004(arg_56_2:Find("Selected"), arg_50_0.furnitureType == var_56_0)

		_ = var_2_10004

		local var_56_1 = var_2_10004.any
		local var_56_2 = var_50_0
		local var_56_3 = var_56_1(var_6.GetSlots(var_56_2), function(arg_57_0)
			_ = var_3_10001

			return var_3_10001.any(var_50_8, function(arg_58_0)
				if arg_58_0:GetType() ~= var_56_0 then
					return
				end

				local var_58_0 = arg_57_0

				if not var_1.CanUseFurniture(var_58_0, arg_58_0) then
					return
				end

				Dorm3dFurniture = var_1

				return var_1.GetViewedFlag(arg_58_0:GetConfigID()) == 0
			end)
		end)

		setActive = var_2_10005

		var_2_10005(arg_56_2:Find("New"), var_56_3)

		return
	end)

	arg_50_0.furnitureItems = {}

	local var_50_15 = arg_50_0.furnitureScroll

	var_5.SetTotalCount(var_50_15, #arg_50_0.displayFurnitures)

	setActive = var_5

	var_5(arg_50_0.furnitureEmpty, #arg_50_0.displayFurnitures == 0)

	if arg_50_0.timerRefreshShop then
		local var_50_16 = arg_50_0.timerRefreshShop

		var_5.Stop(var_50_16)
	end

	Timer = var_5
	arg_50_0.timerRefreshShop = var_5.New(function()
		table = var_2_10000

		var_2_10000.Foreach(arg_50_0.furnitureItems, function(arg_60_0, arg_60_1)
			local var_60_0 = arg_50_0

			var_2.UpdateViewFurnitureItem(var_60_0, arg_60_0)

			return
		end)

		return
	end, 1, -1)

	local var_50_17 = arg_50_0.timerRefreshShop

	var_5.Start(var_50_17)

	local var_50_18 = {}
	local var_50_19 = arg_50_0.furnitureType
	local var_50_20 = {
		var_50_0
	}

	unpack = var_8
	var_50_20[2] = var_8(arg_50_0.globalZones)
	_ = var_8

	local var_50_21 = var_8.reduce(var_50_20, {}, function(arg_61_0, arg_61_1)
		table = var_2_10002

		var_2_10002.insertto(arg_61_0, arg_61_1:GetSlots())

		return arg_61_0
	end)

	_ = var_9

	local var_50_22 = var_9.select(var_50_21, function(arg_62_0)
		return arg_62_0:GetType() == var_50_19
	end)

	_ = var_9

	var_9.each(var_50_22, function(arg_63_0)
		local var_63_0 = arg_63_0:GetConfigID()

		var_50_18[var_63_0] = 0

		return
	end)

	local var_50_23 = false

	if arg_50_0.selectSlotId then
		Dorm3dFurnitureSlot = var_10

		local var_50_24 = var_10.New({
			configId = arg_50_0.selectSlotId
		})
		local var_50_25 = var_10.GetType(var_50_24)

		Dorm3dFurniture = var_12

		if var_50_25 ~= var_12.TYPE.DECORATION then
			local var_50_26 = var_10:GetType()

			Dorm3dFurniture = var_12

			if var_50_26 == var_12.TYPE.SPECIAL then
				local var_50_27 = arg_50_0.room
				local var_50_28 = var_11.GetFurnitures(var_50_27)

				_ = var_12

				if var_12.detect(var_50_28, function(arg_64_0)
					local var_64_0 = arg_64_0:GetSlotID()
					local var_64_1 = var_0

					return var_64_0 == var_2.GetConfigID(var_64_1)
				end) then
					arg_50_0:CleanSlot()
				end
			end

			if not var_50_23 then
				arg_50_0.labelSettings = nil
			end

			setActive = var_10

			var_10(arg_50_0.lableTrans, var_50_23)

			local var_50_29 = arg_50_0.scene
			local var_50_30 = var_10.DisplayFurnitureSlots

			_ = var_13

			var_50_30(var_50_29, var_13.map(var_50_22, function(arg_65_0)
				return arg_65_0:GetConfigID()
			end))

			local var_50_31 = arg_50_0.scene

			var_10.UpdateDisplaySlots(var_50_31, var_50_18)

			local var_50_32 = arg_50_0.scene

			var_10.RefreshSlots(var_50_32, arg_50_0.room)

			return
		end
	end
end

function var_0_1.UpdateViewFurnitureItem(arg_66_0, arg_66_1)
	local var_66_0 = arg_66_0.furnitureItems[arg_66_1]
	local var_66_1 = arg_66_0.displayFurnitures[arg_66_1]

	if not var_66_0 then
		return
	end

	tf = var_1_10004

	local var_66_2 = var_1_10004(var_66_0)

	var_66_2.name = var_66_1.id
	updateCustomDrop = var_5

	local var_66_3 = var_66_2:Find("Item/Dorm3dIconTpl")

	Drop = var_1_10008

	local var_66_4 = var_1_10008.New
	local var_66_5 = {}

	DROP_TYPE_DORM3D_FURNITURE = var_1_10011
	var_66_5.type = var_1_10011
	var_66_5.id = var_66_1.id
	var_66_5.count = var_66_1.count

	var_5(var_66_3, var_66_4(var_66_5))

	setText = var_5

	local var_66_6 = var_66_2:Find("Item/Name")
	local var_66_7 = var_66_1.template

	var_5(var_66_6, var_8.GetName(var_66_7))

	i18n = var_5

	local var_66_8 = var_5("dorm3d_furniture_count", var_66_1.useable .. "/" .. var_66_1.count)

	if var_66_1.useable < var_66_1.count then
		i18n = var_6
		var_66_8 = var_6("dorm3d_furniture_used") .. var_66_8
	elseif var_66_1.count == 0 then
		i18n = var_6
		var_66_8 = var_6("dorm3d_furniture_lack") .. var_66_8
	end

	setText = var_6

	var_6(var_66_2:Find("Item/Count"), var_66_8)

	setActive = var_6

	var_6(var_66_2:Find("Selected"), arg_66_0.selectFurnitureId == var_66_1.id)

	setCanvasGroupAlpha = var_6

	var_6(var_66_2:Find("Item"), 1)

	local var_66_9 = var_66_1.template
	local var_66_10 = var_6.IsValuable(var_66_9)
	local var_66_11 = var_66_1.template
	local var_66_12 = var_7.IsSpecial(var_66_11)
	local var_66_13 = 0

	if var_66_12 then
		var_66_13 = 2
	elseif var_66_10 then
		var_66_13 = 1
	end

	setActive = var_66_11

	var_66_11(var_66_2:Find("Item/BG/Pro"), var_66_13 == 1)

	setActive = var_66_11

	var_66_11(var_66_2:Find("Item/LabelPro"), var_66_13 == 1)

	setActive = var_66_11

	var_66_11(var_66_2:Find("Item/BG/SP"), var_66_13 == 2)

	setActive = var_66_11

	var_66_11(var_66_2:Find("Item/LabelSP"), var_66_13 == 2)

	setActive = var_66_11

	var_66_11(var_66_2:Find("Item/Action"), false)

	local var_66_14 = var_66_1.template
	local var_66_15 = var_9.GetEndTime(var_66_14)

	if var_66_1.count == 0 and 0 < var_66_15 then
		pg = var_10

		local var_66_16 = var_10.TimeMgr.GetInstance()
		local var_66_17

		if not (var_66_15 > var_10.GetServerTime(var_66_16)) then
			var_66_17 = false
		else
			var_66_17 = true
		end

		setActive = var_66_14

		var_66_14(var_66_2:Find("TimeLimit"), var_66_17)

		if var_66_17 then
			setText = var_66_14

			local var_66_18 = var_66_2:Find("TimeLimit/Text")

			skinCommdityTimeStamp = var_14

			var_66_14(var_66_18, var_14(var_66_15))
		end

		onButton = var_66_14

		local var_66_19 = arg_66_0
		local var_66_20 = var_66_2
		local var_66_21 = var_66_2.Find(var_66_20, "Item/Tip")

		local function var_66_22()
			local var_67_0 = arg_66_0
			local var_67_1 = var_0.emit

			Dorm3dFurnitureSelectMediator = var_2_10003

			local var_67_2 = var_2_10003.SHOW_FURNITURE_ACESSES
			local var_67_3 = {
				showGOBtn = true
			}

			i18n = var_2_10005
			var_67_3.title = var_2_10005("courtyard_label_detail")

			local var_67_4 = {}

			DROP_TYPE_DORM3D_FURNITURE = var_2_10006
			var_67_4.type = var_2_10006
			var_67_4.id = var_66_1.id
			var_67_4.count = var_66_1.count
			var_67_3.drop = var_67_4

			local var_67_5 = var_66_1.template

			var_67_3.list = var_5.GetAcesses(var_67_5)

			var_67_1(var_67_0, var_67_2, var_67_3)

			return
		end

		SFX_PANEL = var_66_20

		var_66_14(var_66_19, var_66_21, var_66_22, var_66_20)

		local var_66_23 = var_66_1.count
		local var_66_24 = 0 < var_66_23 and not var_66_1.viewedFlag

		setActive = var_12

		var_12(var_66_2:Find("Item/New"), var_66_24)

		if var_66_24 then
			Dorm3dFurniture = var_12

			var_12.SetViewedFlag(var_66_1.id)
		end

		onButton = var_12

		var_12(arg_66_0, var_66_2, function()
			if var_66_1.count > 0 then
				setActive = var_0

				local var_68_0 = var_66_2

				var_0(var_2.Find(var_68_0, "Item/New"), false)

				var_66_1.viewedFlag = true
			end

			local var_68_1 = var_66_1.template
			local var_68_2 = var_0.GetTargetSlotID(var_68_1)

			arg_66_0.selectSlotId = nil

			if var_66_1.useable > 0 then
				local var_68_3 = arg_66_0.room

				var_1.ReplaceFurniture(var_68_3, var_68_2, var_66_1.id)

				table = var_1

				var_1.insert(arg_66_0.replaceFurnitures, {
					slotId = var_68_2,
					furnitureId = var_66_1.id
				})

				local var_68_4 = arg_66_0

				var_1.UpdateDataDisplayFurnitures(var_68_4)

				local var_68_5 = arg_66_0

				var_1.UpdateView(var_68_5)

				pg = var_1

				local var_68_6 = var_1.CriMgr.GetInstance()

				var_1.PlaySE_V3(var_68_6, "ui-dorm_furniture_placement")
			elseif var_66_1.useable < var_66_1.count then
				arg_66_0.selectSlotId = var_68_2

				local var_68_7 = arg_66_0

				var_1.UpdateView(var_68_7)
			end

			return
		end)

		if var_66_1.count == 0 then
			local var_66_25 = var_66_1.template
			local var_66_26

			if not var_12.GetShopID(var_66_25) then
				var_66_26 = 0
			end

			setActive = var_66_19

			local var_66_27 = var_66_2

			var_66_19(var_66_2.Find(var_66_27, "GO"), var_66_26 ~= 0)

			if var_66_26 ~= 0 then
				CommonCommodity = var_66_19

				local var_66_28 = var_66_19.New
				local var_66_29 = {
					id = var_66_26
				}

				Goods = var_16

				local var_66_30 = var_66_28(var_66_29, var_16.TYPE_SHOPSTREET)
				local var_66_31, var_66_32, var_66_33 = var_13.GetPrice(var_66_30)

				Drop = var_66_27

				local var_66_34 = var_66_27.New
				local var_66_35 = {}

				DROP_TYPE_RESOURCE = var_1_10020
				var_66_35.type = var_1_10020
				var_66_35.id = var_13:GetResType()
				var_66_35.count = var_66_31

				local var_66_36 = var_66_34(var_66_35)

				pg = var_18

				local var_66_37 = var_18.shop_template[var_66_26]

				onButton = var_66_35

				local var_66_38 = arg_66_0
				local var_66_39 = var_66_2
				local var_66_40 = var_66_2.Find(var_66_39, "GO")

				local function var_66_41()
					local var_69_0 = var_66_1.template
					local var_69_1 = var_0.GetEndTime(var_69_0)
					local var_69_2 = arg_66_0
					local var_69_3 = var_1.emit

					Dorm3dFurnitureSelectMediator = var_2_10004

					local var_69_4 = var_2_10004.SHOW_SHOPPING_CONFIRM_WINDOW
					local var_69_5 = {}
					local var_69_6 = {}
					local var_69_7 = "<icon name="
					local var_69_8 = var_0

					var_69_6.icon = var_69_7 .. var_8.GetResIcon(var_69_8) .. " w=1.1 h=1.1/>"
					var_69_6.off = var_66_32
					var_69_6.cost = var_66_36.count
					var_69_6.old = var_66_33

					local var_69_9 = var_66_1.template

					var_69_6.name = var_7.GetName(var_69_9)
					var_69_5.content = var_69_6
					i18n = var_69_6
					var_69_5.tip = var_69_6("dorm3d_shop_gift_tip")
					var_69_5.drop = var_66_1.template
					var_69_5.endTime = var_69_1

					function var_69_5.onYes()
						local var_70_0 = var_66_1.template

						if not var_0.InShopTime(var_70_0) then
							pg = var_0

							local var_70_1 = var_0.TipsMgr.GetInstance()
							local var_70_2 = var_0.ShowTips

							i18n = var_3_10003

							var_70_2(var_70_1, var_3_10003("dorm3d_purchase_outtime"))

							return
						end

						local var_70_3 = arg_66_0
						local var_70_4 = var_0.emit

						GAME = var_3_10003

						var_70_4(var_70_3, var_3_10003.SHOPPING, {
							silentTip = true,
							count = 1,
							shopId = var_66_26
						})

						return
					end

					var_69_3(var_69_2, var_69_4, var_69_5)

					return
				end

				SFX_PANEL = var_66_39

				var_66_35(var_66_38, var_66_40, var_66_41, var_66_39)
			end

			return
		end
	end
end

function var_0_1.CleanSlot(arg_71_0)
	if not arg_71_0.selectSlotId then
		return
	end

	local var_71_0 = arg_71_0.selectSlotId
	local var_71_1 = arg_71_0.room

	var_2.ReplaceFurniture(var_71_1, var_71_0, 0)

	table = var_2

	var_2.insert(arg_71_0.replaceFurnitures, {
		furnitureId = 0,
		slotId = var_71_0
	})
	arg_71_0:ResetSelectSetting()
	arg_71_0:UpdateDataDisplayFurnitures()
	arg_71_0:UpdateView()

	return
end

function var_0_1.OnReplaceFurnitureDone(arg_72_0)
	arg_72_0.replaceFurnitures = {}
	existCall = var_1

	var_1(arg_72_0.replaceFurnitureCallback)

	arg_72_0.replaceFurnitureCallback = nil

	return
end

function var_0_1.OnReplaceFurnitureError(arg_73_0)
	arg_73_0.replaceFurnitureCallback = nil

	return
end

function var_0_1.AutoReplaceFurniture(arg_74_0)
	local var_74_0 = arg_74_0.normalZones[arg_74_0.zoneIndex]
	local var_74_1 = var_1.GetSlots(var_74_0)

	_ = var_1_10003

	var_1_10003.each(var_74_1, function(arg_75_0)
		local var_75_0 = arg_75_0:GetType()

		Dorm3dFurniture = var_2_10002

		if var_75_0 ~= var_2_10002.TYPE.FLOOR then
			local var_75_1 = arg_75_0:GetType()

			Dorm3dFurniture = var_2

			if var_75_1 == var_2.TYPE.WALLPAPER then
				return
			end

			local var_75_2 = arg_74_0.room
			local var_75_3 = var_1.GetFurnitures(var_75_2)

			_ = var_2

			if var_2.detect(var_75_3, function(arg_76_0)
				local var_76_0 = arg_76_0:GetSlotID()
				local var_76_1 = arg_75_0

				return var_76_0 == var_2.GetConfigID(var_76_1)
			end) and var_2:GetConfigID() ~= arg_75_0:GetDefaultFurniture() then
				return
			end

			table = var_75_2

			local var_75_4 = var_75_2.shallowCopy(var_75_3)
			local var_75_5 = {
				function(arg_77_0)
					local var_77_1

					if arg_77_0:GetSlotID() == 0 then
						local var_77_0 = arg_75_0

						if var_1.CanUseFurniture(var_77_0, arg_77_0) then
							var_77_1 = 0

							goto label_77_0
						end
					end

					var_77_1 = 1

					::label_77_0::

					return var_77_1
				end,
				function(arg_78_0)
					return -arg_78_0:GetRarity()
				end,
				function(arg_79_0)
					return -arg_79_0:GetConfigID()
				end
			}

			table = var_4

			local var_75_6 = var_4.sort
			local var_75_7 = var_75_4

			CompareFuncs = var_2_10007

			var_75_6(var_75_7, var_2_10007(var_75_5))

			if not var_75_4[1] or var_4:GetSlotID() ~= 0 or not arg_75_0:CanUseFurniture(var_4) then
				return
			end

			local var_75_8 = arg_74_0.room

			var_5.ReplaceFurniture(var_75_8, arg_75_0:GetConfigID(), var_4:GetConfigID())

			table = var_5

			var_5.insert(arg_74_0.replaceFurnitures, {
				slotId = arg_75_0:GetConfigID(),
				furnitureId = var_4:GetConfigID()
			})

			return
		end
	end)
	arg_74_0:ResetSelectSetting()
	arg_74_0:UpdateDataDisplayFurnitures()
	arg_74_0:UpdateView()

	return
end

function var_0_1.ShowReplaceWindow(arg_80_0, arg_80_1, arg_80_2)
	if #arg_80_0.replaceFurnitures == 0 then
		existCall = var_4

		return var_4(arg_80_1)
	end

	local var_80_0 = arg_80_0
	local var_80_1 = arg_80_0.emit

	Dorm3dFurnitureSelectMediator = var_1_10007

	local var_80_2 = var_1_10007.SHOW_CONFIRM_WINDOW
	local var_80_3 = {}

	i18n = var_1_10009
	var_80_3.title = var_1_10009("title_info")
	i18n = var_9
	var_80_3.content = var_9("dorm3d_furniture_sure_save")

	function var_80_3.onYes()
		local var_81_0 = arg_80_0
		local var_81_1 = var_0.emit

		GAME = var_2_10003

		local var_81_2 = var_2_10003.APARTMENT_REPLACE_FURNITURE
		local var_81_3 = {}
		local var_81_4 = arg_80_0.room

		var_81_3.roomId = var_5.GetConfigID(var_81_4)
		var_81_3.furnitures = var_0

		var_81_1(var_81_0, var_81_2, var_81_3)

		arg_80_0.replaceFurnitureCallback = arg_80_1

		return
	end

	var_80_3.onNo = arg_80_2

	var_80_1(var_80_0, var_80_2, var_80_3)

	return
end

function var_0_1.onBackPressed(arg_82_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_83_0)
			local var_83_0 = arg_82_0

			var_1.ShowReplaceWindow(var_83_0, arg_83_0, arg_83_0)

			return
		end,
		function(arg_84_0)
			GetOrAddComponent = var_2_10001

			local var_84_0 = arg_82_0._tf

			typeof = var_2_10004
			CanvasGroup = var_2_10006
			var_2_10001(var_84_0, var_2_10004(var_2_10006)).alpha = 0

			local var_84_1 = arg_82_0.scene

			var_1.ExitFurnitureWatchMode(var_84_1, function()
				var_0_1.super.onBackPressed(arg_82_0)

				return
			end)

			return
		end
	})

	return
end

function var_0_1.willExit(arg_86_0)
	arg_86_0.furnitureScroll.enabled = false

	if arg_86_0.timerRefreshShop then
		local var_86_0 = arg_86_0.timerRefreshShop

		var_1.Stop(var_86_0)
	end

	UpdateBeat = var_1

	var_1:RemoveListener(arg_86_0.updateHandler)

	return
end

return var_0_1
