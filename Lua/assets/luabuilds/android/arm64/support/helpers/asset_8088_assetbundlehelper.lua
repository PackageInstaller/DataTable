AssetBundleHelper = {}

local var_0_0 = AssetBundleHelper

function AssetBundleHelper.GetClass()
	if EDITOR_TOOL then
		return pg.AssetBundleEditor
	else
		return pg.AssetBundle
	end

	return
end

function AssetBundleHelper.LoadAssetBundle(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = var_0_0.GetClass().New(string.lower(arg_2_0))

	var_2_0:Load(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function AssetBundleHelper.UnloadAssetBundle(arg_3_0, arg_3_1, arg_3_2)
	if EDITOR_TOOL then
		-- block empty
	else
		ResourceMgr.Inst:ClearBundleRef(arg_3_0, defaultValue(arg_3_1, false), defaultValue(arg_3_2, false))
	end

	return
end

function AssetBundleHelper.AutoUnloadAssetBundle(arg_4_0, arg_4_1)
	onNextTick(function()
		if arg_4_1 then
			arg_4_0:Dispose()
		else
			arg_4_0:ClearDependenciesBundle()
		end

		return
	end)

	return
end

function AssetBundleHelper.LoadAsset(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	if arg_6_3 then
		AssetBundleHelper.LoadAssetBundle(arg_6_0, arg_6_3, true, function(arg_7_0)
			arg_7_0:LoadAssetAsync(arg_6_1, arg_6_2, function(arg_8_0)
				arg_6_4(arg_8_0)
				var_0_0.AutoUnloadAssetBundle(arg_7_0, arg_6_5)

				return
			end, false, false)

			return
		end)
	else
		local var_6_0 = AssetBundleHelper.LoadAssetBundle(arg_6_0, arg_6_3, true)
		local var_6_1 = var_6_0:LoadAssetSync(arg_6_1, arg_6_2, false, false)

		existCall(arg_6_4, var_6_1)
		var_0_0.AutoUnloadAssetBundle(var_6_0, arg_6_5)

		return var_6_1
	end

	return
end

function AssetBundleHelper.LoadManyAssets(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_0 = {}

	if arg_9_3 then
		AssetBundleHelper.LoadAssetBundle(arg_9_0, arg_9_3, true, function(arg_10_0)
			parallelAsync(underscore.map(arg_9_1, function(arg_11_0)
				return function(arg_12_0)
					arg_10_0:LoadAssetAsync(arg_11_0, arg_9_2, function(arg_13_0)
						var_9_0[arg_11_0] = arg_13_0

						arg_12_0()

						return
					end, false, false)

					return
				end
			end), function()
				arg_9_4(var_9_0)
				var_0_0.AutoUnloadAssetBundle(arg_10_0, arg_9_5)

				return
			end)

			return
		end)
	else
		local var_9_1 = AssetBundleHelper.LoadAssetBundle(arg_9_0, arg_9_3, true)

		for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
			var_9_0[iter_9_1] = var_9_1:LoadAssetSync(iter_9_1, arg_9_2, false, false)
		end

		existCall(arg_9_4, var_9_0)
		var_0_0.AutoUnloadAssetBundle(var_9_1, arg_9_5)

		return var_9_0
	end

	return
end

local var_0_1 = {}

function AssetBundleHelper.StoreAssetBundle(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	var_0_1[arg_15_0] = var_0_1[arg_15_0] or {}

	table.insert(var_0_1[arg_15_0], var_0_0.LoadAssetBundle(arg_15_0, arg_15_1, arg_15_2, arg_15_3))

	return
end

function AssetBundleHelper.UnstoreAssetBundle(arg_16_0, arg_16_1)
	table.remove(var_0_1[arg_16_0]):Dispose(arg_16_1)

	return
end

AssetBundleHelper.bundleDic = {}
AssetBundleHelper.bundleCount = 0

function AssetBundleHelper.BuildAssetNameDic(arg_17_0, arg_17_1)
	if var_0_0.bundleDic[arg_17_0] then
		return
	end

	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		var_17_0[iter_17_1] = iter_17_1
		var_17_0[string.lower(iter_17_1)] = iter_17_1

		local var_17_2 = GetFileName(iter_17_1)

		var_17_0[var_17_2] = iter_17_1
		var_17_0[string.lower(var_17_2)] = iter_17_1

		local var_17_3 = string.split(var_17_2, ".")[1]

		if var_17_3 then
			var_17_0[var_17_3] = iter_17_1
			var_17_0[string.lower(var_17_3)] = iter_17_1
		end
	end

	if var_0_0.bundleCount > 500 then
		var_0_0.bundleCount = 0
		var_0_0.bundleDic = {}
	end

	var_0_0.bundleCount = var_0_0.bundleCount + 1
	var_0_0.bundleDic[arg_17_0] = var_17_0

	return
end

function AssetBundleHelper.GetTotalRefList(arg_18_0)
	if not arg_18_0 or #arg_18_0 == 0 then
		return {}
	end

	local var_18_0 = ResourceMgr.Inst:GetFullDependencies(arg_18_0)
	local var_18_1 = {}

	for iter_18_0 = 0, var_18_0.Length - 1 do
		if not table.contains(var_18_1, var_18_0[iter_18_0]) then
			table.insert(var_18_1, var_18_0[iter_18_0])
		end
	end

	return var_18_1
end

return AssetBundleHelper
