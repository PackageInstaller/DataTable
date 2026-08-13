class = var_0_10000

local var_0_0 = var_0_10000("TowerClimbBgMgr")
local var_0_1 = {
	{
		"1",
		"2",
		"3"
	},
	{
		"4",
		"5",
		"6"
	},
	{
		"7",
		"8",
		"9"
	}
}

var_0_0.effects = {
	{
		{
			"pata_jiandan",
			{
				0,
				-179.5
			}
		}
	},
	{
		{
			"pata_jiandan",
			{
				0,
				46
			}
		}
	},
	{
		{
			"pata_jiandan",
			{
				0,
				61.5
			}
		}
	},
	{
		{
			"pata_jiandan",
			{
				0,
				-179.5
			}
		}
	},
	{
		{
			"pata_jiandan",
			{
				0,
				46
			}
		}
	},
	{
		{
			"pata_jiandan",
			{
				0,
				61.5
			}
		}
	},
	{
		{
			"pata_kunan",
			{
				0,
				-834.5
			}
		},
		{
			"pata_shandian01",
			{
				370,
				-47.5
			}
		},
		{
			"pata_shandian02",
			{
				370,
				601.5
			}
		}
	},
	{
		{
			"pata_shandian03",
			{
				-210,
				-764
			}
		},
		{
			"pata_shandian04",
			{
				220,
				-259
			}
		},
		{
			"pata_shandian03",
			{
				-210,
				252
			}
		},
		{
			"pata_shandian04",
			{
				252,
				639
			}
		}
	},
	{
		{
			"pata_shandian03",
			{
				-299,
				-99.50002
			}
		},
		{
			"pata_shandian04",
			{
				324,
				174.5
			}
		},
		{
			"pata_kunan",
			{
				0,
				52.5
			}
		}
	}
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.tr = arg_1_1

	return
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_0

	var_2_0.bgMaps = var_0_1[arg_2_1]
	assert = var_2_0

	var_2_0(var_0_0.bgMaps, arg_2_1)

	local var_2_1 = {}
	local var_2_2 = arg_2_0.tr

	var_2_1[1] = var_4.Find(var_2_2, "Image1")

	local var_2_3 = arg_2_0.tr

	var_2_1[2] = var_4.Find(var_2_3, "Image2")

	local var_2_4 = arg_2_0.tr

	var_2_1[3] = var_4.Find(var_2_4, "Image3")
	arg_2_0.list = var_2_1
	arg_2_0.names = {}

	local var_2_5 = {}

	for iter_2_0 = 1, 2 do
		setActive = var_1_10008

		var_1_10008(arg_2_0.list[iter_2_0], false)

		table = var_1_10008

		var_1_10008.insert(var_2_5, function(arg_3_0)
			local var_3_0 = arg_2_0
			local var_3_1 = var_1.GetBg(var_3_0, iter_2_0)
			local var_3_2 = arg_2_0

			var_2.LoadImage(var_3_2, var_3_1, function(arg_4_0)
				setActive = var_3_10001

				var_3_10001(arg_2_0.list[iter_2_0], true)

				local var_4_0 = arg_2_0.list[iter_2_0]
				local var_4_1 = var_1.GetComponent

				typeof = var_3
				Image = var_3_10004
				var_4_1(var_4_0, var_3(var_3_10004)).sprite = arg_4_0

				local var_4_2 = arg_2_0.list[iter_2_0]
				local var_4_3 = var_1.GetComponent

				typeof = var_3
				Image = var_3_10004

				local var_4_4 = var_4_3(var_4_2, var_3(var_3_10004))

				var_1.SetNativeSize(var_4_4)
				arg_3_0()

				return
			end)

			arg_2_0.names[arg_2_0.list[iter_2_0]] = var_3_1

			local var_3_3 = arg_2_0

			var_2.LoadEffect(var_3_3, var_3_1, arg_2_0.list[iter_2_0])

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_2_5, function()
		local var_5_0 = 0

		ipairs = var_2_10001

		for iter_5_0, iter_5_1 in var_2_10001(arg_2_0.list) do
			if arg_2_0.list[iter_5_0 - 1] then
				var_5_0 = var_5_0 + var_6.rect.height
			end

			setAnchoredPosition = var_7

			var_7(iter_5_1, {
				z = 0,
				x = 0,
				y = var_5_0
			})
		end

		arg_2_2()

		return
	end)

	return
end

function var_0_0.DoMove(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}
	local var_6_1

	ipairs = var_1_10005

	for iter_6_0, iter_6_1 in var_1_10005(arg_6_0.list) do
		if iter_6_1 then
			var_6_1 = var_6_1 or iter_6_0
			table = var_1_10010

			var_1_10010.insert(var_6_0, function(arg_7_0)
				getAnchoredPosition = var_2_10001

				local var_7_0 = var_2_10001(iter_6_1)

				LeanTween = var_2

				local var_7_1 = var_2.value(iter_6_1.gameObject, iter_6_1.anchoredPosition.y, var_7_0.y - arg_6_1 * 0.8, 0.2)
				local var_7_2 = var_2.setOnUpdate

				System = var_4

				local var_7_3 = var_7_2(var_7_1, var_4.Action_float(function(arg_8_0)
					setAnchoredPosition = var_3_10001

					var_3_10001(iter_6_1, {
						y = arg_8_0
					})

					return
				end))
				local var_7_4 = var_2.setEase

				LeanTweenType = var_4

				local var_7_5 = var_7_4(var_7_3, var_4.easeOutQuad)
				local var_7_6 = var_2.setOnComplete

				System = var_4

				var_7_6(var_7_5, var_4.Action(arg_7_0))

				return
			end)
		end
	end

	parallelAsync = var_5

	var_5(var_6_0, function()
		local var_9_0 = arg_6_0

		var_0.DoCheck(var_9_0, var_6_1)
		arg_6_2()

		return
	end)

	return
end

function var_0_0.DoCheck(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.list[arg_10_1]
	local var_10_1 = arg_10_0.list[arg_10_1 + 2]

	getAnchoredPosition = var_4

	local var_10_3

	if var_4(var_10_0).y + var_10_0.rect.height + arg_10_0.list[arg_10_1 + 1].rect.height - arg_10_0.tr.rect.height >= 50 then
		local var_10_2 = var_10_1

		var_10_3 = var_10_1.GetComponent
		typeof = var_1_10008
		Image = var_1_10009
		var_10_3 = var_10_3(var_10_2, var_1_10008(var_1_10009))
		var_1_10008 = arg_10_0

		local var_10_4 = arg_10_0.GetBg(var_1_10008, arg_10_1 + 2)

		if arg_10_0.names[var_10_1] ~= var_10_4 then
			var_1_10009 = arg_10_0

			arg_10_0.LoadImage(var_1_10009, var_10_4, function(arg_11_0)
				setActive = var_2_10001

				var_2_10001(var_10_1, true)

				var_10_3.sprite = arg_11_0

				local var_11_0 = var_10_3

				var_1.SetNativeSize(var_11_0)

				return
			end)

			var_1_10009 = arg_10_0

			arg_10_0.LoadEffect(var_1_10009, var_10_4, var_10_1)

			var_1_10008 = arg_10_0.names
			var_1_10008[var_10_1] = var_10_4
		end
	end

	math = var_10_3

	if var_10_3.abs(var_4.y) >= var_10_0.rect.height then
		local var_10_5 = var_10_0
		local var_10_6 = var_10_0.GetComponent

		typeof = var_1_10008
		Image = var_1_10009
		var_10_6(var_10_5, var_1_10008(var_1_10009)).sprite = nil
		arg_10_0.names[var_10_0] = nil

		var_10_0:SetAsFirstSibling()

		arg_10_0.list[arg_10_1 + 3] = var_10_0

		local var_10_7 = arg_10_0.list

		var_10_7[arg_10_1] = false
		getAnchoredPosition = var_10_7

		local var_10_8 = var_10_7(var_10_1)

		setAnchoredPosition = var_7

		var_7(var_10_0, {
			y = var_10_8.y + var_10_1.rect.height
		})
		arg_10_0:ReturnEffect(var_10_0)
	end

	return
end

function var_0_0.GetBg(arg_12_0, arg_12_1)
	local var_12_0

	if not var_0_0.bgMaps[arg_12_1] then
		var_12_0 = var_0_0.bgMaps[#var_0_0.bgMaps]
	end

	return var_12_0
end

function var_0_0.LoadImage(arg_13_0, arg_13_1, arg_13_2)
	LoadSpriteAtlasAsync = var_1_10003

	var_1_10003("clutter/towerclimbing_bg" .. arg_13_1, nil, function(arg_14_0)
		arg_13_2(arg_14_0)

		return
	end)

	return
end

function var_0_0.LoadEffect(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = var_0_0.effects

	tonumber = var_1_10004

	if var_15_0[var_1_10004(arg_15_1)] then
		ipairs = var_4

		for iter_15_0, iter_15_1 in var_4(var_3) do
			local var_15_1 = iter_15_1[1]
			local var_15_2 = iter_15_1[2]

			PoolMgr = var_1_10011

			local var_15_3 = var_1_10011.GetInstance()

			var_1_10011.GetUI(var_15_3, var_15_1, true, function(arg_16_0)
				if not arg_15_0.list then
					PoolMgr = var_1

					local var_16_0 = var_1.GetInstance()

					var_1.ReturnUI(var_16_0, var_15_1, arg_16_0)
				else
					arg_16_0.name = var_15_1
					SetParent = var_1

					var_1(arg_16_0, arg_15_2)

					local var_16_1 = arg_16_0.transform

					Vector3 = var_2
					var_16_1.anchoredPosition3D = var_2(var_15_2[1], var_15_2[2], -200)
					setActive = var_16_1

					var_16_1(arg_16_0, true)
				end

				return
			end)
		end
	end

	return
end

function var_0_0.ReturnEffect(arg_17_0, arg_17_1)
	if arg_17_1.childCount > 0 then
		for iter_17_0 = 1, var_2 do
			local var_17_0 = arg_17_1
			local var_17_1 = arg_17_1.GetChild(var_17_0, iter_17_0 - 1)

			PoolMgr = var_17_0

			local var_17_2 = var_17_0.GetInstance()

			var_8.ReturnUI(var_17_2, var_17_1.name, var_17_1.gameObject)
		end
	end

	return
end

function var_0_0.Clear(arg_18_0)
	eachChild = var_1_10001

	var_1_10001(arg_18_0.tr, function(arg_19_0)
		local var_19_0 = arg_19_0
		local var_19_1 = arg_19_0.GetComponent

		typeof = var_2_10003
		Image = var_2_10004
		var_19_1(var_19_0, var_2_10003(var_2_10004)).sprite = nil

		local var_19_2 = arg_18_0

		var_1.ReturnEffect(var_19_2, arg_19_0)

		return
	end)

	arg_18_0.list = nil
	arg_18_0.names = nil

	return
end

return var_0_0
