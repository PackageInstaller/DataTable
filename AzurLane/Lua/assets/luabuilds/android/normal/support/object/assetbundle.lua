pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
class = var_0_10001
var_0.AssetBundle = var_0_10001("AssetBundle")

function var_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.path = arg_1_1

	return
end

function var_1.Load(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	assert = var_1_10004

	var_1_10004(not arg_2_0.ab)

	arg_2_0.abs = {}

	if arg_2_1 then
		seriesAsync = var_2_0

		var_2_0({
			function(arg_3_0)
				if not arg_2_2 then
					return arg_3_0()
				end

				table = var_1

				local var_3_0 = var_1.CArrayToArray

				ResourceMgr = var_2_10002

				local var_3_1 = var_2_10002.Inst
				local var_3_2 = var_3_0(var_2.GetAllDependencies(var_3_1, arg_2_0.path))

				parallelAsync = var_2
				underscore = var_3_1

				var_2(var_3_1.map(var_3_2, function(arg_4_0)
					return function(arg_5_0)
						AssetBundleHelper = var_4_10001

						var_4_10001.LoadAssetBundle(arg_4_0, arg_2_1, false, function(arg_6_0)
							table = var_5_10001

							var_5_10001.insert(arg_2_0.abs, arg_6_0)
							arg_5_0()

							return
						end)

						return
					end
				end), arg_3_0)

				return
			end
		}, function()
			ResourceMgr = var_2_10000

			local var_7_0 = var_2_10000.Inst

			var_0.loadAssetBundleAsync(var_7_0, arg_2_0.path, function(arg_8_0)
				local var_8_0 = arg_2_0

				var_8_0.ab = arg_8_0
				existCall = var_8_0

				var_8_0(arg_2_3, arg_2_0)

				return
			end)

			return
		end)
	else
		local var_2_0

		if arg_2_2 then
			table = var_2_0
			var_2_0 = var_2_0.CArrayToArray
			ResourceMgr = var_5

			local var_2_1 = var_5.Inst

			var_2_0 = var_2_0(var_5.GetAllDependencies(var_2_1, arg_2_0.path))
			ipairs = var_5

			for iter_2_0, iter_2_1 in var_5(var_2_0) do
				table = var_1_10010
				var_1_10010 = var_1_10010.insert

				local var_2_2 = arg_2_0.abs

				AssetBundleHelper = var_1_10012

				var_1_10010(var_2_2, var_1_10012.LoadAssetBundle(iter_2_1, arg_2_1, false, nil))
			end
		end

		ResourceMgr = var_2_0

		local var_2_3 = var_2_0.Inst

		arg_2_0.ab = var_4.loadAssetBundleSync(var_2_3, arg_2_0.path)
		existCall = var_4

		var_4(arg_2_3, arg_2_0)

		return arg_2_0
	end

	return
end

function var_1.LoadAssetSync(arg_9_0, arg_9_1, ...)
	local var_9_0 = arg_9_0

	arg_9_1 = arg_9_0.ChangeAssetName(var_9_0, arg_9_1)

	if not arg_9_0.ab then
		warning = var_2
		string = var_9_0

		var_2(var_9_0.format("without assetbundle:%s", arg_9_0.path))

		return nil
	end

	ResourceMgr = var_2

	local var_9_1 = var_2.Inst

	return var_2.LoadAssetSync(var_9_1, arg_9_0.ab, arg_9_1, ...)
end

function var_1.LoadAssetAsync(arg_10_0, arg_10_1, arg_10_2, arg_10_3, ...)
	local var_10_0 = arg_10_0

	arg_10_1 = arg_10_0.ChangeAssetName(var_10_0, arg_10_1)

	if not arg_10_0.ab then
		warning = var_4
		string = var_10_0

		var_4(var_10_0.format("without assetbundle:%s", arg_10_0.path))

		return nil
	end

	ResourceMgr = var_4

	local var_10_1 = var_4.Inst
	local var_10_2 = var_4.LoadAssetAsync
	local var_10_3 = arg_10_0.ab
	local var_10_4 = arg_10_1
	local var_10_5 = arg_10_2

	UnityEngine = var_1_10009

	return var_10_2(var_10_1, var_10_3, var_10_4, var_10_5, var_1_10009.Events.UnityAction_UnityEngine_Object(arg_10_3), ...)
end

function var_1.GetAllAssetNames(arg_11_0)
	table = var_1_10001

	local var_11_0 = var_1_10001.CArrayToArray
	local var_11_1 = arg_11_0.ab

	return var_11_0(var_2.GetAllAssetNames(var_11_1))
end

function var_1.ChangeAssetName(arg_12_0, arg_12_1)
	if arg_12_1 ~= nil and arg_12_1 ~= "" then
		string = var_1_10002

		if var_1_10002.find(arg_12_1, "/") then
			var_1_10002 = arg_12_1 or ""

			return var_1_10002
		else
			AssetBundleHelper = var_1_10002

			if not var_1_10002.bundleDic[arg_12_0.path] then
				arg_12_0:BuildAssetNameDic()
			end
		end

		AssetBundleHelper = var_1_10002

		local var_12_0 = var_1_10002.bundleDic[arg_12_0.path]

		string = var_3

		local var_12_1

		if not var_12_0[var_3.lower(arg_12_1)] then
			var_12_1 = arg_12_1
		end

		return var_12_1
	end
end

function var_1.BuildAssetNameDic(arg_13_0)
	AssetBundleHelper = var_1_10001

	if var_1_10001.bundleDic[arg_13_0.path] then
		return
	end

	AssetBundleHelper = var_1

	var_1.BuildAssetNameDic(arg_13_0.path, arg_13_0:GetAllAssetNames())

	return
end

function var_1.ClearDependenciesBundle(arg_14_0)
	ipairs = var_1_10001

	for iter_14_0, iter_14_1 in var_1_10001(arg_14_0.abs) do
		iter_14_1:Dispose()
	end

	arg_14_0.abs = {}

	return
end

function var_1.ForceClearRef(arg_15_0, arg_15_1)
	arg_15_0:ClearDependenciesBundle()

	AssetBundleHelper = var_2

	var_2.UnloadAssetBundle(arg_15_0.path, arg_15_1)

	arg_15_0.ab = nil

	return
end

function var_1.Dispose(arg_16_0, arg_16_1)
	if arg_16_0.ab then
		arg_16_0:ForceClearRef(arg_16_1)
	end

	return
end

return
