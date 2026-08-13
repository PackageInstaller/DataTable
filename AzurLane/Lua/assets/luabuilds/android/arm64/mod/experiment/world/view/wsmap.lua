class = var_0_10000

local var_0_0 = "WSMap"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	map = "table",
	rtTargetArrow = "userdata",
	transform = "userdata",
	wsMapArtifactsFA = "table",
	wsMapFleets = "table",
	wsMapCells = "table",
	wsMapAttachments = "table",
	wsTerrainEffects = "table",
	rtTop = "userdata",
	rtQuads = "userdata",
	wsCarryItems = "table",
	rtEffectA = "userdata",
	wsMapQuads = "table",
	wsMapPath = "table",
	wsMapResource = "table",
	twTimerId = "number",
	wsMapArtifacts = "table",
	twTimer = "userdata",
	world = "table",
	rtItems = "userdata",
	wsPool = "table",
	rtEffectB = "userdata",
	rtCells = "userdata",
	displayRangeLines = "table",
	wsTimer = "table",
	displayRangeTimer = "table",
	transportDisplay = "number",
	wsMapItems = "table",
	rangeVisible = "boolean",
	wsMapTransports = "table",
	rtEffectC = "userdata"
}
var_0_1.Listeners = {
	onRemoveCarry = "OnRemoveCarry",
	onUpdateTerrain = "OnUpdateTerrain",
	onUpdateAttachment = "OnUpdateAttachment",
	onUpdateFleetFOV = "OnUpdateFleetFOV",
	onAddAttachment = "OnAddAttachment",
	onRemoveAttachment = "OnRemoveAttachment",
	onAddCarry = "OnAddCarry"
}
var_0_1.EventUpdateEventTips = "WSMap.EventUpdateEventTips"

function var_0_1.Setup(arg_1_0, arg_1_1)
	arg_1_0.map = arg_1_1
	arg_1_0.wsMapQuads = {}
	arg_1_0.wsMapItems = {}
	arg_1_0.wsMapCells = {}
	arg_1_0.wsMapFleets = {}
	arg_1_0.wsMapArtifacts = {}
	arg_1_0.wsMapArtifactsFA = {}
	arg_1_0.wsMapTransports = {}
	arg_1_0.wsMapAttachments = {}
	arg_1_0.wsTerrainEffects = {}
	arg_1_0.wsCarryItems = {}
	WSMapPath = var_2
	arg_1_0.wsMapPath = var_2.New()

	local var_1_0 = arg_1_0.wsMapPath

	var_2.Setup(var_1_0, arg_1_0.map.theme)

	WSMapResource = var_2
	arg_1_0.wsMapResource = var_2.New()

	local var_1_1 = arg_1_0.wsMapResource

	var_2.Setup(var_1_1, arg_1_0.map)

	WorldConst = var_2
	arg_1_0.transportDisplay = var_2.TransportDisplayNormal
	pg = var_2

	var_2.DelegateInfo.New(arg_1_0)

	return
end

function var_0_1.Dispose(arg_2_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_2_0)

	local var_2_0 = arg_2_0.wsMapPath

	var_1.Dispose(var_2_0)
	arg_2_0:ClearTargetArrow()
	arg_2_0:Unload()
	arg_2_0:Clear()

	return
end

function var_0_1.Load(arg_3_0, arg_3_1)
	local var_3_0 = {}

	table = var_1_10003

	var_1_10003.insert(var_3_0, function(arg_4_0)
		local var_4_0 = arg_3_0

		var_1.InitPlane(var_4_0, arg_4_0)

		return
	end)

	table = var_3

	var_3.insert(var_3_0, function(arg_5_0)
		local var_5_0 = arg_3_0.wsMapResource

		var_1.Load(var_5_0, arg_5_0)

		return
	end)

	table = var_3

	var_3.insert(var_3_0, function(arg_6_0)
		local var_6_0 = arg_3_0

		var_1.InitClutter(var_6_0)

		local var_6_1 = arg_3_0

		var_1.InitMap(var_6_1)
		arg_6_0()

		return
	end)

	seriesAsync = var_3

	var_3(var_3_0, arg_3_1)

	return
end

function var_0_1.Unload(arg_7_0)
	arg_7_0:DisposeMap()

	local var_7_0 = arg_7_0.wsMapResource

	var_1.Unload(var_7_0)

	if arg_7_0.transform then
		PoolMgr = var_1

		local var_7_1 = var_1.GetInstance()

		var_1.ReturnPrefab(var_7_1, "world/object/world_plane", "world_plane", arg_7_0.transform.gameObject, true)

		arg_7_0.transform = nil
	end

	return
end

