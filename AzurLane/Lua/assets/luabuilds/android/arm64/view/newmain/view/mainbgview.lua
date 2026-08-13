class = var_0_10000

local var_0_0 = "MainBGView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.MainBaseView"))
local var_0_2 = {
	{
		{
			0,
			5
		},
		"bg_main_night"
	},
	{
		{
			5,
			8
		},
		"bg_main_twilight"
	},
	{
		{
			8,
			16
		},
		"bg_main_day"
	},
	{
		{
			16,
			19
		},
		"bg_main_twilight"
	},
	{
		{
			19,
			24
		},
		"bg_main_night"
	}
}
local var_0_3 = 0

function var_0_1.GetBgAndBgm()
	local var_1_0 = var_0_2

	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_1_1 = var_1_10001(var_1_10003)
	local var_1_2 = var_1.RawGetActivityById

	pg = var_1_10004

	if var_1_2(var_1_1, var_1_10004.gameset.dayandnight_bgm.key_value) and not var_1:isEnd() then
		pg = var_1_10002
		var_1_0 = var_1_10002.gameset.dayandnight_bgm.description
	end

	pg = var_1_10002

	local var_1_3 = var_1_10002.TimeMgr.GetInstance()
	local var_1_4 = var_2.GetServerHour(var_1_3)

	ipairs = var_1_1

	for iter_1_0, iter_1_1 in var_1_1(var_1_0) do
		if var_1_4 >= iter_1_1[1][1] and var_1_4 < var_8[2] then
			return iter_1_1[2], iter_1_1[3]
		end
	end

	return
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	var_0_1.super.Ctor(arg_2_0, arg_2_1, nil)

	arg_2_0._tf = arg_2_1
	arg_2_0._go = arg_2_1.gameObject

	local var_2_0 = {}
	local var_2_1 = arg_2_1.parent.parent
	local var_2_2 = var_3.Find(var_2_1, "paintBg")
	local var_2_3 = var_3.GetComponent

	typeof = var_6
	Canvas = var_1_10008
	var_2_0[1] = var_2_3(var_2_2, var_6(var_1_10008))

	local var_2_4 = arg_2_1.parent.parent
	local var_2_5 = var_3.Find(var_2_4, "paint")
	local var_2_6 = var_3.GetComponent

	typeof = var_6
	Canvas = var_1_10008
	var_2_0[2] = var_2_6(var_2_5, var_6(var_1_10008))
	arg_2_0.paintingCanvases = var_2_0
	arg_2_0.isSpecialBg = false
	arg_2_0.isloading = false

	return
end

function var_0_1.getUIName(arg_3_0)
	return "MainBGView"
end

function var_0_1.Init(arg_4_0, arg_4_1)
	arg_4_0.ship = arg_4_1

	arg_4_0:ClearSpecailBg()

	arg_4_0.isSpecialBg = arg_4_1:getShipBgPrint() ~= arg_4_1:rarity2bgPrintForGet()
	MainPaintingView = var_3

	local var_4_0, var_4_1 = var_3.GetAssistantStatus(arg_4_1)

	arg_4_0._showBg = var_4_1

	if arg_4_0.isSpecialBg and var_4_1 then
		arg_4_0:SetSpecailBg(var_2)
		arg_4_0:ClearMapBg()
		arg_4_0:ClearCommonBg()
	elseif var_0_3 and var_0_3 ~= 0 then
		pg = var_5

		local var_4_2 = var_5.expedition_data_by_map[var_0_3]

		assert = var_6

		var_6(var_4_2, "expedition_data_by_map >>> " .. var_0_3)

		local var_4_3 = var_4_2.bg .. "_" .. var_4_2.ani_name

		if arg_4_0.mapLoaderKey ~= var_4_3 then
			arg_4_0:ClearMapBg()

			arg_4_0.mapLoaderKey = var_4_3

			arg_4_0:SetMapBg(var_4_2.bg, var_4_2.ani_name)
		end

		arg_4_0:ClearCommonBg()
	else
		local var_4_4 = var_0_1.GetBgAndBgm()

		if arg_4_0.commonBg == var_4_4 then
			return
		end

		arg_4_0:SetCommonBg(var_4_4)
		arg_4_0:ClearMapBg()

		arg_4_0.commonBg = var_4_4
	end

	return
end

function var_0_1.ClearCommonBg(arg_5_0)
	arg_5_0.commonBg = nil

	return
end

function var_0_1.Refresh(arg_6_0, arg_6_1)
	arg_6_0:Init(arg_6_1)

	return
end

function var_0_1.SetSpecailBg(arg_7_0, arg_7_1)
	arg_7_0.isloading = true

	local var_7_0 = var_0_1.GetBgAndBgm()

	pg = var_1_10003

	local var_7_1 = var_1_10003.DynamicBgMgr.GetInstance()

	var_3.LoadBg(var_7_1, arg_7_0, arg_7_1, arg_7_0._tf.parent, arg_7_0._tf, function(arg_8_0)
		local var_8_0 = arg_7_0

		var_1.SetCommonBg(var_8_0, var_7_0)

		setActive = var_1

		var_1(arg_7_0._tf, true)

		tf = var_1

		local var_8_1 = var_1(arg_8_0)

		var_1.SetAsLastSibling(var_8_1)

		arg_7_0.isloading = false

		local var_8_2 = arg_8_0.transform

		Vector3 = var_2
		var_8_2.localPosition = var_2(0, 0, 200)

		return
	end, function()
		arg_7_0.isloading = false

		return
	end)

	return
