local var_0_0 = class("Dorm3dSceneMgr")

function var_0_0.ParseInfo(arg_1_0)
	return unpack(string.split(arg_1_0, "|"))
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.sceneInfo = arg_2_1
	arg_2_0.artSceneInfo = arg_2_0.sceneInfo
	arg_2_0.subSceneInfo = arg_2_0.sceneInfo
	arg_2_0.lastSceneRootDict = {}
	arg_2_0.cacheSceneDic = {}

	local var_2_0, var_2_1 = var_0_0.ParseInfo(arg_2_0.sceneInfo)

	seriesAsync({
		function(arg_3_0)
			SceneOpMgr.Inst:LoadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. var_2_1 .. "/" .. var_2_0 .. "_scene"), var_2_0, LoadSceneMode.Additive, function(arg_4_0, arg_4_1)
				arg_2_0.originArtScene = arg_4_0

				SceneManager.SetActiveScene(arg_4_0)

				local var_4_0 = getSceneRootTFDic(arg_4_0).MainCamera

				if var_4_0 then
					setActive(var_4_0, false)
				end

				arg_3_0()

				return
			end)

			return
		end,
		function(arg_5_0)
			SceneOpMgr.Inst:LoadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. var_2_1 .. "/" .. var_2_0 .. "_base_scene"), var_2_0 .. "_base", LoadSceneMode.Additive, arg_5_0)

			return
		end
	}, arg_2_2)

	return
end

function var_0_0.EnableSceneDisplay(arg_6_0, arg_6_1, arg_6_2)
	assert(tobool(arg_6_0.lastSceneRootDict[arg_6_1]) == arg_6_2)

	if arg_6_2 then
		table.Foreach(arg_6_0.lastSceneRootDict[arg_6_1], function(arg_7_0, arg_7_1)
			if IsNil(arg_7_0) then
				return
			end

			setActive(arg_7_0, arg_7_1)

			return
		end)

		arg_6_0.lastSceneRootDict[arg_6_1] = nil
	else
		arg_6_0.lastSceneRootDict[arg_6_1] = {}

		table.IpairsCArray(SceneManager.GetSceneByName(arg_6_1):GetRootGameObjects(), function(arg_8_0, arg_8_1)
			if tostring(arg_8_1.hideFlags) ~= "None" then
				return
			end

			arg_6_0.lastSceneRootDict[arg_6_1][arg_8_1] = isActive(arg_8_1)

			setActive(arg_8_1, false)

			return
		end)
	end

	return
end