function var_0_1.InitPlane(arg_8_0, arg_8_1)
	PoolMgr = var_1_10002

	local var_8_0 = var_1_10002.GetInstance()

	var_2.GetPrefab(var_8_0, "world/object/world_plane", "world_plane", true, function(arg_9_0)
		local var_9_0 = arg_8_0

		var_9_0.transform = arg_9_0.transform
		setActive = var_9_0

		var_9_0(arg_8_0.transform, false)

		local var_9_1 = arg_8_0
		local var_9_2 = arg_8_0.transform

		var_9_1.rtQuads = var_2.Find(var_9_2, "quads")

		local var_9_3 = arg_8_0
		local var_9_4 = arg_8_0.transform

		var_9_3.rtItems = var_2.Find(var_9_4, "items")

		local var_9_5 = arg_8_0
		local var_9_6 = arg_8_0.transform

		var_9_5.rtCells = var_2.Find(var_9_6, "cells")

		local var_9_7 = arg_8_0
		local var_9_8 = arg_8_0.transform

		var_9_7.rtTop = var_2.Find(var_9_8, "top")

		local var_9_9 = arg_8_0
		local var_9_10 = arg_8_0.transform

		var_9_9.rtEffectA = var_2.Find(var_9_10, "effect-a-1-999")

		local var_9_11 = arg_8_0
		local var_9_12 = arg_8_0.transform

		var_9_11.rtEffectB = var_2.Find(var_9_12, "effect-b-1001-1999")

		local var_9_13 = arg_8_0
		local var_9_14 = arg_8_0.transform

		var_9_13.rtEffectC = var_2.Find(var_9_14, "effect-c-2001-2999")

		local var_9_15 = arg_8_0.map

		assert = var_2

		var_2(var_9_15 and var_9_15.active, "map not exist or map not active.")

		local var_9_16 = var_9_15.theme
		local var_9_17 = arg_8_0.transform

		var_9_17.name = "plane"
		Vector3 = var_4

		local var_9_18 = var_4(var_9_16.offsetx, var_9_16.offsety, var_9_16.offsetz)

		WorldConst = var_5
		var_9_17.anchoredPosition3D = var_9_18 + var_5.DefaultMapOffset

		local var_9_19 = var_9_17
		local var_9_20 = var_9_17.Find(var_9_19, "display")
		local var_9_21 = var_4.Find(var_9_20, "mask/sea")

		setImageAlpha = var_9_19

		var_9_19(var_9_21, 0)

		GetSpriteFromAtlasAsync = var_9_19

		var_9_19("chapter/pic/" .. var_9_16.assetSea, var_9_16.assetSea, function(arg_10_0)
			if var_9_21 then
				setImageSprite = var_1

				var_1(var_9_21, arg_10_0, false)

				setImageAlpha = var_1

				var_1(var_9_21, 1)
			end

			return
		end)

		Vector2 = var_9_19

		local var_9_22 = var_9_19(10000, 10000)

		Vector2 = var_9_20

		local var_9_23 = var_9_20.zero

		Vector2 = var_8
		WorldConst = var_10

		local var_9_24 = var_10.MaxColumn

		WorldConst = var_2_10011

		local var_9_25 = var_8(var_9_24, var_2_10011.MaxRow)

		Vector2 = var_9
		WorldConst = var_11

		local var_9_26 = -var_11.MaxColumn

		WorldConst = var_2_10012

		local var_9_27 = var_9(var_9_26, -var_2_10012.MaxRow)
		local var_9_28 = 0

		WorldConst = var_9_26

		for iter_9_0 = var_9_28, var_9_26.MaxRow - 1 do
			var_2_10014 = 0
			WorldConst = var_2_10015

			for iter_9_1 = var_2_10014, var_2_10015.MaxColumn - 1 do
				var_2_10020 = var_9_15

				if var_9_15.GetCell(var_2_10020, iter_9_0, iter_9_1) then
					math = var_2_10019
					var_9_22.x = var_2_10019.min(var_9_22.x, iter_9_1)
					math = var_2_10019
					var_2_10019 = var_2_10019.min
					var_2_10021 = var_9_22.y
					WorldConst = var_2_10022
					var_9_22.y = var_2_10019(var_2_10021, var_2_10022.MaxRow * 0.5 - iter_9_0 - 1)
					math = var_2_10019
					var_9_25.x = var_2_10019.min(var_9_25.x, iter_9_1)
					math = var_2_10019
					var_9_25.y = var_2_10019.min(var_9_25.y, iter_9_0)
					math = var_2_10019
					var_9_27.x = var_2_10019.max(var_9_27.x, iter_9_1)
					math = var_2_10019
					var_9_27.y = var_2_10019.max(var_9_27.y, iter_9_0)
				end
			end
		end

		local var_9_29 = var_9_16.cellSize + var_9_16.cellSpace

		var_9_22.x = var_9_22.x * var_9_29.x
		var_9_22.y = var_9_22.y * var_9_29.y
		var_9_23.x = (var_9_27.x - var_9_25.x + 1) * var_9_29.x
		var_9_23.y = (var_9_27.y - var_9_25.y + 1) * var_9_29.y
		var_4.anchoredPosition = var_9_22 + var_9_23 * 0.5
		var_4.sizeDelta = var_9_23
		Vector2 = var_11
		math = iter_9_0

		local var_9_30 = iter_9_0.floor(var_4.sizeDelta.x / var_9_29.x)

		math = var_2_10014

		local var_9_31 = var_11(var_9_30, var_2_10014.floor(var_4.sizeDelta.y / var_9_29.y))
		local var_9_32 = var_4:Find("linev")
		local var_9_33 = var_12.GetChild(var_9_32, 0)
		local var_9_34 = var_12
		local var_9_35 = var_12.GetComponent

		typeof = var_17
		GridLayoutGroup = var_2_10019

		local var_9_36 = var_9_35(var_9_34, var_17(var_2_10019))

		Vector2 = var_9_32
		WorldConst = var_17
		var_9_36.cellSize = var_9_32(var_17.LineCross, var_4.sizeDelta.y)
		Vector2 = var_15

		local var_9_37 = var_9_29.x

		WorldConst = var_18
		var_9_36.spacing = var_15(var_9_37 - var_18.LineCross, 0)

		local var_9_38 = var_9_36.padding

		math = var_9_34
		var_9_38.left = var_9_34.floor(var_9_36.spacing.x)

		local var_9_39 = var_12.childCount - 1

		math = var_16

		for iter_9_2 = var_9_39, var_16.max(var_9_31.x - 1, 0), -1 do
			if 0 < iter_9_2 then
				Destroy = var_19

				var_19(var_12:GetChild(iter_9_2))
			end
		end

		for iter_9_3 = var_12.childCount, var_9_31.x - 2 do
			Instantiate = var_19
			var_2_10021 = var_19(var_9_33).transform

			var_19.SetParent(var_2_10021, var_12, false)
		end

		local var_9_40 = var_4:Find("lineh")
		local var_9_41 = var_15.GetChild(var_9_40, 0)
		local var_9_42 = var_15
		local var_9_43 = var_15.GetComponent

		typeof = var_2_10020
		GridLayoutGroup = var_2_10022

		local var_9_44 = var_9_43(var_9_42, var_2_10020(var_2_10022))

		Vector2 = var_9_40

		local var_9_45 = var_4.sizeDelta.x

		WorldConst = var_2_10021
		var_9_44.cellSize = var_9_40(var_9_45, var_2_10021.LineCross)
		Vector2 = var_18

		local var_9_46 = 0
		local var_9_47 = var_9_29.y

		WorldConst = var_2_10022
		var_9_44.spacing = var_18(var_9_46, var_9_47 - var_2_10022.LineCross)

		local var_9_48 = var_9_44.padding

		math = var_9_42
		var_9_48.top = var_9_42.floor(var_9_44.spacing.y)

		local var_9_49 = var_15.childCount - 1

		math = var_19

		for iter_9_4 = var_9_49, var_19.max(var_9_31.y - 1, 0), -1 do
			if 0 < iter_9_4 then
				Destroy = var_22

				var_22(var_15:GetChild(iter_9_4))
			end
		end

		for iter_9_5 = var_15.childCount, var_9_31.y - 2 do
			Instantiate = var_22

			local var_9_50 = var_22(var_9_41).transform

			var_22.SetParent(var_9_50, var_15, false)
		end

		arg_8_1()

		return
	end)

	return
end

function var_0_1.InitClutter(arg_11_0)
	LeanTween = var_1_10001

	local var_11_0 = var_1_10001.value
	local var_11_1 = arg_11_0.transform.gameObject
	local var_11_2 = 1
	local var_11_3 = 0

	WorldConst = var_1_10006

	local var_11_4 = var_11_0(var_11_1, var_11_2, var_11_3, var_1_10006.QuadBlinkDuration)
	local var_11_5 = var_1.setEase

	LeanTweenType = var_11_2

	local var_11_6 = var_11_5(var_11_4, var_11_2.easeInOutSine)

	arg_11_0.twTimer = var_1.setLoopPingPong(var_11_6)

	local var_11_7 = arg_11_0.wsTimer

	var_1.AddInMapTween(var_11_7, arg_11_0.twTimer.uniqueId)
	arg_11_0:NewTargetArrow()

	return
end

function var_0_1.InitMap(arg_12_0)
	local var_12_0 = arg_12_0.map.theme

	_ = var_1_10003

	local var_12_1 = var_1_10003.values(var_1.cells)

	table = var_1_10004

	var_1_10004.sort(var_12_1, function(arg_13_0, arg_13_1)
		return arg_13_0.row < arg_13_1.row or arg_13_0.row == arg_13_1.row and arg_13_0.column < arg_13_1.column
	end)

	ipairs = var_4

	for iter_12_0, iter_12_1 in var_4(var_12_1) do
		local var_12_2 = arg_12_0

		var_1_10009 = arg_12_0.NewQuad(var_12_2, iter_12_1)
		var_1_10010 = arg_12_0.wsMapQuads
		WSMapQuad = var_12_2
		var_1_10010[var_12_2.GetName(iter_12_1.row, iter_12_1.column)] = var_1_10009

		local var_12_3 = arg_12_0

		var_1_10010 = arg_12_0.NewCell(var_12_3, iter_12_1)

		local var_12_4 = arg_12_0.wsMapCells

		WSMapCell = var_12_3
		var_12_4[var_12_3.GetName(iter_12_1.row, iter_12_1.column)] = var_1_10010
	end

	ipairs = var_4

	for iter_12_2, iter_12_3 in var_4(var_1.config.float_items) do
		var_1_10009 = iter_12_3[1]
		var_1_10010 = iter_12_3[2]

		if var_1:GetCell(var_1_10009, var_1_10010) then
			local var_12_5 = arg_12_0
			local var_12_6

			if not arg_12_0.GetItem(var_12_5, var_1_10009, var_1_10010) then
				var_12_6 = arg_12_0:NewItem(var_11)

				local var_12_7 = arg_12_0.wsMapItems

				WSMapItem = var_12_5
				var_12_7[var_12_5.GetName(var_11.row, var_11.column)] = var_12_6
			end

			local var_12_8 = arg_12_0:NewArtifact(var_12_6, iter_12_3)

			table = var_12_5

			var_12_5.insert(arg_12_0.wsMapArtifacts, var_12_8)
		end
	end

	ipairs = var_4

	for iter_12_4, iter_12_5 in var_4(var_12_1) do
		ipairs = var_1_10009

		for iter_12_6, iter_12_7 in var_1_10009(iter_12_5.attachments) do
			var_1_10016 = arg_12_0

			local var_12_9 = arg_12_0.GetCell(var_1_10016, iter_12_7.row, iter_12_7.column)
			local var_12_10 = iter_12_7.type

			WorldMapAttachment = var_1_10016

			if var_12_10 == var_1_10016.TypeArtifact then
				local var_12_11 = arg_12_0
				local var_12_12

				if not arg_12_0.GetItem(var_12_11, iter_12_5.row, iter_12_5.column) then
					var_12_12 = arg_12_0:NewItem(iter_12_5)
					var_1_10016 = arg_12_0.wsMapItems
					WSMapItem = var_12_11
					var_1_10016[var_12_11.GetName(iter_12_5.row, iter_12_5.column)] = var_12_12
				end

				var_1_10016 = arg_12_0:NewArtifact(var_12_12, iter_12_7:GetArtifaceInfo(), iter_12_7)
				table = var_12_11

				var_12_11.insert(arg_12_0.wsMapArtifactsFA, var_1_10016)
			else
				local var_12_13 = arg_12_0:NewAttachment(var_12_9, iter_12_7)

				table = var_1_10016

				var_1_10016.insert(arg_12_0.wsMapAttachments, var_12_13)
			end
		end
	end

	ipairs = var_4

	for iter_12_8, iter_12_9 in var_4(var_1:GetNormalFleets()) do
		local var_12_14 = arg_12_0:NewFleet(iter_12_9)

		table = var_1_10010

		var_1_10010.insert(arg_12_0.wsMapFleets, var_12_14)

		ipairs = var_1_10010

		for iter_12_10, iter_12_11 in var_1_10010(iter_12_9:GetCarries()) do
			local var_12_15 = arg_12_0:NewCarryItem(iter_12_9, iter_12_11)

			table = var_1_10016

			var_1_10016.insert(arg_12_0.wsCarryItems, var_12_15)
		end
	end

	arg_12_0:FlushFleets()

	local var_12_16 = var_1
	local var_12_17 = var_1.AddListener

	WorldMap = iter_12_8

	var_12_17(var_12_16, iter_12_8.EventUpdateFleetFOV, arg_12_0.onUpdateFleetFOV)

	return
