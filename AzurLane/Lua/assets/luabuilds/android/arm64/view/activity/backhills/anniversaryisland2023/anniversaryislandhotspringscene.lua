class = var_0_10000

local var_0_0 = "AnniversaryIslandHotSpringScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.BackHills.NewYearFestival.NewYearHotSpringScene"))

function var_0_1.getUIName(arg_1_0)
	return "AnniversaryIslandHotSpringUI"
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
	arg_2_0.slotTFs = var_2_3(var_2_1.range(4, 15), function(arg_3_0)
		local var_3_0 = arg_2_0.scrollRect
		local var_3_1 = var_1.Find(var_3_0, "Pool")

		return var_1.GetChild(var_3_1, arg_3_0 - 1)
	end)
	table = var_1

	local var_2_4 = var_1.remove(arg_2_0.slotTFs, 12)

	table = var_1_10002

	local var_2_5 = var_1_10002.remove(arg_2_0.slotTFs, 11)

	table = var_3

	var_3.insert(arg_2_0.slotTFs, 1, var_2_5)

	table = var_3

	var_3.insert(arg_2_0.slotTFs, 7, var_2_4)

	_ = var_3
	arg_2_0.slotOriginalPos = var_3.map(arg_2_0.slotTFs, function(arg_4_0)
		return arg_4_0.anchoredPosition
	end)
	Clone = var_3
	arg_2_0.slotShipPos = var_3(arg_2_0.slotOriginalPos)
	table = var_3

	var_3.Foreach(arg_2_0:GetRecordPos(), function(arg_5_0, arg_5_1)
		arg_2_0.slotShipPos[arg_5_0] = arg_5_1

		return
	end)

	_ = var_3

	local var_2_6 = var_3.map

	_ = var_5

	local var_2_7 = var_5.range
	local var_2_8 = arg_2_0.scrollRect

	arg_2_0.poolItems = var_2_6(var_2_7(var_7.Find(var_2_8, "Pool").childCount), function(arg_6_0)
		local var_6_0 = arg_2_0.scrollRect
		local var_6_1 = var_1.Find(var_6_0, "Pool")

		return var_1.GetChild(var_6_1, arg_6_0 - 1)
	end)
	Canvas = var_3

	var_3.ForceUpdateCanvases()

	_ = var_3
	arg_2_0.scrollBGs = var_3.map({
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

	local var_2_9 = arg_2_0._tf

	arg_2_0.top = var_3.Find(var_2_9, "Top")
	pg = var_3

	var_3.ViewUtils.SetSortingOrder(arg_2_0._tf, -1001)

	arg_2_0.spineRoles = {}
	Material = var_3

	local var_2_10 = var_3.New

	pg = var_5

	local var_2_11 = var_5.ShaderMgr.GetInstance()

	arg_2_0.washMaterial = var_2_10(var_5.GetShader(var_2_11, "M02/Unlit_Colored_Semitransparent"))

	local var_2_12 = arg_2_0.washMaterial

	var_3.SetFloat(var_2_12, "_Height", 0.5)

	return
end

function var_0_1.SetActivity(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.activity

	arg_8_0.activity = arg_8_1

	if not var_8_0 then
		return
	end

	table = var_1_10003

	var_1_10003.Foreach(var_8_0.data1_list, function(arg_9_0, arg_9_1)
		if arg_9_1 > 0 then
			local var_9_0

			if not arg_8_1.data1_list[arg_9_0] then
				var_9_0 = 0
			end

			if var_9_0 == 0 then
				local var_9_1 = arg_8_0.slotShipPos

				Clone = var_2_10004
				var_9_1[arg_9_0] = var_2_10004(arg_8_0.slotOriginalPos[arg_9_0])
			end
		end

		return
	end)

	return
end

function var_0_1.didEnter(arg_10_0)
	var_0_1.super.didEnter(arg_10_0)

	pg = var_1

	local var_10_0 = var_1.NewStoryMgr.GetInstance()
	local var_10_1 = var_1.Play
	local var_10_2 = arg_10_0.activity

	var_10_1(var_10_0, var_4.getConfig(var_10_2, "config_client").unlockstory)

	return
end

function var_0_1.UpdateView(arg_11_0)
	arg_11_0:UpdateSlots()

	return
end

function var_0_1.GetRecordPos(arg_12_0)
	PlayerPrefs = var_1_10001

	local var_12_0 = var_1_10001.GetString("hotspring_ship_pos_2023", "")

	_ = var_1_10002

	local var_12_1 = var_1_10002.map

	string = var_4

	local var_12_2 = var_12_1(var_4.split(var_12_0, ";"), function(arg_13_0)
		tonumber = var_2_10001

		return var_2_10001(arg_13_0)
	end)
	local var_12_3 = {}

	for iter_12_0 = 1, #var_12_2, 2 do
		table = var_1_10008
		var_1_10008 = var_1_10008.insert

		local var_12_4 = var_12_3

		Vector2 = var_1_10011

		var_1_10008(var_12_4, var_1_10011.New(var_12_2[iter_12_0], var_12_2[iter_12_0 + 1]))
	end

	return var_12_3
end

function var_0_1.RecordPos(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	table = var_1_10002

	local var_14_0 = var_1_10002.concat

	_ = var_1_10004

	local var_14_1 = var_14_0(var_1_10004.reduce(arg_14_1, {}, function(arg_15_0, arg_15_1)
		table = var_2_10002

		var_2_10002.insert(arg_15_0, arg_15_1.x)

		table = var_2

		var_2.insert(arg_15_0, arg_15_1.y)

		return arg_15_0
	end), ";")

	PlayerPrefs = var_1_10003

	var_1_10003.SetString("hotspring_ship_pos_2023", var_14_1)

	return
end

return var_0_1
