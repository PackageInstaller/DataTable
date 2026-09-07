pg = pg or {}
pg.FontMgr = singletonClass("FontMgr")

function pg.FontMgr.Init(arg_1_0, arg_1_1)
	print("initializing font manager...")

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs({
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
		table.insert(var_1_0, function(arg_2_0)
			AssetBundleHelper.StoreAssetBundle("font/" .. iter_1_1, true, false, function(arg_3_0)
				arg_2_0()

				return
			end)

			return
		end)
	end

	parallelAsync(var_1_0, function(arg_4_0)
		arg_1_1(arg_4_0)

		return
	end)

	return
end

return