end

function var_0_1.DisposeMap(arg_14_0)
	local var_14_0 = arg_14_0.map
	local var_14_1 = var_1.RemoveListener

	WorldMap = var_1_10004

	var_14_1(var_14_0, var_1_10004.EventUpdateFleetFOV, arg_14_0.onUpdateFleetFOV)

	_ = var_14_1

	var_14_1.each(arg_14_0.wsCarryItems, function(arg_15_0)
		local var_15_0 = arg_14_0

		var_1.DisposeCarryItem(var_15_0, arg_15_0)

		return
	end)

	arg_14_0.wsCarryItems = {}
	_ = var_1

	var_1.each(arg_14_0.wsMapFleets, function(arg_16_0)
		local var_16_0 = arg_14_0

		var_1.DisposeFleet(var_16_0, arg_16_0)

		return
	end)

	arg_14_0.wsMapFleets = {}
	_ = var_1

	var_1.each(arg_14_0.wsMapAttachments, function(arg_17_0)
		local var_17_0 = arg_14_0

		var_1.DisposeAttachment(var_17_0, arg_17_0)

		return
	end)

	arg_14_0.wsMapAttachments = {}
	_ = var_1

	var_1.each(arg_14_0.wsMapArtifacts, function(arg_18_0)
		local var_18_0 = arg_14_0

		var_1.DisposeArtifact(var_18_0, arg_18_0)

		return
	end)

	arg_14_0.wsMapArtifacts = {}
	pairs = var_1

	for iter_14_0, iter_14_1 in var_1(arg_14_0.wsMapTransports) do
		arg_14_0:DisposeTransport(iter_14_1)
	end

	arg_14_0.wsMapTransports = {}
	_ = var_1

	var_1.each(arg_14_0.wsMapArtifactsFA, function(arg_19_0)
		local var_19_0 = arg_14_0

		var_1.DisposeArtifact(var_19_0, arg_19_0)

		return
	end)

	arg_14_0.wsMapArtifactsFA = {}
	pairs = var_1

	for iter_14_2, iter_14_3 in var_1(arg_14_0.wsMapCells) do
		arg_14_0:DisposeCell(iter_14_3)
	end

	arg_14_0.wsMapCells = {}
	pairs = var_1

	for iter_14_4, iter_14_5 in var_1(arg_14_0.wsMapItems) do
		arg_14_0:DisposeItem(iter_14_5)
	end

	arg_14_0.wsMapItems = {}
	pairs = var_1

	for iter_14_6, iter_14_7 in var_1(arg_14_0.wsMapQuads) do
		arg_14_0:DisposeQuad(iter_14_7)
	end

	arg_14_0.wsMapQuads = {}
	ipairs = var_1

	for iter_14_8, iter_14_9 in var_1(arg_14_0.wsTerrainEffects) do
		arg_14_0:DisposeTerrainEffect(iter_14_9)
	end

	arg_14_0.wsTerrainEffects = {}

	return
end

