class = var_0_10000

local var_0_0 = var_0_10000("PileGameBgMgr")

var_0_0.bgMaps = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"10",
	"11",
	"12"
}
var_0_0.effects = {
	[0] = "diediele_1yanhua",
	nil,
	"diediele_2liuxin",
	"diediele_2liuxin",
	12,
	"diediele_3xinxin",
	[nil] = nil
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.tr = arg_1_1

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	local var_2_0 = {}
	local var_2_1 = arg_2_0.tr

	var_2_0[1] = var_3.Find(var_2_1, "Image1")

	local var_2_2 = arg_2_0.tr

	var_2_0[2] = var_3.Find(var_2_2, "Image2")

	local var_2_3 = arg_2_0.tr

	var_2_0[3] = var_3.Find(var_2_3, "Image3")
	arg_2_0.list = var_2_0
	arg_2_0.names = {}

	local var_2_4 = {}

	for iter_2_0 = 1, 2 do
		setActive = var_1_10007

		var_1_10007(arg_2_0.list[iter_2_0], false)

		table = var_1_10007

		var_1_10007.insert(var_2_4, function(arg_3_0)
			local var_3_0 = arg_2_0
			local var_3_1 = var_1.GetBg(var_3_0, iter_2_0)
			local var_3_2 = arg_2_0

			var_2.LoadImage(var_3_2, var_3_1, function(arg_4_0)
				setActive = var_3_10001

				var_3_10001(arg_2_0.list[iter_2_0], true)

				local var_4_0 = arg_2_0.list[iter_2_0]
				local var_4_1 = var_1.GetComponent

				typeof = var_4
				Image = var_3_10006
				var_4_1(var_4_0, var_4(var_3_10006)).sprite = arg_4_0

				arg_3_0()

				return
			end)

			arg_2_0.names[arg_2_0.list[iter_2_0]] = var_3_1

			local var_3_3 = arg_2_0

			var_2.LoadEffect(var_3_3, var_3_1, arg_2_0.list[iter_2_0])

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_2_4, function()
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

		arg_2_1()

		return
	end)

	return
end

function var_0_0.DoMove(arg_6_0, arg_6_1)
	local var_6_0

	ipairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_0.list) do
		if iter_6_1 then
			var_6_0 = var_6_0 or iter_6_0
			getAnchoredPosition = var_1_10008
			var_1_10008 = var_1_10008(iter_6_1)
			setAnchoredPosition = var_1_10009

			var_1_10009(iter_6_1, {
				y = var_1_10008.y - arg_6_1
			})
		end
	end

	arg_6_0:DoCheck(var_6_0)

	return
end

function var_0_0.DoCheck(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.list[arg_7_1]
	local var_7_1 = arg_7_0.list[arg_7_1 + 2]

	getAnchoredPosition = var_4

	local var_7_3

	if var_4(var_7_0).y + var_7_0.rect.height + arg_7_0.list[arg_7_1 + 1].rect.height - arg_7_0.tr.rect.height >= 50 then
		local var_7_2 = var_7_1

		var_7_3 = var_7_1.GetComponent
		typeof = var_1_10009
		Image = var_1_10011
		var_7_3 = var_7_3(var_7_2, var_1_10009(var_1_10011))
		var_1_10009 = arg_7_0

		local var_7_4 = arg_7_0.GetBg(var_1_10009, arg_7_1 + 2)

		if arg_7_0.names[var_7_1] ~= var_7_4 then
			arg_7_0:LoadImage(var_7_4, function(arg_8_0)
				setActive = var_2_10001

				var_2_10001(var_7_1, true)

				var_7_3.sprite = arg_8_0

				local var_8_0 = var_7_3

				var_1.SetNativeSize(var_8_0)

				return
			end)
			arg_7_0:LoadEffect(var_7_4, var_7_1)

			arg_7_0.names[var_7_1] = var_7_4
		end
	end

	math = var_7_3

	if var_7_3.abs(var_4.y) >= var_7_0.rect.height then
		local var_7_5 = var_7_0
		local var_7_6 = var_7_0.GetComponent

		typeof = var_1_10009
		Image = var_1_10011
		var_7_6(var_7_5, var_1_10009(var_1_10011)).sprite = nil
		arg_7_0.names[var_7_0] = nil

		var_7_0:SetAsFirstSibling()

		arg_7_0.list[arg_7_1 + 3] = var_7_0

		local var_7_7 = arg_7_0.list

		var_7_7[arg_7_1] = false
		getAnchoredPosition = var_7_7

		local var_7_8 = var_7_7(var_7_1)

		setAnchoredPosition = var_7

		var_7(var_7_0, {
			y = var_7_8.y + var_7_1.rect.height
		})
		arg_7_0:ReturnEffect(var_7_0)
	end

	return
end

function var_0_0.GetBg(arg_9_0, arg_9_1)
	local var_9_0

	if not var_0_0.bgMaps[arg_9_1] then
		var_9_0 = var_0_0.bgMaps[#var_0_0.bgMaps]
	end

	return var_9_0
end

function var_0_0.LoadImage(arg_10_0, arg_10_1, arg_10_2)
	LoadSpriteAtlasAsync = var_1_10003

	var_1_10003("clutter/bg" .. arg_10_1, nil, function(arg_11_0)
		arg_10_2(arg_11_0)

		return
	end)

	return
end

function var_0_0.LoadEffect(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = var_0_0.effects

	tonumber = var_1_10004

	if var_12_0[var_1_10004(arg_12_1)] then
		PoolMgr = var_4

		local var_12_1 = var_4.GetInstance()

		var_4.GetUI(var_12_1, var_3, true, function(arg_13_0)
			if not arg_12_0.list then
				PoolMgr = var_1

				local var_13_0 = var_1.GetInstance()

				var_1.ReturnUI(var_13_0, var_0, arg_13_0)
			else
				arg_13_0.name = var_0
				SetParent = var_1

				var_1(arg_13_0, arg_12_2)

				setActive = var_1

				var_1(arg_13_0, true)
			end

			return
		end)
	end

	return
end

function var_0_0.ReturnEffect(arg_14_0, arg_14_1)
	if arg_14_1.childCount > 0 then
		local var_14_0 = arg_14_1:GetChild(0)

		PoolMgr = var_1_10004

		local var_14_1 = var_1_10004.GetInstance()

		var_4.ReturnUI(var_14_1, var_14_0.name, var_14_0.gameObject)
	end

	return
end

function var_0_0.Clear(arg_15_0)
	eachChild = var_1_10001

	var_1_10001(arg_15_0.tr, function(arg_16_0)
		local var_16_0 = arg_16_0
		local var_16_1 = arg_16_0.GetComponent

		typeof = var_2_10004
		Image = var_2_10006
		var_16_1(var_16_0, var_2_10004(var_2_10006)).sprite = nil

		local var_16_2 = arg_15_0

		var_1.ReturnEffect(var_16_2, arg_16_0)

		return
	end)

	arg_15_0.list = nil
	arg_15_0.names = nil

	return
end

return var_0_0
