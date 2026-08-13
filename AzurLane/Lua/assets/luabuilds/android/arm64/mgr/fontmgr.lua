pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.FontMgr = var_0_10001("FontMgr")

function var_0.FontMgr.Init(arg_1_0, arg_1_1)
	print = var_1_10002

	var_1_10002("initializing font manager...")

	local var_1_0 = {}

	pairs = var_1_10003

	for iter_1_0, iter_1_1 in var_1_10003({
		weijichuanFont = "weijichuanFont",
		remfont = "remfont",
		chuanjiadanFont = "chuanjiadanFont",
		heitibold = "ZhunYuan_Bold",
		crifont = "crifont",
		heiti = "zhunyuan",
		explofont = "explofont",
		impact = "impact",
		countnumber = "countnumber",
		weaponcountfont = "weaponcountfont",
		missfont = "missfont",
		treatfont = "treatfont",
		MStiffHei = "MStiffHei",
		lvnumber = "lvnumber",
		number = "number",
		sourcehanserifcn = "sourcehanserifcn-bold_0",
		bankgthd = "bankgthd"
	}) do
		table = var_1_10008

		var_1_10008.insert(var_1_0, function(arg_2_0)
			AssetBundleHelper = var_2_10001

			var_2_10001.StoreAssetBundle("font/" .. iter_1_1, true, false, function(arg_3_0)
				arg_2_0()

				return
			end)

			return
		end)
	end

	parallelAsync = var_3

	var_3(var_1_0, function(arg_4_0)
		arg_1_1(arg_4_0)

		return
	end)

	return
end

return
