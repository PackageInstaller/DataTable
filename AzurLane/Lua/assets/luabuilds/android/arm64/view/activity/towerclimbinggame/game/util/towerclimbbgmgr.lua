local var_0_0 = class("TowerClimbBgMgr")
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
	var_0_0.bgMaps = var_0_1[arg_2_1]

	assert(var_0_0.bgMaps, arg_2_1)

	arg_2_0.list = {
		arg_2_0.tr:Find("Image1"),
		arg_2_0.tr:Find("Image2"),
		arg_2_0.tr:Find("Image3")
	}
	arg_2_0.names = {}

	for iter_2_0 = 1, 2 do
		setActive(arg_2_0.list[iter_2_0], false)
		table.insert({}, function(arg_3_0)
			local var_3_0 = arg_2_0:GetBg(iter_2_0)

			arg_2_0:LoadImage(var_3_0, function(arg_4_0)
				setActive(arg_2_0.list[iter_2_0], true)

				arg_2_0.list[iter_2_0]:GetComponent(typeof(Image)).sprite = arg_4_0

				arg_2_0.list[iter_2_0]:GetComponent(typeof(Image)):SetNativeSize()
				arg_3_0()

				return
			end)

			arg_2_0.names[arg_2_0.list[iter_2_0]] = var_3_0

			arg_2_0:LoadEffect(var_3_0, arg_2_0.list[iter_2_0])

			return
		end)
	end

	seriesAsync({}, function()
		local var_5_0 = 0

		for iter_5_0, iter_5_1 in ipairs(arg_2_0.list) do
			if arg_2_0.list[iter_5_0 - 1] then
				var_5_0 = var_5_0 + arg_2_0.list[iter_5_0 - 1].rect.height
			end

			setAnchoredPosition(iter_5_1, {
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
	local var_6_0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.list) do
		if iter_6_1 then
			var_6_0 = nil or iter_6_0

			table.insert({}, function(arg_7_0)
				LeanTween.value(iter_6_1.gameObject, iter_6_1.anchoredPosition.y, getAnchoredPosition(iter_6_1).y - arg_6_1 * 0.8, 0.2):setOnUpdate(System.Action_float(function(arg_8_0)
					setAnchoredPosition(iter_6_1, {
						y = arg_8_0
					})

					return
				end)):setEase(LeanTweenType.easeOutQuad):setOnComplete(System.Action(arg_7_0))

				return
			end)
		end
	end

	parallelAsync({}, function()
		arg_6_0:DoCheck(var_6_0)
		arg_6_2()

		return
	end)

	return
end

function var_0_0.DoCheck(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.list[arg_10_1 + 2]
	local var_10_1 = getAnchoredPosition(arg_10_0.list[arg_10_1])

	if var_10_1.y + arg_10_0.list[arg_10_1].rect.height + arg_10_0.list[arg_10_1 + 1].rect.height - arg_10_0.tr.rect.height >= 50 then
		local var_10_2 = arg_10_0.list[arg_10_1 + 2]:GetComponent(typeof(Image))
		local var_10_3 = arg_10_0:GetBg(arg_10_1 + 2)

		if arg_10_0.names[arg_10_0.list[arg_10_1 + 2]] ~= var_10_3 then
			arg_10_0:LoadImage(var_10_3, function(arg_11_0)
				setActive(var_10_0, true)

				var_10_2.sprite = arg_11_0

				var_10_2:SetNativeSize()

				return
			end)
			arg_10_0:LoadEffect(var_10_3, arg_10_0.list[arg_10_1 + 2])

			arg_10_0.names[arg_10_0.list[arg_10_1 + 2]] = var_10_3
		end
	end

	if math.abs(var_10_1.y) >= arg_10_0.list[arg_10_1].rect.height then
		arg_10_0.list[arg_10_1]:GetComponent(typeof(Image)).sprite = nil
		arg_10_0.names[arg_10_0.list[arg_10_1]] = nil

		arg_10_0.list[arg_10_1]:SetAsFirstSibling()

		arg_10_0.list[arg_10_1 + 3] = arg_10_0.list[arg_10_1]
		arg_10_0.list[arg_10_1] = false

		setAnchoredPosition(arg_10_0.list[arg_10_1], {
			y = getAnchoredPosition(arg_10_0.list[arg_10_1 + 2]).y + arg_10_0.list[arg_10_1 + 2].rect.height
		})
		arg_10_0:ReturnEffect(arg_10_0.list[arg_10_1])
	end

	return
end

function var_0_0.GetBg(arg_12_0, arg_12_1)
	return var_0_0.bgMaps[arg_12_1] or var_0_0.bgMaps[#var_0_0.bgMaps]
end

function var_0_0.LoadImage(arg_13_0, arg_13_1, arg_13_2)
	LoadSpriteAtlasAsync("clutter/towerclimbing_bg" .. arg_13_1, nil, function(arg_14_0)
		arg_13_2(arg_14_0)

		return
	end)

	return
end

function var_0_0.LoadEffect(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = var_0_0.effects[tonumber(arg_15_1)]

	if var_15_0 then
		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			local var_15_1 = iter_15_1[2]

			PoolMgr.GetInstance():GetUI(iter_15_1[1], true, function(arg_16_0)
				if not arg_15_0.list then
					PoolMgr.GetInstance():ReturnUI(var_0, arg_16_0)
				else
					arg_16_0.name = var_0

					SetParent(arg_16_0, arg_15_2)

					arg_16_0.transform.anchoredPosition3D = Vector3(var_15_1[1], var_15_1[2], -200)

					setActive(arg_16_0, true)
				end

				return
			end)
		end
	end

	return
end

function var_0_0.ReturnEffect(arg_17_0, arg_17_1)
	if arg_17_1.childCount > 0 then
		for iter_17_0 = 1, arg_17_1.childCount do
			local var_17_0 = arg_17_1:GetChild(iter_17_0 - 1)

			PoolMgr.GetInstance():ReturnUI(var_17_0.name, var_17_0.gameObject)
		end
	end

	return
end

function var_0_0.Clear(arg_18_0)
	eachChild(arg_18_0.tr, function(arg_19_0)
		arg_19_0:GetComponent(typeof(Image)).sprite = nil

		arg_18_0:ReturnEffect(arg_19_0)

		return
	end)

	arg_18_0.list = nil
	arg_18_0.names = nil

	return
end

return var_0_0
