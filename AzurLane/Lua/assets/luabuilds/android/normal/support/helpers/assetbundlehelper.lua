local var_0_0 = {}

AssetBundleHelper = AssetBundleHelper

function var_0.GetClass()
	EDITOR_TOOL = var_1_10000

	if var_1_10000 then
		pg = var_1_10000

		return var_1_10000.AssetBundleEditor
	else
		pg = var_1_10000

		return var_1_10000.AssetBundle
	end

	return
end

function var_0.LoadAssetBundle(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = var_0.GetClass().New

	string = var_1_10005

	local var_2_1 = var_2_0(var_1_10005.lower(arg_2_0))

	var_4.Load(var_2_1, arg_2_1, arg_2_2, arg_2_3)

	return var_4
end

function var_0.UnloadAssetBundle(arg_3_0, arg_3_1, arg_3_2)
	EDITOR_TOOL = var_1_10003

	if var_1_10003 then
		-- block empty
	else
		ResourceMgr = var_1_10003

		local var_3_0 = var_1_10003.Inst
		local var_3_1 = var_3.ClearBundleRef
		local var_3_2 = arg_3_0

		defaultValue = var_1_10006

		local var_3_3 = var_1_10006(arg_3_1, false)

		defaultValue = var_7

		var_3_1(var_3_0, var_3_2, var_3_3, var_7(arg_3_2, false))
	end

	return
end

function var_0.AutoUnloadAssetBundle(arg_4_0, arg_4_1)
	onNextTick = var_1_10002

	var_1_10002(function()
		if arg_4_1 then
			local var_5_0 = arg_4_0

			var_0.Dispose(var_5_0)
		else
			local var_5_1 = arg_4_0

			var_0.ClearDependenciesBundle(var_5_1)
		end

		return
	end)

	return
end

function var_0.LoadAsset(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	if arg_6_3 then
		AssetBundleHelper = var_1_10006

		var_1_10006.LoadAssetBundle(arg_6_0, arg_6_3, true, function(arg_7_0)
			arg_7_0:LoadAssetAsync(arg_6_1, arg_6_2, function(arg_8_0)
				arg_6_4(arg_8_0)
				var_0.AutoUnloadAssetBundle(arg_7_0, arg_6_5)

				return
			end, false, false)

			return
		end)
	else
		AssetBundleHelper = var_1_10006

		local var_6_0 = var_1_10006.LoadAssetBundle(arg_6_0, arg_6_3, true)
		local var_6_1 = var_6.LoadAssetSync(var_6_0, arg_6_1, arg_6_2, false, false)

		existCall = var_6_0

		var_6_0(arg_6_4, var_6_1)
		var_0.AutoUnloadAssetBundle(var_6, arg_6_5)

		return var_6_1
	end

	return
end

function var_0.LoadManyAssets(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_0 = {}

	if arg_9_3 then
		AssetBundleHelper = var_1_10007

		var_1_10007.LoadAssetBundle(arg_9_0, arg_9_3, true, function(arg_10_0)
			parallelAsync = var_2_10001
			underscore = var_2_10002

			var_2_10001(var_2_10002.map(arg_9_1, function(arg_11_0)
				return function(arg_12_0)
					local var_12_0 = arg_10_0

					var_1.LoadAssetAsync(var_12_0, arg_11_0, arg_9_2, function(arg_13_0)
						var_9_0[arg_11_0] = arg_13_0

						arg_12_0()

						return
					end, false, false)

					return
				end
			end), function()
				arg_9_4(var_9_0)
				var_0.AutoUnloadAssetBundle(arg_10_0, arg_9_5)

				return
			end)

			return
		end)
	else
		AssetBundleHelper = var_1_10007

		local var_9_1 = var_1_10007.LoadAssetBundle(arg_9_0, arg_9_3, true)

		ipairs = var_8

		for iter_9_0, iter_9_1 in var_8(arg_9_1) do
			var_9_0[iter_9_1] = var_9_1:LoadAssetSync(iter_9_1, arg_9_2, false, false)
		end

		existCall = var_8

		var_8(arg_9_4, var_9_0)
		var_0.AutoUnloadAssetBundle(var_9_1, arg_9_5)

		return var_9_0
	end

	return
end

local var_0_1 = {}

function var_0.StoreAssetBundle(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = var_0_1
	local var_15_1

	if not var_0_1[arg_15_0] then
		var_15_1 = {}
	end

	var_15_0[arg_15_0] = var_15_1
	table = var_15_0

	var_15_0.insert(var_0_1[arg_15_0], var_0.LoadAssetBundle(arg_15_0, arg_15_1, arg_15_2, arg_15_3))

	return
end

function var_0.UnstoreAssetBundle(arg_16_0, arg_16_1)
	table = var_1_10002

	local var_16_0 = var_1_10002.remove(var_0_1[arg_16_0])

	var_2.Dispose(var_16_0, arg_16_1)

	return
end

var_0.bundleDic = {}
var_0.bundleCount = 0

function var_0.BuildAssetNameDic(arg_17_0, arg_17_1)
	if var_0.bundleDic[arg_17_0] then
		return
	end

	local var_17_0 = {}

	ipairs = var_1_10003

	for iter_17_0, iter_17_1 in var_1_10003(arg_17_1) do
		var_17_0[iter_17_1] = iter_17_1
		string = var_1_10009
		var_17_0[var_1_10009.lower(var_8)] = iter_17_1
		GetFileName = var_1_10009
		var_17_0[var_1_10009(var_8)] = iter_17_1
		string = var_1_10009
		var_17_0[var_1_10009.lower(var_8)] = iter_17_1
		string = var_1_10009

		if var_1_10009.split(var_8, ".")[1] then
			var_17_0[var_8] = iter_17_1
			string = var_1_10009
			var_17_0[var_1_10009.lower(var_8)] = iter_17_1
		end
	end

	if var_0.bundleCount > 500 then
		var_0.bundleCount = 0
		var_0.bundleDic = {}
	end

	var_0.bundleCount = var_0.bundleCount + 1
	var_0.bundleDic[arg_17_0] = var_17_0

	return
end

function var_0.GetTotalRefList(arg_18_0)
	if not arg_18_0 or #arg_18_0 == 0 then
		return {}
	end

	ResourceMgr = var_1_10001

	local var_18_0 = var_1_10001.Inst
	local var_18_1 = var_1.GetFullDependencies(var_18_0, arg_18_0)
	local var_18_2 = {}

	for iter_18_0 = 0, var_18_1.Length - 1 do
		local var_18_3 = var_18_1[iter_18_0]

		table = var_1_10008

		if not var_1_10008.contains(var_18_2, var_18_3) then
			table = var_1_10008

			var_1_10008.insert(var_18_2, var_18_1[iter_18_0])
		end
	end

	return var_18_2
end

return var_0