function var_0_1.OnAddAttachment(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.GetCell(var_20_0, arg_20_2.row, arg_20_2.column)

	assert = var_1_10005

	var_1_10005(var_20_1, "cell not exist: " .. arg_20_2.row .. ", " .. arg_20_2.column)

	local var_20_2 = arg_20_3.type

	WorldMapAttachment = var_20_0

	local var_20_5

	if var_20_2 == var_20_0.TypeArtifact then
		local var_20_3 = arg_20_0
		local var_20_4

		if not arg_20_0.GetItem(var_20_3, arg_20_2.row, arg_20_2.column) then
			var_20_4 = arg_20_0:NewItem(arg_20_2)
			var_20_5 = arg_20_0.wsMapItems
			WSMapItem = var_20_3
			var_20_5[var_20_3.GetName(arg_20_2.row, arg_20_2.column)] = var_20_4
		end

		var_20_5 = arg_20_0:NewArtifact(var_20_4, arg_20_3:GetArtifaceInfo(), arg_20_3)
		table = var_20_3

		var_20_3.insert(arg_20_0.wsMapArtifactsFA, var_20_5)
	else
		local var_20_6 = arg_20_0:NewAttachment(var_20_1, arg_20_3)

		table = var_20_5

		var_20_5.insert(arg_20_0.wsMapAttachments, var_20_6)
		arg_20_0:OnUpdateAttachment(nil, arg_20_3)
	end

	return
end

function var_0_1.OnRemoveAttachment(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_3.type

	WorldMapAttachment = var_1_10005

	if var_21_0 == var_1_10005.TypeArtifact then
		for iter_21_0 = #arg_21_0.wsMapArtifactsFA, 1, -1 do
			if arg_21_0.wsMapArtifactsFA[iter_21_0].attachment == arg_21_3 then
				arg_21_0:DisposeArtifact(var_8)

				table = var_9

				var_9.remove(arg_21_0.wsMapArtifactsFA, iter_21_0)

				break
			end
		end
	else
		for iter_21_1 = #arg_21_0.wsMapAttachments, 1, -1 do
			if arg_21_0.wsMapAttachments[iter_21_1].attachment == arg_21_3 then
				arg_21_0:DisposeAttachment(var_8)

				table = var_9

				var_9.remove(arg_21_0.wsMapAttachments, iter_21_1)
				arg_21_0:OnUpdateAttachment(nil, arg_21_3)

				break
			end
		end
	end

	return
end

function var_0_1.OnUpdateAttachment(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:FindAttachments(arg_22_2.row, arg_22_2.column)

	_ = var_1_10004

	var_1_10004.each(var_22_0, function(arg_23_0)
		arg_23_0:Update(arg_22_1)

		return
	end)

	if arg_22_0:FindFleet(arg_22_2.row, arg_22_2.column) then
		arg_22_0:FlushFleets()
	end

	arg_22_0:DispatchEvent(var_0_1.EventUpdateEventTips)

	return
end

function var_0_1.OnUpdateTerrain(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0, var_24_1 = arg_24_0:GetTerrainEffect(arg_24_2.row, arg_24_2.column)

	if var_24_0 then
		arg_24_0:DisposeTerrainEffect(var_24_0)

		table = var_5

		var_5.remove(arg_24_0.wsTerrainEffects, var_24_1)
	end

	local var_24_2 = arg_24_2
	local var_24_3 = arg_24_2.GetTerrain(var_24_2)

	WorldMapCell = var_6

	if var_24_3 ~= var_6.TerrainStream then
		WorldMapCell = var_6

		if var_24_3 ~= var_6.TerrainWind then
			WorldMapCell = var_6

			if var_24_3 ~= var_6.TerrainIce then
				WorldMapCell = var_6

				if var_24_3 == var_6.TerrainPoison then
					local var_24_4 = arg_24_0:NewTerrainEffect(arg_24_2)

					table = var_24_2

					var_24_2.insert(arg_24_0.wsTerrainEffects, var_24_4)
				end

				return
			end
		end
	end
end

function var_0_1.OnAddCarry(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_0:NewCarryItem(arg_25_2, arg_25_3)

	table = var_1_10005

	var_1_10005.insert(arg_25_0.wsCarryItems, var_25_0)

	return
end

function var_0_1.OnRemoveCarry(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	for iter_26_0 = #arg_26_0.wsCarryItems, 1, -1 do
		if arg_26_0.wsCarryItems[iter_26_0].carryItem == arg_26_3 then
			arg_26_0:DisposeCarryItem(var_8)

			table = var_9

			var_9.remove(arg_26_0.wsCarryItems, iter_26_0)

			break
		end
	end

	return
end

function var_0_1.OnUpdateFleetFOV(arg_27_0)
	arg_27_0:FlushFleets()

	return
end

function var_0_1.NewQuad(arg_28_0, arg_28_1)
	WPool = var_1_10002

	local var_28_0 = var_1_10002
	local var_28_1 = var_1_10002.Get

	WSMapQuad = var_1_10005

	local var_28_2 = var_28_1(var_28_0, var_1_10005)

	WSMapQuad = var_1_10003

	local var_28_3 = var_1_10003.GetResName()
	local var_28_4 = arg_28_0.wsPool

	var_28_2.transform = var_4.Get(var_28_4, var_28_3).transform

	local var_28_5 = var_28_2.transform

	var_4.SetParent(var_28_5, arg_28_0.rtQuads, false)

	var_28_2.twTimer = arg_28_0.twTimer

	var_28_2:Setup(arg_28_1, arg_28_0.map.theme)

	return var_28_2
end

function var_0_1.DisposeQuad(arg_29_0, arg_29_1)
	WSMapQuad = var_1_10002

	local var_29_0 = var_1_10002.GetResName()
	local var_29_1 = arg_29_0.wsPool

	var_3.Return(var_29_1, var_29_0, arg_29_1.transform.gameObject)

	WPool = var_3

	var_3:Return(arg_29_1)

	return
end

function var_0_1.NewItem(arg_30_0, arg_30_1)
	WPool = var_1_10002

	local var_30_0 = var_1_10002
	local var_30_1 = var_1_10002.Get

	WSMapItem = var_1_10005

	local var_30_2 = var_30_1(var_30_0, var_1_10005)

	WSMapItem = var_1_10003

	local var_30_3 = var_1_10003.GetResName()
	local var_30_4 = arg_30_0.wsPool

	var_30_2.transform = var_4.Get(var_30_4, var_30_3).transform

	local var_30_5 = var_30_2.transform

	var_4.SetParent(var_30_5, arg_30_0.rtItems, false)
	var_30_2:Setup(arg_30_1, arg_30_0.map.theme)

	return var_30_2
end

function var_0_1.DisposeItem(arg_31_0, arg_31_1)
	WSMapItem = var_1_10002

	local var_31_0 = var_1_10002.GetResName()
	local var_31_1 = arg_31_0.wsPool

	var_3.Return(var_31_1, var_31_0, arg_31_1.transform.gameObject)

	WPool = var_3

	var_3:Return(arg_31_1)

	return
end

function var_0_1.NewCell(arg_32_0, arg_32_1)
	WPool = var_1_10002

	local var_32_0 = var_1_10002
	local var_32_1 = var_1_10002.Get

	WSMapCell = var_1_10005

	local var_32_2 = var_32_1(var_32_0, var_1_10005)

	WSMapCell = var_1_10003

	local var_32_3 = var_1_10003.GetResName()
	local var_32_4 = arg_32_0.wsPool

	var_32_2.transform = var_4.Get(var_32_4, var_32_3).transform

	local var_32_5 = var_32_2.transform

	var_4.SetParent(var_32_5, arg_32_0.rtCells, false)

	var_32_2.wsMapResource = arg_32_0.wsMapResource
	var_32_2.wsTimer = arg_32_0.wsTimer

	var_32_2:Setup(arg_32_0.map, arg_32_1)

	local var_32_6 = var_32_2.rtFog
	local var_32_7 = var_4.SetParent
	local var_32_8 = arg_32_0.rtCells

	var_32_7(var_32_6, var_7.Find(var_32_8, "fogs"), true)

	local var_32_9 = arg_32_1
	local var_32_10 = arg_32_1.AddListener

	WorldMapCell = var_7

	var_32_10(var_32_9, var_7.EventAddAttachment, arg_32_0.onAddAttachment)

	local var_32_11 = arg_32_1
	local var_32_12 = arg_32_1.AddListener

	WorldMapCell = var_7

	var_32_12(var_32_11, var_7.EventRemoveAttachment, arg_32_0.onRemoveAttachment)

	local var_32_13 = arg_32_1
	local var_32_14 = arg_32_1.AddListener

	WorldMapCell = var_7

	var_32_14(var_32_13, var_7.EventUpdateTerrain, arg_32_0.onUpdateTerrain)
	arg_32_0:OnUpdateTerrain(nil, arg_32_1)

	return var_32_2
end

function var_0_1.DisposeCell(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1.cell
	local var_33_1 = arg_33_1.rtFog

	var_3.SetParent(var_33_1, arg_33_1.transform, true)

	local var_33_2 = var_33_0
	local var_33_3 = var_33_0.RemoveListener

	WorldMapCell = var_6

	var_33_3(var_33_2, var_6.EventAddAttachment, arg_33_0.onAddAttachment)

	local var_33_4 = var_33_0
	local var_33_5 = var_33_0.RemoveListener

	WorldMapCell = var_6

	var_33_5(var_33_4, var_6.EventRemoveAttachment, arg_33_0.onRemoveAttachment)

	local var_33_6 = var_33_0
	local var_33_7 = var_33_0.RemoveListener

	WorldMapCell = var_6

	var_33_7(var_33_6, var_6.EventUpdateTerrain, arg_33_0.onUpdateTerrain)

	WSMapCell = var_33_7

	local var_33_8 = var_33_7.GetResName()
	local var_33_9 = arg_33_0.wsPool

	var_4.Return(var_33_9, var_33_8, arg_33_1.transform.gameObject)

	WPool = var_4

	var_4:Return(arg_33_1)

	return
end

function var_0_1.NewTransport(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	WPool = var_1_10004

	local var_34_0 = var_1_10004
	local var_34_1 = var_1_10004.Get

	WSMapTransport = var_1_10007

	local var_34_2 = var_34_1(var_34_0, var_1_10007)

	WSMapTransport = var_1_10005

	local var_34_3 = var_1_10005.GetResName()
	local var_34_4 = arg_34_0.wsPool

	var_34_2.transform = var_6.Get(var_34_4, var_34_3).transform

	local var_34_5 = var_34_2.transform

	var_6.SetParent(var_34_5, arg_34_0.rtQuads, false)

	var_34_2.wsMapPath = arg_34_0.wsMapPath

	var_34_2:Setup(arg_34_1, arg_34_2, arg_34_3, arg_34_0.map)

	return var_34_2
end

function var_0_1.DisposeTransport(arg_35_0, arg_35_1)
	WSMapTransport = var_1_10002

	local var_35_0 = var_1_10002.GetResName()
	local var_35_1 = arg_35_0.wsPool

	var_3.Return(var_35_1, var_35_0, arg_35_1.transform.gameObject)

	WPool = var_3

	var_3:Return(arg_35_1)

	return
end

function var_0_1.NewAttachment(arg_36_0, arg_36_1, arg_36_2)
	WPool = var_1_10003

	local var_36_0 = var_1_10003
	local var_36_1 = var_1_10003.Get

	WSMapAttachment = var_1_10006

	local var_36_2 = var_36_1(var_36_0, var_1_10006)

	WSMapAttachment = var_1_10004

	local var_36_3 = var_1_10004.GetResName(arg_36_2)
	local var_36_4 = arg_36_0.wsPool

	var_36_2.transform = var_5.Get(var_36_4, var_36_3).transform

	local var_36_5 = var_36_2.transform

	var_5.SetParent(var_36_5, arg_36_1.rtAttachments, false)

	var_36_2.twTimer = arg_36_0.twTimer

	var_36_2:Setup(arg_36_0.map, arg_36_1.cell, arg_36_2)

	local var_36_6 = arg_36_2
	local var_36_7 = arg_36_2.AddListener

	WorldMapAttachment = var_8

	var_36_7(var_36_6, var_8.EventUpdateFlag, arg_36_0.onUpdateAttachment)

	local var_36_8 = arg_36_2
	local var_36_9 = arg_36_2.AddListener

	WorldMapAttachment = var_8

	var_36_9(var_36_8, var_8.EventUpdateData, arg_36_0.onUpdateAttachment)

	local var_36_10 = arg_36_2
	local var_36_11 = arg_36_2.AddListener

	WorldMapAttachment = var_8

	var_36_11(var_36_10, var_8.EventUpdateLurk, arg_36_0.onUpdateAttachment)

	return var_36_2
end

function var_0_1.DisposeAttachment(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_1.attachment
	local var_37_1 = var_2.RemoveListener

	WorldMapAttachment = var_1_10006

	var_37_1(var_37_0, var_1_10006.EventUpdateFlag, arg_37_0.onUpdateAttachment)

	local var_37_2 = var_2
	local var_37_3 = var_2.RemoveListener

	WorldMapAttachment = var_6

	var_37_3(var_37_2, var_6.EventUpdateData, arg_37_0.onUpdateAttachment)

	local var_37_4 = var_2
	local var_37_5 = var_2.RemoveListener

	WorldMapAttachment = var_6

	var_37_5(var_37_4, var_6.EventUpdateLurk, arg_37_0.onUpdateAttachment)

	WSMapAttachment = var_37_5

	local var_37_6 = var_37_5.GetResName(var_2)
	local var_37_7 = arg_37_0.wsPool

	var_4.Return(var_37_7, var_37_6, arg_37_1.transform.gameObject)

	WPool = var_4

	var_4:Return(arg_37_1)

	return
end

function var_0_1.NewArtifact(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	WPool = var_1_10004

	local var_38_0 = var_1_10004
	local var_38_1 = var_1_10004.Get

	WSMapArtifact = var_1_10007

	local var_38_2 = var_38_1(var_38_0, var_1_10007).transform

	var_5.SetParent(var_38_2, arg_38_1.rtArtifacts, false)
	var_4:Setup(arg_38_2, arg_38_0.map.theme, arg_38_3)

	return var_4
end

function var_0_1.DisposeArtifact(arg_39_0, arg_39_1)
	WPool = var_1_10002

	var_1_10002:Return(arg_39_1)

	return
end

function var_0_1.GetTerrainEffectParent(arg_40_0, arg_40_1)
	WorldMapCell = var_1_10002

	if arg_40_1 == var_1_10002.TerrainStream then
		return arg_40_0.rtEffectB
	else
		WorldMapCell = var_2

		if arg_40_1 == var_2.TerrainWind then
			return arg_40_0.rtEffectC
		else
			WorldMapCell = var_2

			if arg_40_1 == var_2.TerrainIce then
				return arg_40_0.rtEffectA
			else
				WorldMapCell = var_2

				if arg_40_1 == var_2.TerrainPoison then
					return arg_40_0.rtEffectA
				else
					assert = var_2

					var_2(false, "terrain type error: " .. arg_40_1)
				end
			end
		end
	end

	return
end

function var_0_1.NewTerrainEffect(arg_41_0, arg_41_1)
	WPool = var_1_10002

	local var_41_0 = var_1_10002
	local var_41_1 = var_1_10002.Get

	WSMapCellEffect = var_1_10005

	local var_41_2 = var_41_1(var_41_0, var_1_10005)

	createNewGameObject = var_1_10003
	var_41_2.transform = var_1_10003("mapCellEffect")

	local var_41_3 = var_41_2.transform

	var_3.SetParent(var_41_3, arg_41_0:GetTerrainEffectParent(arg_41_1:GetTerrain()), false)
	var_41_2:Setup(arg_41_1, arg_41_0.map.theme)

	return var_41_2
end

function var_0_1.DisposeTerrainEffect(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_1.transform

	WPool = var_1_10003

	var_1_10003:Return(arg_42_1)

	Destroy = var_3

	var_3(var_42_0)

	return
end

function var_0_1.GetTerrainEffect(arg_43_0, arg_43_1, arg_43_2)
	ipairs = var_1_10003

	for iter_43_0, iter_43_1 in var_1_10003(arg_43_0.wsTerrainEffects) do
		if iter_43_1.cell.row == arg_43_1 and iter_43_1.cell.column == arg_43_2 then
			return iter_43_1, iter_43_0
		end
	end

	return
end

function var_0_1.NewFleet(arg_44_0, arg_44_1)
	WPool = var_1_10002

	local var_44_0 = var_1_10002
	local var_44_1 = var_1_10002.Get

	WSMapFleet = var_1_10005

	local var_44_2 = var_44_1(var_44_0, var_1_10005)

	WSMapFleet = var_1_10003

	local var_44_3 = var_1_10003.GetResName()
	local var_44_4 = arg_44_0.wsPool

	var_44_2.transform = var_4.Get(var_44_4, var_44_3).transform

	local var_44_5 = var_44_2.transform

	var_4.SetParent(var_44_5, arg_44_0.rtCells, false)
	var_44_2:Setup(arg_44_1, arg_44_0.map.theme)

	local var_44_6 = var_44_2.rtRetreat

	var_4.SetParent(var_44_6, arg_44_0.rtTop, false)

	local var_44_7 = arg_44_1
	local var_44_8 = arg_44_1.AddListener

	WorldMapFleet = var_7

	var_44_8(var_44_7, var_7.EventAddCarry, arg_44_0.onAddCarry)

	local var_44_9 = arg_44_1
	local var_44_10 = arg_44_1.AddListener

	WorldMapFleet = var_7

	var_44_10(var_44_9, var_7.EventRemoveCarry, arg_44_0.onRemoveCarry)

	return var_44_2
end

function var_0_1.DisposeFleet(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_1.fleet
	local var_45_1 = var_2.RemoveListener

	WorldMapFleet = var_1_10005

	var_45_1(var_45_0, var_1_10005.EventAddCarry, arg_45_0.onAddCarry)

	local var_45_2 = arg_45_1.fleet
	local var_45_3 = var_2.RemoveListener

	WorldMapFleet = var_5

	var_45_3(var_45_2, var_5.EventRemoveCarry, arg_45_0.onRemoveCarry)

	local var_45_4 = arg_45_1.rtRetreat

	var_2.SetParent(var_45_4, arg_45_1.transform, false)

	local var_45_5 = arg_45_0.wsPool
	local var_45_6 = var_2.Return

	WSMapFleet = var_5

	var_45_6(var_45_5, var_5.GetResName(), arg_45_1.transform.gameObject)

	WPool = var_45_6

	var_45_6:Return(arg_45_1)

	return
end

function var_0_1.NewCarryItem(arg_46_0, arg_46_1, arg_46_2)
	WPool = var_1_10003

	local var_46_0 = var_1_10003
	local var_46_1 = var_1_10003.Get

	WSCarryItem = var_1_10006

	local var_46_2 = var_46_1(var_46_0, var_1_10006)

	WSCarryItem = var_1_10004

	local var_46_3 = var_1_10004.GetResName()
	local var_46_4 = arg_46_0.wsPool

	var_46_2.transform = var_5.Get(var_46_4, var_46_3).transform

	local var_46_5 = var_46_2.transform

	var_5.SetParent(var_46_5, arg_46_0.rtCells, false)
	var_46_2:Setup(arg_46_1, arg_46_2, arg_46_0.map.theme)

	return var_46_2
end

function var_0_1.DisposeCarryItem(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0.wsPool
	local var_47_1 = var_2.Return

	WSCarryItem = var_1_10005

	var_47_1(var_47_0, var_1_10005.GetResName(), arg_47_1.transform.gameObject)

	WPool = var_47_1

	var_47_1:Return(arg_47_1)

	return
end

function var_0_1.GetCarryItem(arg_48_0, arg_48_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_48_0.wsCarryItems, function(arg_49_0)
		return arg_49_0.carryItem == arg_48_1
	end)
end

function var_0_1.FindCarryItems(arg_50_0, arg_50_1)
	_ = var_1_10002

	return var_1_10002.filter(arg_50_0.wsCarryItems, function(arg_51_0)
		return arg_51_0.fleet == arg_50_1
	end)
end

function var_0_1.GetFleet(arg_52_0, arg_52_1)
	if not arg_52_1 then
		local var_52_0 = arg_52_0.map

		arg_52_1 = var_1_10002.GetFleet(var_52_0)
	end

	_ = var_1_10002

	return var_1_10002.detect(arg_52_0.wsMapFleets, function(arg_53_0)
		return arg_53_0.fleet == arg_52_1
	end)
end

function var_0_1.FindFleet(arg_54_0, arg_54_1, arg_54_2)
	_ = var_1_10003

	return var_1_10003.detect(arg_54_0.wsMapFleets, function(arg_55_0)
		return arg_55_0.fleet.row == arg_54_1 and arg_55_0.fleet.column == arg_54_2
	end)
end

function var_0_1.GetCell(arg_56_0, arg_56_1, arg_56_2)
	WSMapCell = var_1_10003

	local var_56_0 = var_1_10003.GetName(arg_56_1, arg_56_2)

	return arg_56_0.wsMapCells[var_56_0]
end

function var_0_1.GetAttachment(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	_ = var_1_10004

	return var_1_10004.detect(arg_57_0.wsMapAttachments, function(arg_58_0)
		return arg_58_0.attachment.row == arg_57_1 and arg_58_0.attachment.column == arg_57_2 and arg_58_0.attachment.type == arg_57_3
	end)
end

function var_0_1.FindAttachments(arg_59_0, arg_59_1, arg_59_2)
	_ = var_1_10003

	return var_1_10003.filter(arg_59_0.wsMapAttachments, function(arg_60_0)
		return arg_60_0.attachment.row == arg_59_1 and arg_60_0.attachment.column == arg_59_2
	end)
end

function var_0_1.GetQuad(arg_61_0, arg_61_1, arg_61_2)
	WSMapQuad = var_1_10003

	local var_61_0 = var_1_10003.GetName(arg_61_1, arg_61_2)

	return arg_61_0.wsMapQuads[var_61_0]
end

function var_0_1.GetItem(arg_62_0, arg_62_1, arg_62_2)
	WSMapItem = var_1_10003

	local var_62_0 = var_1_10003.GetName(arg_62_1, arg_62_2)

	return arg_62_0.wsMapItems[var_62_0]
end

function var_0_1.GetTransport(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	WSMapTransport = var_1_10004

	local var_63_0 = var_1_10004.GetName(arg_63_1, arg_63_2, arg_63_3)

	return arg_63_0.wsMapTransports[var_63_0]
end

function var_0_1.UpdateRangeVisible(arg_64_0, arg_64_1)
	if arg_64_0.rangeVisible ~= arg_64_1 then
		arg_64_0.rangeVisible = arg_64_1

		if arg_64_1 then
			arg_64_0:DisplayMoveRange()
		else
			arg_64_0:HideMoveRange()
		end
	end

	return
end

function var_0_1.DisplayMoveRange(arg_65_0)
	arg_65_0.displayRangeLines = {}

	local var_65_0 = arg_65_0.map
	local var_65_1 = var_1.GetFleet(var_65_0)

	nowWorld = var_1_10002

	local var_65_2 = var_1_10002()
	local var_65_3 = var_2.GetMoveRange(var_65_2, var_65_1)
	local var_65_4 = 0

	ipairs = var_65_2

	for iter_65_0, iter_65_1 in var_65_2(var_65_3) do
		local var_65_5 = arg_65_0
		local var_65_6 = arg_65_0.GetQuad(var_65_5, iter_65_1.row, iter_65_1.column)

		setImageAlpha = var_1_10010

		local var_65_7 = var_65_6.rtWalkQuad

		math = var_13

		local var_65_8 = var_13.pow
		local var_65_9 = 0.75
		local var_65_10

		if not iter_65_1.stay or not (iter_65_1.stay - 1) then
			var_65_10 = 0
		end

		var_1_10010(var_65_7, var_65_8(var_65_9, var_65_10))

		setLocalScale = var_1_10010

		local var_65_11 = var_65_6.rtWalkQuad

		Vector3 = var_13

		var_1_10010(var_65_11, var_13.zero)

		ManhattonDist = var_1_10010
		var_1_10010 = var_1_10010(var_65_1, iter_65_1)
		math = var_65_5
		var_65_4 = var_65_5.max(var_65_4, var_1_10010)

		local var_65_12 = {
			line = iter_65_1
		}

		function var_65_12.func()
			local var_66_0 = var_65_12

			LeanTween = var_2_10001

			local var_66_1 = var_2_10001.scale
			local var_66_2 = var_65_6.rtWalkQuad

			Vector3 = var_2_10004

			local var_66_3 = var_66_1(var_66_2, var_2_10004.one, 0.2)
			local var_66_4 = var_1.setEase

			LeanTweenType = var_4
			var_66_0.uid = var_66_4(var_66_3, var_4.easeInOutSine).uniqueId

			local var_66_5 = arg_65_0.wsTimer

			var_0.AddInMapTween(var_66_5, var_65_12.uid)

			return
		end

		local var_65_13 = arg_65_0.displayRangeLines
		local var_65_14

		if not arg_65_0.displayRangeLines[var_1_10010] then
			var_65_14 = {}
		end

		var_65_13[var_1_10010] = var_65_14
		table = var_65_13

		var_65_13.insert(arg_65_0.displayRangeLines[var_1_10010], var_65_12)
	end

	if var_65_4 > 0 then
		local var_65_15 = 0
		local var_65_16 = arg_65_0.wsTimer

		arg_65_0.displayRangeTimer = var_5.AddInMapTimer(var_65_16, function()
			var_65_15 = var_65_15 + 1

			if arg_65_0.displayRangeLines[var_65_15] then
				ipairs = var_0

				for iter_67_0, iter_67_1 in var_0(arg_65_0.displayRangeLines[var_65_15]) do
					iter_67_1.func()
				end
			end

			return
		end, 0.1, var_65_4)

		local var_65_17 = arg_65_0.displayRangeTimer

		var_5.Start(var_65_17)
	end

	return
end

function var_0_1.HideMoveRange(arg_68_0)
	if arg_68_0.displayRangeTimer then
		local var_68_0 = arg_68_0.wsTimer

		var_1.RemoveInMapTimer(var_68_0, arg_68_0.displayRangeTimer)

		arg_68_0.displayRangeTimer = nil
	end

	if arg_68_0.displayRangeLines then
		pairs = var_1

		for iter_68_0, iter_68_1 in var_1(arg_68_0.displayRangeLines) do
			ipairs = var_1_10006

			for iter_68_2, iter_68_3 in var_1_10006(iter_68_1) do
				if iter_68_3.uid then
					var_1_10013 = arg_68_0.wsTimer

					var_11.RemoveInMapTween(var_1_10013, iter_68_3.uid)
				end

				local var_68_1 = iter_68_3.line
				local var_68_2 = arg_68_0:GetQuad(var_68_1.row, var_68_1.column)

				setImageAlpha = var_1_10013

				var_1_10013(var_68_2.rtWalkQuad, 0)

				setLocalScale = var_1_10013

				local var_68_3 = var_68_2.rtWalkQuad

				Vector3 = var_16

				var_1_10013(var_68_3, var_16.one)
			end
		end

		arg_68_0.displayRangeLines = nil
	end

	return
end

function var_0_1.MovePath(arg_69_0, arg_69_1, arg_69_2, arg_69_3, arg_69_4, arg_69_5)
	local var_69_0 = arg_69_0.map

	_ = var_1_10007

	local var_69_1 = var_1_10007.map(arg_69_2, function(arg_70_0)
		local var_70_0 = arg_69_0

		return var_1.GetQuad(var_70_0, arg_70_0.row, arg_70_0.column)
	end)
	local var_69_2

	if arg_69_5 then
		WPool = var_9

		local var_69_3 = var_9
		local var_69_4 = var_9.Get

		WSMapEffect = var_1_10012
		var_69_2 = var_69_4(var_69_3, var_1_10012)
		createNewGameObject = var_9
		var_69_2.transform = var_9("mapEffect")

		local var_69_5 = var_69_2.transform

		var_9.SetParent(var_69_5, arg_69_1.transform, false)

		local var_69_6 = var_69_2.transform

		Vector3 = var_10
		var_69_6.anchoredPosition3D = var_10.zero

		local var_69_7 = var_69_2.transform

		Vector3 = var_10
		var_69_7.localEulerAngles = var_10(arg_69_0.map.theme.angle, 0, 0)
		var_69_2.modelOrder = arg_69_1.modelOrder

		local var_69_8 = var_69_2
		local var_69_9 = var_69_2.Setup

		WorldConst = var_12

		var_69_9(var_69_8, var_12.GetWindEffect())
		var_69_2:Load()
	end

	local var_69_10 = 0

	ipairs = var_10

	for iter_69_0, iter_69_1 in var_10(var_69_1) do
		LeanTween = var_1_10015

		var_1_10015.cancel(iter_69_1.rtWalkQuad)

		setLocalScale = var_1_10015

		local var_69_11 = iter_69_1.rtWalkQuad

		Vector3 = var_1_10018

		var_1_10015(var_69_11, var_1_10018.one)

		setImageAlpha = var_1_10015

		var_1_10015(iter_69_1.rtWalkQuad, 0)

		LeanTween = var_1_10015

		local var_69_12 = var_1_10015.alpha(iter_69_1.rtWalkQuad, 1, arg_69_2[iter_69_0].duration / 2)

		var_1_10015.setDelay(var_69_12, var_69_10)

		var_69_10 = var_69_10 + arg_69_2[iter_69_0].duration / 2
	end

	local var_69_13 = 0
	local var_69_14

	local function var_69_15(arg_71_0, arg_71_1, arg_71_2)
		var_69_13 = var_69_13 + 1

		if var_69_13 <= #var_69_1 then
			local var_71_0 = var_69_1[var_69_13]

			LeanTween = var_4

			var_4.cancel(var_71_0.rtWalkQuad)

			setImageAlpha = var_4

			var_4(var_71_0.rtWalkQuad, 1)

			LeanTween = var_4

			var_4.alpha(var_71_0.rtWalkQuad, 0, arg_69_2[var_69_13].duration)
		end

		return
	end

	local var_69_16

	local function var_69_17()
		local var_72_0 = arg_69_0.wsMapPath
		local var_72_1 = var_0.RemoveListener

		WSMapPath = var_2_10003

		var_72_1(var_72_0, var_2_10003.EventArrivedStep, var_69_15)

		local var_72_2 = arg_69_0.wsMapPath
		local var_72_3 = var_0.RemoveListener

		WSMapPath = var_3

		var_72_3(var_72_2, var_3.EventArrived, var_69_17)

		_ = var_72_3

		var_72_3.each(var_69_1, function(arg_73_0)
			LeanTween = var_3_10001

			var_3_10001.cancel(arg_73_0.rtWalkQuad)

			setImageAlpha = var_1

			var_1(arg_73_0.rtWalkQuad, 0)

			return
		end)

		if arg_69_5 then
			local var_72_4 = var_69_2.transform

			WPool = var_2_10001

			var_2_10001:Return(var_69_2)

			Destroy = var_1

			var_1(var_72_4)
		end

		return
	end

	local var_69_18 = arg_69_0.wsMapPath
	local var_69_19 = var_13.AddListener

	WSMapPath = var_1_10016

	var_69_19(var_69_18, var_1_10016.EventArrivedStep, var_69_15)

	local var_69_20 = arg_69_0.wsMapPath
	local var_69_21 = var_13.AddListener

	WSMapPath = var_16

	var_69_21(var_69_20, var_16.EventArrived, var_69_17)

	local var_69_22 = arg_69_0.wsMapPath

	var_13.UpdateObject(var_69_22, arg_69_1)

	local var_69_23 = arg_69_0.wsMapPath
	local var_69_24 = var_13.UpdateAction

	if arg_69_5 then
		WorldConst = var_69_25

		local var_69_25

		if not var_69_25.ActionDrag then
			WorldConst = var_69_25
			var_69_25 = var_69_25.ActionMove
		end

		var_69_24(var_69_23, var_69_25)

		local var_69_26 = arg_69_0.wsMapPath

		var_13.UpdateDirType(var_69_26, arg_69_4)

		local var_69_27 = arg_69_0.wsMapPath

		var_13.StartMove(var_69_27, arg_69_3, arg_69_2, arg_69_5 and 100 or 0)

		return arg_69_0.wsMapPath
	end
end

function var_0_1.FlushFleets(arg_74_0)
	arg_74_0:FlushFleetVisibility()
	arg_74_0:FlushFleetRetreatBtn()
	arg_74_0:FlushEnemyFightingMark()
	arg_74_0:FlushTransportDisplay()

	local var_74_0 = arg_74_0.map
	local var_74_1 = var_1.GetFleet(var_74_0)

	_ = var_1_10002

	var_1_10002.each(arg_74_0.wsMapFleets, function(arg_75_0)
		arg_75_0:UpdateSelected(arg_75_0.fleet == var_74_1)

		return
	end)

	return
end

function var_0_1.FlushFleetRetreatBtn(arg_76_0)
	local var_76_0 = arg_76_0.map
	local var_76_1 = var_1.GetFleet(var_76_0)

	_ = var_1_10002

	var_1_10002.each(arg_76_0.wsMapFleets, function(arg_77_0)
		local var_77_0 = arg_77_0.fleet
		local var_77_1 = arg_76_0.map
		local var_77_2 = var_2.GetCell(var_77_1, var_77_0.row, var_77_0.column)

		if var_2.ExistEnemy(var_77_2) then
			local var_77_3

			if var_77_0 == var_76_1 then
				WorldConst = var_77_3
				var_77_3 = not var_77_3.IsWorldGuideEnemyId(var_2:GetStageEnemy().id)
			else
				var_77_3 = false
			end
		end

		if false then
			var_77_3 = true
		end

		setActive = var_77_1

		var_77_1(arg_77_0.rtRetreat, var_77_3)

		if var_77_3 then
			local var_77_4 = arg_77_0.rtRetreat
			local var_77_5 = arg_76_0.rtTop
			local var_77_6 = var_5.InverseTransformPoint(var_77_5, arg_77_0.transform.position)

			Vector3 = var_6
			var_77_4.localPosition = var_77_6 + var_6(89, 0, 0)

			local var_77_7 = arg_77_0.rtRetreat

			Vector3 = var_5
			var_77_7.localEulerAngles = var_5(-arg_76_0.map.theme.angle, 0, 0)

			local var_77_8 = arg_77_0.rtRetreat

			var_4.SetAsLastSibling(var_77_8)
		end

		return
	end)

	return
end

function var_0_1.FlushEnemyFightingMark(arg_78_0)
	_ = var_1_10001

	var_1_10001.each(arg_78_0.wsMapAttachments, function(arg_79_0)
		local var_79_0 = arg_79_0.attachment

		WorldMapAttachment = var_2_10002

		if var_2_10002.IsEnemyType(var_79_0.type) then
			local var_79_1 = arg_79_0
			local var_79_2 = arg_79_0.UpdateIsFighting
			local var_79_3 = arg_78_0.map

			var_79_2(var_79_1, var_5.ExistFleet(var_79_3, var_79_0.row, var_79_0.column))
		end

		return
	end)

	return
end

function var_0_1.FlushTransportVisibleByFleet(arg_80_0)
	pairs = var_1_10001

	for iter_80_0, iter_80_1 in var_1_10001(arg_80_0.wsMapTransports) do
		_ = var_1_10006

		if not var_1_10006.any(arg_80_0.wsMapFleets, function(arg_81_0)
			ManhattonDist = var_2_10001

			return var_2_10001({
				row = arg_81_0.fleet.row,
				column = arg_81_0.fleet.column
			}, {
				row = iter_80_1.row,
				column = iter_80_1.column
			}) <= 1
		end) then
			arg_80_0:DisposeTransport(iter_80_1)

			var_1_10006 = arg_80_0.wsMapTransports
			var_1_10006[iter_80_0] = nil
		end
	end

	_ = var_1

	var_1.each(arg_80_0.wsMapFleets, function(arg_82_0)
		WorldConst = var_2_10001

		local var_82_0 = var_2_10001.DirNone

		WorldConst = var_2_10002

		for iter_82_0 = var_82_0, var_2_10002.DirLeft do
			WorldConst = var_2_10005
			var_2_10005 = var_2_10005.DirToLine(iter_82_0)

			local var_82_1 = arg_80_0.map

			if var_6.GetCell(var_82_1, arg_82_0.fleet.row + var_2_10005.row, arg_82_0.fleet.column + var_2_10005.column) then
				WorldConst = var_7

				local var_82_2 = var_7.DirUp

				WorldConst = var_82_1

				for iter_82_1 = var_82_2, var_82_1.DirLeft do
					bit = var_82_3

					local var_82_3 = var_82_3.band
					local var_82_4 = var_6.dir

					bit = var_2_10014

					if var_82_3(var_82_4, var_2_10014.lshift(1, iter_82_1)) > 0 then
						WSMapTransport = var_82_3
						var_82_3 = var_82_3.GetName(var_6.row, var_6.column, iter_82_1)

						local var_82_6, var_82_7

						if not arg_80_0.wsMapTransports[var_82_3] then
							local var_82_5 = arg_80_0

							var_82_6 = var_82_7.NewTransport(var_82_5, var_6.row, var_6.column, iter_82_1)
							var_82_7 = arg_80_0.wsMapTransports
							var_82_7[var_82_3] = var_82_6
							setActive = var_82_7

							var_82_7(var_82_6.rtClick, false)
						end

						_ = var_82_7

						local var_82_8 = var_82_7.any(arg_80_0.wsMapFleets, function(arg_83_0)
							return arg_83_0.fleet.row == var_0.row and arg_83_0.fleet.column == var_0.column
						end)

						var_82_6:UpdateAlpha(var_82_8 and 1 or 0)

						setActive = var_2_10014

						var_2_10014(var_82_6.rtForbid, arg_80_0.map.config.is_transfer == 0)
					end
				end
			end
		end

		return
	end)

	return
end

function var_0_1.FlushFleetVisibility(arg_84_0)
	underscore = var_1_10001

	var_1_10001.each(arg_84_0.wsMapFleets, function(arg_85_0)
		local var_85_0 = arg_85_0.fleet
		local var_85_1 = arg_84_0.map
		local var_85_2 = var_2.GetCell(var_85_1, var_85_0.row, var_85_0.column)
		local var_85_3 = not var_2.ExistEnemy(var_85_2) and not var_2:InFog()

		arg_85_0:UpdateActive(var_85_3)

		_ = var_4

		local var_85_4 = var_4.each
		local var_85_5 = arg_84_0

		var_85_4(var_6.FindCarryItems(var_85_5, var_85_0), function(arg_86_0)
			arg_86_0:UpdateActive(var_85_3)

			return
		end)

		return
	end)

	return
end

function var_0_1.UpdateSubmarineSupport(arg_87_0)
	_ = var_1_10001

	var_1_10001.each(arg_87_0.wsMapFleets, function(arg_88_0)
		arg_88_0:UpdateSubmarineSupport()

		return
	end)

	return
end

function var_0_1.FlushMovingAttachment(arg_89_0, arg_89_1)
	if arg_89_1.transform.parent ~= arg_89_0.rtCells then
		local var_89_0 = arg_89_1.transform

		var_2.SetParent(var_89_0, arg_89_0.rtCells, true)
	end

	local var_89_1 = {
		row = arg_89_1.attachment.row,
		column = arg_89_1.attachment.column
	}

	WorldMapAttachment = var_3

	if var_3.IsEnemyType(arg_89_1.attachment.type) and arg_89_0:FindFleet(var_89_1.row, var_89_1.column) then
		var_3:UpdateActive(true)

		setActive = var_4

		var_4(var_3.rtRetreat, false)
		arg_89_1:UpdateIsFighting(false)
	end

	arg_89_0:FlushMovingAttachmentOrder(arg_89_1, var_89_1)

	return
end

function var_0_1.FlushMovingAttachmentOrder(arg_90_0, arg_90_1, arg_90_2)
	local var_90_0 = arg_90_0
	local var_90_1 = arg_90_0.GetCell(var_90_0, arg_90_2.row, arg_90_2.column).cell

	setActive = var_90_0

	local var_90_2 = arg_90_1.transform
	local var_90_3

	if var_90_1:GetInFOV() then
		var_90_3 = not var_90_1:InFog()
	end

	var_90_0(var_90_2, var_90_3)

	local var_90_4 = arg_90_1
	local var_90_5 = arg_90_1.SetModelOrder
	local var_90_6 = arg_90_1.attachment

	var_90_5(var_90_4, var_8.GetModelOrder(var_90_6), arg_90_2.row)

	return
end

function var_0_1.UpdateTransportDisplay(arg_91_0, arg_91_1)
	if arg_91_0.transportDisplay ~= arg_91_1 then
		arg_91_0.transportDisplay = arg_91_1

		arg_91_0:FlushTransportDisplay()
	end

	return
end

function var_0_1.FlushTransportDisplay(arg_92_0)
	local var_92_0 = arg_92_0.transportDisplay

	WorldConst = var_1_10002

	if var_92_0 == var_1_10002.TransportDisplayNormal then
		arg_92_0:FlushTransportVisibleByFleet()
	else
		arg_92_0:FlushTransportVisibleByState()
	end

	return
end

function var_0_1.FlushTransportVisibleByState(arg_93_0)
	local var_93_0 = arg_93_0.map
	local var_93_1 = var_1.GetCellsInFOV(var_93_0)

	pairs = var_1_10002

	for iter_93_0, iter_93_1 in var_1_10002(arg_93_0.wsMapTransports) do
		_ = var_1_10007

		if not var_1_10007.any(var_93_1, function(arg_94_0)
			return arg_94_0.row == iter_93_1.row and arg_94_0.column == iter_93_1.column
		end) then
			arg_93_0:DisposeTransport(iter_93_1)

			var_1_10007 = arg_93_0.wsMapTransports
			var_1_10007[iter_93_0] = nil
		end
	end

	WorldConst = var_2

	local var_93_2 = var_2.DirUp

	_ = var_3

	var_3.each(var_93_1, function(arg_95_0)
		local var_95_0 = var_93_2

		WorldConst = var_2_10002

		for iter_95_0 = var_95_0, var_2_10002.DirLeft do
			bit = var_2_10005
			var_2_10005 = var_2_10005.band

			local var_95_1 = arg_95_0.dir

			bit = var_2_10008

			if var_2_10005(var_95_1, var_2_10008.lshift(1, iter_95_0)) > 0 then
				WSMapTransport = var_2_10005
				var_2_10005 = var_2_10005.GetName(arg_95_0.row, arg_95_0.column, iter_95_0)

				local var_95_3, var_95_4

				if not arg_93_0.wsMapTransports[var_2_10005] then
					local var_95_2 = arg_93_0

					var_95_3 = var_95_4.NewTransport(var_95_2, arg_95_0.row, arg_95_0.column, iter_95_0)
					var_95_4 = arg_93_0.wsMapTransports
					var_95_4[var_2_10005] = var_95_3
				end

				setActive = var_95_4

				local var_95_5 = var_95_3.rtForbid
				local var_95_6 = arg_93_0.transportDisplay

				WorldConst = var_11

				var_95_4(var_95_5, var_95_6 == var_11.TransportDisplayGuideForbid)

				setActive = var_95_4

				local var_95_7 = var_95_3.rtDanger
				local var_95_8 = arg_93_0.transportDisplay

				WorldConst = var_11

				var_95_4(var_95_7, var_95_8 == var_11.TransportDisplayGuideDanger)
				var_95_3:UpdateAlpha(1)
			end
		end

		return
	end)

	return
end

function var_0_1.NewTargetArrow(arg_96_0)
	local var_96_0 = arg_96_0.wsPool

	arg_96_0.rtTargetArrow = var_1.Get(var_96_0, "arrow_tpl").transform
	setActive = var_1

	var_1(arg_96_0.rtTargetArrow, false)

	return
end

function var_0_1.DisplayTargetArrow(arg_97_0, arg_97_1, arg_97_2)
	local var_97_0 = arg_97_0
	local var_97_1 = arg_97_0.GetCell(var_97_0, arg_97_1, arg_97_2)
	local var_97_2 = arg_97_0.rtTargetArrow

	var_4.SetParent(var_97_2, var_97_1.transform, false)

	local var_97_3 = arg_97_0.rtTargetArrow

	Vector2 = var_97_0
	var_97_3.anchoredPosition = var_97_0.zero

	local var_97_4 = arg_97_0.rtTargetArrow

	Vector3 = var_5
	var_97_4.localEulerAngles = var_5(-arg_97_0.map.theme.angle, 0, 0)

	local var_97_5 = arg_97_0.rtTargetArrow
	local var_97_6 = var_4.GetComponent

	typeof = var_7
	Canvas = var_9

	local var_97_7 = var_97_6(var_97_5, var_7(var_9))

	WorldConst = var_5

	local var_97_8 = var_5.LOFleet

	defaultValue = var_97_5
	var_97_7.sortingOrder = var_97_8 + var_97_5(arg_97_1, 0) * 10
	setActive = var_97_7

	var_97_7(arg_97_0.rtTargetArrow, true)

	return
end

function var_0_1.HideTargetArrow(arg_98_0)
	local var_98_0 = arg_98_0.rtTargetArrow

	var_1.SetParent(var_98_0, arg_98_0.transform, false)

	setActive = var_1

	var_1(arg_98_0.rtTargetArrow, false)

	return
end

function var_0_1.ClearTargetArrow(arg_99_0)
	local var_99_0 = arg_99_0.wsPool

	var_1.Return(var_99_0, "arrow_tpl", arg_99_0.rtTargetArrow)

	return
end

function var_0_1.ShowScannerMap(arg_100_0, arg_100_1)
	pairs = var_1_10002

	for iter_100_0, iter_100_1 in var_1_10002(arg_100_0.wsMapQuads) do
		if arg_100_1 then
			iter_100_1:UpdateStatic(true, true)
		else
			iter_100_1:UpdateStatic(false)
		end
	end

	return
end

return var_0_1
