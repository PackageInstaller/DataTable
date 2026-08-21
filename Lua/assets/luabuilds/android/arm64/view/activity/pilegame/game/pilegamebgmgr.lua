local var_0_0 = class("PileGameBgMgr")

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

		arg_2_1()

		return
	end)

	return
end

function var_0_0.DoMove(arg_6_0, arg_6_1)
	local var_6_0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.list) do
		if iter_6_1 then
			local var_6_1

			if not var_6_0 then
				var_6_0 = iter_6_0
				var_6_1 = iter_6_1
			end

			;({}).y = getAnchoredPosition(iter_6_1).y - arg_6_1

			setAnchoredPosition(iter_6_1, {})
		end
	end

	arg_6_0:DoCheck(var_6_0)

	return
end

function var_0_0.DoCheck(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.list[arg_7_1 + 2]
	local var_7_1 = getAnchoredPosition(arg_7_0.list[arg_7_1])

	if var_7_1.y + arg_7_0.list[arg_7_1].rect.height + arg_7_0.list[arg_7_1 + 1].rect.height - arg_7_0.tr.rect.height >= 50 then
		local var_7_2 = arg_7_0.list[arg_7_1 + 2]:GetComponent(typeof(Image))
		local var_7_3 = arg_7_0:GetBg(arg_7_1 + 2)

		if arg_7_0.names[arg_7_0.list[arg_7_1 + 2]] ~= var_7_3 then
			arg_7_0:LoadImage(var_7_3, function(arg_8_0)
				setActive(var_7_0, true)

				var_7_2.sprite = arg_8_0

				var_7_2:SetNativeSize()

				return
			end)
			arg_7_0:LoadEffect(var_7_3, arg_7_0.list[arg_7_1 + 2])

			arg_7_0.names[arg_7_0.list[arg_7_1 + 2]] = var_7_3
		end
	end

	if math.abs(var_7_1.y) >= arg_7_0.list[arg_7_1].rect.height then
		arg_7_0.list[arg_7_1]:GetComponent(typeof(Image)).sprite = nil
		arg_7_0.names[arg_7_0.list[arg_7_1]] = nil

		arg_7_0.list[arg_7_1]:SetAsFirstSibling()

		arg_7_0.list[arg_7_1 + 3] = arg_7_0.list[arg_7_1]
		arg_7_0.list[arg_7_1] = false

		setAnchoredPosition(arg_7_0.list[arg_7_1], {
			y = getAnchoredPosition(arg_7_0.list[arg_7_1 + 2]).y + arg_7_0.list[arg_7_1 + 2].rect.height
		})
		arg_7_0:ReturnEffect(arg_7_0.list[arg_7_1])
	end

	return
end

function var_0_0.GetBg(arg_9_0, arg_9_1)
	return var_0_0.bgMaps[arg_9_1] or var_0_0.bgMaps[#var_0_0.bgMaps]
end

function var_0_0.LoadImage(arg_10_0, arg_10_1, arg_10_2)
	LoadSpriteAtlasAsync("clutter/bg" .. arg_10_1, nil, function(arg_11_0)
		arg_10_2(arg_11_0)

		return
	end)

	return
end

function var_0_0.LoadEffect(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = var_0_0.effects[tonumber(arg_12_1)]

	if var_12_0 then
		PoolMgr.GetInstance():GetUI(var_12_0, true, function(arg_13_0)
			if not arg_12_0.list then
				PoolMgr.GetInstance():ReturnUI(var_12_0, arg_13_0)
			else
				arg_13_0.name = var_12_0

				SetParent(arg_13_0, arg_12_2)
				setActive(arg_13_0, true)
			end

			return
		end)
	end

	return
end

function var_0_0.ReturnEffect(arg_14_0, arg_14_1)
	if arg_14_1.childCount > 0 then
		local var_14_0 = arg_14_1:GetChild(0)

		PoolMgr.GetInstance():ReturnUI(var_14_0.name, var_14_0.gameObject)
	end

	return
end

function var_0_0.Clear(arg_15_0)
	eachChild(arg_15_0.tr, function(arg_16_0)
		arg_16_0:GetComponent(typeof(Image)).sprite = nil

		arg_15_0:ReturnEffect(arg_16_0)

		return
	end)

	arg_15_0.list = nil
	arg_15_0.names = nil

	return
end

return var_0_0