end

function var_0_1.SetMapBg(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.isloading = true
	arg_10_0.effectGo = nil
	parallelAsync = var_3

	var_3({
		function(arg_11_0)
			PoolMgr = var_2_10001

			local var_11_0 = var_2_10001.GetInstance()

			var_1.GetSprite(var_11_0, "levelmap/" .. arg_10_1, "", true, function(arg_12_0)
				setImageSprite = var_3_10001

				var_3_10001(arg_10_0._tf, arg_12_0)
				arg_11_0()

				return
			end)

			return
		end,
		function(arg_13_0)
			if not arg_10_2 or arg_10_2 == "" then
				arg_13_0()

				return
			end

			PoolMgr = var_1

			local var_13_0 = var_1.GetInstance()

			var_1.GetPrefab(var_13_0, "ui/" .. arg_10_2, "", true, function(arg_14_0)
				setParent = var_3_10001

				var_3_10001(arg_14_0, arg_10_0._tf)

				local var_14_0 = arg_10_0

				var_1.AdjustMapEffect(var_14_0, arg_14_0)

				arg_10_0.effectGo = arg_14_0

				arg_13_0()

				return
			end)

			return
		end
	}, function()
		arg_10_0.isloading = false

		return
	end)

	return
end

function var_0_1.ClearMapBg(arg_16_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_16_0.effectGo) then
		Object = var_1

		var_1.Destroy(arg_16_0.effectGo)

		arg_16_0.effectGo = nil
	end

	ipairs = var_1

	for iter_16_0, iter_16_1 in var_1(arg_16_0.paintingCanvases) do
		iter_16_1.overrideSorting = false
		iter_16_1.sortingOrder = 0
	end

	arg_16_0.mapLoaderKey = nil

	return
end

function var_0_1.AdjustMapEffect(arg_17_0, arg_17_1)
	math = var_1_10002

	local var_17_0 = -var_1_10002.huge
	local var_17_1 = arg_17_1
	local var_17_2 = arg_17_1.GetComponentsInChildren

	typeof = var_1_10006
	Canvas = var_1_10008

	local var_17_3 = var_17_2(var_17_1, var_1_10006(var_1_10008))
	local var_17_4 = var_3.ToTable(var_17_3)

	ipairs = var_1_10004

	for iter_17_0, iter_17_1 in var_1_10004(var_17_4) do
		if var_17_0 < iter_17_1.sortingOrder then
			var_17_0 = iter_17_1.sortingOrder
		end
	end

	local var_17_5 = arg_17_1
	local var_17_6 = arg_17_1.GetComponentsInChildren

	typeof = iter_17_0

	local var_17_7 = var_17_6(var_17_5, iter_17_0("UnityEngine.ParticleSystemRenderer"))
	local var_17_8 = var_4.ToTable(var_17_7)

	ipairs = var_5

	for iter_17_2, iter_17_3 in var_5(var_17_8) do
		if var_17_0 < iter_17_3.sortingOrder then
			var_17_0 = var_10
		end
	end

	ipairs = var_5

	for iter_17_4, iter_17_5 in var_5(arg_17_0.paintingCanvases) do
		iter_17_5.overrideSorting = true
		iter_17_5.sortingOrder = var_17_0 + (iter_17_4 == 3 and 2 or 1)
	end

	return
end

function var_0_1.SetCommonBg(arg_18_0, arg_18_1)
	setActive = var_1_10002

	var_1_10002(arg_18_0._tf, false)

	setActive = var_1_10002

	var_1_10002(arg_18_0._tf, true)

	local var_18_0 = arg_18_0._tf
	local var_18_1 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007

	local var_18_2 = var_18_1(var_18_0, var_5(var_1_10007)).sprite

	setImageSprite = var_18_0

	local var_18_3 = arg_18_0._tf

	LoadSprite = var_1_10007

	var_18_0(var_18_3, var_1_10007("commonbg/" .. arg_18_1, ""))

	if var_18_2 then
		Resources = var_18_0

		var_18_0.UnloadAsset(var_18_2.texture)
	end

	return
end

function var_0_1.ClearSpecailBg(arg_19_0)
	if arg_19_0.isSpecialBg then
		pg = var_1

		local var_19_0 = var_1.DynamicBgMgr.GetInstance()

		var_1.ClearBg(var_19_0, arg_19_0:getUIName())

		arg_19_0.isSpecialBg = false
	end

	return
end

function var_0_1.IsLoading(arg_20_0)
	return arg_20_0.isloading
end

function var_0_1.Disable(arg_21_0)
	arg_21_0:ClearSpecailBg()

	return
end

function var_0_1.Dispose(arg_22_0)
	var_0_1.super.Dispose(arg_22_0)
	arg_22_0:ClearSpecailBg()
	arg_22_0:ClearMapBg()

	return
end

return var_0_1