function var_0_0.LoadTimelineScene(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0

	if not arg_9_0.cacheSceneDic[arg_9_1.name] then
		arg_9_0.cacheSceneDic[arg_9_1.name] = arg_9_1

		table.insert({}, function(arg_10_0)
			pg.SceneAnimMgr.GetInstance():Dorm3DSceneChange(function(arg_11_0)
				if arg_9_1.waitForTimeline then
					arg_9_1.waitForTimeline(arg_11_0)
				else
					var_9_0 = arg_11_0
				end

				arg_10_0()

				return
			end)

			return
		end)
		table.insert({}, function(arg_12_0)
			SceneOpMgr.Inst:LoadSceneAsync(string.lower("dorm3d/character/" .. arg_9_1.assetRootName .. "/timeline/" .. arg_9_1.name .. "/" .. arg_9_1.name .. "_scene"), arg_9_1.name, LoadSceneMode.Additive, function(arg_13_0, arg_13_1)
				existCall(arg_9_1.loadSceneFunc, arg_13_0, arg_13_1)
				setActive(GameObject.Find("[camera]").transform:GetComponentInChildren(typeof(Camera)), false)
				arg_12_0()

				return
			end)

			return
		end)
	end

	table.insert({}, function(arg_14_0)
		if tobool(arg_9_0.lastSceneRootDict[arg_9_1.name]) ~= tobool(arg_9_1.isCache) then
			arg_9_0:EnableSceneDisplay(arg_9_1.name, not arg_9_1.isCache)
		end

		arg_14_0()
		existCall(var_9_0)

		return
	end)
	seriesAsync({}, arg_9_2)

	return
end

function var_0_0.UnloadTimelineScene(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	assert(arg_15_0.cacheSceneDic[arg_15_1])

	if tobool(arg_15_2) == tobool(arg_15_0.cacheSceneDic[arg_15_1].isCache) then
		SceneOpMgr.Inst:UnloadSceneAsync(string.lower("dorm3d/character/scenes/" .. arg_15_0.cacheSceneDic[arg_15_1].assetRootName .. "/timeline/" .. arg_15_1 .. "/" .. arg_15_1 .. "_scene"), arg_15_1, function()
			arg_15_0.cacheSceneDic[arg_15_1] = nil
			arg_15_0.lastSceneRootDict[arg_15_1] = nil

			existCall(arg_15_3)

			return
		end)
	else
		arg_15_0:EnableSceneDisplay(arg_15_1, false)
		existCall(arg_15_3)
	end

	return
end

function var_0_0.ChangeArtScene(arg_17_0, arg_17_1, arg_17_2)
	if var_0_0.IsSameSceneInfo(arg_17_1, arg_17_0.artSceneInfo) then
		existCall(arg_17_2)

		return
	end

	local var_17_0 = {}
	local var_17_1 = false
	local var_17_2

	if var_0_0.IsSameSceneInfo(arg_17_1, arg_17_0.sceneInfo) then
		table.insert(var_17_0, function(arg_18_0)
			local var_18_0, var_18_1 = var_0_0.ParseInfo(arg_17_0.sceneInfo)

			SceneManager.SetActiveScene(SceneManager.GetSceneByName(var_18_0))
			arg_17_0:EnableSceneDisplay(var_18_0, true)
			arg_18_0()

			return
		end)
	else
		var_17_1 = true

		table.insert(var_17_0, function(arg_19_0)
			pg.SceneAnimMgr.GetInstance():Dorm3DSceneChange(function(arg_20_0)
				var_17_2 = arg_20_0

				arg_19_0()

				return
			end)

			return
		end)

		local var_17_3, var_17_4 = var_0_0.ParseInfo(arg_17_1)

		table.insert(var_17_0, function(arg_21_0)
			SceneOpMgr.Inst:LoadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. var_17_4 .. "/" .. var_17_3 .. "_scene"), var_17_3, LoadSceneMode.Additive, function(arg_22_0, arg_22_1)
				SceneManager.SetActiveScene(arg_22_0)

				local var_22_0 = getSceneRootTFDic(arg_22_0).MainCamera

				if var_22_0 then
					setActive(var_22_0, false)
				end

				arg_21_0()

				return
			end)

			return
		end)
	end

	if var_0_0.IsSameSceneInfo(arg_17_0.artSceneInfo, arg_17_0.sceneInfo) then
		table.insert(var_17_0, function(arg_23_0)
			local var_23_0, var_23_1 = var_0_0.ParseInfo(arg_17_0.sceneInfo)

			arg_17_0:EnableSceneDisplay(var_23_0, false)
			arg_23_0()

			return
		end)
	else
		local var_17_5, var_17_6 = var_0_0.ParseInfo(arg_17_0.artSceneInfo)

		table.insert(var_17_0, function(arg_24_0)
			SceneOpMgr.Inst:UnloadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. var_17_6 .. "/" .. var_17_5 .. "_scene"), var_17_5, function()
				existCall(arg_24_0)

				return
			end)

			return
		end)
	end

	table.insert(var_17_0, function(arg_26_0)
		arg_26_0()

		if var_17_1 then
			var_17_2()
		end

		return
	end)

	arg_17_0.artSceneInfo = arg_17_1

	seriesAsync(var_17_0, arg_17_2)

	return
end

