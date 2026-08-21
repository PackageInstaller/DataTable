module("framework.resource.rescache.MultiResLoader", package.seeall)

local var_0_0 = class("MultiResLoader")

function var_0_0.ctor(arg_1_0)
	arg_1_0._loadedResDict = {}
	arg_1_0._resPaths = {}
	arg_1_0._resPreloadFlags = {}
	arg_1_0._resTypeList = {}
	arg_1_0._isAllPreload = false
	arg_1_0._callbackObj = false
	arg_1_0._finishCallback = false
	arg_1_0._progressCallback = false
	arg_1_0.loadedCount = 0
	arg_1_0.totalCount = 0
	arg_1_0.successCount = 0
end

function var_0_0.isAllSuccess(arg_2_0)
	return arg_2_0.totalCount == arg_2_0.successCount
end

function var_0_0.addResPath(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 == nil then
		arg_3_2 = false
	end

	if arg_3_3 == nil then
		arg_3_3 = ResType.AssetBunble
	end

	table.insert(arg_3_0._resPaths, arg_3_1)
	table.insert(arg_3_0._resPreloadFlags, arg_3_2)
	table.insert(arg_3_0._resTypeList, arg_3_3)
end

function var_0_0.setResPaths(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._resPaths = arg_4_1
	arg_4_0._resPreloadFlags = arg_4_2 or false
	arg_4_0._resTypeList = arg_4_3 or false
end

function var_0_0.setAllPreload(arg_5_0)
	arg_5_0._isAllPreload = true
end

function var_0_0.load(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_0._resPaths == nil or #arg_6_0._resPaths == 0 then
		arg_6_1(arg_6_3, arg_6_0)

		return
	end

	arg_6_0._finishCallback = arg_6_1 or false
	arg_6_0._progressCallback = arg_6_2 or false
	arg_6_0._callbackObj = arg_6_3 or false
	arg_6_0.totalCount = #arg_6_0._resPaths

	local var_6_0 = false
	local var_6_1 = ResType.AssetBunble

	for iter_6_0 = 1, arg_6_0.totalCount do
		if arg_6_0._isAllPreload then
			var_6_0 = true
		elseif arg_6_0._resPreloadFlags then
			var_6_0 = arg_6_0._resPreloadFlags[iter_6_0]
		else
			var_6_0 = false
		end

		if arg_6_0._resTypeList then
			var_6_1 = arg_6_0._resTypeList[iter_6_0]
		else
			var_6_1 = ResType.AssetBunble
		end

		getres(arg_6_0._resPaths[iter_6_0], var_0_0._onResLoaded, arg_6_0, var_6_1, var_6_0)
	end
end

function var_0_0._onResLoaded(arg_7_0, arg_7_1)
	if arg_7_0.totalCount == 0 then
		return
	end

	if arg_7_1.IsSuccess then
		arg_7_0.successCount = arg_7_0.successCount + 1

		if not arg_7_0._loadedResDict[arg_7_1.ResPath] then
			arg_7_0._loadedResDict[arg_7_1.ResPath] = arg_7_1

			arg_7_1:Retain()
		end
	end

	arg_7_0.loadedCount = arg_7_0.loadedCount + 1

	if arg_7_0._progressCallback then
		if arg_7_0._callbackObj then
			arg_7_0._progressCallback(arg_7_0._callbackObj, arg_7_1, arg_7_0.loadedCount, arg_7_0.totalCount)
		else
			arg_7_0._progressCallback(arg_7_1, arg_7_0.loadedCount, arg_7_0.totalCount)
		end
	end

	if arg_7_0.loadedCount >= arg_7_0.totalCount and arg_7_0._finishCallback then
		if arg_7_0._callbackObj then
			arg_7_0._finishCallback(arg_7_0._callbackObj, arg_7_0)
		else
			arg_7_0._finishCallback(arg_7_0)
		end
	end
end

function var_0_0.isLoadAll(arg_8_0)
	return arg_8_0.loadedCount >= arg_8_0.totalCount
end

function var_0_0.getResources(arg_9_0)
	return arg_9_0._loadedResDict
end

function var_0_0.getResource(arg_10_0, arg_10_1)
	return arg_10_0._loadedResDict[arg_10_1]
end

function var_0_0.clear(arg_11_0)
	if arg_11_0.totalCount == 0 then
		return
	end

	if arg_11_0.loadedCount < arg_11_0.totalCount then
		for iter_11_0 = 1, arg_11_0.totalCount do
			removeresl(arg_11_0._resPaths[iter_11_0], var_0_0._onResLoaded, arg_11_0)
		end
	end

	for iter_11_1, iter_11_2 in pairs(arg_11_0._loadedResDict) do
		iter_11_2:Release()
	end

	table.clear(arg_11_0._loadedResDict)
	table.clear(arg_11_0._resPaths)
	table.clear(arg_11_0._resPreloadFlags)
	table.clear(arg_11_0._resTypeList)

	arg_11_0._isAllPreload = false
	arg_11_0._callbackObj = false
	arg_11_0._finishCallback = false
	arg_11_0._progressCallback = false
	arg_11_0.loadedCount = 0
	arg_11_0.totalCount = 0
	arg_11_0.successCount = 0
end

return var_0_0