function var_0_0.ChangeSubScene(arg_27_0, arg_27_1, arg_27_2)
	if var_0_0.IsSameSceneInfo(arg_27_1, arg_27_0.subSceneInfo) then
		return existCall(arg_27_2)
	end

	local var_27_0 = {}
	local var_27_1 = false
	local var_27_2

	if not var_0_0.IsSameSceneInfo(arg_27_1, arg_27_0.sceneInfo) then
		var_27_1 = true

		table.insert(var_27_0, function(arg_28_0)
			pg.SceneAnimMgr.GetInstance():Dorm3DSceneChange(function(arg_29_0)
				var_27_2 = arg_29_0

				arg_28_0()

				return
			end)

			return
		end)

		local var_27_3, var_27_4 = var_0_0.ParseInfo(arg_27_1)
		local var_27_5 = var_27_3 .. "_base"

		table.insert(var_27_0, function(arg_30_0)
			SceneOpMgr.Inst:LoadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. var_27_4 .. "/" .. var_27_5 .. "_scene"), var_27_5, LoadSceneMode.Additive, arg_30_0)

			return
		end)
	end

	if not var_0_0.IsSameSceneInfo(arg_27_0.subSceneInfo, arg_27_0.sceneInfo) then
		local var_27_6, var_27_7 = var_0_0.ParseInfo(arg_27_0.subSceneInfo)
		local var_27_8 = var_27_6 .. "_base"

		table.insert(var_27_0, function(arg_31_0)
			SceneOpMgr.Inst:UnloadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. var_27_7 .. "/" .. var_27_8 .. "_scene"), var_27_8, arg_31_0)

			return
		end)
	end

	table.insert(var_27_0, function(arg_32_0)
		arg_32_0()

		if var_27_1 then
			var_27_2()
		end

		return
	end)

	arg_27_0.subSceneInfo = arg_27_1

	seriesAsync(var_27_0, arg_27_2)

	return
end

function var_0_0.Dispose(arg_33_0)
	for iter_33_0, iter_33_1 in pairs(arg_33_0.cacheSceneDic) do
		if iter_33_1 then
			local var_33_0 = iter_33_1.assetRootName

			table.insert({}, function(arg_34_0)
				SceneOpMgr.Inst:UnloadSceneAsync(string.lower("dorm3d/character/scenes/" .. var_33_0 .. "/timeline/" .. iter_33_0 .. "/" .. iter_33_0 .. "_scene"), iter_33_0, arg_34_0)

				return
			end)
		end
	end

	if not var_0_0.IsSameSceneInfo(arg_33_0.subSceneInfo, arg_33_0.sceneInfo) then
		table.insert({
			arg_33_0.sceneInfo
		}, arg_33_0.subSceneInfo)
	end

	for iter_33_2, iter_33_3 in ipairs({
		arg_33_0.sceneInfo
	}) do
		local var_33_1, var_33_2 = var_0_0.ParseInfo(iter_33_3)
		local var_33_3 = var_33_1 .. "_base"

		table.insert({}, function(arg_35_0)
			SceneOpMgr.Inst:UnloadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. var_33_2 .. "/" .. var_33_3 .. "_scene"), var_33_3, arg_35_0)

			return
		end)
	end

	if not var_0_0.IsSameSceneInfo(arg_33_0.artSceneInfo, arg_33_0.sceneInfo) then
		table.insert({
			arg_33_0.sceneInfo
		}, arg_33_0.artSceneInfo)
	end

	for iter_33_4, iter_33_5 in ipairs({
		arg_33_0.sceneInfo
	}) do
		local var_33_4, var_33_5 = var_0_0.ParseInfo(iter_33_5)

		table.insert({}, function(arg_36_0)
			SceneOpMgr.Inst:UnloadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. var_33_5 .. "/" .. var_33_4 .. "_scene"), var_33_4, arg_36_0)

			return
		end)
	end

	seriesAsync({}, function()
		arg_33_0.sceneInfo = nil
		arg_33_0.artSceneInfo = nil
		arg_33_0.subSceneInfo = nil
		arg_33_0.lastSceneRootDict = nil
		arg_33_0.cacheSceneDic = nil

		print("unload scene finish !")

		return
	end)

	return
end

function var_0_0.IsSameSceneInfo(arg_38_0, arg_38_1)
	return string.lower(arg_38_0) == string.lower(arg_38_1)
end

return var_0_0
